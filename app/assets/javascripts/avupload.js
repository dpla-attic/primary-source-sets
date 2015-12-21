/*
 * Handle a/v file uploads
 */
//= require upload

function AVUploadHandler() { UploadHandler.call(this); }
AVUploadHandler.prototype = Object.create(UploadHandler.prototype);


AVUploadHandler.prototype.createAssetRecord = function(postdata) {
    // For file basename, get rid of "video/" or "audio/" path part and
    // file extension.
    var key = postdata[pss_asset_type]['file_name'];
    var file_base = key.replace(/^[a-z]+\/(.*)\.[a-z0-9]+$/i, "$1");

    postdata[pss_asset_type]['file_base'] = file_base;
    postdata[pss_asset_type]['key'] = key;
    delete postdata[pss_asset_type]['file_name'];

    this.postAssetRecord(postdata);
};


$(function() {
    new AVUploadHandler();
});
