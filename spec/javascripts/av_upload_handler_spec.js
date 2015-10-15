
describe("AVUploadHandler", function() {

    beforeEach(function() {
        a = new AVUploadHandler();
        spyOn(a, 'postAssetRecord').and.stub();
        html = '<script>var pss_asset_type = "video";</script>' +
               '<form></form>';
        setFixtures(html);
    });

    it("Generates AJAX POST data with path prefix and alphabetic extension",
        function() {
            good_data = {video: {file_base: 'a', key: 'video/a.a'}};
            a.createAssetRecord('video/a.a');
            expect(a.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with alphnumeric file extension",
        function() {
            good_data = {video: {file_base: 'a', key: 'video/a.mp4'}};
            a.createAssetRecord('video/a.mp4');
            expect(a.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

});
