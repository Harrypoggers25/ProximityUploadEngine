<%@ Page Title="Dashboard Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ProximityUploadEngine.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_FileDropper.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_VideoPreview.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_ListBox.css" />
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_CheckBoxList.css" />

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

        /*.hp-checkbox-scroll-wrapper,
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
            }*/

        .hp-listbox-scroll {
            height: 300px;
        }
    </style>
    <main class="ms-5 mt-3">
        <h1>Video Upload Engine</h1>
        <div id="panel1" class="w-50 mt-3">
            <div id="dd_agency" class="HP-DropDown mb-3"></div>
            <%--<asp:HiddenField ID="hf_agencyEmail1" runat="server" />--%>
            <div class="d-flex flex-column">
                <h3>Choose Client:</h3>
                <div id="dd_client" class="HP-DropDown"></div>
                <div class="d-flex justify-content-end">
                    <a class="d-flex justify-content-end" href="#">Add new client</a>
                </div>
            </div>
            <div class="d-flex flex-column mt-3">
                <h3>Choose Hotel(s):</h3>
                <div class="hp-checkbox-scroll-wrapper">
                    <div id="cbl_hotel" class="HP-CheckBoxList"></div>
                    <%--<asp:CheckBoxList ID="cbl_hotel" runat="server"></asp:CheckBoxList>--%>
                </div>
                <div class="d-flex justify-content-end">
                    <a class="d-flex justify-content-end" href="#">Add new hotel</a>
                </div>
            </div>
            <div class="d-flex justify-content-end mt-3">
                <button id="btn_next1" class="btn btn-primary w-25">Next</button>
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
                        <div class="d-flex flex-column">
                            <h3>Upload Details:</h3>

                            <span class="fw-bold">Title:</span>
                            <asp:TextBox ID="tb_title" runat="server"></asp:TextBox>

                            <span class="mt-3 fw-bold">Description:</span>
                            <asp:TextBox ID="tb_description" runat="server"></asp:TextBox>
                        </div>
                        <div class="d-flex flex-row mt-3">
                            <div class="w-50">
                                <h3>Video Preview:</h3>
                                <div id="video1" class="HP-VideoPreview"></div>
                            </div>
                            <div class="d-flex flex-column ms-3 w-50">
                                <h3>Video Details:</h3>
                                <div class="flex-fill d-flex flex-column justify-content-between">
                                    <div id="videoDetails1" class="HP-ListBox w-100"></div>
                                    <div class="d-flex flex-row justify-content-between">
                                        <button id="btn_unload1" class="btn btn-primary w-25">Unload</button>
                                        <button id="btn_upload1" class="btn btn-primary w-25">Upload</button>
                                    </div>
                                </div>
                                <%--<asp:ListBox ID="lb_videoDetails" runat="server" CssClass="hp-listbox-scroll w-100"></asp:ListBox>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <span id="tempString" class="fw-bold">Output:</span>
    </main>
    <script src="Scripts/HP_Scripts/HP_DropDown.js"></script>
    <script src="Scripts/HP_Scripts/HP_FileDropper.js"></script>
    <script src="Scripts/HP_Scripts/HP_VideoPreview.js"></script>
    <script src="Scripts/HP_Scripts/HP_Ajax.js"></script>
    <script src="Scripts/HP_Scripts/HP_ListBox.js"></script>
    <script src="Scripts/HP_Scripts/HP_CheckBoxList.js"></script>
    <script>
        // Panel 1
        const ddAgency = new HP_DropDown("#dd_agency", { initialOption: "Choose Agency" });
        var cblHotel = new HP_CheckBoxList("#cbl_hotel");
        HP_Ajax.postJson({
            url: "Dashboard.aspx/getAllAgency",
            success: function (agencies) {
                ddAgency.clearOptions();
                for (var i = 0; i < agencies.length; i++) {
                    ddAgency.addOption(agencies[i].name, agencies[i].credential.email);
                }
                ddAgency.onChange(function () {
                    HP_Ajax.postJson({
                        url: "Dashboard.aspx/getAgencyAllClient",
                        data: { email: ddAgency.getValue() },
                        success: function (clients) {
                            ddClient.clearOptions();
                            for (var i = 0; i < clients.length; i++) {
                                ddClient.addOption(clients[i].name, clients[i].id);
                            }
                        },
                        error: function () {
                            console.log("Error: Unable to get Agency's Client");
                        }
                    });
                    HP_Ajax.postJson({
                        url: "Dashboard.aspx/getAllAgencyHotel",
                        data: { email: ddAgency.getValue() },
                        success: function (hotels) {
                            cblHotel.clearRows();
                            for (var i = 0; i < hotels.length; i++) {
                                cblHotel.addRow(hotels[i].name, hotels[i].id);
                            }
                        },
                        error: function () {
                            console.log("Error: Unable to Get Agency's Hotel");
                        }
                    })
                });
            },
            error: function () {
                console.log("Error: Cannot Get Agencies Data");
            }
        });
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
                    url: "Web_Handlers/Dashboard/UpdateVideoDetails.ashx?",
                    data: { "file": dropper1.getFile() },
                    success: function (videoDetail) {
                        videoDetails1.addRows(["File Directory:", videoDetail.fileDir]);
                        videoDetails1.addRows(["File Size:", videoDetail.fileSize]);
                        videoDetails1.addRows(["File Type:", videoDetail.fileType]);
                        videoDetails1.addRows(["Video Duration:", "unknown"]);
                        videoDetails1.addRows(["Video Resolution:", "unknown"]);
                        videoDetails1.addRows(["Audio Format:", "unknown"]);
                        videoDetails1.addRows(["Audio Channel:", "unknown"]);
                    },
                    error: function () {
                        console.log("Error: Unable to update video details");
                    }
                })
            },
            onError: function () {
                console.log("Error: Unable to load video")
            }
        });

        // Panel 3
        const video1 = new HP_VideoPreview("#video1", { fadeIn: true });
        const videoDetails1 = new HP_ListBox("#videoDetails1", { maxCol: 2 })
        videoDetails1.cols[0].addClass("fw-bold text-nowrap");
        const btnUnload1 = $("#btn_unload1").click(function (e) {
            e.preventDefault();

            $("#<%= tb_title.ClientID %>").val("");
            $("#<%= tb_description.ClientID %>").val("");
            video1.unloadVideo();
            videoDetails1.clearRows();
        });
        const btnUpload1 = $("#btn_upload1").click(function (e) {
            e.preventDefault();
            var content = {
                client_id: ddClient.getValue(),
                title: $("#<%= tb_title.ClientID %>").val(),
                description: $("#<%= tb_description.ClientID %>").val()
            }
            HP_Ajax.postFormData({
                url: "Web_Handlers/Dashboard/UploadVideo.ashx",
                data: { "file": dropper1.getFile(), "content": JSON.stringify(content), "hotel_ids": JSON.stringify(cblHotel.getCheckedRowValues()) },
                success: function (outputDir) {
                    output.text(`Output: ${outputDir}`);
                },
                error: function () {
                    console.log("Error: Unable to upload video");
                }
            })
        });

        // temporary Panel
        const output = $("#tempString");
    </script>
</asp:Content>
