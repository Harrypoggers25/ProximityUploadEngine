class HP_Cropper {
    constructor(mainElement) {
        this.element = $(mainElement).addClass("HP-Cropper");
        this.wrapper = $("<div>").addClass("HP-Crop-Image-Wrapper");
        this.image = $("<img>").addClass("HP-Crop-Image");
        this.box = $("<div>").addClass("HP-Crop-Box");

        this.wrapper.append(this.image, this.box);
        this.element.append(this.wrapper);

        this.resizeElement(this.box);
        this.recenterElement(this.box);

        this.onImageLoad = null;

        this.image[0].onload = () => {
            this.image.css("height", "100%");
            this.image.css("width", "auto");
            this.resizeElement(this.image);
            this.recenterElement(this.image);

            this.rw = this.image[0].width;
            this.rh = this.image[0].height;

            this.aw = this.image[0].naturalWidth;
            this.ah = this.image[0].naturalHeight;

            this.ratio = this.aw / this.rw;
            this.rk = 0;

            this.onImageLoad();
        }
        this.image.draggable({ drag: (event, ui) => { this.edgeBound(event, ui); } });
        this.wrapper.on("wheel", (event) => {
            event.preventDefault();
            var drk = event.originalEvent.deltaY * -0.01 * 5;
            if (this.rk + drk <= 0) {
                this.rk = 0;
                drk = 0;
            }
            else {
                this.rk += drk;
            }
            const dw = drk;
            const dh = dw / this.aw * this.ah;

            this.setImageSize(this.rw + this.rk, this.rh + this.rk / this.aw * this.ah);
            this.setPos(this.image, this.getLeft(this.image) - dw / 2, this.getTop(this.image) - dh / 2);
            this.edgeBound();
            //this.printInfo();
        });
    }
    loadImage(src, onImageLoad = function () { }) {
        this.onImageLoad = onImageLoad;
        this.image.attr("src", src).css("display", "block");
    }
    getRect() {
        const rx = Math.round(this.getLeft(this.image) - this.getLeft(this.box));
        const ry = Math.round(this.getTop(this.image) - this.getTop(this.box));

        const ak = this.ratio * this.rk;
        const ax = Math.round(this.ratio * rx);
        const ay = Math.round(this.ratio * ry);

        const bh = Math.round(this.ah * this.ah / (this.ah + ak / this.aw * this.ah));
        const bw = bh;
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

        //this.printInfo();
    }
    printInfo() {
        const rx = Math.round(this.getLeft(this.image) - this.getLeft(this.box));
        const ry = Math.round(this.getTop(this.image) - this.getTop(this.box));

        const ak = this.ratio * this.rk;
        const ax = Math.round(this.ratio * rx);
        const ay = Math.round(this.ratio * ry);

        const bh = this.ah * this.ah / (this.ah + ak / this.aw * this.ah);
        const bw = bh;
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