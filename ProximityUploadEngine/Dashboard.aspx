<%@ Page Title="Dashboard Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ProximityUploadEngine.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_FileDropper.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_VideoPreview.css" />
    <style>
        .HP-FileDropper {
            width: 100%;
        }

        .HP-VideoPreview {
            width: 100%;
            height: auto;
        }
    </style>
    <main class="vh-100">
        <div class="container">
            <h1 class="ms-5">Dashboard</h1>
            <div class="row">
                <div class="col-12 w-100 d-flex justify-content-center">
                    <div class="col-8">
                        <h3>Choose Company:</h3>
                        <select class="form-select" aria-label="Default select example">
                            <option value="1" selected>Company 1</option>
                            <option value="2">Company 2</option>
                            <option value="3">Company 3</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-12 w-100 d-flex justify-content-center">
                    <div class="card col-8">
                        <div class="card-header">
                            <h3>Upload Your Content</h3>
                        </div>
                        <div class="card-body d-flex align-items-center flex-column">
                            <div class="col w-100 d-flex justify-content-center">
                                <div id="dropper1" class="HP-FileDropper w-100"></div>
                                <div id="video1" class="HP-VideoPreview w-75"></div>
                            </div>
                            <div class="col mt-3">
                                <button id="btn_unloadVideo1" class="btn btn-primary" style="display: none;">Unload Video</button>
                                <button id="btn_uploadVideo1" class="btn btn-primary" style="display: none;">Upload Video</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="Scripts/HP_Scripts/HP_FileDropper.js"></script>
    <script src="Scripts/HP_Scripts/HP_VideoPreview.js"></script>
    <script>
        const dropper1 = new HP_FileDropper("#dropper1", {
            txt_messagePrompt: "Drag/Drop a file here or Upload from File",
            txt_onHover: "Open File Directory",
            txt_onDrag: "Drop File in Drop Zone",
            txt_messageError: "Invalid Format: Please upload a valid video file",
            clr_onHover: "#e5e5e5",
            clr_offHover: "#f7f7f7",
            fadeIn: true,
            mime: "video/",
            onSuccess: function () {
                video1.loadVideo(dropper1.getFile());
                video1.element.show();
                dropper1.element.hide();
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
            onErrorLoad: function () {
                btnUnloadVideo1.show();
            }
        });
        video1.element.hide();
        btnUnloadVideo1 = $("#btn_unloadVideo1").hide().click(function (e) {
            e.preventDefault();
            video1.unloadVideo();
            video1.element.hide();
            dropper1.element.show();
        });
        btnUploadVideo1 = $("#btn_uploadVideo1").hide().click(function (e) {
            e.preventDefault();
            var formData = new FormData();
            formData.append("file", dropper1.getFile());
            $.ajax({
                url: "Web_Handlers/FileUploadHandler.ashx?",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    console.log(response);
                },
                error: function () {
                    console.log("upload fail")
                }
            });
        });
    </script>
</asp:Content>
