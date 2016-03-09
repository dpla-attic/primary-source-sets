$(function() {
  $(document).ready(function() {

    /* 
     * Initiate slick slider carousel. Slick is an external javascript library.
     * @see config/initializers/assets.rb
     * https://github.com/kenwheeler/slick
     */
    $('.carousel').slick({
      infinite: true,
      arrows: true,
      slidesToShow: 3,
      slidesToScroll: 3,
      responsive: [{
        breakpoint: 1024,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2
        }
      }, {
        breakpoint: 600, //tailored to fit width of set image
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }]
    });

    /*
     * This executes after everything on the page (including images) have
     * loaded.
     */ 
    $(window).on('load', function() {
      // Make all items in the carousel the same height.
      $('.slick-slide').outerHeight( $('.slick-track').height() );
    });
  });
});
