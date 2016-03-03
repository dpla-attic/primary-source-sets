/*
 * JavaScript related to admin forms.
 */

(function() {

  $(document).ready(function() {

    $('.asset_check_box').click(function() {
      $('.asset_check_box').prop('checked', false);
      $(this).prop('checked', true);
    });

    $('.thumbnail_check_box').click(function() {
      $('.thumbnail_check_box').prop('checked', false);
      $(this).prop('checked', true);
    });

    $('.small_image_check_box').click(function() {
      $('.small_image_check_box').prop('checked', false);
      $(this).prop('checked', true);
    });

    /* 
     * Show link to show/hide expansible content. Hide expansible content.
     * By default, the link is hidden and and the content is shown to make it
     * usable for those with JavaScript disabled.
     */
    $('.expand-control').html('show').show();
    $('.expand-content').hide();

    /* 
     * Show/hide function for expansible content.
     * .expand-control is a DOM element that users can click to show or hide
     * sections of content.
     */
    $('.expand-control').click(function() {
      var content = $(this).closest('.expansible').find('.expand-content');
      if(content.is(':visible')) {
        content.hide('slow');
        $(this).html('show');
      } else {
        content.show('slow');
        $(this).html('hide');
      }
    });
  });
})();
