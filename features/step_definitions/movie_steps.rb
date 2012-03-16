# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    #a_movie = Movie.new(:title => movie["title"], :rating => movie["rating"], :release_date => movie["release_date"])
    #a_movie.create
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |mov1, mov2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  # id('movies')/x:tbody/x:tr
  sorted_movies = page.all(:xpath, '//table[@id="movies"]/tbody/tr/td')
  @sorted_movie_names = []
  sorted_movies.each do |elem|
    @sorted_movie_names << elem.text
  end
  mov1_pos = @sorted_movies_names.index(mov1)
  mov2_pos = @sorted_movies_names.index(mov2)
  puts mov1_pos
  puts mov2_pos
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split
  ratings.each do |rating|
    if uncheck
      step %Q{I uncheck "ratings_#{rating}"}
    else
      step %Q{I check "ratings_#{rating}"}
    end
  end
end