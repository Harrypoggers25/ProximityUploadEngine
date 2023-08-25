<%@ Page Title="Admin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="ProximityUploadEngine.AdminPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .dataTables_filter {
            margin-bottom: 10px; /* Adjust the margin value as needed */
            margin-right: 16px; /* Adjust the margin value as needed */
        }

        .editor-delete, .editor-edit {
            cursor: pointer;
        }

        #example tfoot tr:hover {
            background-color: white !important;
        }
    </style>
    <main>
        <h1>Admin Page</h1>
        <table id="example" class="table table-dark table-striped table-bordered table-hover">
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
    </main>
    <script>
        $(document).ready(function () {
            const dataTable = new DataTable('#example', {
                paging: false,
                info: false,
                scrollCollapse: true,
                scrollY: '60vh',
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
                    url: 'AdminPage.aspx/GetAllAgency', // Replace with your server-side method to fetch updated data
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

            // Edit record
            dataTable.on('click', 'td.editor-edit', function (e) {
                e.preventDefault();
            });

            // Delete a record
            dataTable.on('click', 'td.editor-delete', function (e) {
                const row = $(this).closest('tr'); // Get the closest row
                const rowData = dataTable.row(row).data();

                $.ajax({
                    type: 'POST',
                    url: 'AdminPage.aspx/DeleteAgency', // Specify the method in the code behind
                    data: JSON.stringify({ id: rowData.id }), // Pass the parameter as JSON
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function () {
                        console.log("Deleted row " + rowData.id);
                        refreshTable();
                    },
                    error: function (error) {
                        console.log("error: unable to delete row");
                    }
                });
                e.preventDefault();
            });
        });
    </script>
</asp:Content>
