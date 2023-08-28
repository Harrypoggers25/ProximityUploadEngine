<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="agencydashboard.aspx.cs" Inherits="ProximityUploadEngine.agencydashboard" %>

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
        margin-top: 5vh;
        margin-left: 300px;
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

    .button-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 50%;
        margin: 20px auto;
    }

    #submitBtn, #resetBtn {
        background-color: steelblue;
        border-color: royalblue;
        width: 48%;
        border-radius: 10px;
    }



    .dark-mode #submitBtn, .dark-mode #resetBtn, .dark-mode .uploadertext, .dark-mode .user-header, .dark-mode .fa-cloud-upload,
    .dark-mode .fa-video-camera, .dark-mode #optionSelector, .dark-mode #optionSelector-option {
        color: white;
    }

    .error-message {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: rgba(255, 0, 0, 0.8);
        color: white;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
    }

    .success-message {
        display: none;
        text-align: center;
        margin-top: 10px;
        font-size: 16px;
        color: green;
    }

    .success-icon {
        font-size: 20px;
        margin-right: 5px;
    }

    .border-divider {
        width: 2px;
        height: 100%;
        background-color: gray;
        margin: 0 10px;
    }

    .option-dropdown {
        display: inline-block;
        margin-left: 10px;
    }

    #optionSelector {
        padding: 8px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 10px;
        background-color: transparent;
        cursor: pointer;
    }

        #optionSelector option {
            padding: 5px;
            font-size: 14px;
            background-color: transparent;
            color: black;
        }

    </style>
    <main aria-labelledby="title">
        <div class="container">
            <div class="row my-4">
                <div class="col col-lg-6 col-sm-12">
                    <div class="card px-3 py-2">
                        <div class="card-body">
                            <h2 class="fs-4">Hi,
                                <asp:Label ID="lbl_username" runat="server" Text=""></asp:Label>
                            </h2>
                            <span id="currentTime"><%: DateTime.Now.TimeOfDay.Hours %>:<%: DateTime.Now.TimeOfDay.Minutes %> AM <%: DateTime.Now.Date.Day %>/<%: DateTime.Now.Date.Month %>/<%: DateTime.Now.Date.Year %></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="custom-card">
            <center>
                <label class="user-header">UPLOAD YOUR ADVERTISEMENT</label>
            </center>
            <div class="border-divider"></div>
            <div class="option-dropdown">
                <select id="optionSelector">
                    <option value="" disabled selected>Select an option</option>
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                    <!-- Add more options as needed -->
                </select>
            </div>
            <br />
            <div class="uploader">
                <div class="upload-box" onclick="document.getElementById('videoFile').click()">
                    <i class="fa fa-cloud-upload" aria-hidden="true" style="font-size: 50px;"></i>
                    <span class="uploadertext">Upload Video</span>
                </div>
                <div class="border-divider"></div>
                <div class="upload-box" ondrop="handleDrop(event)" ondragover="handleDragOver(event)" ondragleave="handleDragLeave(event)">
                    <i class="fa fa-video-camera" aria-hidden="true" style="font-size: 50px;"></i>
                    <span class="uploadertext">Drag video</span>
                </div>
            </div>

            <!-- Error Message -->
            <div id="errorMessage" class="error-message">
                <i class="fa fa-exclamation-circle" aria-hidden="true"></i>
                Please select a valid video file.
            </div>

            <!-- Success Message -->
            <div class="success-message" id="successMessage">
                <i class="fa fa-check-circle success-icon" aria-hidden="true"></i>
                Video submitted successfully!
            </div>


            <div class="video-preview-box" id="videoPreviewBox">
                <video id="videoPreview" controls autoplay loop muted>
                    Your browser does not support the video tag.
                </video>
            </div>
            <div class="button-container">
                <button id="resetBtn" onclick="resetVideoPreview()" style="display: none;">
                    <i class="fa fa-chevron-circle-left" aria-hidden="true" style="font-size: 15px; margin-right: 5px;"></i>Change Ads
                </button>
                <button id="submitBtn" onclick="submitVideo()" disabled>
                    <i class="fa fa-upload" aria-hidden="true" style="font-size: 15px; margin-right: 5px;"></i>Submit
                </button>
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
              const optionSelector = document.getElementById('optionSelector');

    optionSelector.addEventListener('change', function() {
        // No need to update the selectedOptionText span
    });


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
            const errorMessage = document.getElementById('errorMessage');

            if (selectedVideo) {
                if (selectedVideo.type.indexOf('video/') !== 0) {
                    errorMessage.style.display = 'block';
                    selectedVideo = null;
                    return;
                }

                errorMessage.style.display = 'none';
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
            const errorMessage = document.getElementById('errorMessage');

            videoPreview.pause();
            videoPreview.currentTime = 0;
            videoPreviewBox.style.display = 'none';
            submitBtn.disabled = true;
            resetBtn.style.display = 'none';
            errorMessage.style.display = 'none';

            // Show upload boxes
            document.querySelectorAll('.upload-box').forEach(box => {
                box.style.display = 'flex';
            });

            selectedVideo = null;
        }

        function submitVideo() {
            const videoPreviewBox = document.getElementById('videoPreviewBox');
            const submitBtn = document.getElementById('submitBtn');
            const resetBtn = document.getElementById('resetBtn');
            const errorMessage = document.getElementById('errorMessage');
            const successMessage = document.getElementById('successMessage');

            if (selectedVideo) {
                // Display success message
                successMessage.style.display = 'block';

                // Hide other elements
                submitBtn.disabled = true;
                resetBtn.style.display = 'none';
                videoPreviewBox.style.display = 'none';
                errorMessage.style.display = 'none';

                // Show upload boxes
                document.querySelectorAll('.upload-box').forEach(box => {
                    box.style.display = 'flex';
                });

                // Clear background music and reset video after a delay
                 setTimeout(function () {
            videoPreview.pause();
            videoPreview.currentTime = 0;
            videoPreview.src = "";
            resetVideoPreview();
            successMessage.style.display = 'none'; // Hide the success message
            location.reload(); // Refresh the page after 10 seconds
        }, 3000); // 10 seconds in milliseconds
    } else {
        // Display error message
        errorMessage.style.display = 'block';
    }
}
    </script>

</asp:Content>

