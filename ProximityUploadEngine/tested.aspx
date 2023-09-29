<%@ Page Title="Tested Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="tested.aspx.cs" Inherits="ProximityUploadEngine.tested" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_FileDropper.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_VideoPreview.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_ProfilePicture.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_Cropper.css" />--%>
    <%--<link rel="stylesheet" href="Scripts/HP_Scripts/HP_ListBox.css" />--%>
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_CheckBoxList.css" />
    <main>
        <div id="cbl1" class="HP-CheckBoxList"></div>
        <button id="btn1">push</button>
        <%--<div class="card">
            <div class="card-body">
                <div class="d-flex flex-row">
                    <div class="d-flex flex-row">
                        <div id="listbox1" class="HP-ListBox"></div>
                        <div id="listbox2" class="HP-ListBox"></div>
                    </div>
                </div>
            </div>
        </div>--%>
        <%--<h1>HP Framework:</h1>
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
        <button id="btn_uploadPicture1" class="btn btn-primary">Upload Picture</button>--%>
    </main>
    <%-- <script src="Scripts/HP_Scripts/HP_FileDropper.js"></script>
    <script src="Scripts/HP_Scripts/HP_VideoPreview.js"></script>
    <script src="Scripts/HP_Scripts/HP_ProfilePicture.js"></script>
    <script src="Scripts/HP_Scripts/HP_Cropper.js"></script>--%>
    <%--<script src="Scripts/HP_Scripts/HP_ListBox.js"></script>--%>
    <script src="Scripts/HP_Scripts/HP_CheckBoxList.js"></script>
    <script>
        var cbl1 = new HP_CheckBoxList("#cbl1");
        cbl1.addRow("hehe1", 1);
        cbl1.addRow("hehe2", 2);
        cbl1.addRow("hehe3", 3);
        cbl1.addRow("hehe4", 4);
        cbl1.addRow("hehe5", 5);
        cbl1.addRow("hehe6", "huhu");
        cbl1.addRow("hehe7", 7);
        cbl1.addRow("hehe8", 8);
        cbl1.addRow("hehe9", 9);

        $("#btn1").click(function (e) {
            e.preventDefault();

            var values = cbl1.getCheckedRowValues();
            console.log(values);
        });
        //var listbox1 = new HP_ListBox("#listbox1", { maxCol: 2 });
        //listbox1.addRows(["File Directory:", "C:\\Firdaus\\Project\\ASP.Net\\ProximityUploadEngine\\ProximityUploadEngine\\Web_Handlers\\Dashboard\\video_reference.mp4"]);
        //listbox1.addRows(["File Size:", "772 Kb"]);
        //listbox1.addRows(["File Type:", "video/mp4"]);
        //listbox1.addRows(["Video Duration:", "unknown"]);
        //listbox1.addRows(["Video Resolution:", "unknown"]);
        //listbox1.addRows(["Audio Format:", "unknown"]);
        //listbox1.addRows(["Audio Channel:", "unknown"]);

        //var listbox2 = new HP_ListBox("#listbox2", { maxCol: 2 });
        //listbox2.addRows(["File Directory:", "C:\\Firdaus\\Project\\ASP.Net\\ProximityUploadEngine\\ProximityUploadEngine\\Web_Handlers\\Dashboard\\video_reference.mp4"]);
        //listbox2.addRows(["File Size:", "772 Kb"]);
        //listbox2.addRows(["File Type:", "video/mp4"]);
        //listbox2.addRows(["Video Duration:", "unknown"]);
        //listbox2.addRows(["Video Resolution:", "unknown"]);
        //listbox2.addRows(["Audio Format:", "unknown"]);
        //listbox2.addRows(["Audio Channel:", "unknown"]);
        //$(document).ready(function () {
        //    const dropper1 = new HP_FileDropper("#dropper1", {
        //        txt_messagePrompt: "Drag/Drop a file here or Upload from File",
        //        txt_onHover: "Open File Directory",
        //        txt_onDrag: "Drop File in Drop Zone",
        //        txt_messageError: "Invalid Video File: Please upload a valid video file",
        //        clr_onHover: "lightgrey",
        //        clr_offHover: "white",
        //        fadeIn: true,
        //        onSuccess: function () {
        //            video1.loadVideo(dropper1.getFile());
        //        },
        //        onError: function () {
        //            video1.loadVideo(dropper1.getFile());
        //        }
        //    });

        //    const video1 = new HP_VideoPreview("#video1", {
        //        fadeIn: true,
        //        onSuccessLoad: function () {
        //            btnUnloadVideo1.show();
        //            btnUploadVideo1.show();
        //        },
        //        onUnload: function () {
        //            btnUnloadVideo1.hide();
        //            btnUploadVideo1.hide();
        //        },
        //    });
        //    const btnUnloadVideo1 = $("#btn_unloadVideo1").click(function (e) {
        //        e.preventDefault();
        //        video1.unloadVideo();
        //    });
        //    const btnUploadVideo1 = $("#btn_uploadVideo1").click(function (e) {
        //        e.preventDefault();
        //        var formData = new FormData();
        //        formData.append("file", dropper1.getFile());
        //        $.ajax({
        //            url: "Web_Handlers/FileUploadHandler.ashx?",
        //            type: "POST",
        //            data: formData,
        //            processData: false,
        //            contentType: false,
        //            success: function (response) {
        //                console.log("successfully uploaded video");
        //            }
        //        });
        //    });

        //    const cropper1 = new HP_Cropper("#cropper1");
        //    const picture1 = new HP_ProfilePicture("#picture1", {
        //        fadeIn: true,
        //        onLoad: function (e) {
        //            cropper1.loadImage(e);
        //        }
        //    });

        //    $("#btn_uploadPicture1").click(function (e) {
        //        e.preventDefault();
        //        const rect = cropper1.getRect();
        //        picture1.setImageRect(rect);
        //        var formData = new FormData();
        //        formData.append("file", picture1.getImageFile());
        //        formData.append("rect", JSON.stringify(rect));
        //        $.ajax({
        //            url: "Web_Handlers/FileUploadHandler.ashx?",
        //            type: "POST",
        //            data: formData,
        //            processData: false,
        //            contentType: false,
        //            success: function (response) {
        //                console.log("successfully");
        //            }
        //        });
        //    });
        //});
    </script>
</asp:Content>
