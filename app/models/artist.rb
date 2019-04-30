class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug_name)
    found = slug_name.gsub("-", " ").titleize
    self.find_by(name: found)
  end
end
