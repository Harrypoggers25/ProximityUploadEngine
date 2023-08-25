﻿<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="userdashboard.aspx.cs" Inherits="ProximityUploadEngine.userdashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .user-header {
            font-family: 'roboto' sans-serif;
            font-weight: bold;
            font-size: 30px;
        }

        .uploader-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 55vh;
        }

        .custom-card {
            width: 50%;
            margin-top: -10vh;
            display: flex;
            flex-direction: column;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.5);
            padding: 20px;
            background-color: transparent;
        }


        .uploader {
            display: flex;
            align-items: center;
            width: 100%;
        }

        .upload-box,
        .video-preview-box {
            flex: 1;
            height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            border: 2px dashed royalblue;
            border-radius: 10px;
            margin: 0 5px;
        }

            .upload-box:hover {
                opacity: 0.5;
            }

        #videoPreviewBox {
            display: none;
        }

        #videoPreview {
            width: 95%;
            height: 95%;
            object-fit: cover;
        }

        .border-divider {
            width: 2px;
            height: 100%;
            background-color: gray;
        }

        #submitBtn {
            background-color: transparent;
            margin-left: 400px;
            width: 20%;
            margin-top: 20px;
            border: 2px dashed royalblue;
            border-radius: 10px;
        }

        #resetBtn {
            background-color: transparent;
            width: 20%;
            margin-top: 20px;
            border: 2px dashed royalblue;
            border-radius: 10px;
        }

        .dark-mode #submitBtn, .dark-mode #resetBtn, .dark-mode .uploadertext, .dark-mode .user-header {
            color: white;
        }
    </style>
    <main aria-labelledby="title">
        <div class="container">
            <div class="row my-4">
                <div class="col col-lg-6 col-sm-12">
                    <div class="card px-3 py-2">
                        <div class="card-body">
                            <h2 class="fs-4">Hi,
                                <asp:Label ID="lbl_username" runat="server" Text=""></asp:Label></h2>
                            <span id="currentTime"><%: DateTime.Now.TimeOfDay.Hours %>:<%: DateTime.Now.TimeOfDay.Minutes %> AM <%: DateTime.Now.Date.Day %>/<%: DateTime.Now.Date.Month %>/<%: DateTime.Now.Date.Year %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <center>
            <label class="user-header">UPLOAD YOUR AD</label></center>
        <div class="uploader-container">
            <div class="custom-card">
                <div class="uploader">
                    <div class="upload-box" onclick="document.getElementById('videoFile').click()">
                        <span class="uploadertext">Choose File</span>
                    </div>
                    <div class="border-divider"></div>
                    <div class="upload-box" ondrop="handleDrop(event)" ondragover="handleDragOver(event)" ondragleave="handleDragLeave(event)">
                        <span class="uploadertext">Drag your video</span>
                    </div>
                </div>
                <div class="video-preview-box" id="videoPreviewBox">
                    <video id="videoPreview" controls autoplay loop muted>
                        Your browser does not support the video tag.
                    </video>
                </div>
                <button id="resetBtn" onclick="resetVideoPreview()" style="display: none;">Change Ads</button>
                <button id="submitBtn" onclick="submitVideo()" disabled>Submit</button>

            </div>
        </div>
        <input id="videoFile" type="file" accept="video/*" onchange="handleVideoFile()" style="display: none;">
    </main>


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            function updateTime() {
                const currentTimeElement = document.getElementById("currentTime");
                const now = new Date();
                const hours = now.getHours();
                const amPm = hours >= 12 ? "PM" : "AM";
                const formattedHours = (hours % 12 || 12).toString().padStart(2, '0');
                const minutes = now.getMinutes().toString().padStart(2, '0');

                const timeString = `${formattedHours}:${minutes} ${amPm}`;
                currentTimeElement.textContent = timeString;

                const currentDate = `${now.getDate()}/${now.getMonth() + 1}/${now.getFullYear()}`;
                currentTimeElement.textContent += ` ${currentDate}`;
            }

            updateTime();
            setInterval(updateTime, 1000);
        });

        let selectedVideo = null;

        function handleVideoFile() {
            const videoFileInput = document.getElementById('videoFile');
            selectedVideo = videoFileInput.files[0];
            handleVideoPreview();
        }

        function handleDragOver(event) {
            event.preventDefault();
            event.currentTarget.classList.add('dragover');
        }

        function handleDragLeave(event) {
            event.preventDefault();
            event.currentTarget.classList.remove('dragover');
        }

        function handleDrop(event) {
            event.preventDefault();
            event.currentTarget.classList.remove('dragover');

            const droppedFiles = event.dataTransfer.files;
            if (droppedFiles.length > 0) {
                selectedVideo = droppedFiles[0];
                handleVideoPreview();
            }
        }

        function handleVideoPreview() {
            const videoPreview = document.getElementById('videoPreview');
            const videoPreviewBox = document.getElementById('videoPreviewBox');
            const submitBtn = document.getElementById('submitBtn');
            const resetBtn = document.getElementById('resetBtn');

            if (selectedVideo) {
                if (selectedVideo.type.indexOf('video/') !== 0) {
                    alert('Please select a valid video file.');
                    selectedVideo = null;
                    return;
                }

                videoPreviewBox.style.display = 'flex';
                videoPreview.src = URL.createObjectURL(selectedVideo);
                videoPreview.load();
                submitBtn.disabled = false;
                resetBtn.style.display = 'block';

                // Hide upload boxes
                document.querySelectorAll('.upload-box').forEach(box => {
                    box.style.display = 'none';
                });
            } else {
                resetVideoPreview();
            }
        }

        function resetVideoPreview() {
            const videoPreview = document.getElementById('videoPreview');
            const videoPreviewBox = document.getElementById('videoPreviewBox');
            const submitBtn = document.getElementById('submitBtn');
            const resetBtn = document.getElementById('resetBtn');

            videoPreview.pause();
            videoPreview.currentTime = 0;
            videoPreviewBox.style.display = 'none';
            submitBtn.disabled = true;
            resetBtn.style.display = 'none';

            // Show upload boxes
            document.querySelectorAll('.upload-box').forEach(box => {
                box.style.display = 'flex';
            });

            selectedVideo = null;
        }

        function submitVideo() {
            if (selectedVideo) {
                alert('Video submitted successfully!');
            }
        }

    </script>

</asp:Content>
