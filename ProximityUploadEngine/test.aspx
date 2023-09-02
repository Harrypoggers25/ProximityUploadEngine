<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .drop-wrapper {
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

            .drop-wrapper .icn-drop {
                font-size: 80px;
            }

            .drop-wrapper .drop-messagePrompt {
                font-size: 20px;
            }

            .drop-wrapper .drop-messageError {
                display: none;
                color: red;
            }

            .drop-wrapper .drop-zone {
                position: absolute;
                width: inherit;
                height: inherit;
                border-radius: inherit;
            }
    </style>
    <main>
        <div class="drop-wrapper">
            <i class="fa fa-cloud-upload icn-drop" aria-hidden="true"></i>
            <span class="drop-messagePrompt"></span>
            <div class="drop-messageError">
                <i class="fa fa-exclamation-circle" aria-hidden="true"></i>
                <span>Invalid Video File: Please upload a valid video file.</span>
            </div>
            <div class="drop-zone"></div>
        </div>
    </main>
    <script>
        $(document).ready(function () {
            const txt_messagePrompt = "Drag/Drop a file here or Upload from File";
            const txt_onHover = "Open File Directory";
            const txt_onDrag = "Drop File in Drop Zone";
            const clr_onHover = "lightgrey";
            const clr_offHover = "white";

            const dropwrapper = $('.drop-wrapper');
            const dropZone = $('.drop-zone');
            const icon = $('.drop-wrapper .icn-drop');
            const messagePrompt = $('.drop-wrapper .drop-messagePrompt').text(txt_messagePrompt);
            const messageError = $('.drop-wrapper .drop-messageError');

            // Drag and Drop Functions
            dropZone.on('dragover', function (e) {
                setBorder(e, "dashed", "black");
                updateAttr('fa-cloud-upload', 'fa-chevron-circle-down', txt_onDrag, clr_onHover);
            });

            dropZone.on('dragleave', function (e) {
                setBorder(e, "solid", "black");
                updateAttr('fa-chevron-circle-down', 'fa-cloud-upload', txt_messagePrompt, clr_offHover);
            });
            dropZone.on('drop', function (e) {
                setBorder(e, "solid", "black");
                updateAttr('fa-chevron-circle-down', 'fa-cloud-upload', txt_messagePrompt, clr_offHover);

                var file = e.originalEvent.dataTransfer.files[0];
                handleFile(file);
            });
            function setBorder(e, style, color) {
                e.preventDefault();
                dropwrapper.css('border', '4px ' + style + ' ' + color);
            }

            // Click Functions
            dropwrapper.click(function () {
                updateAttr('fa-folder', 'fa-cloud-upload', txt_messagePrompt, clr_offHover);

                var input = $("<input>");
                input.attr("type", "file").attr("accept", "video/*").attr("multiple", false);
                input.click()
                    .change(function (event) {
                        var file = event.target.files[0];
                        handleFile(file);
                    });
            });

            // Hover Functions
            dropwrapper.hover(
                function () {
                    updateAttr('fa-cloud-upload', 'fa-folder', txt_onHover, clr_onHover);
                },
                function () {
                    updateAttr('fa-folder', 'fa-cloud-upload', txt_messagePrompt, clr_offHover);
                }
            )
            function updateAttr(oldIconClass, newIconClass, newTextPrompt, newBgColor) {
                icon.removeClass(oldIconClass).addClass(newIconClass);
                if (newTextPrompt != null) {
                    messagePrompt.text(newTextPrompt);
                }
                if (newBgColor != null) {
                    dropwrapper.css("background-color", newBgColor);
                }
            }

            // File Handler
            function handleFile(file) {
                if (!file.type.startsWith('video/')) {
                    messageError.show();
                }
                else {
                    messageError.hide();

                    var reader = new FileReader();
                    reader.onload = function (e) {
                        console.log('File data:', e.target.result);
                    };
                    reader.readAsDataURL(file);
                }
            }
        });
    </script>
</asp:Content>
