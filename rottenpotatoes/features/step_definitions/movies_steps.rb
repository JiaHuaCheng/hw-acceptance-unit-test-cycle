# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body =~ /#{e1}.+#{e2}/
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  #fail "Unimplemented"
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
    if uncheck.nil?   # if sentence is check, (un) cannot match anything, then $0 should be nil
      check("ratings_#{rating}")
    else
      uncheck("ratings_#{rating}")
    end
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(page).to have_css("table#movies tr", :count=>(Movie.count + 1)) #1 for row header
  #fail "Unimplemented"
end


Then (/^the director of "([^"]*)" should be "([^"]*)"$/) do |arg1, arg2|
  expect(Movie.find_by_title(arg1).director).to eq(arg2)
end