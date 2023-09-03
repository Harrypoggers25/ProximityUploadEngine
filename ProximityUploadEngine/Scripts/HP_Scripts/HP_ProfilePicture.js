class HP_Rect {
    constructor(x = 0, y = 0, w = 0, h = 0) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
    }
}
class HP_ProfilePicture {
    constructor(mainElement, { imgId, fileUploadId, imgSrc, fadeIn = false } = {}) {
        this.mainElement = $(mainElement);
        this.imgElement = imgId == null ? $('<img>').addClass('HP-img-profile-picture') : $("#" + imgId);
        this.icnWrapper = $('<div>').addClass('HP-icn-profile-picture');
        this.icn = $('<i>').addClass('fa fa-camera').attr('aria-hidden', 'true');
        this.span = $('<span>').text('Change photo');
        this.icnWrapper.append(this.icn, this.span);
        this.mainElement.append(this.imgElement, this.icnWrapper).addClass("HP-ProfileProfile");

        this.imgElement[0].src = imgSrc == null ? "https://us.123rf.com/450wm/captainvector/captainvector1602/captainvector160224698/52998632-faceless-man.jpg?ver=6" : imgSrc;
        this.resizeFitImageInContainer();
        if (fadeIn) {
            this.imgElement.hide();
            this.imgElement.fadeIn(1000);
        }

        this.mainElement.hover(
            () => {
                this.icnWrapper.css("display", "flex");
            },
            () => {
                this.icnWrapper.css("display", "none");
            }
        );
        this.icnWrapper.click(() => {
            this.input = fileUploadId == null ? $("<input>") : $("#" + fileUploadId);
            this.input.attr("type", "file").attr("accept", "image/*").attr("multiple", false)
                .change((event) => {
                    const selectedImage = event.target.files[0];
                    if (selectedImage) {
                        this.updateImage(selectedImage);
                    }
                    if (fileUploadId == null) {
                        this.input.remove();
                    }
                });
            this.input.click();
        });
    }
    updateImage(file) {
        if (this.imgElement[0].src != "") {
            URL.revokeObjectURL(this.imgElement[0].src);
        }
        this.imgElement[0].src = URL.createObjectURL(file);
        this.resizeFitImageInContainer();
        this.icnWrapper.css("display", "none"); // fix bug: won't end hover state after file upload
    }
    resizeFitImageInContainer() {
        this.imgElement[0].onload = () => {
            const width = this.imgElement[0].width;
            const height = this.imgElement[0].height;
            if (width > height) {
                this.imgElement.css("height", "100%");
                this.imgElement.css("width", "auto");
            }
            else {
                this.imgElement.css("height", "auto");
                this.imgElement.css("width", "100%");
            }
        }
    }
};
