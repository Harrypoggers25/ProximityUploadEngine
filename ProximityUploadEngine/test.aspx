<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .img-profile-picture-wrapper, .icn-profilePictureHover {
            display: flex;
            justify-content: center;
            align-content: center;
            align-items: center;
            flex-direction: column;
        }

        .img-profile-picture-wrapper {
            position: relative;
            background-color: black;
            border-radius: 50%;
            aspect-ratio: 1;
            width: 150px;
            overflow: hidden;
        }

            .img-profile-picture-wrapper > * {
                position: absolute;
            }

            .img-profile-picture-wrapper img {
                height: 100%;
            }

            .img-profile-picture-wrapper input {
                display: none;
            }

            .img-profile-picture-wrapper:hover .icn-profilePictureHover {
                display: flex;
            }

        .icn-profilePictureHover {
            display: none;
            aspect-ratio: 1;
            width: 98%;
            background: rgba(50, 50, 50, 0.9);
            color: lightgray;
            border-radius: 50%;
            cursor: pointer;
            transition: display ease;
        }

            .icn-profilePictureHover i {
                font-size: 40px;
            }

            .icn-profilePictureHover span {
                font-size: 17px;
                font-weight: 600;
            }
    </style>
    <main>
        <div class="img-profile-picture-wrapper">
            <asp:Image ID="img_profilePicture" runat="server" ImageUrl="/assets/images/user.png" />
            <div class="icn-profilePictureHover">
                <i class="fa fa-camera" aria-hidden="true"></i>
                <span>Change photo</span>
            </div>
            <asp:FileUpload ID="fu_imgUploadHandler" runat="server" accept="image/*" />
            <asp:Button ID="btn_imgUploadHandler" runat="server" Text="Button" OnClick="UploadImage_Click" />
        </div>
    </main>
    <script>
        $(document).ready(function () {
            // upload image to relative file handler
            $(".icn-profilePictureHover").click(function () {
                $("#<%= fu_imgUploadHandler.ClientID %>").click();
            });
            $("#<%= fu_imgUploadHandler.ClientID %>").change(function () {
                $("#<%= btn_imgUploadHandler.ClientID %>").click();
            });
        })
    </script>
</asp:Content>
