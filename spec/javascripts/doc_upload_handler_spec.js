
describe("DocUploadHandler", function() {
    var duh;

    beforeEach(function() {
        duh = new DocUploadHandler();
        spyOn(duh, 'postAssetRecord').and.stub();
        var html = '<form></form>';
        pss_asset_type = 'document'; //global var set in view
        setFixtures(html);
    });

    afterEach(function() {
        delete pss_asset_type; //clean up
    });

    it("Generates AJAX POST data with the given data",
        function() {
            good_data = {document: {file_name: 'x', source_ids: '4'}};
            duh.createAssetRecord(good_data);
            expect(duh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    ); 
});
