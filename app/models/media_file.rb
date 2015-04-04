class MediaFile < ActiveRecord::Base

  composed_of :media_type, mapping: ['media_type', 'value'], allow_nil: true, converter: -> (value) { MediaType.new(value) }

  validates_presence_of :path
  validates_uniqueness_of :path

  before_validation :set_filename

  after_commit :fetch_metadata, on: :create

  def exists?
    File.exist? path
  end

  private

  def set_filename
    self.filename = File.basename(path) unless path.blank?
  end

  def fetch_metadata
    MetadataFetcherJob.perform_later(id)
  end

end
