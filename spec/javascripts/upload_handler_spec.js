
describe("UploadHandler", function() {

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

});
