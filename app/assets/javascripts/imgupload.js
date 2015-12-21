/*
 * Handle image uploads
 */
//= require upload

function ImageUploadHandler() { UploadHandler.call(this); }
ImageUploadHandler.prototype = Object.create(UploadHandler.prototype);


ImageUploadHandler.prototype.createAssetRecord = function(postdata) {
    postdata[pss_asset_type]['size'] = $('input[name="image[size]"]:checked').val();
    postdata[pss_asset_type]['width'] = $('input[name="image[width]"]').val();
    postdata[pss_asset_type]['height'] = $('input[name="image[height]"]').val();
    postdata[pss_asset_type]['alt_text'] = $('input[name="image[alt_text]"]').val();

    this.postAssetRecord(postdata);
};


$(function() {
    new ImageUploadHandler();
});
