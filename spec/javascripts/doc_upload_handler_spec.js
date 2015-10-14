
describe("DocUploadHandler", function() {

    beforeEach(function() {
        duh = new DocUploadHandler();
        spyOn(duh, 'postAssetRecord').and.stub();
        html = '<script>var pss_asset_type = "document";</script>' +
               '<form></form>';
        setFixtures(html);
    });

    it("Generates AJAX POST data with the file name",
        function() {
            good_data = {document: {file_name: 'a.pdf'}};
            duh.createAssetRecord('a.pdf');
            expect(duh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

});
