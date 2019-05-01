class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug_name)
    normalized = slug_name.gsub("-", " ").downcase
    self.where("lower(name) = ?", normalized).first
  end
end
