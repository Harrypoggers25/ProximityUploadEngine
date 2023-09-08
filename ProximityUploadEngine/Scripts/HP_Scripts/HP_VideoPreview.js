class HP_VideoPreview {
    constructor(mainElement, { txt_UnloadedVideo, txt_ErrorLoadVideo, fadeIn = false, onSuccessLoad, onErrorLoad, onUnload } = {}) {
        this.onSuccessLoad = onSuccessLoad == null ? function () { } : onSuccessLoad;
        this.onErrorLoad = onErrorLoad == null ? function () { } : onErrorLoad;
        this.onUnload = onUnload == null ? function () { } : onUnload;

        this.str_UnloadedVideo = txt_UnloadedVideo == null ? "No Video Loaded" : txt_UnloadedVideo;
        this.str_ErrorLoadVideo = txt_ErrorLoadVideo == null ? "Error: Unable to Load Video" : txt_ErrorLoadVideo;

        this.element = $(mainElement).addClass("HP-VideoPreview");
        this.videoWrapper = $("<div>").addClass("HP-Video-Wrapper");
        this.unloadVideoWrapper = $("<div>").addClass("HP-Unloaded-Video-Wrapper");
        this.icn_Error = $("<i>").addClass("fa fa-exclamation-circle Icn-Error");
        this.txt_unloadedVideo = $("<span>").addClass("HP-Text-Unloaded-Video")
            .text(this.str_UnloadedVideo);
        this.video = $("<video>").addClass("HP-Video").attr("controls", true);
        this.video[0].onloadeddata = () => {
            this.unloadVideoWrapper.hide();
            this.video[0].muted = true;
            this.video.show();
            this.onSuccessLoad();
        }
        this.unloadVideoWrapper.append(this.icn_Error, this.txt_unloadedVideo);
        this.videoWrapper.append(this.video, this.unloadVideoWrapper);
        this.element.append(this.videoWrapper);

        if (fadeIn) {
            this.unloadVideoWrapper.hide();
            this.unloadVideoWrapper.fadeIn(500);
        }
    }
    loadVideo(file) {
        if (file == null ? true : !file.type.startsWith('video/')) {
            this.txt_unloadedVideo.text(this.str_ErrorLoadVideo);
            this.icn_Error.show();
            this.unloadVideo();
            this.onErrorLoad();
        } else {
            this.txt_unloadedVideo.text(this.str_UnloadedVideo);
            this.icn_Error.hide();
            this.unloadVideo();
            this.video[0].src = URL.createObjectURL(file);
            this.video[0].load();
        }
    }
    unloadVideo() {
        if (this.video[0].src != "") {
            URL.revokeObjectURL(this.video[0].src);
            this.video[0].src = "";
        }
        this.video.hide();
        this.unloadVideoWrapper.show();
        this.onUnload();
    }
}