##
# This tests GET Controller routes and expects them to redirect to the admin
# login path.  Available routes are: :index, :show, :new, and :edit
#
# @param actions Symbol the actions for this examples to test.
#
# This assumes the following variable have been defined in the controller spec,
# or are passed as a block to this example:
#   :resource
#   :parent (optional)
#
shared_examples 'admin-only route' do |*actions|

  let(:params) do
    params = { id: resource.id }
    if defined?(parent)
      params.merge!({ "#{parent.class.name.underscore}_id".to_sym =>
        parent.id })
    end
    params
  end

  actions.each do |action|

    it "redirects #{action} to admin login" do
      get action, params
      expect(response)
        .to redirect_to "#{Settings.relative_url_root}#{new_admin_session_path}"
    end
  end
end
