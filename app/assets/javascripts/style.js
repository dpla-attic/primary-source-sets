/*
 * Handles dynamic styling of the DOM.
 */
(function() {

  /*
   * Remove 'js-off' classes from DOM elements.  The 'js-off' class is used to
   * hide DOM elements when javascript is disabled.
   */
   $(document).ready(function() {
    $('.js-off').removeClass('js-off');
   });

  $(document).ready(function() {
    setNameContainerHeight();
  });

  $(window).resize(function() {
    setNameContainerHeight();
  })
})();

/*
 * This dynamically styles the boxes (class = set-name-container) that contain
 * the title in a set tile, for example those found in the sets#index view.
 * Ensure that each title box is the same height as all other boxes in the same
 * row.  Each box will be resized to be a tall as the tallest box in the row.
 */
function setNameContainerHeight() {
  
  $('div.moduleContainer.threeCol').each(function() {
    var maxHeight = 0;
    var container = $(this).find('.set-name-container');

    container.each(function() {
      if ($(this).height() > maxHeight) {
        maxHeight = $(this).height();
      }
    });

    container.each(function() {
      $(this).height(maxHeight);
    });
  })
}
