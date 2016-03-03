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
      lazyLoad: 'ondemand',
      responsive: [{
        breakpoint: 1024,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2
        }
      }, {
        breakpoint: 680,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }]
    });

    $('.slick-slide').outerHeight( $('.slick-track').height() );
  });
});
