class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  #what does this do?
  accepts_nested_attributes_for :notes, :reject_if => proc { |attrs| attrs[:content].blank? }

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end
  
  #solution has artist.try(:name) which is the same as this method
  def artist_name
    if artist 
      artist.name
    end
  end
end
