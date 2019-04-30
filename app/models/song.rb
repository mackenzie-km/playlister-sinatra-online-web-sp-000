class Song < ActiveRecord::Base
  belongs_to :artist
  has_and_belongs_to_many :genres, join_table: "songs_genres"

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug_name)
    found = slug_name.gsub("-", " ").titleize
    self.find_by(name: found)
  end
end
