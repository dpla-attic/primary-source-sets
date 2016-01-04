/*
 * Handles dynamic styling of the DOM.
 */
(function() {

  $(document).ready(function() {
    setAsideHeight();
    setNameContainerHeight();
  });

  $(window).resize(function() {
    setAsideHeight();
    setNameContainerHeight();
  })
})();

/*
 * Extend the height of the aside module to be at least as tall as the rendered
 * media asset.
 */
function setAsideHeight() {
  var height = $('.source aside .module').outerHeight();
  var minHeight = $('.source .media-inner-container').height();
  if (minHeight > height) {
    $('.source aside .module').outerHeight(minHeight);
  }

  // resize header on set page
  var moduleHeight = $('.set .guide-link .module').outerHeight();
  var titleHeight = $('.set .title-outer-container').outerHeight();

  if (moduleHeight < titleHeight) {
    $('.set .guide-link .module').outerHeight(titleHeight);
  }
  if (titleHeight < moduleHeight) {
    $('.set .title-outer-container').outerHeight(moduleHeight);
  }
}

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
