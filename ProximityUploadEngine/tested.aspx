<%@ Page Title="Tested Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tested.aspx.cs" Inherits="ProximityUploadEngine.tested" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_FileDropper.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_VideoPreview.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_ProfilePicture.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_Cropper.css" />
    <main>
        <h1>HP Framework:</h1>
        <h2>File Dropper (Video only):</h2>
        <div id="dropper1" class="HP-FileDropper"></div>
        <br />
        <h2>Video Preview: (Load from dropper)</h2>
        <div id="video1" class="HP-VideoPreview"></div>
        <button id="btn_unloadVideo1" class="btn btn-primary" style="display: none;">Unload Video</button>
        <button id="btn_uploadVideo1" class="btn btn-primary" style="display: none;">Upload Video</button>
        <br />
        <h2>Profile Picture: (Update from Cropper)</h2>
        <div id="picture1" class="HP-ProfilePicture"></div>
        <h2>Cropper:</h2>
        <div id="cropper1" class="HP-Cropper"></div>
        <button id="btn_uploadPicture1" class="btn btn-primary">Upload Picture</button>
    </main>
    <script src="Scripts/HP_Scripts/HP_FileDropper.js"></script>
    <script src="Scripts/HP_Scripts/HP_VideoPreview.js"></script>
    <script src="Scripts/HP_Scripts/HP_ProfilePicture.js"></script>
    <script src="Scripts/HP_Scripts/HP_Cropper.js"></script>
    <script>
        $(document).ready(function () {
            const dropper1 = new HP_FileDropper("#dropper1", {
                txt_messagePrompt: "Drag/Drop a file here or Upload from File",
                txt_onHover: "Open File Directory",
                txt_onDrag: "Drop File in Drop Zone",
                txt_messageError: "Invalid Video File: Please upload a valid video file",
                clr_onHover: "lightgrey",
                clr_offHover: "white",
                fadeIn: true,
                onSuccess: function () {
                    video1.loadVideo(dropper1.getFile());
                },
                onError: function () {
                    video1.loadVideo(dropper1.getFile());
                }
            });

            const video1 = new HP_VideoPreview("#video1", {
                fadeIn: true,
                onSuccessLoad: function () {
                    btnUnloadVideo1.show();
                    btnUploadVideo1.show();
                },
                onUnload: function () {
                    btnUnloadVideo1.hide();
                    btnUploadVideo1.hide();
                },
            });
            const btnUnloadVideo1 = $("#btn_unloadVideo1").click(function (e) {
                e.preventDefault();
                video1.unloadVideo();
            });
            const btnUploadVideo1 = $("#btn_uploadVideo1").click(function (e) {
                e.preventDefault();
                const rect = cropper1.getRect();
                picture1.setImageRect(rect);
                var formData = new FormData();
                formData.append("file", dropper1.getFile());
                $.ajax({
                    url: "Web_Handlers/FileUploadHandler.ashx?",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        console.log("successfully uploaded video");
                    }
                });
            });

            const cropper1 = new HP_Cropper("#cropper1");
            const picture1 = new HP_ProfilePicture("#picture1", {
                fadeIn: true,
                onLoad: function (e) {
                    cropper1.loadImage(e);
                }
            });

            $("#btn_uploadPicture1").click(function (e) {
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
        });
    </script>
</asp:Content>
