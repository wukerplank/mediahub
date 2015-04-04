class MetadataFetcherJob < ActiveJob::Base

  queue_as :metadata_fetcher

  def perform(media_file_id)
    media_file = MediaFile.find(media_file_id)

    movie_info = FFMPEG::Movie.new(media_file.path)

    media_file.update_attributes(
      md5: get_md5(media_file.path),
      ctime: File.ctime(media_file.path),
      mtime: File.mtime(media_file.path),
      atime: File.atime(media_file.path),
      width: movie_info.width,
      height: movie_info.height,
      filesize: File.size(media_file.path),
      duration: movie_info.duration,
      video_codec: movie_info.video_codec,
      audio_codec: movie_info.audio_codec
    )
  end

  private

  def get_md5(path)
    # `md5 "#{path}"`
    '1234'
  end

end
