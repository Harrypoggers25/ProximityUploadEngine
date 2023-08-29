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
            background-color: #004e92;
            border-radius: 50%;
            aspect-ratio: 1;
            width: 150px;
        }

            .img-profile-picture-wrapper > * {
                position: absolute;
            }

            .img-profile-picture-wrapper img {
                height: 100%;
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

        #icn_showPassword_show {
            display: none;
        }
    </style>
    <main>
        <%--<div class="img-profile-picture-wrapper">
            <asp:Image ID="img_profilePicture" runat="server" ImageUrl="/assets/images/user.png" />
            <div class="icn-profilePictureHover">
                <i class="fa fa-camera" aria-hidden="true"></i>
                <span>Change photo</span>
            </div>
        </div>--%>
        <div class="input-group mb-3">
            <asp:TextBox ID="tb_password" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
            <div id="btn_showPassword" class="btn btn-primary">
                <i id="icn_showPassword_show" class="fa fa-eye" aria-hidden="true"></i>
                <i id="icn_showPassword_hide" class="fa fa-eye-slash" aria-hidden="true"></i>
            </div>
        </div>
    </main>
    <script>
        //$(document).ready(function () {
        //    // upload image to relative file handler
        //    $(".icn-profilePictureHover").click(function () {
        //        var input = $("<input>")
        //            .attr("type", "file")
        //            .attr("accept", "image/*")
        //            .attr("multiple", false)
        //            .change(function (event) {
        //                var selectedImage = event.target.files[0];
        //                if (selectedImage) {
        //                    uploadFileToRelativeDir(selectedImage);
        //                }
        //                input.remove();
        //            });

        //        input.click();
        //    });

        //    function uploadFileToRelativeDir(file) {
        //        var formData = new FormData();
        //        formData.append("file", file);

        //        $.ajax({
        //            type: "POST",
        //            url: "test.aspx/UploadImage",
        //            data: formData,
        //            contentType: false,
        //            processData: false,
        //            dataType: "json",
        //            success: function (response) {
        //                console.log(response.d);
        //            },
        //            error: function () {
        //                console.log("Error: Unable to upload image");
        //            }
        //        });
        //    }

        //})
        $(document).ready(function () {
            var isShowPassword = false;
            $("#btn_showPassword").click(function () {
                isShowPassword = !isShowPassword;
                if (isShowPassword) {
                    $("#icn_showPassword_show").show();
                    $("#icn_showPassword_hide").hide();
                    $("#<%= tb_password.ClientID %>").attr("type", "text");

                }
                else {
                    $("#icn_showPassword_show").hide();
                    $("#icn_showPassword_hide").show();
                    $("#<%= tb_password.ClientID %>").attr("type", "password");
                }
                $("#<%= tb_password.ClientID %>").focus();
            });
        })
    </script>
</asp:Content>
