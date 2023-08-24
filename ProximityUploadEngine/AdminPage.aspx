<%@ Page Title="Admin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="ProximityUploadEngine.AdminPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <table id="example" class="cell-border" style="width: 100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                </tr>
            </thead>
            <tfoot>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                </tr>
            </tfoot>
        </table>
    </main>
    <script>
        $(document).ready(function () {
            new DataTable('#example', {
                paging: false,
                scrollCollapse: true,
                scrollY: '60vh',
                ajax: {
                    url: 'AdminPage.aspx/GetAllAgency', // URL to fetch data
                    type: 'POST', // Use POST method
                    contentType: 'application/json', // Set content type
                    dataSrc: function (response) {
                        return JSON.parse(response.d); // Parse the data
                    }
                },
                columns: [
                    { data: 'id' },
                    { data: 'name' },
                    { data: 'email' },
                    { data: 'password' }
                ]
            });
        });
    </script>
</asp:Content>
