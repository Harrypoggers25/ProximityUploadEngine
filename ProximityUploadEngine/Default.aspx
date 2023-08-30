<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProximityUploadEngine._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .Cd-Login {
            color: cornflowerblue;
            border: 2px solid cornflowerblue;
        }

            .Cd-Login .card-header {
                text-align: center;
                padding: 10px;
                border-bottom: 2px solid cornflowerblue;
            }

            .Cd-Login .card-body {
                display: flex;
                align-items: center;
                flex-direction: column;
                padding-top: 0;
            }

            .Cd-Login h2 {
                font-family: Verdana, sans-serif;
                font-weight: 600;
                font-size: 2em;
                font-style: oblique;
            }

            .Cd-Login .input-group {
                margin-bottom: 10px;
            }

            .Cd-Login .input-group-text {
                border-radius: 0;
            }

            .Cd-Login i {
                color: inherit;
                width: 15px;
            }

        #icn_showPassword_show {
            display: none;
        }

        .form-group {
            width: 75%;
        }
    </style>

    <main>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-6">
                    <div class="card Cd-Login">
                        <div class="card-header">
                            <img src="/svg/Vision-Four.svg" height="50" alt="SVG Image" />
                        </div>
                        <div class="card-body">
                            <h2 class="p-3 text-center">LOG IN</h2>
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text h-100">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox class="form-control" ID="tb_username" placeholder="Username" runat="server"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfv_Username" ControlToValidate="tb_username" runat="server"
                                    ErrorMessage="Username is required" ForeColor="Red" Display="Dynamic" />
                            </div>
                            <div class="form-group mt-3">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text h-100">
                                            <i class="fas fa-key"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox ID="tb_password" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                                    <div id="btn_showPassword" class="btn btn-primary">
                                        <i id="icn_showPassword_show" class="fa fa-eye" aria-hidden="true"></i>
                                        <i id="icn_showPassword_hide" class="fa fa-eye-slash" aria-hidden="true"></i>
                                    </div>

                                </div>
                                <asp:RequiredFieldValidator ID="rfv_password" ControlToValidate="tb_password" runat="server"
                                    ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic" />
                            </div>
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary mt-4" OnClick="btnLogin_click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>
    <script>
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
