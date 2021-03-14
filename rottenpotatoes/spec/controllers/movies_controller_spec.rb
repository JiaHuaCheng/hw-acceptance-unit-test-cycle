require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'find_with_the_same_director' do
    let(:movie) { FactoryGirl.create(:movie)}
    it 'call model method find_with_the_same_director' do
      expect_any_instance_of(Movie).to receive(:find_with_the_same_director).with(no_args)
      get :find_with_the_same_director, id: movie.id
    end
    
    context 'movie has a director' do
      let!(:movie2) { FactoryGirl.create(:movie, director: movie.director)}
      it do
        get :find_with_the_same_director, id: movie.id
        expect(response).to redirect_to(movie_path(movie2.id))
      end
    end
    
    context 'movie has no director' do
      let(:movie2) { FactoryGirl.create(:movie, director: nil) }
      it 'redirected to root' do
        get :find_with_the_same_director, id: movie2.id
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
