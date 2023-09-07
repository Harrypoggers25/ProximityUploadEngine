<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_ProfilePicture.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_Cropper.css" />
    <main>
        <h2>Profile Picture: (Update from Cropper)</h2>
        <div id="picture1" class="HP-ProfilePicture"></div>
        <h2>Cropper:</h2>
        <div id="cropper1" class="HP-Cropper"></div>
        <button class="btn btn-primary">Click Me Daddy</button>
    </main>
    <script src="Scripts/HP_Scripts/HP_ProfilePicture.js"></script>
    <script src="Scripts/HP_Scripts/HP_Cropper.js"></script>
    <script>
        $(document).ready(function () {

            const cropper1 = new HP_Cropper("#cropper1");
            const picture1 = new HP_ProfilePicture("#picture1", {
                fadeIn: true,
                onLoad: function (e) {
                    cropper1.loadImage(e);
                }
            });

            $("button").click(function (e) {
                e.preventDefault();
                const rect = cropper1.getRect();
                picture1.setImageRect(rect);
                var formData = new FormData();
                formData.append("file", picture1.getImageFile());
                formData.append("rect", JSON.stringify(rect));
                $.ajax({
                    url: "Web_Handlers/FileUploadHandler.ashx?",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        console.log("successfully");
                    }
                });
            });
        })
    </script>
</asp:Content>
