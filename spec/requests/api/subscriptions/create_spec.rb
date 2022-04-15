RSpec.describe 'POST /api/subscriptions', type: :request do
  let!(:stripe_helper) { StripeMock.create_test_helper }
  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }

  before { StripeMock.start }

  subject { response }

  describe 'as a authenticated user' do
    before do
      post '/api/subscriptions', params: { stripeToken: stripe_helper.generate_card_token, amount: 200 },  headers: credentials
    end

    it { is_expected.to have_http_status 201 }

    it 'is expected to return a message that subscription status was changed' do
      expect(response_json['message']).to eq 'You are now subscribed.'
    end

    it 'is expected that the user subscription status is changed' do
      expect(user.reload.subscribed).to eq true
    end
  end

  describe 'as an unauthenticated user' do
    before do
      post '/api/subscriptions', headers: nil
    end

    it { is_expected.to have_http_status 401 }

    it 'is expected to return an error message' do
      expect(response_json['errors'][0]).to eq 'You need to sign in or sign up before continuing.'
    end

    it 'is expected not to change the user subscription status' do
      expect(user.reload.subscribed).to eq false
    end
  end
end
