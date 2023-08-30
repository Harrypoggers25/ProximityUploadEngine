<%@ Page Title="Settings Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="ProximityUploadEngine.Settings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /*Profile Picture*/
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

        /*Others*/
        #lbl_editProfile {
            background-color: #004e92;
            color: white;
        }

        .nav-link {
            color: var(--bs-nav-tabs-link-active-color);
        }

        .nav-tabs .nav-link.active {
            color: var(--bs-nav-link-color);
        }

        Setting-Card label {
            font-weight: 700;
        }

        Setting-Card span {
            font-weight: normal;
        }

        h2 {
            font-size: 30px;
        }

        .Pfl-Cd-Text {
            color: dimgrey;
        }

        .Panel-Setting:first-child {
            display: none;
        }
    </style>
    <main>
        <div class="container">
            <div class="row" style="height: 80vh;">
                <div class="col-3" style="height: 100%;">
                    <div class="card shadow Setting-Card" style="height: 100%;">
                        <div class="card-header">
                            <div class="row d-flex flex-column text-center">
                                <div class="col d-flex justify-content-center mb-3">
                                    <div class="img-profile-picture-wrapper">
                                        <asp:Image ID="img_profilePicture" runat="server" ImageUrl="/assets/images/user.png" />
                                        <div class="icn-profilePictureHover">
                                            <i class="fa fa-camera" aria-hidden="true"></i>
                                            <span>Change photo</span>
                                        </div>
                                        <asp:FileUpload ID="fu_imgUploadHandler" runat="server" accept="image/*" />
                                        <asp:Button ID="btn_imgUploadHandler" runat="server" Text="Button" OnClick="UploadImage_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="row d-flex flex-column text-center">
                                <div class="col mb-3">
                                    <div class="row">
                                        <div class="col d-flex justify-content-center">
                                            <div class="row d-flex flex-column text-start">
                                                <div class="col text-nowrap">
                                                    <label>Last Visited</label>
                                                </div>
                                                <div class="col text-nowrap">
                                                    <span class="Pfl-Cd-Text">
                                                        <asp:Label ID="lbl_lastVisited" runat="server" Text="69 minutes"></asp:Label>
                                                        ago
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col d-flex justify-content-center">
                                            <div class="row d-flex flex-column text-start">
                                                <div class="col">
                                                    <label>Place</label>
                                                </div>
                                                <div class="col">
                                                    <asp:Label ID="lbl_place" runat="server" Text="Hawaii" CssClass="Pfl-Cd-Text"></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col d-flex justify-content-center">
                                    <div class="row d-flex flex-column text-start">
                                        <div class="col Pfl-Cd-Text mb-3">
                                            <span>
                                                <i class="fa-regular fa-user"></i>
                                                <asp:Label ID="lbl_username1" runat="server" Text="Username Here"></asp:Label>
                                            </span>
                                        </div>
                                        <div class="col Pfl-Cd-Text mb-3">
                                            <span>
                                                <i class="fa-regular fa-calendar-days"></i>
                                                Joined on
                                                <asp:Label ID="lbl_joinDate" runat="server" Text="2069"></asp:Label>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-9" style="height: 100%;">
                    <h2>Settings</h2>
                    <div class="row d-flex flex-column">
                        <div class="col">
                            <ul class="nav nav-tabs Nav-Setting">
                                <asp:HiddenField ID="n_tabIndex" runat="server" Value="1" />
                                <li class="nav-item">
                                    <a class="nav-link active" href="#" style="font-weight: 700;">Profile</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#" style="font-weight: 700;">Security</a>
                                </li>
                            </ul>
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="col Panel-Setting">
                                    <div class="row d-flex flex-column">
                                        <div class="col mt-4">
                                            <label>
                                                Email:<br />
                                                <asp:TextBox ID="tb_email" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                        <div class="col mt-4">
                                            <label>
                                                Username:<br />
                                                <asp:TextBox ID="tb_username" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                        <div class="col mt-4">
                                            <label>
                                                Phone Number:<br />
                                                <asp:TextBox ID="tb_phoneNumber" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                        <div class="col mt-4">
                                            <label>
                                                City:<br />
                                                <asp:TextBox ID="tb_city" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="col Panel-Setting">
                                    <div class="row d-flex flex-column">
                                        <div class="col mt-4">
                                            <label>
                                                Old Password:<br />
                                                <asp:TextBox ID="tb_oldPassword" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                        <div class="col mt-4">
                                            <label>
                                                New Password:<br />
                                                <asp:TextBox ID="tb_newPassword" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                        <div class="col mt-4">
                                            <label>
                                                Confirm Password :<br />
                                                <asp:TextBox ID="tb_cfmPassword" runat="server" CssClass="form-control w-100"></asp:TextBox>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col text-center">
                            <asp:Button ID="btn_updateSetting" runat="server" Text="Update Settings" CssClass="btn rounded-pill" Style="color: #ffffff; background-color: #004e92; max-width: 100%;" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script>
        $(document).ready(function () {
            // disable email textbox
            $("#<%= tb_email.ClientID %>").prop("disabled", true);

            // setting panel
            var currentPanel = $(".Panel-Setting:first-of-type");
            tabIndex = $("#<%= n_tabIndex.ClientID %>");
            updatePanel(tabIndex.val());
            function updatePanel(index) {
                $(".Panel-Setting").hide();
                currentPanel = $(".Panel-Setting:nth-of-type(" + index + ")");
                currentPanel.show();
            }
            $(".Nav-Setting a").click(function () {
                $(".Nav-Setting a").removeClass("active");
                $(this).addClass("active");
                tabIndex.val($(this).closest('.nav-item').index());
                updatePanel(tabIndex.val());
            });

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
