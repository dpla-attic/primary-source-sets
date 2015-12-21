
describe("ImageUploadHandler", function() {
    var iuh;
    var input_data = {image: {file_name: 'a.jpg', source_ids: '4'}};

    beforeEach(function() {
        iuh = new ImageUploadHandler();
        spyOn(iuh, 'postAssetRecord').and.stub();
        var html = '<form></form>';
        pss_asset_type = 'image'; //global var set in view
        setFixtures(html);
    });

    afterEach(function() {
        delete pss_asset_type; //clean up
    });

    it("Generates AJAX POST data with the image size",
        function() {
            var good_data = {
                image: {
                    file_name: 'a.jpg',
                    source_ids: '4',
                    size: 'small',
                    width: undefined,
                    height: undefined,
                    alt_text: undefined
                }
            };
            var html =
                '<input name="image[size]" type="radio" value="large">' +
                '<input name="image[size]" type="radio" value="small" checked>';
            appendSetFixtures(html);
            iuh.createAssetRecord(input_data);
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with width and height",
        function() {
            var good_data = {
                image: {
                    file_name: 'a.jpg',
                    source_ids: '4',
                    size: undefined,
                    width: '600',
                    height: '400',
                    alt_text: undefined
                }
            };
            var html =
               '<input name="image[width]" type="text" value="600" />' +
               '<input name="image[height]" type="text" value="400" />';
            appendSetFixtures(html);
            iuh.createAssetRecord(input_data);
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with alt text",
        function() {
            var good_data = {
                image: {
                    file_name: 'a.jpg',
                    source_ids: '4',
                    size: undefined,
                    width: undefined,
                    height: undefined,
                    alt_text: 'x'
                }
            };
            var html =
               '<input name="image[alt_text]" type="text" value="x" />';
            appendSetFixtures(html);
            iuh.createAssetRecord(input_data);
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );
});
