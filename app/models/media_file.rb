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

  validates_format_of :filename, with: /\A[^\.]+\.[^\.]+\z/i, on: :update

  after_validation :rename_file_if_necessary, on: :update
  after_validation :set_filename, :set_imdb_id

  after_commit :fetch_metadata, on: :create
  after_commit :create_symlink, on: :create
  after_commit :remove_symlink, on: :destroy
  after_commit :create_movie_on_mediamaster

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
    FileUtils.mkdir_p symlink_directory unless File.exist?(symlink_directory)
    FileUtils.symlink self.path, symlink_path unless File.symlink?(symlink_path) || File.exist?(symlink_path)
  end

  def remove_symlink
    FileUtils.remove symlink_path if File.exist? symlink_path
  end

  def rename_file_if_necessary
    new_path = File.join File.dirname(self.path), self.filename

    return if self.path == new_path

    if File.exist?(new_path)
      self.errors.add(:filename, "File already exists")
      return false
    end

    FileUtils.mv(self.path, new_path)
    self.path = new_path
    self.send :remove_symlink
    self.send :create_symlink
  end

  def create_movie_on_mediamaster
    return if self.imdb_id.blank?
    MediamasterMovieCreationJob.perform_later(self.imdb_id, User.first.id)
  end
end
