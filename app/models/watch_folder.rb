class WatchFolder < ActiveRecord::Base

  composed_of :media_type, mapping: ['media_type', 'value'], allow_nil: true, converter: -> (value) { MediaType.new(value) }

  scope :movie_type, -> { where(media_type: MediaType.new('movie')) }
  scope :tvshow_type, -> { where(media_type: MediaType.new('tvshow')) }

  validate :folder_existence

  def exists?
    Dir.exist? folder
  end

  private

  def folder_existence
    self.errors.add(:folder, 'does not exist') unless exists?
  end

end
