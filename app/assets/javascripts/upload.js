
/*
 * Handle media file uploads directly to S3, and create new asset records.
 *
 * Manage the form submission, intercepting the submit event.
 * Provide upload status.  For successful uploads, create the new asset record
 * and send the user to the asset's page.
 *
 */

(function() {

    $(document).ready(function() {

        $('form').on('submit', function(e) {

            e.preventDefault();

            var data = new FormData(this);
            var xhr = new XMLHttpRequest();

            xhr.upload.addEventListener(
                'progress',
                function(e) {
                    updateProgress(e);
                },
                false
            );

            xhr.onreadystatechange = function(e) {
                handleResponseIfDone(xhr);
            };

            xhr.open('POST', $('form').attr('action'), true);
            xhr.send(data);

            return false;

        });

    });

    /*
     * `onreadystatechange' handler for form submission
     */
    function handleResponseIfDone(xhr) {
        if (xhr.readyState == 4) {
            if (xhr.status == '201') {
                key = $('Key', xhr.responseXML).text();
                createAssetRecord(key);
            } else {
                alert('Got an unexpected response: ' + xhr.statusText);
            }
        }
    }

    /*
     * POST to our API to add an asset for the file that was just uploaded to
     * S3.  Load the asset's "view" resource if that is successful.
     */
    function createAssetRecord(key) {

        // For file basename, get rid of "video/" or "audio/" path part and
        // file extension.
        file_base = key.replace(/^[a-z]+\/(.*)\.[a-z0-9]+$/i, "$1");

        postdata = {};
        postdata[pss_asset_type] = {file_base: file_base, key: key};

        $.ajax({
            method: 'POST',
            url: pss_create_asset_path,  // defined in the HTML
            data: postdata
        }).done(function(data) {
            document.location = data.resource;
        }).fail(function(xhr) {
            alert('Failed to create asset record: ' + xhr.statusText);
        });
    }

    /*
     * Handle the `progress' event of the XMLHttpRequest.
     * Update the progress percentage indicator.
     */
    function updateProgress(e) {
        $p = $('#upload-progress');
        if (e.lengthComputable) {
            if (! $p.is(':visible')) {
                $p.show();
            }
            var pct = Math.round(e.loaded / e.total * 100);
            $p.text(pct + '% complete');
        }
    }

})();
