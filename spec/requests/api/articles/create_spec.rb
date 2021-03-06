RSpec.describe 'POST /api/articles' do
  subject { response }

  let(:user) { create(:user) }
  let(:credentials) { user.create_new_auth_token }
  let!(:sports_category) { create(:category, name: 'Sports') }
  let!(:business_category) { create(:category, name: 'Business') }

  describe 'as an authenticated user' do
    describe 'successfully' do
      before do
        post '/api/articles', params: {
          article: { title: 'News about Sports', body: 'Lorem ipsum...', category: 'Sports' }
        }, headers: credentials

        @article = Article.last
      end

      it { is_expected.to have_http_status 201 }

      it 'is expected to create an instance of an Article' do
        expect(@article).not_to be nil
      end

      it 'is expected to have a title' do
        expect(@article.title).to eq 'News about Sports'
      end

      it 'is expected to have a body' do
        expect(@article.body).to eq 'Lorem ipsum...'
      end

      it 'is expected to respond with a confirmation message' do
        expect(response_json['message']).to eq 'Article created successfully'
      end
    end

    describe 'unsuccessfully' do
      describe 'due to missing params' do
        before do
          post '/api/articles', params: {}, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq 'Missing params'
        end
      end

      describe 'due to missing title' do
        before do
          post '/api/articles', params: {
            article: {
              body: 'Lorem ipsum...',
              category: 'Sports'
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Title can't be blank"
        end
      end

      describe 'due to missing body' do
        before do
          post '/api/articles', params: {
            article: {
              title: 'News about Sports',
              category: 'Sports'
            }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Body can't be blank"
        end
      end

      describe 'due to missing category' do
        before do
          post '/api/articles', params: {
            article: { title: 'News about Sports', body: 'Lorem ipsum...' }
          }, headers: credentials
        end

        it { is_expected.to have_http_status :unprocessable_entity }

        it 'is expected to respond with an error message' do
          expect(response_json['message']).to eq "Category can't be blank"
        end
      end
    end
  end

  describe 'as an non-authenticated user' do
    before do
      post '/api/articles', params: {
        article: { title: 'News about Sports', body: 'Lorem ipsum...', category: 'Sports' }, headers: nil
      }
    end

    it { is_expected.to have_http_status 401 }

    it 'is expected to respond with an error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
