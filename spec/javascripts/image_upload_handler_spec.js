
describe("ImageUploadHandler", function() {

    beforeEach(function() {
        iuh = new ImageUploadHandler();
        spyOn(iuh, 'postAssetRecord').and.stub();
        html = '<script>var pss_asset_type = "image";</script>' +
               '<form></form>';
        setFixtures(html);
    });

    it("Generates AJAX POST data with the file name",
        function() {
            good_data = {
                image: {
                    file_name: 'a.jpg',
                    size: undefined,
                    width: undefined,
                    height: undefined,
                    alt_text: undefined
                }
            };
            iuh.createAssetRecord('a.jpg');
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with the image size",
        function() {
            good_data = {
                image: {
                    file_name: 'a.jpg',
                    size: 'small',
                    width: undefined,
                    height: undefined,
                    alt_text: undefined
                }
            };
            html =
                '<input name="image[size]" type="radio" value="large">' +
                '<input name="image[size]" type="radio" value="small" checked>';
            appendSetFixtures(html);
            iuh.createAssetRecord('a.jpg');
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with width and height",
        function() {
            good_data = {
                image: {
                    file_name: 'a.jpg',
                    size: undefined,
                    width: '600',
                    height: '400',
                    alt_text: undefined
                }
            };
            html =
               '<input name="image[width]" type="text" value="600" />' +
               '<input name="image[height]" type="text" value="400" />';
            appendSetFixtures(html);
            iuh.createAssetRecord('a.jpg');
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

    it("Generates AJAX POST data with alt text",
        function() {
            good_data = {
                image: {
                    file_name: 'a.jpg',
                    size: undefined,
                    width: undefined,
                    height: undefined,
                    alt_text: 'x'
                }
            };
            html =
               '<input name="image[alt_text]" type="text" value="x" />';
            appendSetFixtures(html);
            iuh.createAssetRecord('a.jpg');
            expect(iuh.postAssetRecord).toHaveBeenCalledWith(good_data);
        }
    );

});
