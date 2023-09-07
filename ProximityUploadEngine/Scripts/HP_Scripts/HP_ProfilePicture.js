class HP_ProfilePicture {
    constructor(mainElement, { text = 'Change photo', onLoad, fadeIn = false, src = "https://us.123rf.com/450wm/captainvector/captainvector1602/captainvector160224698/52998632-faceless-man.jpg?ver=6" } = {}) {
        this.mainElement = $(mainElement).addClass("HP-ProfilePicture");
        this.bgWrapper = $("<div>").addClass("HP-Background-Wrapper");
        this.imageWrapper = $("<div>").addClass("HP-Image-Wrapper");
        this.image = $("<img>").addClass("HP-Image").attr("src", src);
        this.hoverbg = $("<div>").addClass("HP-Hover-Background HP-Clickable");
        this.hoverWrapper = $("<div>").addClass("HP-Hover-Wrapper HP-Clickable");
        this.icn_hover = $("<i>").addClass("fa fa-camera HP-Icn-Hover").attr('aria-hidden', 'true');
        this.txt_hover = $("<span>").addClass("HP-Txt-Hover").text(text);

        this.imageWrapper.append(this.image);
        this.hoverWrapper.append(this.icn_hover, this.txt_hover);
        this.bgWrapper.append(this.imageWrapper, this.hoverbg, this.hoverWrapper);
        this.mainElement.append(this.bgWrapper);

        this.clickable = $(".HP-Clickable");

        this.onLoad = onLoad == null ? function () { } : onLoad;
        this.url = null;
        this.file = null;
        this.image[0].onload = () => {
            const w = this.image[0].naturalWidth;
            const h = this.image[0].naturalHeight;
            const k = h > w ? w : h;
            const x = w / 2 - k / 2;
            const y = h / 2 - k / 2;

            this.setImageRect({ x: x, y: y, w: k, h: k });
            this.onLoad(this.image[0].src);
        };

        if (fadeIn) {
            this.image.hide();
            this.image.fadeIn(500);
        }


        this.clickable.hover(
            () => {
                this.hoverbg.css("opacity", "0.7");
                this.hoverWrapper.css("opacity", "1");
            },
            () => {
                this.hoverbg.css("opacity", "0");
                this.hoverWrapper.css("opacity", "0");
            }
        );
        this.clickable.click(() => {
            const input = $("<input>")
                .attr("type", "file").attr("accept", "image/*").attr("multiple", false)
                .click()
                .change((event) => {
                    const file = event.target.files[0];
                    if (file && file.type.startsWith("image/")) {
                        this.updateImage(file);
                    }
                    input.remove();
                    this.clickable.css("opacity", "0");
                });
        });
    }
    updateImage(file) {
        if (this.url != null) {
            URL.revokeObjectURL(this.url);
        }
        this.url = URL.createObjectURL(file);
        this.file = file;
        this.loadImageFromUrl(this.url);
    }
    loadImageFromUrl(url) {
        this.image[0].src = url;
    }
    setImageRect(rect) {
        const kw = this.imageWrapper.width() / rect.w;
        const kh = this.imageWrapper.height() / rect.h;
        const rw = this.image[0].naturalWidth * kw;
        const rh = this.image[0].naturalHeight * kh;
        const rx = rect.x * kw;
        const ry = rect.y * kh;

        this.image.css({
            "transform": "translate(" + -rx + "px, " + -ry + "px)",
            "width": rw + "px",
            "height": rh + "px"
        });
    }
    getImageFile() {
        return this.file;
    }
}
