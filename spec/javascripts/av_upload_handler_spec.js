
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
            var input_data = {video: {file_name: 'video/a.a', source_ids: '4'}}
            var good_data = {video: {file_base: 'a',
                                     key: 'video/a.a',
                                     source_ids: '4'}};
            a.createAssetRecord(input_data);
            expect(a.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with alphnumeric file extension",
        function() {
            var input_data = {video: {file_name: 'video/a.mp4', source_ids: '4'}}
            var good_data = {video: {file_base: 'a',
                                     key: 'video/a.mp4',
                                     source_ids: '4'}};
            a.createAssetRecord(input_data);
            expect(a.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );
});
