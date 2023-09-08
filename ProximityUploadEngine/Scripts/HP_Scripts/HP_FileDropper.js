class HP_FileDropper {
    constructor(mainElement,
        {
            mime,
            txt_messagePrompt, txt_onHover, txt_onDrag, txt_messageError,
            clr_onHover, clr_offHover,
            bdr_onDrag, bdr_offDrag,
            borderOn = true, fadeIn = false,
            onSuccess, onError
        } = {}) {

        this.file = null;
        this.mime = mime;
        this.borderOn = borderOn;
        this.onSuccess = onSuccess == null ? function () { } : onSuccess;
        this.onError = onError == null ? function () { } : onError;

        this.txt_messagePrompt = txt_messagePrompt == null ? "" : txt_messagePrompt;
        this.txt_onHover = txt_onHover == null ? this.txt_messagePrompt : txt_onHover;
        this.txt_onDrag = txt_onDrag == null ? this.txt_messagePrompt : txt_onDrag;
        this.txt_messageError = txt_messageError == null ? "" : txt_messageError;
        this.clr_onHover = clr_onHover == null ? "transparent" : clr_onHover;
        this.clr_offHover = clr_offHover == null ? this.clr_onHover : clr_offHover;
        this.bdr_onDrag = bdr_onDrag == null ? "2px dashed black" : bdr_onDrag;
        this.bdr_offDrag = bdr_offDrag == null ? "2px solid black" : bdr_offDrag;


        this.element = $(mainElement).addClass("HP-FileDropper");
        this.dropwrapper = this.element;
        this.icon = $("<i>").addClass("fa fa-cloud-upload HP-icn-drop").attr('aria-hidden', 'true');
        this.messagePrompt = $("<span>").addClass("HP-drop-messagePrompt").text(txt_messagePrompt);
        this.messageErrorWrapper = $("<div>").addClass("HP-drop-messageError");
        this.iconError = $("<i>").addClass("fa fa-exclamation-circle").attr('aria-hidden', 'true');
        this.messageError = $("<span>").text(txt_messageError);
        this.dropZone = $("<div>").addClass("HP-drop-zone");

        this.messageErrorWrapper.append(this.iconError, this.messageError);
        this.dropwrapper.append(this.icon, this.messagePrompt, this.messageErrorWrapper, this.dropZone);

        if (!this.borderOn) {
            this.dropwrapper.css('border', "none");
        }
        else if (bdr_offDrag != null) {
            this.updateBorder(null, this.bdr_offDrag);
        }
        if (fadeIn) {
            $(".HP-icn-drop, .HP-drop-messagePrompt").hide();
            $(".HP-icn-drop, .HP-drop-messagePrompt").fadeIn(500);
        }

        // Drag and Drop handler
        this.dropZone.on('dragover', (e) => {
            this.updateBorder(e, this.bdr_onDrag);
            this.updateAttr('fa-cloud-upload', 'fa-chevron-circle-down', this.txt_onDrag, this.clr_onHover);
        });

        this.dropZone.on('dragleave', (e) => {
            this.updateBorder(e, this.bdr_offDrag);
            this.updateAttr('fa-chevron-circle-down', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);
        });

        this.dropZone.on('drop', (e) => {
            this.updateBorder(e, this.bdr_offDrag);
            this.updateAttr('fa-chevron-circle-down', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);

            var file = e.originalEvent.dataTransfer.files[0];
            this.handleFile(file);
        });

        // Click handler
        this.dropwrapper.click(() => {
            this.updateAttr('fa-folder', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);

            var input = $("<input>");
            const mime = this.mime == null ? "/" : this.mime;
            input.attr("type", "file").attr("accept", `${mime}*`).attr("multiple", false)
                .change((event) => {
                    var file = event.target.files[0];
                    this.handleFile(file);
                });
            input.click();
        });

        // Hover handler
        this.dropwrapper.hover(
            () => {
                this.updateAttr('fa-cloud-upload', 'fa-folder', this.txt_onHover, this.clr_onHover);
            },
            () => {
                this.updateAttr('fa-folder', 'fa-cloud-upload', this.txt_messagePrompt, this.clr_offHover);
            }
        );
    }
    updateBorder(e, borderStyle) {
        if (e != null) {
            e.preventDefault();
        }
        if (this.borderOn) {
            this.dropwrapper.css('border', borderStyle);
        }
    }
    updateAttr(oldIconClass, newIconClass, newTextPrompt, newBgColor) {
        this.icon.removeClass(oldIconClass).addClass(newIconClass);
        if (newTextPrompt != null) {
            this.messagePrompt.text(newTextPrompt);
        }
        if (newBgColor != null) {
            this.dropwrapper.css("background-color", newBgColor);
        }
    }
    handleFile(file) {
        this.file = null;

        if (this.mime == null ? false : !file.type.startsWith(this.mime)) {
            this.messageErrorWrapper.show();
            this.onError();
        } else {
            this.messageErrorWrapper.hide();

            this.file = file;
            this.onSuccess();
        }
    }
    getFile() {
        return this.file;
    }
    readFile() {
        var reader = new FileReader();
        reader.onload = (e) => {
            console.log('File data:', e.target.result);
            reader.remove();
        };
        reader.readAsDataURL(this.file);
    }
}