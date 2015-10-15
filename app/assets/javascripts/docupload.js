/*
 * Handle PDF uploads
 */
//= require upload

function DocUploadHandler() { UploadHandler.call(this); }
DocUploadHandler.prototype = Object.create(UploadHandler.prototype);


DocUploadHandler.prototype.createAssetRecord = function(key) {
    postdata = {};
    postdata[pss_asset_type] = {file_name: key};
    this.postAssetRecord(postdata);
};


$(function() {
    new DocUploadHandler();
});
