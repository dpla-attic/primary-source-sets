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
}
