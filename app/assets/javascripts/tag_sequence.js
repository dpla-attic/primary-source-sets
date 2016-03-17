/*
 * Handles sortable tag_sequences functionality.
 * @see app/views/vocabularies/show.html.erb
 */
$(function() {
  $(document).ready(function() {
    $('#tag_sequences').sortable({
      /*
       * When sortable tag_sequence list is updated, send a POST request to
       * tag_sequences#sort containing the ids of all tag_sequences in their new
       * order.
       */
      update: function() {
        $.ajax({
          url: pss_tag_sequences_sort_path, //defined in view
          type: 'post',
          data: $('#tag_sequences').sortable('serialize'),
          dataType: 'script'
        });
      }
    });
  });
});
