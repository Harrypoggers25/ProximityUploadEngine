//HTML Structure
//<div class="HP-Sidebar-Wrapper">
//    <div class="HP-Sidebar-Modal"></div>
//    <div id="pnl_sidebar" class="HP-Sidebar">
// all uls are sections
//        <ul class="HP-Sidebar-Header">
//            <li>
//                <i class="fas fa-bars HP-Sidebar-Icon"></i>
//                <span class="HP-Sidebar-Text">Menu</span>
//            </li>
//        </ul>
//        <ul class="HP-Sidebar-Body">
//            <li class="HP-Sidebar-Nav-Item">
//                <a href="Dashboard">
//                    <i class="fas fa-home HP-Sidebar-Icon"></i>
//                    <span class="HP-Sidebar-Text">Home</span>
//                </a>
//            </li>
//            <li class="HP-Sidebar-Nav-Item">
//                <a href="Settings">
//                    <i class="fas fa-cog HP-Sidebar-Icon"></i>
//                    <span class="HP-Sidebar-Text">Settings</span>
//                </a>
//            </li>
//            <li class="HP-Sidebar-Nav-Item">
//                <a href="Default">
//                    <i class="fas fa-sign-out HP-Sidebar-Icon"></i>
//                    <span class="HP-Sidebar-Text">Logout</span>
//                </a>
//            </li>
//        </ul>
//        <ul class="HP-Sidebar-Footer">
//            <li>DarkMode

//            </li>
//        </ul>
//    </div>
//</div>

class HP_Sidebar {
    #wrapper;
    #modal;
    #sidebar;
    #items = [];
    #header;
    #body;
    #footer;
    #initialPositionY;
    #initialHeight;
    #initialWidth;
    #currentPositionY;
    #currentWidth;
    #currentToggle;
    #maxHeight;
    constructor(mainElement, initialPositionY, { rows = [] } = {}) {
        this.element = $(mainElement).addClass("HP-Sidebar");

        this.#wrapper = $("<div>").addClass("HP-Sidebar-Wrapper");
        this.#modal = $("<div>").addClass("HP-Sidebar-Modal");
        this.#sidebar = this.element;
        this.#header = this.#getSection(this.#sidebar, "ul", "HP-Sidebar-Header");
        this.#body = this.#getSection(this.#sidebar, "ul", "HP-Sidebar-Body");
        this.#footer = this.#getSection(this.#sidebar, "ul", "HP-Sidebar-Footer");

        this.#sidebar.replaceWith(this.#wrapper);
        const sections = [this.#header, this.#body, this.#footer];
        for (var i = 0; i < rows.length; i++) {
            if (rows[i] == null) {
                continue;
            }
            const row = {
                icon: rows[i].icon == null ? "" : rows[i].icon,
                text: rows[i].text != null ? rows[i].text : this.#items[i].element.text(),
                href: rows[i].href == null ? null : rows[i].href
            }
            this.#items[i].element.text("");

            const icon = row.icon == null || row.icon == "" ? null : $("<i>").addClass(row.icon).addClass("HP-Sidebar-Icon").attr('aria-hidden', 'true');
            const text = icon == null ? null : $("<span>").addClass("HP-Sidebar-Text").text(row.text);

            this.#items[i].element.append(icon, text);
            if (row.href == null) {
                sections[this.#items[i].index].append(this.#items[i].element);
            }
            else {
                const link = $("<a>").attr("href", row.href);
                link.append(this.#items[i].element);
                sections[this.#items[i].index].append(link);
            }
        }
        this.#sidebar.append(this.#header, this.#body, this.#footer);
        this.#wrapper.append(this.#modal, this.#sidebar);

        // functionality
        this.#initialPositionY = this.#wrapper.position().top;
        this.#initialHeight = this.#wrapper.height() - this.#initialPositionY;
        this.#initialWidth = this.#sidebar.width();
        this.#maxHeight = window.innerHeight;
        //console.log("max height: ", this.#maxHeight);
        this.#updateSidebarHeight();
        this.#updateSidebarWidth();

        $(window).scroll(() => {
            this.#updateSidebarHeight();
        });
        $(window).on('resize', () => {
            this.#updateSidebarWidth();
        });
        this.#sidebar.hover(
            () => {
                this.#hovered(true);
            },
            () => {
                this.#hovered(false);
            }
        );
        this.#sidebar.on("wheel", (event) => {
            event.preventDefault();
        });
    }
    #getSection(parentElement, child, childClass) {
        const section = !parentElement.children(child).hasClass(childClass) ? null : parentElement.children(`.${childClass}`);
        if (section != null) {
            const items = this.#items;
            const sectionIndex = childClass == "HP-Sidebar-Header" ? 0 :
                childClass == "HP-Sidebar-Body" ? 1 : 2;
            section.find("li").each(function (index, element) {
                items.push({ index: sectionIndex, element: $(element) });
            });
        }
        return section;
    }
    #updateSidebarWidth() {
        if (window.innerWidth < 768) {
            this.#toggleSidebar(false);
            this.#currentToggle = false;
        }
        else {
            this.#toggleSidebar(true);
            this.#currentToggle = true;
        }
    }
    #updateSidebarHeight() {
        //console.log(window.scrollY);
        //console.log(this.#initialPositionY);
        //console.log("dh", this.#initialHeight + window.scrollY);
        if (this.#initialHeight + window.scrollY <= this.#maxHeight) {
            if (window.scrollY <= this.#initialPositionY) {
                //console.log("unfixed");
                this.#wrapper.css({ "height": this.#initialHeight + window.scrollY, "position": "absolute", top: this.#initialPositionY });

            }
        }
        else {
            this.#wrapper.css({ "height": "100vh", "position": "fixed", "top": 0 });
        }
        //console.log("height", this.#wrapper.height());
    }
    #hovered(isHovered) {
        if (isHovered) {
            this.#modal.css("opacity", 0.8);
            this.#currentWidth = 200;
            this.#sidebar.find("li").css({ "padding-left": 50, "justify-content": "start" });
            this.#sidebar.find(".HP-Sidebar-Text").css({ "margin-left": 20, "display": "block" });
            if (!this.#currentToggle) {
                this.#toggleSidebar(true);
            }
            else {
                this.#sidebar.css("width", this.#currentWidth);
            }
        }
        else {
            this.#modal.css("opacity", 0);
            this.#currentWidth = this.#initialWidth;
            this.#sidebar.find("li").css({ "padding-left": 0, "justify-content": "center" });
            this.#sidebar.find(".HP-Sidebar-Text").css({ "margin-left": 0, "display": "none" });
            if (!this.#currentToggle) {
                this.#toggleSidebar(false);
            }
            else {
                this.#sidebar.css("width", this.#currentWidth);
            }
        }
    }
    #toggleSidebar(isToggled) {
        if (!isToggled) {
            this.#sidebar.hide();
            this.#sidebar.css("width", 0);
        }
        else {
            this.#sidebar.show();
            this.#sidebar.css("width", this.#currentWidth);
        }
    }
}
//const sidebar = $(".HP-Sidebar-Wrapper");
//const navbar = $(".navbar");
//const navbarHeight = navbar.height() +
//    getUnitlessValue(navbar.css("padding-top")) +
//    getUnitlessValue(navbar.css("padding-bottom")) +
//    getUnitlessValue(navbar.css("margin-top")) +
//    getUnitlessValue(navbar.css("margin-bottom"));
//const initalHeight = sidebar.height() - navbarHeight;
//const initalWidth = sidebar.find(".HP-Sidebar").width();
//var currentWidth = initalWidth;
//var currentToggle = true;

