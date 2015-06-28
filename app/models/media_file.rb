class MediaFile < ActiveRecord::Base

  composed_of :media_type,
              mapping:   %w(media_type value),
              allow_nil: true,
              converter: -> (value) { MediaType.new(value) }

  scope :movie_type, -> { where(media_type: MediaType.new('movie')) }
  scope :tvshow_type, -> { where(media_type: MediaType.new('tvshow')) }

  validates_presence_of :path
  validates_uniqueness_of :path

  before_validation :set_filename, :set_imdb_id

  after_commit :fetch_metadata, on: :create

  def exists?
    File.exist? path
  end

  private

  def set_filename
    self.filename = File.basename(path) unless path.blank?
  end

  def set_imdb_id
    return unless file.filename.match(/.*\[(tt\d+)\].*/i)
    self.imdb_id = file.filename.gsub(/.*\[(tt\d+)\].*/i, "\\1")
  end

  def fetch_metadata
    MetadataFetcherJob.perform_later(id)
  end
end
