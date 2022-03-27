RSpec.describe "GET /api/articles", type: :request do

  let!(:articles) { create_list(:article, 5) }

  before do
    get '/api/articles'
  end

  subject { response }

  it { is_expected.to have_http_status 200 }

  it 'is expected to return a collection of 5 articles' do
    expect(response_json['articles'].size).to eq 5
  end
end
