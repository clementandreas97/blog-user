# spec/auth/authenticate_user_spec.rb
require 'rails_helper'

RSpec.describe AuthenticateUser do
  # Create test user
  let(:user) { create(:user) }
  # valid request subject
  let(:valid_auth_obj) { described_class.new(user.email, user.password) }
  # invalid request subject
  let(:invalid_auth_obj) { described_class.new('john', 'doe') }

  # Test suite for AuthenticateUser#Call
  describe '#call' do
    # Return token for valid request
    context 'when credentials valid' do
      it 'returns auth token' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # Raise authentication error for invalid credentials
    context 'when credentials invalid' do
      it 'raises authentication error' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            /Invalid credentials/
          )
      end
    end
  end
end
