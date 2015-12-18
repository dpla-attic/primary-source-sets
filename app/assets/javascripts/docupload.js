/*
 * Handle PDF uploads
 */
//= require upload

function DocUploadHandler() { UploadHandler.call(this); }
DocUploadHandler.prototype = Object.create(UploadHandler.prototype);


DocUploadHandler.prototype.createAssetRecord = function(postdata) {
    this.postAssetRecord(postdata);
};


$(function() {
    new DocUploadHandler();
});
