/*
 * Handle media file uploads directly to S3, and create new asset records.
 *
 * Manage the form submission, intercepting the submit event.
 * Provide upload status.  For successful uploads, create the new asset record
 * and send the user to the asset's page.
 */


function UploadHandler() { this.init(); }
UploadHandler.prototype.init = function() {
    this.$form = $('#upload-form');
    this.addOnSubmit();
};


UploadHandler.prototype.$el = function(selector) {
    return $(selector, this.$form);
};

UploadHandler.prototype.addOnSubmit = function() {

    var that = this;
    this.$form.on('submit', function(e) {

        e.preventDefault();

        files = that.$el('input[name=file]').prop('files');
        if (! files.length) {
            alert('Please choose a file.');
            return false;
        }

        // Fill in Content-Type so S3 doesn't default to
        // "application/octet-stream".
        that.$el('input[name=Content-Type]').val(files[0].type)

        var xhr = new XMLHttpRequest();
        xhr.upload.addEventListener(
            'progress',
            function(e) {
                that.updateProgress(e);
            },
            false
        );
        xhr.onreadystatechange = function(e) {
            that.handleResponseIfDone(xhr);
        };

        xhr.open('POST', that.$form.attr('action'), true);
        xhr.send(new FormData(this));

        return false;

    });

};  // addOnSubmit


UploadHandler.prototype.updateProgress = function(e) {
    $p = $('#upload-progress');
    if (e.lengthComputable) {
        if (! $p.is(':visible')) {
            $p.show();
        }
        var pct = Math.round(e.loaded / e.total * 100);
        $p.text(pct + '% complete');
    }
};


UploadHandler.prototype.handleResponseIfDone = function(xhr) {
    if (xhr.readyState == 4) {
        if (xhr.status == '201') {
            key = $('Key', xhr.responseXML).text();
            this.createAssetRecord(key);
        } else {
            alert('Got an unexpected response: ' + xhr.statusText);
        }
    }
};


UploadHandler.prototype.createAssetRecord = function(key) {
    console.log('createAssetRecord must be overridden.');
};


UploadHandler.prototype.postAssetRecord = function(postdata) {
    $.ajax({
        method: 'POST',
        url: pss_create_asset_path,  // defined in the HTML
        data: postdata
    }).done(function(data) {
        document.location = data.resource;
    }).fail(function(xhr) {
        alert('Failed to create asset record: ' + xhr.statusText);
    });
};
