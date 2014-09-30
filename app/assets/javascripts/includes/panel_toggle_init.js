//toggle panel
$(document).ready(function() {
    $('.toggle.panel h3').on('click', function (e) {
        $(e.target).next('.panel_contents').slideToggle("fast");
        return false;
    });
});