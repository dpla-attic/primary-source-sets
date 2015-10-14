/*
 * Handle a/v file uploads
 */
//= require upload

function AVUploadHandler() { UploadHandler.call(this); }
AVUploadHandler.prototype = Object.create(UploadHandler.prototype);


AVUploadHandler.prototype.createAssetRecord = function(key) {
    // For file basename, get rid of "video/" or "audio/" path part and
    // file extension.
    file_base = key.replace(/^[a-z]+\/(.*)\.[a-z0-9]+$/i, "$1");
    postdata = {};
    postdata[pss_asset_type] = {file_base: file_base, key: key};
    this.postAssetRecord(postdata);
};


$(function() {
    new AVUploadHandler();
});
