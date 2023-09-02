<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .HP-drop-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width: 300px;
            height: 300px;
            border: 4px solid black;
            border-radius: 15px;
            text-align: center;
            padding: 20px;
            cursor: pointer;
        }

            .HP-drop-wrapper .HP-icn-drop {
                font-size: 80px;
            }

            .HP-drop-wrapper .HP-drop-messagePrompt {
                font-size: 20px;
            }

            .HP-drop-wrapper .HP-drop-messageError {
                display: none;
                color: red;
            }

            .HP-drop-wrapper .HP-drop-zone {
                position: absolute;
                width: inherit;
                height: inherit;
                border-radius: inherit;
            }
    </style>
    <main>
        <div id="dropper1"></div>
    </main>
    <script>
        $(document).ready(function () {
            class HP_FileDropper {
                constructor({ id, txt_messagePrompt, txt_onHover, txt_onDrag, txt_messageError, clr_onHover, clr_offHover, onSuccess, onError }) {
                    this.file = null;
                    this.onSuccess = onSuccess == null ? function () { } : onSuccess;
                    this.onError = onError == null ? function () { } : onError;

                    this.txt_messagePrompt = txt_messagePrompt == null ? "" : txt_messagePrompt;
                    this.txt_onHover = txt_onHover == null ? this.txt_messagePrompt : txt_onHover;
                    this.txt_onDrag = txt_onDrag == null ? this.txt_messagePrompt : txt_onDrag;
                    this.txt_messageError = txt_messageError == null ? "" : txt_messageError;
                    this.clr_onHover = clr_onHover == null ? "transparent" : clr_onHover;
                    this.clr_offHover = clr_offHover == null ? this.clr_onHover : clr_offHover;

                    this.idElement = $("#" + id).addClass("HP-drop-wrapper");
                    this.dropwrapper = this.idElement;
                    this.icon = $("<i>").addClass("fa fa-cloud-upload HP-icn-drop").attr('aria-hidden', 'true');
                    this.messagePrompt = $("<span>").addClass("HP-drop-messagePrompt").text(txt_messagePrompt);
                    this.messageErrorWrapper = $("<div>").addClass("HP-drop-messageError");
                    this.iconError = $("<i>").addClass("fa fa-exclamation-circle").attr('aria-hidden', 'true');
                    this.messageError = $("<span>").text(txt_messageError);
                    this.dropZone = $("<div>").addClass("HP-drop-zone");

                    this.messageErrorWrapper.append(this.iconError, this.messageError);
                    this.dropwrapper.append(this.icon, this.messagePrompt, this.messageErrorWrapper, this.dropZone);

                    // Arrow functions to maintain 'this' context
                    this.dropZone.on('dragover', (e) => {
                        this.setBorder(e, "dashed", "black");
                        this.updateAttr('fa-cloud-upload', 'fa-chevron-circle-down', this.txt_onDrag, this.clr_onHover);
                    });

                    this.dropZone.on('dragleave', (e) => {
                        this.setBorder(e, "solid", "black");
                        this.updateAttr('fa-chevron-circle-down', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);
                    });

                    this.dropZone.on('drop', (e) => {
                        this.setBorder(e, "solid", "black");
                        this.updateAttr('fa-chevron-circle-down', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);

                        var file = e.originalEvent.dataTransfer.files[0];
                        this.handleFile(file);
                    });

                    // Arrow function for click event
                    this.dropwrapper.click(() => {
                        this.updateAttr('fa-folder', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);

                        var input = $("<input>");
                        input.attr("type", "file").attr("accept", "video/*").attr("multiple", false);
                        input.click()
                            .change((event) => {
                                var file = event.target.files[0];
                                this.handleFile(file);
                            });
                    });

                    // Arrow functions for hover event
                    this.dropwrapper.hover(
                        () => {
                            this.updateAttr('fa-cloud-upload', 'fa-folder', this.txt_onHover, this.clr_onHover);
                        },
                        () => {
                            this.updateAttr('fa-folder', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);
                        }
                    );
                }
                setBorder(e, style, color) {
                    e.preventDefault();
                    this.dropwrapper.css('border', '4px ' + style + ' ' + color);
                }
                updateAttr(oldIconClass, newIconClass, newTextPrompt, newBgColor) {
                    this.icon.removeClass(oldIconClass).addClass(newIconClass);
                    if (newTextPrompt != null) {
                        this.messagePrompt.text(newTextPrompt);
                    }
                    if (newBgColor != null) {
                        this.dropwrapper.css("background-color", newBgColor);
                    }
                }
                handleFile(file) {
                    if (!file.type.startsWith('video/')) {
                        this.messageErrorWrapper.show();
                        this.onError();
                    } else {
                        this.messageErrorWrapper.hide();

                        this.file = file;
                        this.onSuccess();
                    }
                }
                getFile() {
                    return this.file;
                }
                readFile() {
                    var reader = new FileReader();
                    reader.onload = (e) => {
                        console.log('File data:', e.target.result);
                        reader.remove();
                    };
                    reader.readAsDataURL(this.file);
                }
            }

            const dropper1 = new HP_FileDropper({
                id: "dropper1",
                txt_messagePrompt: "Drag/Drop a file here or Upload from File",
                txt_onHover: "Open File Directory", // Use colons instead of equals for property assignments
                txt_onDrag: "Drop File in Drop Zone",
                txt_messageError: "Invalid Video File: Please upload a valid video file",
                clr_onHover: "lightgrey",
                clr_offHover: "white",
                onSuccess: function () {
                    console.log("hehe");
                },
                onError: function () {
                    console.log("hoho");
                }
            });
        });
    </script>
</asp:Content>
