# factorygirl allow us to create templates for valid and re-usable objects

FactoryGirl.define do
  factory :movie do
    title 'Star Wars'
    director 'George Lucas'
    rating 'PG'
    release_date '1977-05-25'
  end
end