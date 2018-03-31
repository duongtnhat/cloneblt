$(document).ready(function () {
    console.log("ready!");
    var iScrollPos = 0;
    $(window).scroll(function () {
        var iCurScrollPos = $(this).scrollTop();
        if (iCurScrollPos > iScrollPos) {
            console.log('down');
            $(".navbar").removeClass("nav-down").addClass("nav-up");
        } else {
            console.log('up');
            $(".navbar").removeClass("nav-up").addClass("nav-down");
        }
        iScrollPos = iCurScrollPos;
    });

});