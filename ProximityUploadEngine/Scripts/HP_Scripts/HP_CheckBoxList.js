class HP_CheckBoxList {
    #wrapper;
    constructor(mainElement) {
        this.element = $(mainElement).addClass("HP-CheckBoxList");
        this.#wrapper = $("<div>").addClass("HP-CheckBoxList-Wrapper");

        this.element.append(this.#wrapper);
    }
    addRow(text, value) {
        var ul = $("<ul>");
        var li1 = $("<li>");
        var input = $("<input>").attr("type", "checkbox").val(value);
        var li2 = $("<li>").text(text);

        li1.append(input);
        ul.append(li1, li2);
        this.#wrapper.append(ul);
    }
    getCheckedRowValues() {
        var values = [];
        this.#wrapper.find('input[type="checkbox"]:checked').each(function () {
            values.push($(this).val());
        });
        return values;
    }
    clearRows() {
        this.#wrapper.empty();
    }
}