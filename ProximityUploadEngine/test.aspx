<%@ Page Title="Test Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="ProximityUploadEngine.test" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Scripts/HP_Scripts/HP_ProfilePicture.css" />
    <style>
        .HP-Cropper {
            background-color: black;
            aspect-ratio: 16/9;
            height: 400px;
        }

            .HP-Cropper .HP-Crop-Image-Wrapper {
                position: relative;
                width: 100%;
                height: 100%;
                overflow: hidden;
            }

            .HP-Cropper .HP-Crop-Image {
                height: 100%;
                outline: 2px dotted rgba(255,255,255,0.5);
                position: absolute;
                left: 50%;
                transform: translateX(-50%);
                /*display: none;*/
            }

            .HP-Cropper .HP-Crop-Box {
                display: flex;
                justify-content: center;
                align-items: center;
                position: absolute;
                left: 50%;
                top: 50%;
                transform: translate(-50%, -50%);
                aspect-ratio: 1;
                height: 100%;
                /*width: 1px;*/
                background-color: dimgrey;
                opacity: 0.7;
                outline: 2px dashed white;
                overflow: hidden;
                pointer-events: none;
                touch-action: none;
            }

                .HP-Cropper .HP-Crop-Box::after,
                .HP-Cropper .HP-Crop-Box::before {
                    content: "";
                    position: absolute;
                    border: 2px dashed white;
                }

                .HP-Cropper .HP-Crop-Box::after {
                    width: 120%;
                    height: 33.33%;
                }

                .HP-Cropper .HP-Crop-Box::before {
                    height: 120%;
                    width: 33.33%;
                }
    </style>
    <main>
        <div id="picture1" class="HP-ProfilePicture"></div>
        <div id="cropper1" class="HP-Cropper"></div>
        <%--<div class="HP-Cropper">
            <div class="HP-Crop-Image-Wrapper">
                <img class="HP-Crop-Image" src="https://us.123rf.com/450wm/captainvector/captainvector1602/captainvector160224698/52998632-faceless-man.jpg?ver=6" />
                <img class="HP-Crop-Image" src="/assets/images/test.png" />
                <div class="HP-Crop-Box"></div>
            </div>
        </div>--%>
    </main>
    <script src="Scripts/HP_Scripts/HP_ProfilePicture.js"></script>
    <script>
        $(document).ready(function () {
            const picture1 = new HP_ProfilePicture("#picture1", { fadeIn: true });
            class HP_Cropper {
                constructor(mainElement, { src } = {}) {
                    this.mainElement = $(mainElement).addClass("HP-Cropper");
                    this.wrapper = $("<div>").addClass("HP-Crop-Image-Wrapper");
                    this.image = $("<img>").addClass("HP-Crop-Image").attr("src", src);
                    this.box = $("<div>").addClass("HP-Crop-Box");

                    this.wrapper.append(this.image, this.box);
                    this.mainElement.append(this.wrapper);

                    this.resizeElement(this.box);
                    this.recenterElement(this.box);

                    this.resizeElement(this.image);
                    this.recenterElement(this.image)

                    // constant relative values
                    this.rw = this.image[0].width;
                    this.rh = this.image[0].height;
                    // constant actual values
                    this.aw = this.image[0].naturalWidth;
                    this.ah = this.image[0].naturalHeight;

                    this.ratio = this.aw / this.rw;
                    this.rk = 0;

                    this.image.draggable({ drag: (event, ui) => { this.edgeBound(event, ui); } });
                    this.wrapper.hover(
                        () => {
                            $('body').css('overflow', 'hidden');
                        },
                        () => {
                            $('body').css('overflow', 'auto');
                        }
                    );
                    this.wrapper.on("wheel", (event) => {
                        var drk = event.originalEvent.deltaY * -0.01 * 2;
                        if (this.rk + drk <= 0) {
                            this.rk = 0;
                            drk = 0;
                        }
                        else {
                            this.rk += drk;
                        }
                        this.edgeBound();

                        this.setImageSize(this.rk + this.rw, this.rk + this.rh);
                        this.setPos(this.image, this.getLeft(this.image) - drk / 2, this.getTop(this.image) - drk / 2)
                        //printInfo();
                    });
                }
                getRect() {
                    const rx = Math.round(this.getLeft(this.image) - this.getLeft(this.box));
                    const ry = Math.round(this.getTop(this.image) - this.getTop(this.box));

                    const ak = this.ratio * this.rk;
                    const ax = Math.round(this.ratio * rx);
                    const ay = Math.round(this.ratio * ry);

                    const bw = this.box.width() * this.box.width() / (this.rw + this.rk);
                    const bh = this.box.height() * this.box.height() / (this.rh + this.rk);
                    const x = -Math.round(this.aw / (this.aw + ak) * ax);
                    const y = -Math.round(this.aw / (this.aw + ak) * ay);

                    return { x: x, y: y, w: bw, h: bh };
                }
                getLeft(element) {
                    return element.position().left;
                }
                getTop(element) {
                    return element.position().top;
                }
                setPos(element, x, y) {
                    element.css({ "left": `${x}px`, "top": `${y}px` });
                }
                setImageSize(w, h) {
                    this.image.css({ "width": `${w}px`, "height": `${h}px` });
                }
                recenterElement(element) {
                    this.setPos(element, (this.wrapper.width() - element.width()) / 2, (this.wrapper.height() - element.height()) / 2);
                    element.css("transform", "none");
                };
                resizeElement(element) {
                    element.css({ "width": `${element.width() - 4}px`, "height": `${element.height() - 4}px` });
                }
                edgeBound(event = null, ui = null) {
                    const dw = this.getLeft(this.box) - this.image[0].width + this.box.width();
                    const dh = this.getTop(this.box) - this.image[0].height + this.box.height();

                    if (event == null && ui == null) {
                        var top = this.getTop(this.image) > this.getTop(this.box) ? this.getTop(this.box) : this.getTop(this.image) < dh ? dh : this.getTop(this.image);
                        var left = this.getLeft(this.image) > this.getLeft(this.box) ? this.getLeft(this.box) : this.getLeft(this.image) < dw ? dw : this.getLeft(this.image);
                        this.setPos(this.image, left, top);
                    }
                    else {
                        ui.position.top = ui.position.top > this.getTop(this.box) ? this.getTop(this.box) : ui.position.top < dh ? dh : ui.position.top;
                        ui.position.left = ui.position.left > this.getLeft(this.box) ? this.getLeft(this.box) : ui.position.left < dw ? dw : ui.position.left;
                    }

                    //printInfo();
                }
                printInfo() {
                    const rx = Math.round(this.getLeft(this.image) - this.getLeft(this.box));
                    const ry = Math.round(this.getTop(this.image) - this.getTop(this.box));

                    const ak = this.ratio * this.rk;
                    const ax = Math.round(this.ratio * rx);
                    const ay = Math.round(this.ratio * ry);

                    const bw = this.box.width() * this.box.width() / (this.rw + this.rk);
                    const bh = this.box.height() * this.box.height() / (this.rh + this.rk);
                    const x = -Math.round(this.aw / (this.aw + ak) * ax);
                    const y = -Math.round(this.aw / (this.aw + ak) * ay);

                    console.clear();
                    console.log(`Box\n\n` +
                        `ak: ${ak}\n\n` +
                        `Actual\n` +
                        `Width: ${bw}\n` +
                        `Height: ${bh}\n` +
                        `x: ${x}\n` +
                        `y: ${y}\n\n`);
                    console.log(`Image\n\n` +
                        `rk: ${this.rk}\n\n` +
                        `Actual\n` +
                        `Width: ${this.aw}\n` +
                        `Height: ${this.ah}\n` +
                        `x: ${x}\n` +
                        `y: ${y}\n\n` +
                        `Absolute\n` +
                        `Width: ${this.aw + ak}\n` +
                        `Height: ${this.ah + ak}\n` +
                        `x: ${ax}\n` +
                        `y: ${ay}\n\n` +
                        `Relative\n` +
                        `Width: ${this.rw + this.rk}\n` +
                        `Height: ${this.rh + this.rk}\n` +
                        `x: ${rx}\n` +
                        `y: ${ry}\n\n`);
                }
            }
            const cropper = new HP_Cropper("#cropper1", {
                src: "/assets/images/test.png"
            })
            //const box = $(".HP-Crop-Box");
            //resizeElement(box);
            //recenterElement(box);
            //const image = $(".HP-Crop-Image");
            //resizeElement(image);
            //recenterElement(image)

            //// relative values
            //const rw = image[0].width;
            //const rh = image[0].height;
            //// actual values
            //const aw = image[0].naturalWidth;
            //const ah = image[0].naturalHeight;

            //const ratioAR = aw / rw;
            //var rk = 0;

            //image.draggable({ drag: function (event, ui) { edgeBound(event, ui); } });
            //$(".HP-Crop-Image-Wrapper").hover(
            //    function () {
            //        $('body').css('overflow', 'hidden');
            //    },
            //    function () {
            //        $('body').css('overflow', 'auto');
            //    }
            //);
            //$(".HP-Crop-Image-Wrapper").on("wheel", function (event) {
            //    var drk = event.originalEvent.deltaY * -0.01 * 2;
            //    image.off("drag");
            //    if (rk + drk <= 0) {
            //        rk = 0;
            //        drk = 0;
            //    }
            //    else {
            //        rk += drk;
            //    }
            //    edgeBound();

            //    setImageSize(rk + rw, rk + rh);
            //    setPos(image, getLeft(image) - drk / 2, getTop(image) - drk / 2)
            //    //printInfo();
            //});
            //function getRect() {
            //    const rx = Math.round(getLeft(image) - getLeft(box));
            //    const ry = Math.round(getTop(image) - getTop(box));

            //    const ak = ratioAR * rk;
            //    const ax = Math.round(ratioAR * rx);
            //    const ay = Math.round(ratioAR * ry);

            //    const bw = box.width() * box.width() / (rw + rk);
            //    const bh = box.height() * box.height() / (rh + rk);
            //    const x = -Math.round(aw / (aw + ak) * ax);
            //    const y = -Math.round(aw / (aw + ak) * ay);

            //    return { x: x, y: y, w: bw, h: bh };
            //}
            //function getLeft(element) {
            //    return element.position().left;
            //}
            //function getTop(element) {
            //    return element.position().top;
            //}
            //function setPos(element, x, y) {
            //    element.css({ "left": `${x}px`, "top": `${y}px` });
            //}
            //function setImageSize(w, h) {
            //    image.css({ "width": `${w}px`, "height": `${h}px` });
            //}
            //function recenterElement(element) {
            //    setPos(element, ($(".HP-Crop-Image-Wrapper").width() - element.width()) / 2, ($(".HP-Crop-Image-Wrapper").height() - element.height()) / 2);
            //    element.css("transform", "none");
            //};
            //function resizeElement(element) {
            //    element.css({ "width": `${element.width() - 4}px`, "height": `${element.height() - 4}px` });
            //}
            //function edgeBound(event = null, ui = null) {
            //    const dw = getLeft(box) - image[0].width + $(".HP-Crop-Box").width();
            //    const dh = getTop(box) - image[0].height + $(".HP-Crop-Box").height();

            //    if (event == null && ui == null) {
            //        var top = getTop(image) > getTop(box) ? getTop(box) : getTop(image) < dh ? dh : getTop(image);
            //        var left = getLeft(image) > getLeft(box) ? getLeft(box) : getLeft(image) < dw ? dw : getLeft(image);
            //        setPos(image, left, top);
            //    }
            //    else {
            //        ui.position.top = ui.position.top > getTop(box) ? getTop(box) : ui.position.top < dh ? dh : ui.position.top;
            //        ui.position.left = ui.position.left > getLeft(box) ? getLeft(box) : ui.position.left < dw ? dw : ui.position.left;
            //    }

            //    //printInfo();
            //}
            //function printInfo() {
            //    const rx = Math.round(getLeft(image) - getLeft(box));
            //    const ry = Math.round(getTop(image) - getTop(box));

            //    const ak = ratioAR * rk;
            //    const ax = Math.round(ratioAR * rx);
            //    const ay = Math.round(ratioAR * ry);

            //    const bw = box.width() * box.width() / (rw + rk);
            //    const bh = box.height() * box.height() / (rh + rk);
            //    const x = -Math.round(aw / (aw + ak) * ax);
            //    const y = -Math.round(aw / (aw + ak) * ay);

            //    console.clear();
            //    console.log(`Box\n\n` +
            //        `ak: ${ak}\n\n` +
            //        `Actual\n` +
            //        `Width: ${bw}\n` +
            //        `Height: ${bh}\n` +
            //        `x: ${x}\n` +
            //        `y: ${y}\n\n`);
            //    console.log(`Image\n\n` +
            //        `rk: ${rk}\n\n` +
            //        `Actual\n` +
            //        `Width: ${aw}\n` +
            //        `Height: ${ah}\n` +
            //        `x: ${x}\n` +
            //        `y: ${y}\n\n` +
            //        `Absolute\n` +
            //        `Width: ${aw + ak}\n` +
            //        `Height: ${ah + ak}\n` +
            //        `x: ${ax}\n` +
            //        `y: ${ay}\n\n` +
            //        `Relative\n` +
            //        `Width: ${rw + rk}\n` +
            //        `Height: ${rh + rk}\n` +
            //        `x: ${rx}\n` +
            //        `y: ${ry}\n\n`);
            //}
        })
    </script>

</asp:Content>
