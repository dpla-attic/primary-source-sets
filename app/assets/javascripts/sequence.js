/*
 * Handles sortable sequences functionality.
 * @see app/views/vocabularies/show.html.erb
 */
$(function() {
  $(document).ready(function() {
    $('#sequences').sortable({
      /*
       * When sortable sequence list is updated, send a POST request to
       * sequences#sort containing the ids of all sequences in their new order.
       */
      update: function() {
        $.ajax({
          url: pss_sequences_sort_path, //defined in view
          type: 'post',
          data: $('#sequences').sortable('serialize'),
          dataType: 'script'
        });
      }
    });
  });
});
