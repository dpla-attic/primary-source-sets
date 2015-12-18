require 'rails_helper'

RSpec.configure do |c|
  c.infer_base_class_for_anonymous_controllers = false
end

describe ApplicationController, type: :controller do
end
