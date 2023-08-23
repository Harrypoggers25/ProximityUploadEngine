<%@ Page Title="Admin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="ProximityUploadEngine.AdminPage" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <table id="myTable" class="display" style="width: 100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Password</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </main>
    <script>
        $(document).ready(function () {
            $('#myTable').DataTable({
                ajax: {
                    url: 'AgenciesHandler.ashx',
                    dataSrc: ''
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
