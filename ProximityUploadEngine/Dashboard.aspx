<%@ Page Title="Dashboard Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ProximityUploadEngine.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_FileDropper.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_VideoPreview.css" />
    <style>
        .hp-icn-add-hotel {
            display: flex;
            align-items: center;
            font-size: 28px;
            color: grey;
            cursor: pointer;
        }

            .hp-icn-add-hotel:hover {
                color: black;
            }

        .HP-DropDown {
            height: 50px;
            font-size: 20px;
        }

        .hp-checkbox-scroll-wrapper,
        .hp-listbox-scroll {
            padding: 2px 4px;
            font-size: 20px;
        }

        .hp-checkbox-scroll-wrapper {
            height: 200px;
            overflow-y: scroll;
            border: 1px solid grey;
        }

            .hp-checkbox-scroll-wrapper label {
                margin-left: 4px;
            }

        .hp-listbox-scroll {
            height: 300px;
        }
    </style>
    <main class="ms-5 mt-3">
        <h1>Video Upload Engine</h1>
        <div id="panel1" class="mt-3">
            <div id="dd_agency" class="HP-DropDown mb-3"></div>
            <div class="d-flex flex-column w-50">
                <h3>Choose Client:</h3>
                <div id="dd_client" class="HP-DropDown"></div>
                <div class="d-flex justify-content-end">
                    <a class="d-flex justify-content-end" href="#">Add new client</a>
                </div>
            </div>
            <div class="d-flex flex-column w-50 mt-3">
                <h3>Choose Hotel(s):</h3>
                <div class="hp-checkbox-scroll-wrapper">
                    <asp:CheckBoxList ID="cbl_hotel" runat="server"></asp:CheckBoxList>
                </div>
                <div class="d-flex justify-content-end">
                    <a class="d-flex justify-content-end" href="#">Add new hotel</a>
                </div>
            </div>
        </div>
        <div id="panel2" class="mt-3">
            <div class="card">
                <div class="card-header">
                    <h3>Upload Your Content</h3>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-center w-100">
                        <div id="dropper1" class="HP-FileDropper w-100"></div>
                    </div>
                </div>
            </div>
        </div>
        <div id="panel3" class="mt-3">
            <div class="card">
                <div class="card-header">
                    <h3>Video Succefully Uploaded</h3>
                </div>
                <div class="card-body">
                    <div class="d-flex flex-column">
                        <div class="d-flex flex-row">
                            <div class="w-100">
                                <h3>Video Preview:</h3>
                                <div class="d-flex justify-content-center w-100" style="background-color: black;">
                                    <div id="video1" class="HP-VideoPreview"></div>
                                </div>
                            </div>
                            <div class="ms-3 w-100">
                                <h3>Video Details:</h3>
                                <asp:ListBox ID="lb_videoDetails" runat="server" CssClass="hp-listbox-scroll w-100"></asp:ListBox>
                            </div>
                        </div>
                        <div class="d-flex flex-column mt-3">
                            <h3>Upload Details:</h3>

                            <span class="fw-bold">Title:</span>
                            <asp:TextBox ID="tb_title" runat="server"></asp:TextBox>

                            <span class="mt-3 fw-bold">Description:</span>
                            <asp:TextBox ID="tb_description" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="Scripts/HP_Scripts/HP_DropDown.js"></script>
    <script src="Scripts/HP_Scripts/HP_FileDropper.js"></script>
    <script src="Scripts/HP_Scripts/HP_VideoPreview.js"></script>
    <script src="Scripts/HP_Scripts/HP_Ajax.js"></script>
    <script>
        // Panel 1
        const ddAgency = new HP_DropDown("#dd_agency", { initialOption: "Choose Agency" });
        const ddClient = new HP_DropDown("#dd_client", { initialOption: "Choose Client" });

        //$("#panel1").hide();

        // Panel 2
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
                HP_Ajax.postFormData({
                    url: "Web_Handlers/Dashboard/UpdateVideoDetails.ashx",
                    data: { "file": dropper1.getFile() },
                    success: function (response) {

                    }
                })
            },
            onError: function () {
                console.log("Error: Unable to load video")
            }
        });

        // Panel 3
        const video1 = new HP_VideoPreview("#video1", {
            fadeIn: true,
            onSuccessLoad: function () {
            },
            onUnload: function () {
            },
            onErrorLoad: function () {
            }
        });
    </script>
</asp:Content>
