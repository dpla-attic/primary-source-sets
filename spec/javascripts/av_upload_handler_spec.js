
describe("AVUploadHandler", function() {
    var a;

    beforeEach(function() {
        a = new AVUploadHandler();
        spyOn(a, 'postAssetRecord').and.stub();
        var html = '<form></form>';
        pss_asset_type = 'video'; //global var set in view
        setFixtures(html);
    });

    afterEach(function() {
        delete pss_asset_type; //clean up
    });

    it("Generates AJAX POST data with path prefix and alphabetic extension",
        function() {
            var good_data = {video: {file_base: 'a', key: 'video/a.a'}};
            a.createAssetRecord('video/a.a');
            expect(a.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with alphnumeric file extension",
        function() {
            var good_data = {video: {file_base: 'a', key: 'video/a.mp4'}};
            a.createAssetRecord('video/a.mp4');
            expect(a.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

});
