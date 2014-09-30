$(document).ready(function () {
    var resouce_place_holder = $("#used_resouces_count");
    if (resouce_place_holder.length) {


        $.get(resouce_place_holder.data("path"),
            { "id": resouce_place_holder.data("id") },
            function (data) {
                resouce_place_holder.html(data);
            }
        );

    }


});