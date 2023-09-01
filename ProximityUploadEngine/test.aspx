<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .img-profile-picture-wrapper, .icn-profile-picture {
            display: flex;
            justify-content: center;
            align-content: center;
            align-items: center;
            flex-direction: column;
        }

        .img-profile-picture-wrapper {
            border: 2px solid black;
            position: relative;
            background-color: white;
            border-radius: 50%;
            aspect-ratio: 1;
            width: 150px;
            overflow: hidden;
        }

            .img-profile-picture-wrapper > * {
                position: absolute;
            }

            .img-profile-picture-wrapper input {
                display: none;
            }

            .img-profile-picture-wrapper img {
                height: 100%;
            }

        .icn-profile-picture {
            display: none;
            aspect-ratio: 1;
            width: 100%;
            background: rgba(50, 50, 50, 0.9);
            color: lightgray;
            border-radius: 50%;
            cursor: pointer;
            transition: display ease;
        }

            .icn-profile-picture i {
                font-size: 40px;
            }

            .icn-profile-picture span {
                font-size: 17px;
                font-weight: 600;
            }
    </style>
    <main>
        <div id="hehe"></div>
        <div id="huhu">
            <asp:Image ID="Image1" runat="server" />
            <asp:FileUpload ID="FileUpload1" runat="server" Style="display: none;" />
            <asp:HiddenField ID="HiddenField1" runat="server" Value="/assets/images/user.png" />
        </div>

        <asp:Button ID="btn_upload" runat="server" Text="Upload" CssClass="btn btn-primary" OnClick="UploadImage_Click" />
    </main>
    <script>
        $(document).ready(function () {
            // upload image to relative file handler
            class HP_ProfilePicture {
                constructor({ id, imgId, fileUploadId, imgSrc }) {
                    const idElement = $("#" + id);
                    const imgElement = imgId == null ? $('<img>').addClass('img-profile-picture') : $("#" + imgId);
                    imgElement.attr('src', imgSrc);
                    const icnWrapper = $('<div>').addClass('icn-profile-picture');
                    const icn = $('<i>').addClass('fa fa-camera').attr('aria-hidden', 'true');
                    const span = $('<span>').text('Change photo');

                    icnWrapper.append(icn, span);
                    idElement.append(imgElement, icnWrapper).addClass("img-profile-picture-wrapper");

                    idElement.hover(
                        function () {
                            icnWrapper.css("display", "flex");
                        },
                        function () {
                            icnWrapper.css("display", "none");
                        }
                    );
                    icnWrapper.click(function () {
                        var input = fileUploadId == null ? $("<input>") : $("#" + fileUploadId);
                        input.attr("type", "file").attr("accept", "image/*").attr("multiple", false)
                            .change(function (event) {
                                var selectedImage = event.target.files[0];
                                if (selectedImage) {
                                    updateImageToContainer(selectedImage);
                                }
                                if (fileUploadId == null) {
                                    input.remove();
                                }
                            });
                        input.click();
                    });
                    function updateImageToContainer(file) {
                        imgElement.attr("src", URL.createObjectURL(file));

                        resizeFitImageInContainer();
                        icnWrapper.css("display", "none"); // fix bug: won't end hover state after file upload
                    }
                    function resizeFitImageInContainer() {
                        const image = new Image();
                        image.src = imgElement.attr("src");

                        image.onload = () => {
                            const width = image.width;
                            const height = image.height;

                            if (width > height) {
                                imgElement.css("height", "100%");
                                imgElement.css("width", "auto");
                            }
                            else {
                                imgElement.css("height", "auto");
                                imgElement.css("width", "100%");
                            }

                            URL.revokeObjectURL(imgElement.attr("src"));
                            image.remove();
                        }
                    }
                    resizeFitImageInContainer();
                }
            };

            var pp = new HP_ProfilePicture({
                id: 'hehe',
                imgSrc: '/assets/images/user.png',
            });
            var pupu = new HP_ProfilePicture({
                id: 'huhu',
                imgId: "<%= Image1.ClientID %>",
                fileUploadId: "<%= FileUpload1.ClientID %>",
                imgSrc: $("#<%= HiddenField1.ClientID %>").val(),
            });

        });
    </script>
</asp:Content>