//updateSidebarHeight();
//updateSidebarWidth();

//$(window).scroll(function () {
//    updateSidebarHeight();
//});
//$(window).on('resize', function () {
//    updateSidebarWidth();
//});
//sidebar.find(".HP-Sidebar").hover(
//    function () {
//        hovered(true);

//    },
//    function () {
//        hovered(false);
//    }
//);
//sidebar.find(".HP-Sidebar").on("wheel", function (event) {
//    event.preventDefault();
//});
//function getUnitlessValue(value) {
//    return parseInt(value, 10);
//}
//function updateSidebarWidth() {
//    if (window.innerWidth < 768) {
//        toggleSidebar(false);
//        currentToggle = false;
//    }
//    else {
//        toggleSidebar(true);
//        currentToggle = true;
//    }
//}
//function updateSidebarHeight() {
//    if (window.scrollY <= navbarHeight) {
//        sidebar.css({ "height": initalHeight + window.scrollY, "position": "absolute", top: navbarHeight });
//    }
//    else {
//        sidebar.css({ "height": "100vh", "position": "fixed", "top": 0 });
//    }
//}
//function hovered(isHovered) {
//    if (isHovered) {
//        $(".HP-Sidebar-Modal").css("opacity", 0.8);
//        currentWidth = 200;
//        $(".HP-Sidebar li").css({ "padding-left": 50, "justify-content": "start" });
//        $(".HP-Sidebar .HP-Sidebar-Text").css({ "margin-left": 20, "display": "block" });
//        if (!currentToggle) {
//            toggleSidebar(true);
//        }
//        else {
//            sidebar.find(".HP-Sidebar").css("width", currentWidth);
//        }
//    }
//    else {
//        $(".HP-Sidebar-Modal").css("opacity", 0);
//        currentWidth = initalWidth;
//        $(".HP-Sidebar li").css({ "padding-left": 0, "justify-content": "center" });
//        $(".HP-Sidebar .HP-Sidebar-Text").css({ "margin-left": 0, "display": "none" });
//        if (!currentToggle) {
//            toggleSidebar(false);
//        }
//        else {
//            sidebar.find(".HP-Sidebar").css("width", currentWidth);
//        }
//    }
//}
//function toggleSidebar(isToggled) {
//    if (!isToggled) {
//        sidebar.find(".HP-Sidebar").hide();
//        sidebar.find(".HP-Sidebar").css("width", 0);
//    }
//    else {
//        sidebar.find(".HP-Sidebar").show();
//        sidebar.find(".HP-Sidebar").css("width", currentWidth);
//    }
//}