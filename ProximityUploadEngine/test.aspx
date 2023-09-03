<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .HP-ProfilePicture,
        .HP-ProfilePicture .HP-Background-Wrapper,
        .HP-ProfilePicture .HP-Background-Wrapper > * {
            border-radius: 50%;
        }

            .HP-ProfilePicture,
            .HP-ProfilePicture .HP-Background-Wrapper,
            .HP-ProfilePicture .HP-Hover-Wrapper {
                display: flex;
                justify-content: center;
                align-items: center;
            }

        .HP-ProfilePicture {
            width: 200px;
            height: 200px;
            background-color: black;
        }

            .HP-ProfilePicture input {
                display: none;
            }

            .HP-ProfilePicture .HP-Background-Wrapper {
                position: relative;
                width: 97%;
                height: 97%;
                background-color: white;
            }

                .HP-ProfilePicture .HP-Background-Wrapper > * {
                    position: absolute;
                    width: 100%;
                    height: 100%;
                }

            .HP-ProfilePicture .HP-Image-Wrapper {
                overflow: hidden;
            }

                .HP-ProfilePicture .HP-Image-Wrapper .HP-Image {
                    position: absolute;
                    opacity: 1;
                }

            .HP-ProfilePicture .HP-Hover-Background {
                background: black;
            }

            .HP-ProfilePicture .HP-Hover-Wrapper {
                flex-direction: column;
                color: white;
                font-size: 20px;
            }

                .HP-ProfilePicture .HP-Hover-Wrapper .HP-Icn-Hover {
                    font-size: 35px;
                }

            .HP-ProfilePicture .HP-Clickable {
                opacity: 0;
                transition: opacity ease 0.20s;
                cursor: pointer;
            }
    </style>
    <main>
        <div class="HP-ProfilePicture">
            <div class="HP-Background-Wrapper">
                <div class="HP-Image-Wrapper">
                    <img class="HP-Image" src="https://us.123rf.com/450wm/captainvector/captainvector1602/captainvector160224698/52998632-faceless-man.jpg?ver=6" />
                    <%--<img class="HP-Image" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPb_zOl9FwPdKM7B4DvrpR1q-XRZ-my14M9w&usqp=CAU" />--%>
                </div>
                <div class="HP-Hover-Background HP-Clickable"></div>
                <div class="HP-Hover-Wrapper HP-Clickable">
                    <i class="fa fa-camera HP-Icn-Hover" aria-hidden="true"></i>
                    <span class="HP-Txt-Hover">Change Photo</span>
                </div>
            </div>
        </div>
    </main>
    <script>
        $(document).ready(function () {

            var url = null;
            const rect1 = { x: 0, y: 0, w: 450, h: 450 }

            setImageRect(rect1);

            $(".HP-Image").hide();
            $(".HP-Image").fadeIn(500);

            function updateImage(file) {
                if (url != null) {
                    URL.revokeObjectURL(url);
                }
                url = URL.createObjectURL(file);
                loadImageFromUrl(url);
            }
            function loadImageFromUrl(url) {
                $(".HP-Image")[0].src = url;
                $(".HP-Image")[0].onload = function () {
                    const w = $(".HP-Image")[0].naturalWidth;
                    const h = $(".HP-Image")[0].naturalHeight;
                    const k = h > w ? w : h;
                    const x = w / 2 - k / 2;
                    const y = h / 2 - k / 2;
                    const rect2 = { x: x, y: y, w: k, h: k };
                    setImageRect(rect2);
                }
            }
            function setImageRect(rect) {
                const kw = $(".HP-Image-Wrapper").width() / rect.w;
                const kh = $(".HP-Image-Wrapper").height() / rect.h;
                const rw = $(".HP-Image")[0].naturalWidth * kw;
                const rh = $(".HP-Image")[0].naturalHeight * kh;
                const rx = rect.x * kw;
                const ry = rect.y * kh;

                $(".HP-Image").css({
                    "transform": "translate(" + -rx + "px, " + -ry + "px)",
                    "width": (rw) + "px",
                    "height": (rh) + "px"
                });
            }
            $(".HP-Clickable").hover(
                function () {
                    $(".HP-Hover-Background").css("opacity", "0.7");
                    $(".HP-Hover-Wrapper").css("opacity", "1");
                },
                function () {
                    $(".HP-Hover-Background").css("opacity", "0");
                    $(".HP-Hover-Wrapper").css("opacity", "0");
                }
            );
            $(".HP-Clickable").click(function () {
                const input = $("<input>")
                    .attr("type", "file").attr("accept", "image/*").attr("multiple", false)
                    .click()
                    .change((event) => {
                        const file = event.target.files[0];
                        if (file == null ? false : file.type.startsWith("image/")) {
                            updateImage(file);
                        }
                        input.remove();
                        $(".HP-Clickable").css("opacity", "0");
                    });
            });
        })
    </script>

</asp:Content>
