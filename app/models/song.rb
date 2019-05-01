class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug_name)
    found = slug_name.gsub("-", " ").downcase
    self.find_by(:name => ['name LIKE ?', found])
    #need to keep working on lowercase!!!!
  end


end
