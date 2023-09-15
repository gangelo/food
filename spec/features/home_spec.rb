# frozen_string_literal: true

RSpec.shared_examples 'the request was successful' do
  it 'returns http success' do
    expect(page).to have_http_status(:success)
  end
end

RSpec.shared_examples 'the page is the home page' do
  it 'displays the home page' do
    expect(page).to have_current_path(root_path, ignore_query: true)
  end
end

RSpec.describe 'Home page' do
  describe 'when visiting the home page' do
    before do
      visit root_path
    end

    it_behaves_like 'the request was successful'
    it_behaves_like 'the page is the home page'

    context 'when the user is not logged in' do
      it 'displays the home page' do
        expect(page).to have_content('Home')
      end
    end
  end
end
