
//table rows/cells highlight
$(document).ready(function () {
    //make selectable even if there is no checkbox
    $("table.index_table tr td").click(function () {
        var self = $(this);
        var parent = self.closest('tr');
        if (parent.find('td.selectable').length == 0) {
            self.closest('tr').toggleClass("selected");
        }

        var th_index = self.index();

        $("table.index_table tr.last-vertical-selected").each(function () {
            $('td', $(this)).removeClass('selected');
        });

        $("table.index_table tr").each(function () {
            $(this).addClass('last-vertical-selected');
            $(this).find('td').eq(th_index).toggleClass('selected');
        });

    })
});