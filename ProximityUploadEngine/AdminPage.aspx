<%@ Page Title="Admin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="ProximityUploadEngine.AdminPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
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
        </table>
        <div class="row mt-4">
            <div class="col-12 text-center">
                <div class="btn btn-primary" id="addRowButton">Add Row</div>
            </div>
        </div>
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
            // Edit record
            dataTable.on('click', 'td.editor-edit', function (e) {
                e.preventDefault();

                editor.edit(e.target.closest('tr'), {
                    title: 'Edit record',
                    buttons: 'Update'
                });
            });

            // Delete a record
            dataTable.on('click', 'td.editor-delete', function (e) {
                e.preventDefault();

                console.log("deleted");
                editor.remove(e.target.closest('tr'), {
                    title: 'Delete record',
                    message: 'Are you sure you wish to remove this record?',
                    buttons: 'Delete'
                });
            });
        });
    </script>
</asp:Content>
