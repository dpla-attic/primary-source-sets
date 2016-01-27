require 'rails_helper'

describe Admin, type: :model do

  context 'with a saved, confirmed record' do
    let(:existing_admin) { create(:admin_factory) }

    context 'where it IS NOT having password fields updated' do
      it 'determines that the password does not need to be validated' do
        expect(existing_admin.password_required?).to eq false
      end
    end

    context 'where it IS having its password updated' do
      it 'requires the password to be validated' do
        existing_admin.password = 'x'
        expect(existing_admin.password_required?).to eq true
      end
    end

    it 'reports correctly whether it has a password saved' do
      expect(existing_admin.has_no_password?).to eq false
    end

    it 'reports that it has been confirmed' do
      expect(existing_admin.only_if_unconfirmed { 'yes' }).not_to eq 'yes'
    end
  end

  context 'with a saved yet unconfirmed record' do
    before do
      # Stub confirmation email; see below
      allow_any_instance_of(Admin).to receive(:send_confirmation_instructions)
    end

    it 'reports that it has not been confirmed' do
      # Do not use a fixture. A fixture would save the record and cause the
      # email call to be made, before we can stub it above.
      a = Admin.new(email: 'testunconfirmed@example.org')
      a.save
      expect(a.only_if_unconfirmed {'yes'}).to eq 'yes'
    end
  end

  context 'where the record has not been saved' do
    let(:brandnew_admin) { create(:brandnew_admin_factory) }

    it 'does not require the password to be validated yet' do
      expect(brandnew_admin.password_required?).to eq false
    end
  end

  it 'attempts to set the password with the correct parameters' do
    admin = Admin.new(email: 'testsetpw@example.org')
    pw = 'thepassword'
    pc = 'theconfirmation'
    params = {
      this: 'x',
      that: 'y',
      password: pw,
      password_confirmation: pc
    }
    expect(admin).to receive(:update_attributes)
                 .with({password: pw, password_confirmation: pc})
    admin.attempt_set_password(params)
  end
end
