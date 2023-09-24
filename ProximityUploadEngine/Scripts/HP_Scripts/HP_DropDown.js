class HP_DropDown {
    #opt_initial;
    constructor(mainElement, { initialOption } = {}) {
        this.element = $("<select>");

        this.#opt_initial = initialOption == null ? null : $("<option>").text(initialOption).val("");

        this.clearOptions();
        $(mainElement).replaceWith(this.element);
        this.element.attr("id", mainElement);
    }
    addOption(text, value) {
        const option = $('<option>', {
            text: text,
            value: value
        });
        this.element.append(option);
    }
    clearOptions() {
        this.element.empty();
        this.element.append(this.#opt_initial);
    }
    getValue() {
        return this.element.val();
    }
    onChange(onChange) {
        this.element.change(onChange);
    }
}