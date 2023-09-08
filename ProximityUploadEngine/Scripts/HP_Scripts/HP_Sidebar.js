const sidebar = $(".HP-Sidebar-Wrapper");
const navbar = $(".navbar");
const navbarHeight = navbar.height() +
    getUnitlessValue(navbar.css("padding-top")) +
    getUnitlessValue(navbar.css("padding-bottom")) +
    getUnitlessValue(navbar.css("margin-top")) +
    getUnitlessValue(navbar.css("margin-bottom"));
const initalHeight = sidebar.height() - navbarHeight;
const initalWidth = sidebar.find(".HP-Sidebar").width();
var currentWidth = initalWidth;
var currentToggle = true;

updateSidebarHeight();
updateSidebarWidth();

$(window).scroll(function () {
    updateSidebarHeight();
});
$(window).on('resize', function () {
    updateSidebarWidth();
});
sidebar.find(".HP-Sidebar").hover(
    function () {
        hovered(true);

    },
    function () {
        hovered(false);
    }
);
sidebar.find(".HP-Sidebar").on("wheel", function (event) {
    event.preventDefault();
});
function getUnitlessValue(value) {
    return parseInt(value, 10);
}
function updateSidebarWidth() {
    if (window.innerWidth < 768) {
        toggleSidebar(false);
        currentToggle = false;
        x
    }
    else {
        toggleSidebar(true);
        currentToggle = true;
    }
}
function updateSidebarHeight() {
    if (window.scrollY <= navbarHeight) {
        sidebar.css({ "height": initalHeight + window.scrollY, "position": "absolute", top: navbarHeight });
    }
    else {
        sidebar.css({ "height": "100vh", "position": "fixed", "top": 0 });
    }
}
function hovered(isHovered) {
    if (isHovered) {
        $(".HP-Sidebar-Modal").css("opacity", 0.8);
        currentWidth = 200;
        $(".HP-Sidebar li").css({ "padding-left": 50, "justify-content": "start" });
        $(".HP-Sidebar .HP-Sidebar-Text").css({ "margin-left": 20, "display": "block" });
        if (!currentToggle) {
            toggleSidebar(true);
        }
        else {
            sidebar.find(".HP-Sidebar").css("width", currentWidth);
        }
    }
    else {
        $(".HP-Sidebar-Modal").css("opacity", 0);
        currentWidth = initalWidth;
        $(".HP-Sidebar li").css({ "padding-left": 0, "justify-content": "center" });
        $(".HP-Sidebar .HP-Sidebar-Text").css({ "margin-left": 0, "display": "none" });
        if (!currentToggle) {
            toggleSidebar(false);
        }
        else {
            sidebar.find(".HP-Sidebar").css("width", currentWidth);
        }
    }
}
function toggleSidebar(isToggled) {
    if (!isToggled) {
        sidebar.find(".HP-Sidebar").hide();
        sidebar.find(".HP-Sidebar").css("width", 0);
    }
    else {
        sidebar.find(".HP-Sidebar").show();
        sidebar.find(".HP-Sidebar").css("width", currentWidth);
    }
}