(function() {

  $(document).ready(function() {

    $('.asset_check_box').click(function() {
      $('.asset_check_box').prop('checked', false);
      $(this).prop('checked', true);
    })

    $('.thumbnail_check_box').click(function() {
      $('.thumbnail_check_box').prop('checked', false);
      $(this).prop('checked', true);
    })

    $('.small_image_check_box').click(function() {
      $('.small_image_check_box').prop('checked', false);
      $(this).prop('checked', true);
    })
  });
})();
