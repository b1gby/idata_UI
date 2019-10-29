// 实验室名片hover效果
$(document).ready(function () {
    var lab_card = $(".lab_part");

    function onSelect() {

    }
    lab_card.hover(
        function MouseIn() {
            $(this).animate({
                    marginTop : -3,
                    marginBottom : 20,
                },
                "fast"
            )
        },
        function MouseOut() {
            $(this).animate({
                    marginTop : 5,
                    marginBottom : 12,
                },
                "fast"
            )
        }
    )
})