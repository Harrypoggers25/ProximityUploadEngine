class HP_ListBox {
    #wrapper;
    constructor(mainElement, { maxCol = 1 } = {}) {
        this.element = $(mainElement).addClass("HP-ListBox");
        this.#wrapper = $("<div>").addClass("HP-ListBox-Wrapper");
        this.cols = [];
        for (var i = 0; i < maxCol; i++) {
            this.cols.push($("<ul>"));
            this.#wrapper.append(this.cols[i]);
        }
        this.element.append(this.#wrapper);
    }
    addRows(cols) {
        for (var i = 0; i < this.cols.length; i++) {
            var colItem = $("<li>").text(cols[i]);
            this.cols[i].append(colItem);
        }
    }
    clearRows() {
        for (var i = 0; i < this.cols.length; i++) {
            this.cols[i].empty();
        }
    }
}
