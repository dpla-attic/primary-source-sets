$(function() {
  $(document).ready(function() {
    // Render the poster after all images have finished loading.
    $(window).on('load', function(){
      height = 0;

      $('.left img').each(function(){

        // hide lefthand images (thumbnails) if width less than 110px
        if($(this).width() < 110) {
          $(this).hide();
        }

        // resize lefthand images so width = 110px
        $(this).width(110);

        height += $(this).height();
      });

      console.log(height);

      /*
       * If the height of all the lefthand images isn't enough to fill the
       * space, repeat the the images.
       */
      while (height > 0 && height < 500) {
        var html = $('.left').html();
        $('.left').html(html + html);
        height = height * 2;
      }

      $('.poster').css('visibility', 'visible');
    });
  });
});
