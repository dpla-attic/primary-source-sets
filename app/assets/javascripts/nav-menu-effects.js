
/*
 * Things to do on all pages, which have navigation menus that need to behave
 * responsively.
 */
$(function() {

    $('.menu-btn').click(function() {
        $('.topNav, .MainNav').toggle(400);
        $('span', this).toggleClass('icon-arrow-thin-up');
        $('span', this).toggleClass('icon-arrow-thin-down');
        return false;
    });

    // If the window is resized, we have to ensure the state of the `.topNav'
    // and `.MainNav' divs, depending on which way the window is being sized,
    // and what is being hidden or redisplayed.
    $(window).resize(function() {
        $iconSpan = $('.menu-btn span');
        $divs = $('.topNav, .MainNav');
        if ($(window).width() > 679) {
            // Getting bigger.  Make sure the divs are shown and reset the
            // arrow so that it's pointing down, inviting you to expand the
            // menu, if you make the window narrower again.
            $divs.show();
            $iconSpan.removeClass('icon-arrow-thin-up');
            $iconSpan.addClass('icon-arrow-thin-down');
        } else {
            // The reverse.  It may have been explicitly shown, so make sure
            // it's hidden.
            $divs.hide();
        }
    });

});
