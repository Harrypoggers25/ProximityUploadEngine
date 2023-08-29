<%@ Page Title="Admin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="ProximityUploadEngine.AdminPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /*Data table*/
        .toolbar { /*Title*/
            font-size: 40px;
            font-weight: 600;
            float: left;
            margin-bottom: 10px;
        }

        .dataTables_filter { /*Search Bar*/
            position: absolute;
            top: 20px;
            right: 0;
            margin-right: 16px;
        }

        .editor-delete, .editor-edit {
            cursor: pointer;
        }

        /*Dialog box*/
        .ui-widget-overlay {
            background-color: black;
        }

        .ui-dialog {
            position: fixed;
        }

        .ui-dialog-titlebar {
            border: none;
            background-color: transparent;
        }

        .ui-dialog-titlebar-close {
            background-color: transparent;
            display: flex;
            justify-content: center;
            align-content: center;
            border: none;
        }

        #dlg-agency input {
            min-width: 300px;
        }
    </style>
    <main>
        <table id="tbl-agency" class="table table-dark table-striped table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <th colspan="6">
                        <div id="btnTbAddRow" class="btn btn-primary">Add Row (+)</div>
                    </th>
                </tr>
            </tfoot>
        </table>
        <div id="dlg-agency">
            <label for="tb-name">
                Name:<br />
                <input id="tb-name" name="tb-name" type="text" class="mb-3" />
            </label>
            <br />
            <label for="tb-email">
                Email:<br />
                <input id="tb-email" name="tb-email" type="text" class="mb-3" />
            </label>
            <br />
            <label for="tb-password">
                Password:<br />
                <input id="tb-password" name="tb-password" type="password" class="mb-3" />
            </label>
            <br />
        </div>
        <div id="dlg-delete">
            <span>Are you sure you want to delete this row?</span>
        </div>
    </main>
    <script>
        $(document).ready(function () {
            const dlgDelete = $("#dlg-delete");
            const dlgAgency = $("#dlg-agency");

            // datatable initialization
            const dataTable = new DataTable('#tbl-agency', {
                paging: false,
                info: false,
                scrollCollapse: true,
                scrollY: '60vh',
                dom: '<"toolbar">frtip',
                ajax: {
                    url: 'AdminPage.aspx/GetAllAgency',
                    type: 'POST',
                    contentType: 'application/json',
                    dataSrc: function (response) {
                        return JSON.parse(response.d);
                    }
                },
                columns: [
                    { data: 'id' },
                    { data: 'name' },
                    { data: 'email' },
                    { data: 'password' },
                    {
                        data: null,
                        className: 'dt-center editor-edit',
                        defaultContent: '<i class="fa fa-pencil"></i>',
                        orderable: false
                    },
                    {
                        data: null,
                        className: 'dt-center editor-delete',
                        defaultContent: '<i class="fa fa-trash"></i>',
                        orderable: false
                    }
                ],
            });
            function refreshTable() {
                $.ajax({
                    type: 'POST',
                    url: 'AdminPage.aspx/GetAllAgency',
                    contentType: 'application/json',
                    success: function (response) {
                        var updatedData = JSON.parse(response.d);
                        dataTable.clear().rows.add(updatedData).draw();
                    },
                    error: function (error) {
                        console.log("error: unable to refresh");
                    }
                });
            }
            $('#tbl-agency_wrapper div.toolbar').html('Admin Page');

            // delete dialog initialization (delete row event)
            dlgDelete.dialog({
                autoOpen: false,
                modal: true,
                closeOnEscape: false,
                draggable: false,
                resizable: false,
                width: 500,
                close: function () {
                    dlgDelete.off("dialogopen");
                }
            });
            dataTable.on('click', 'td.editor-delete', function (e) {
                e.preventDefault();

                const row = $(this).closest('tr'); // Get the closest row
                const rowData = dataTable.row(row).data();

                $('.ui-dialog-titlebar-close').html('<i class="fa fa-times" aria-hidden="true"></i>');
                dlgDelete.on("dialogopen", function (event, ui) {
                    dlgDelete.dialog("option", "title", "Delete Row (ID: " + rowData.id + ")");
                });
                dlgDelete.dialog("option", "buttons", [
                    {
                        text: "Confirm",
                        class: "btn btn-primary",
                        click: function () {
                            $.ajax({
                                type: 'POST',
                                url: 'AdminPage.aspx/deleteAgency', // Specify the method in the code behind
                                data: JSON.stringify({ id: rowData.id }), // Pass the parameter as JSON
                                contentType: 'application/json; charset=utf-8',
                                dataType: 'json',
                                success: function () {
                                    console.log("Deleted row " + rowData.id);
                                    refreshTable();
                                    dlgDelete.dialog("close");
                                },
                                error: function (error) {
                                    console.log("error: unable to delete row");
                                }
                            });
                        }
                    }
                ]);
                dlgDelete.dialog("open");
            });

            // agency dialog initialization (Add and edit row event)
            dlgAgency.dialog({
                autoOpen: false,
                modal: true,
                closeOnEscape: false,
                draggable: false,
                resizable: false,
                width: 500,
                close: function (event, ui) {
                    $("#tb-name").val("");
                    $("#tb-email").val("");
                    $("#tb-password").val("");
                    dlgAgency.off("dialogopen");
                }
            });

            //add row event
            $("#btnTbAddRow").click(function (e) {
                e.preventDefault();

                var currentId;
                dlgAgency.on("dialogopen", function (event, ui) {
                    $('.ui-dialog-titlebar-close').html('<i class="fa fa-times" aria-hidden="true"></i>');

                    $.ajax({
                        type: 'POST',
                        url: 'AdminPage.aspx/getFirstEmptyId',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (response) {
                            currentId = JSON.parse(response.d);
                            dlgAgency.dialog("option", "title", "Add New Row (ID: " + currentId + ")");
                        },
                        error: function (error) {
                            console.log("error: unable to get row id");
                        }
                    });
                });
                dlgAgency.dialog("option", "buttons", [
                    {
                        text: "Confirm",
                        class: "btn btn-primary",
                        click: function () {
                            var agency = {
                                id: currentId,
                                name: $("#tb-name").val(),
                                email: $("#tb-email").val(),
                                password: $("#tb-password").val()
                            };
                            if (agency.name === "" || agency.email === "" || agency.password === "") {
                                alert("Please fill in all fields.");
                            } else {
                                $.ajax({
                                    type: 'POST',
                                    url: 'AdminPage.aspx/createAgency',
                                    data: JSON.stringify({ agency: agency }),
                                    contentType: 'application/json; charset=utf-8',
                                    success: function () {
                                        refreshTable();
                                        dlgAgency.dialog("close");
                                    },
                                    error: function (error) {
                                        console.log("error: unable to add new row");
                                    }
                                });
                            }
                        }
                    }
                ]);
                dlgAgency.dialog("open");
            });

            // edit row event
            dataTable.on('click', 'td.editor-edit', function (e) {
                e.preventDefault();

                const row = $(this).closest('tr'); // Get the closest row
                const rowData = dataTable.row(row).data();

                dlgAgency.on("dialogopen", function (event, ui) {
                    $('.ui-dialog-titlebar-close').html('<i class="fa fa-times" aria-hidden="true"></i>');
                    dlgAgency.dialog("option", "title", "Edit Row (ID: " + rowData.id + ")");

                    $("#tb-name").val(rowData.name);
                    $("#tb-email").val(rowData.email);
                    $("#tb-password").val(rowData.password);
                });
                dlgAgency.dialog("option", "buttons", [
                    {
                        text: "Confirm",
                        class: "btn btn-primary",
                        click: function () {
                            var agency = {
                                id: rowData.id,
                                name: $("#tb-name").val(),
                                email: $("#tb-email").val(),
                                password: $("#tb-password").val()
                            };
                            if (agency.name === "" || agency.email === "" || agency.password === "") {
                                alert("Please fill in all fields.");
                            } else {
                                $.ajax({
                                    type: 'POST',
                                    url: 'AdminPage.aspx/updateAgency',
                                    data: JSON.stringify({ agency: agency }),
                                    contentType: 'application/json; charset=utf-8',
                                    success: function () {
                                        refreshTable();
                                        dlgAgency.dialog("close");
                                    },
                                    error: function (error) {
                                        console.log("error: unable to edit row");
                                    }
                                });
                            }
                        }
                    }
                ]);
                dlgAgency.dialog("open");
            });
        });
    </script>
</asp:Content>
