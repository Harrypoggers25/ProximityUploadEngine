class HP_Ajax {
    static postFormData({ url, data, success, error } = {}) {
        var formData = new FormData();
        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                formData.append(key, data[key]);
            }
        }
        $.ajax({
            type: 'POST',
            url: url,
            data: formData,
            processData: false,
            contentType: false,
            success: function (response) {
                if (success != null) {
                    success(response);
                }
            },
            error: function () {
                if (error != null) {
                    error();
                }
            }
        });
    }
    static postJson({ url, data = null, success, error } = {}) {
        $.ajax({
            type: 'POST',
            url: url,
            data: JSON.stringify(data),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                if (success != null) {
                    var parsedResponse = JSON.parse(response)
                    success(parsedResponse);
                }
            },
            error: function () {
                if (error != null) {
                    error();
                }
            }
        });
    }
}