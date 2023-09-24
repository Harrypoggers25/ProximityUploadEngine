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

        .Dialog-VideoLoaded .Panel-VideoPreview {
            overflow: auto scroll;
        }

            .Dialog-VideoLoaded .Panel-VideoPreview .Cd-VideoPreview {
                display: flex;
                justify-content: space-between;
                background: #f7f7f7;
                border: 1px solid #e5e5e5;
                padding: 2px 10px;
                width: 800px;
            }

                .Dialog-VideoLoaded .Panel-VideoPreview .Cd-VideoPreview > span {
                    font-weight: 600;
                }

                .Dialog-VideoLoaded .Panel-VideoPreview .Cd-VideoPreview div {
                    width: 60%;
                }

                    .Dialog-VideoLoaded .Panel-VideoPreview .Cd-VideoPreview div > span {
                        font-style: italic;
                    }

        .Dialog-VideoLoaded .Panel-Fill span:first-of-type {
            font-weight: 600;
        }

        .Dialog-VideoLoaded .Panel-Fill .TextBoxMultiline-Fill {
            height: 200px;
            resize: none;
        }

        .Dialog-VideoLoaded .Panel-Button button {
            width: 125px;
        }
    </style>
    <main>
        <h1 class="ms-5 mt-3">Dashboard</h1>
        <div class="row">
            <div class="col-12 d-flex justify-content-center">
                <div class="col-9">
                    <h3>Choose Hotel:</h3>
                    <select class="form-select" aria-label="Default select example">
                        <option value="1" selected>Hotel 1</option>
                        <option value="2">Hotel 2</option>
                        <option value="3">Hotel 3</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12 d-flex justify-content-center">
                <div class="card col-9">
                    <div class="card-header">
                        <h3>Upload Your Content</h3>
                    </div>
                    <div class="card-body d-flex align-items-center flex-column">
                        <div class="col w-100 d-flex justify-content-center">
                            <div id="dropper1" class="HP-FileDropper w-100"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-12 d-flex justify-content-center">
                <div class="card col-9">
                    <div class="card-header">
                        <h3>Video Successfully Loaded!</h3>
                    </div>
                    <div class="card-body">
                        <div class="row Dialog-VideoLoaded">
                            <div class="col-12 d-flex flex-column">
                                <h3>Video Preview:</h3>
                                <div class="col-12 Panel-VideoPreview">
                                    <div class="col d-flex flex-column align-items-center">
                                        <div class="col-12 d-flex justify-content-center">
                                            <div id="video1" class="HP-VideoPreview w-75"></div>
                                        </div>
                                        <div class="col mt-3">
                                            <div class="Cd-VideoPreview">
                                                <span>File Directory:</span>
                                                <div>
                                                    <span id="txt_fileDirectory1">File_Directory1</span>
                                                </div>
                                            </div>
                                            <div class="Cd-VideoPreview">
                                                <span>File Size:</span>
                                                <div>
                                                    <span id="txt_fileSize1">File_Size1</span>
                                                </div>
                                            </div>
                                            <div class="Cd-VideoPreview">
                                                <span>File Type:</span>
                                                <div>
                                                    <span id="txt_fileType1">File_Type1</span>
                                                </div>
                                            </div>
                                            <div class="Cd-VideoPreview">
                                                <span>Video Duration:</span>
                                                <div>
                                                    <span id="txt_videoDuration1">Video_Duration1</span>
                                                </div>
                                            </div>
                                            <div class="Cd-VideoPreview">
                                                <span>Video Resolution:</span>
                                                <div>
                                                    <span id="txt_videoResolution1">Video_Resolution1</span>
                                                </div>
                                            </div>
                                            <div class="Cd-VideoPreview">
                                                <span>Audio Format:</span>
                                                <div>
                                                    <span id="txt_audioFormat1">Audio_Format1</span>
                                                </div>
                                            </div>
                                            <div class="Cd-VideoPreview">
                                                <span>Audio Channel:</span>
                                                <div>
                                                    <span id="txt_audioChannel1">Audio_Channel1</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 mt-3 Panel-Fill">
                                    <%--<div class="row d-flex align-items-center" style="height: 100%;">--%>
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="col d-flex flex-column">
                                                <span>Title (required)</span>
                                                <asp:TextBox ID="tb_title1" runat="server"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="rfv_title1" runat="server" ErrorMessage="*title cannot be empty"></asp:RequiredFieldValidator>
                                            </div>
                                            <div class="col d-flex flex-column">
                                                <span>Description</span>
                                                <asp:TextBox ID="tb_description1" runat="server" TextMode="MultiLine" CssClass="TextBoxMultiline-Fill"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div id="video2"></div>
                                            <span id="txt_fileName1">Filename1</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 mt-3 Panel-Button d-flex justify-content-center">
                                    <div class="col-4 d-flex justify-content-between">
                                        <button id="btn_unloadVideo1" class="btn btn-primary">Unload Video</button>
                                        <button id="btn_back" class="btn btn-primary">Back</button>
                                        <button id="btn_next" class="btn btn-primary">Next</button>
                                        <button id="btn_uploadVideo1" class="btn btn-primary">Upload Video</button>
                                    </div>
                                </div>
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
        const pnlVideoPreview = $(".Panel-VideoPreview").show();
        const pnlFill = $(".Panel-Fill").hide();
        //pnlVideoPreview.height("640px");
        //pnlFill.height("640px");

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
                //video1.element.show();
                //dropper1.element.hide();
            },
            onError: function () {
                video1.loadVideo(dropper1.getFile());
            }
        });

        const video1 = new HP_VideoPreview("#video1", {
            fadeIn: true,
            onSuccessLoad: function () {
                btnUnloadVideo1.show();
                btnNext1.show();

                pnlVideoPreview.show();
                pnlFill.hide();

                video2.loadVideo(dropper1.getFile());

                var formData = new FormData();
                formData.append("file", dropper1.getFile());

                $.ajax({
                    url: "Web_Handlers/GetVideoData.ashx?",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        $("#txt_fileDirectory1").text(response.FilePath);
                        $("#txt_fileSize1").text(response.FileSize);
                        $("#txt_fileType1").text(response.FileType);
                        $("#txt_videoDuration1").text("no_built_in_implementation");
                        $("#txt_videoResolution1").text("no_built_in_implementation");
                        $("#txt_audioFormat1").text("no_built_in_implementation");
                        $("#txt_audioChannel1").text("no_built_in_implementation");
                        $("#txt_fileName1").text(response.FileName);
                    },
                    error: function () {
                        console.log("Fail to retrieve video metadata")
                    }
                });
            },
            onUnload: function () {
                btnUnloadVideo1.hide();
                btnUploadVideo1.hide();
            },
            onErrorLoad: function () {
                btnUnloadVideo1.show();
            }
        });
        const video2 = new HP_VideoPreview("#video2");
        const btnUnloadVideo1 = $("#btn_unloadVideo1").hide().click(function (e) {
            e.preventDefault();
            video1.unloadVideo();
            video2.unloadVideo();

            pnlVideoPreview.hide();

            btnUnloadVideo1.hide();
            btnBack1.hide();
            btnNext1.hide();
            btnUploadVideo1.hide();
        });
        const btnUploadVideo1 = $("#btn_uploadVideo1").hide().click(function (e) {
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
        const btnBack1 = $('#btn_back').hide().click(function (e) {
            e.preventDefault();

            btnUnloadVideo1.show();
            btnBack1.hide();
            btnNext1.show();
            btnUploadVideo1.hide();

            $(".Dialog-VideoLoaded  h3").text("Video Preview:");

            pnlVideoPreview.show();
            pnlFill.hide();
        });
        const btnNext1 = $("#btn_next").hide().click(function (e) {
            e.preventDefault();

            btnUnloadVideo1.hide();
            btnBack1.show();
            btnNext1.hide();
            btnUploadVideo1.show();

            $(".Dialog-VideoLoaded  h3").text("Fill in the details:");

            pnlVideoPreview.hide();
            pnlFill.show();
        });

    </script>
</asp:Content>
