class Genre < ActiveRecord::Base
  has_and_belongs_to_many :songs, join_table: "song_genres"
  has_many :artists, through: :songs

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug_name)
    found = slug_name.gsub("-", " ").titleize
    self.find_by(name: found)
  end
end
