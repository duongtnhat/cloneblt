$(document).ready(function () {
    var iScrollPos = 0;
    $(window).scroll(function () {
        var iCurScrollPos = $(this).scrollTop();
        if (iCurScrollPos > iScrollPos) {
            $(".navbar").removeClass("nav-down").addClass("nav-up");
        } else {
            $(".navbar").removeClass("nav-up").addClass("nav-down");
        }
        iScrollPos = iCurScrollPos;
    });

});