$(function() {
  $(document).ready(function() {
    // auto-sumbit forms when dropdown menu selections change
    $('.resultsBar select').change(function() {
      $(this).closest('form').submit();
    });
  });
});
