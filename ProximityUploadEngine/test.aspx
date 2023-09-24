<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        main {
            display: flex;
            flex-direction: column;
        }
    </style>
    <main class="ms-5 mt-3">

        <div class="col-12 d-flex flex-row">
            <div class="col-6 p-2">
                <!--Agency-->
                <div class="col-12 d-flex flex-column">
                    <div class="col-12 d-flex flex-row justify-content-between">
                        <h3>Agency:</h3>
                        <div id="slc_email1"></div>
                    </div>
                    <asp:Label ID="lbl_email1" runat="server" Text="Email:"></asp:Label>
                    <asp:TextBox ID="tb_email1" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_name1" runat="server" Text="Name:"></asp:Label>
                    <asp:TextBox ID="tb_name1" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_password1" runat="server" Text="Password:"></asp:Label>
                    <asp:TextBox ID="tb_password1" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_contactNumber1" runat="server" Text="Contact Number:"></asp:Label>
                    <asp:TextBox ID="tb_contactNumber1" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_description1" runat="server" Text="Description:"></asp:Label>
                    <asp:TextBox ID="tb_description1" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <asp:Label ID="lbl_clients1" runat="server" Text="Clients:"></asp:Label>
                    <asp:ListBox ID="lb_clients1" runat="server"></asp:ListBox>

                    <asp:Label ID="lbl_hotels1" runat="server" Text="Hotels:"></asp:Label>
                    <asp:ListBox ID="lb_hotels1" runat="server"></asp:ListBox>

                    <div class="col-12 d-flex flex-row mt-2">
                        <asp:Button ID="Button1" runat="server" Text="Submit" CssClass="btn btn-primary col" OnClick="btnSubmit1_clicked" />
                        <asp:Button ID="Button2" runat="server" Text="Retrieve" CssClass="btn btn-secondary col" OnClick="btnRetrieve1_clicked" />
                        <asp:Button ID="Button3" runat="server" Text="Update" CssClass="btn btn-success col" OnClick="btnUpdate1_clicked" />
                        <asp:Button ID="Button4" runat="server" Text="Delete All" CssClass="btn btn-danger col" OnClick="btnDeleteAll1_clicked" />
                        <asp:Button ID="Button5" runat="server" Text="Delete" CssClass="btn btn-warning col" OnClick="btnDelete1_clicked" />
                    </div>
                </div>

                <!--Agency's Client-->
                <div class="col-12 d-flex flex-column mt-3">
                    <div class="col-12 d-flex flex-row justify-content-between">
                        <h3>Agency's Client:</h3>
                        <div id="slc_email3"></div>
                        <div id="slc_client3"></div>
                        <asp:HiddenField ID="hf_clientId3" runat="server" Value="" />
                    </div>
                    <asp:Label ID="lbl_email3" runat="server" Text="Agency Email:"></asp:Label>
                    <asp:TextBox ID="tb_email3" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_name3" runat="server" Text="Client Name:"></asp:Label>
                    <asp:TextBox ID="tb_name3" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_description3" runat="server" Text="Client Description:"></asp:Label>
                    <asp:TextBox ID="tb_description3" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <asp:Label ID="lbl_location3" runat="server" Text="Client Location:"></asp:Label>
                    <asp:TextBox ID="tb_location3" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <div class="col-12 d-flex flex-row mt-2">
                        <asp:Button ID="Button6" runat="server" Text="Submit" CssClass="btn btn-primary col" OnClick="btnSubmit3_clicked" />
                        <asp:Button ID="Button7" runat="server" Text="Retrieve" CssClass="btn btn-secondary col" OnClick="btnRetrieve3_clicked" />
                        <asp:Button ID="Button8" runat="server" Text="Update" CssClass="btn btn-success col" OnClick="btnUpdate3_clicked" />
                        <asp:Button ID="Button9" runat="server" Text="Delete All" CssClass="btn btn-danger col" OnClick="btnDeleteAll3_clicked" />
                        <asp:Button ID="Button10" runat="server" Text="Delete" CssClass="btn btn-warning col" OnClick="btnDelete3_clicked" />
                    </div>
                </div>

                <!--Content-->
                <div class="col-12 d-flex flex-column mt-3">
                    <h3>Content:</h3>
                    <asp:Label ID="lbl_title5" runat="server" Text="Title:"></asp:Label>
                    <asp:TextBox ID="tb_title5" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_path5" runat="server" Text="Path:"></asp:Label>
                    <asp:TextBox ID="tb_path5" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_description5" runat="server" Text="Description:"></asp:Label>
                    <asp:TextBox ID="tb_description5" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <asp:Label ID="lbl_hotel5" runat="server" Text="Hotel:"></asp:Label>
                    <div id="slc_hotel5"></div>

                    <div class="col-12 d-flex flex-row mt-2">
                        <asp:Button ID="Button21" runat="server" Text="Submit" CssClass="btn btn-primary col" OnClick="btnSubmit3_clicked" />
                        <asp:Button ID="Button22" runat="server" Text="Retrieve" CssClass="btn btn-secondary col" OnClick="btnRetrieve3_clicked" />
                        <asp:Button ID="Button23" runat="server" Text="Update" CssClass="btn btn-success col" OnClick="btnUpdate3_clicked" />
                        <asp:Button ID="Button24" runat="server" Text="Delete All" CssClass="btn btn-danger col" OnClick="btnDeleteAll3_clicked" />
                        <asp:Button ID="Button25" runat="server" Text="Delete" CssClass="btn btn-warning col" OnClick="btnDelete3_clicked" />
                    </div>
                </div>
            </div>
            <div class="col-6 d-flex flex-column p-2">
                <!--Client-->
                <div class="col-12 d-flex flex-column">
                    <div class="col-12 d-flex flex-row justify-content-between">
                        <h3>Client:</h3>
                        <div id="slc_email2"></div>
                    </div>
                    <asp:Label ID="lbl_email2" runat="server" Text="Email:"></asp:Label>
                    <asp:TextBox ID="tb_email2" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_name2" runat="server" Text="Name:"></asp:Label>
                    <asp:TextBox ID="tb_name2" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_password2" runat="server" Text="Password:"></asp:Label>
                    <asp:TextBox ID="tb_password2" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_contactNumber2" runat="server" Text="Contact Number:"></asp:Label>
                    <asp:TextBox ID="tb_contactNumber2" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_description2" runat="server" Text="Description:"></asp:Label>
                    <asp:TextBox ID="tb_description2" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <asp:Label ID="lbl_location2" runat="server" Text="Location:"></asp:Label>
                    <asp:TextBox ID="tb_location2" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <div class="col-12 d-flex flex-row mt-2">
                        <asp:Button ID="Button11" runat="server" Text="Submit" CssClass="btn btn-primary col" OnClick="btnSubmit2_clicked" />
                        <asp:Button ID="Button12" runat="server" Text="Retrieve" CssClass="btn btn-secondary col" OnClick="btnRetrieve2_clicked" />
                        <asp:Button ID="Button13" runat="server" Text="Update" CssClass="btn btn-success col" OnClick="btnUpdate2_clicked" />
                        <asp:Button ID="Button14" runat="server" Text="Delete All" CssClass="btn btn-danger col" OnClick="btnDeleteAll2_clicked" />
                        <asp:Button ID="Button15" runat="server" Text="Delete" CssClass="btn btn-warning col" OnClick="btnDelete2_clicked" />
                    </div>
                </div>

                <!--Hotel-->
                <div class="col-12 d-flex flex-column mt-3">
                    <div class="col-12 d-flex flex-row justify-content-between">
                        <h3>Hotel:</h3>
                        <div id="slc_email4"></div>
                    </div>

                    <asp:Label ID="lbl_email4" runat="server" Text="Email:"></asp:Label>
                    <asp:TextBox ID="tb_email4" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_name4" runat="server" Text="Name:"></asp:Label>
                    <asp:TextBox ID="tb_name4" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_password4" runat="server" Text="Password:"></asp:Label>
                    <asp:TextBox ID="tb_password4" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_contactNumber4" runat="server" Text="Contact Number:"></asp:Label>
                    <asp:TextBox ID="tb_contactNumber4" runat="server"></asp:TextBox>

                    <asp:Label ID="lbl_description4" runat="server" Text="Description:"></asp:Label>
                    <asp:TextBox ID="tb_description4" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <asp:Label ID="lbl_location4" runat="server" Text="Location:"></asp:Label>
                    <asp:TextBox ID="tb_location4" runat="server" TextMode="MultiLine"></asp:TextBox>

                    <asp:Label ID="lbl_agency4" runat="server" Text="Agency:"></asp:Label>
                    <div id="slc_agency4"></div>
                    <asp:HiddenField ID="hf_agencyEmail4" runat="server" Value="" />

                    <div class="col-12 d-flex flex-row mt-2">
                        <asp:Button ID="Button16" runat="server" Text="Submit" CssClass="btn btn-primary col" OnClick="btnSubmit4_clicked" />
                        <asp:Button ID="Button17" runat="server" Text="Retrieve" CssClass="btn btn-secondary col" OnClick="btnRetrieve4_clicked" />
                        <asp:Button ID="Button18" runat="server" Text="Update" CssClass="btn btn-success col" OnClick="btnUpdate4_clicked" />
                        <asp:Button ID="Button19" runat="server" Text="Delete All" CssClass="btn btn-danger col" OnClick="btnDeleteAll4_clicked" />
                        <asp:Button ID="Button20" runat="server" Text="Delete" CssClass="btn btn-warning col" OnClick="btnDelete4_clicked" />
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="Scripts/HP_Scripts/HP_DropDown.js"></script>
    <script>

        // Agency Email
        const slcEmail1 = new HP_DropDown("#slc_email1", { initialOption: "Choose Email" });
        $.ajax({
            type: 'POST',
            url: 'test.aspx/getAllAgency',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var agencies = JSON.parse(response.d);
                slcEmail1.clearOptions();
                for (var i = 0; i < agencies.length; i++) {
                    slcEmail1.addOption(agencies[i].credential.email, agencies[i].credential.email)
                }
                slcEmail1.onChange(function () {
                    $("#<%= tb_email1.ClientID %>").val(slcEmail1.getValue());
                });
            },
            error: function (error) {
                console.log("error: unable to retreive agencies data");
            }
        });

        // Client Email
        const slcEmail2 = new HP_DropDown("#slc_email2", { initialOption: "Choose Email" });
        $.ajax({
            type: 'POST',
            url: 'test.aspx/getAllDirectClient',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var clients = JSON.parse(response.d);
                slcEmail2.clearOptions();
                for (var i = 0; i < clients.length; i++) {
                    slcEmail2.addOption(clients[i].credential.email, clients[i].credential.email);
                }
                slcEmail2.onChange(function () {
                    $("#<%= tb_email2.ClientID %>").val(slcEmail1.getValue());
                });
            },
            error: function (error) {
                console.log("error: unable to retreive clients data");
            }
        });

        // Agency's Client
        const slcEmail3 = new HP_DropDown("#slc_email3", { initialOption: "Choose Email" });
        const slcClient3 = new HP_DropDown("#slc_client3", { initialOption: "Choose Client" });
        $.ajax({
            type: 'POST',
            url: 'test.aspx/getAllAgencyWithClient',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var agencies = JSON.parse(response.d);
                slcEmail3.clearOptions();
                for (var i = 0; i < agencies.length; i++) {
                    slcEmail3.addOption(agencies[i].credential.email, agencies[i].credential.email);
                }
                slcEmail3.onChange(function () {
                    var email = $("#slc_email3").val();
                    $("#<%= tb_email3.ClientID %>").val(email);

                    // Agency's Client's Id
                    $.ajax({
                        type: 'POST',
                        url: 'test.aspx/getAgencyAllClient',
                        data: JSON.stringify({ email: email }),
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        success: function (response) {
                            var clients = JSON.parse(response.d);
                            slcClient3.clearOptions();
                            for (var i = 0; i < clients.length; i++) {
                                slcClient3.addOption(clients[i].name, clients[i].id);
                            }
                            slcClient3.onChange(function () {
                                $("#<%= hf_clientId3.ClientID %>").val(slcClient3.getValue());
                            });
                        },
                        error: function (error) {
                            console.log("error: unable to retreive agencies's client");
                        }
                    });
                });
            },
            error: function (error) {
                console.log("error: unable to retreive agencies's email");
            }
        });

        // Hotel's Email
        const slcEmail4 = new HP_DropDown("#slc_email4", { initialOption: "Choose Email" });
        $.ajax({
            type: 'POST',
            url: 'test.aspx/getAllHotel',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var hotels = JSON.parse(response.d);
                slcEmail4.clearOptions();
                for (var i = 0; i < hotels.length; i++) {
                    slcEmail4.addOption(hotels[i].email, hotels[i].email)
                }
                slcEmail4.onChange(function () {
                    $("#<%= tb_email4.ClientID %>").val(slcEmail4.getValue());
                });
            },
            error: function (error) {
                console.log("error: unable to retrieve hotels");
            }
        });

        // Hotel's Agency
        const slcAgency4 = new HP_DropDown("#slc_agency4", { initialOption: "Choose Agency" });
        $.ajax({
            type: 'POST',
            url: 'test.aspx/getAllAgency',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var agencies = JSON.parse(response.d);
                slcAgency4.clearOptions();
                for (var i = 0; i < agencies.length; i++) {
                    slcAgency4.addOption(agencies[i].name, agencies[i].id)
                }
                slcAgency4.onChange(function () {
                    $("#<%= hf_agencyEmail4.ClientID %>").val(slcAgency4.getValue());
                });
            },
            error: function (error) {
                console.log("error: unable to retrieve hotel's agency");
            }
        });

        // Content's Hotel
        const slcHotel5 = new HP_DropDown("#slc_hotel5", { initialOption: "Choose Hotel" });
    </script>
</asp:Content>
