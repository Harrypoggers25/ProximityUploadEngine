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
        <div class="img-profile-picture-wrapper">
            <asp:Image ID="img_profilePicture" runat="server" ImageUrl="/assets/images/user.png" />
            <div class="icn-profile-picture">
                <i class="fa fa-camera" aria-hidden="true"></i>
                <span>Change photo</span>
            </div>
        </div>
    </main>
    <script>
        $(document).ready(function () {
            // upload image to relative file handler
            resizeFitImageInContainer($("#<%= img_profilePicture.ClientID %>"));
            $(".img-profile-picture-wrapper").hover(
                function () {
                    $(".icn-profile-picture").css("display", "flex");
                },
                function () {
                    $(".icn-profile-picture").css("display", "none");
                }
            );
            $(".icn-profile-picture").click(function () {
                console.log("hehe");
                var input = $("<input>")
                    .attr("type", "file").attr("accept", "image/*").attr("multiple", false)
                    .change(function (event) {
                        var selectedImage = event.target.files[0];
                        if (selectedImage) {
                            updateImageToContainer(selectedImage);
                        }
                        input.remove();
                    });
                input.click();
            });
            function updateImageToContainer(file) {
                const imgProfilePicture = $("#<%= img_profilePicture.ClientID %>");
                imgProfilePicture.attr("src", URL.createObjectURL(file));

                resizeFitImageInContainer(imgProfilePicture);
                $(".icn-profile-picture").css("display", "none");
            }
            function resizeFitImageInContainer(imgElement) {
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
        });
    </script>
</asp:Content>
