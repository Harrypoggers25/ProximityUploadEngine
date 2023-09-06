<%@ Page Title="Tested Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tested.aspx.cs" Inherits="ProximityUploadEngine.tested" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_FileDropper.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_VideoPreview.css" />
    <main>
        <h2>File Dropper (Video only):</h2>
        <div id="dropper1" class="HP-FileDropper"></div>
        <br />
        <h2>Video Preview: (Load from dropper)</h2>
        <div id="video1" class="HP-VideoPreview"></div>
        <button id="btn_unloadVideo1" class="btn btn-primary" style="display: none;">Unload Video</button>
        <br />
        <h2>Profile Picture:</h2>
    </main>
    <script src="Scripts/HP_Scripts/HP_FileDropper.js"></script>
    <script src="Scripts/HP_Scripts/HP_VideoPreview.js"></script>
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
                },
                onUnload: function () {
                    btnUnloadVideo1.hide();
                },
            });
            const btnUnloadVideo1 = $("#btn_unloadVideo1").click(function (e) {
                e.preventDefault();
                video1.unloadVideo();
            });
        });
    </script>
</asp:Content>
