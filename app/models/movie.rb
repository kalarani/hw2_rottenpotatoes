class Movie < ActiveRecord::Base
  def self.ratings
    Movie.all.collect(&:rating).uniq
  end
end
