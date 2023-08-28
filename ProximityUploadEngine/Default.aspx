<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProximityUploadEngine._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .card-header-login {
            text-align: center;
            padding: 10px;
            border-bottom: 2px solid cornflowerblue;
        }

        login-text {
            text-align: center;
            font-family: Verdana, sans-serif;
            font-weight: 600;
            font-size: 20px;
            color: cornflowerblue;
        }

        .card {
            max-width: 400px;
            margin: 0 auto;
            border: 2px solid cornflowerblue;
        }

        .form-group {
            text-align: center;
            padding: 10px;
            font-style: oblique;
        }

            .form-group label {
                display: block;
                text-align: center;
                margin-bottom: 5px;
            }

        .card-body-login {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
        }

        .input-group-prepend .input-group-text {
            color: cornflowerblue;
            background-color: transparent;
            border: none;
        }

        .btn-custom {
            background-color: transparent;
            border-color: cornflowerblue;
            color: cornflowerblue;
        }
    </style>

    <main>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header-login">
                            <img src="/svg/Vision-Four.svg" height="50" alt="SVG Image" />
                        </div>
                        <br />
                        <login-text>LOG IN</login-text>
                        <div class="card-body-login">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox class="form-control" ID="username" placeholder="Username" runat="server"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvUsername" ControlToValidate="username" runat="server"
                                    ErrorMessage="Username is required" ForeColor="Red" Display="Dynamic" />
                            </div>
                        </div>

                        <br />
                        <div class="card-body-login">
                            <div class="form-group">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">
                                            <i class="fas fa-key"></i>
                                        </span>
                                    </div>
                                    <asp:TextBox class="form-control" ID="password" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                                <asp:RequiredFieldValidator ID="rfvpassword" ControlToValidate="password" runat="server"
                                    ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic" />
                            </div>
                            <br />
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-custom rounded-pill mx-auto" />
                            <br />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </main>

</asp:Content>
