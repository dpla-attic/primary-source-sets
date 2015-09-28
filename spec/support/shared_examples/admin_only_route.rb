##
# This tests GET Controller routes and expects them to redirect to the admin
# login path.

# @param routes Symbol the actions for this controller that are admin-only.
#
# The example can be passed a block that defines resource and/or request_params.
# resource should be a factory with an id that will be used to construct routes.
# request_params should be a Hash of params (not including :id).
#
# @example:
#   it_behaves_like 'admin-only route', :index, :show, :edit, :new do
#     let (:resource) { FactoryGirl.create(:guide_factory) }
#     let (:request_params) { source_set: resource.source_set.id }
#   end
shared_examples 'admin-only route' do |*actions|

  let(:admin_login_path) do
    # This route is concatenated in this way because the path helpers for
    # devise are not incorportating the relative url root.
    "#{root_url}#{Settings.relative_url_root.gsub('/', '')}/admins/sign_in"
  end

  actions.each do |action|

    it "redirects #{action} to admin login" do
      params = {}
      params[:id] = resource.id if defined?(resource)
      params.merge!(request_params) if defined?(request_params)

      get action, params
      expect(response).to redirect_to admin_login_path
    end
  end
end
