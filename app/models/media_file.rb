require 'fileutils'

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
  after_commit :create_symlink, on: :create
  after_commit :remove_symlink, on: :destroy

  def exists?
    File.exist? path
  end

  def public_path
    File.join '/', self.media_type.to_s.pluralize, File.basename(self.path)
  end

  private

  def set_filename
    self.filename = File.basename(path) unless path.blank?
  end

  def set_imdb_id
    return unless filename.match(/.*\[(tt\d+)\].*/i)
    self.imdb_id = filename.gsub(/.*\[(tt\d+)\].*/i, "\\1")
  end

  def fetch_metadata
    MetadataFetcherJob.perform_later(id)
  end

  def symlink_directory
    File.join(Rails.root, 'public', self.media_type.to_s.pluralize)
  end

  def symlink_path
    File.join(symlink_directory, File.basename(self.path))
  end

  def create_symlink
    FileUtils.mkdir_p symlink_directory
    FileUtils.symlink self.path, symlink_path
  end

  def remove_symlink
    FileUtils.remove symlink_path if File.exist? symlink_path
  end
end
