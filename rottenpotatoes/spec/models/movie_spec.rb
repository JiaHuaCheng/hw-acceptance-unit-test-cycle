require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

RSpec.describe Movie, type: :model do
    describe '#find_with_the_same_director' do
        context 'find all movies with the same director' do
            let!(:movie1) { FactoryGirl.create(:movie, director: 'director1') }
            let!(:movie2) { FactoryGirl.create(:movie, director: 'director1') }
            let!(:movie3) { FactoryGirl.create(:movie, director: 'director3') }
        
            subject { movie1.find_with_the_same_director }
            it {expect(subject).to eq(movie2) }
            it {expect(subject).not_to eq(movie3) }
        end
    end
end