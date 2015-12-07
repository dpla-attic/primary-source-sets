
describe("UploadHandler", function() {
    var u;

    it("Initializes with #upload-form", function() {
        var html = '<form id="upload-form"></form>';
        setFixtures(html);
        u = new UploadHandler();
        expect(u.$form).toEqual('form');  // 'form' is jQuery selector
    });

    it("Returns an element within the form with `.$el'", function() {
        var html = '<input name="a" />' +
                   '<form id="upload-form"><input name="b" /></form>';
        setFixtures(html);
        u = new UploadHandler();
        expect(u.$el('input').attr('name')).toEqual('b');
    });

    describe("#initializePostdata", function() {

        beforeEach(function() {
            pss_asset_type = 'image'; //global vars set in view
        });

        afterEach(function() {
            delete pss_asset_type; //clean up
        });

        it("Returns an object with asset_type and file_name", function() {
            good_data = {'image': {file_name: 'a.jpg'}};
            expect(u.initializePostdata('a.jpg')).toEqual(good_data);
        });

        describe("#with source_id", function() {
            beforeEach(function() {
                source_id = '4'; //global vars set in view
            });

            afterEach(function() {
                delete source_id; //clean up
            });

            it("Returns an object with source_ids", function() {
                expect(u.initializePostdata('a.jpg').image.source_ids)
                    .toEqual('4');
            });
        });
    });
});
