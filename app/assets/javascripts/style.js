/*
 * Handles dynamic styling of the DOM.
 */
(function() {

  $(document).ready(function() {
    setAsideHeight();
  });

  $(window).resize(function() {
    setAsideHeight();
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

  var moduleHeight = $('.set aside .module').outerHeight();
  var titleHeight = $('.set .title-outer-container').outerHeight();

  if (moduleHeight < titleHeight) {
    $('.set aside .module').outerHeight(titleHeight);
  }
  if (titleHeight < moduleHeight) {
    $('.set .title-outer-container').outerHeight(moduleHeight);
  }
}
