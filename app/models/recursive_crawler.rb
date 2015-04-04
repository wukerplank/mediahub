class RecursiveCrawler

  VALID_SUFFIXES = %w(avi divx mp4 m4v wmv mpg mpeg mkv).map { |s| ".#{s}" }

  def self.run(path, media_type)
    Dir.glob(File.join(escape_path(path), '*')).sort.each do |e|
      if File.directory? e
        run(e, media_type)
      else
        if VALID_SUFFIXES.include? File.extname(e).downcase
          MediaFile.create(path: e, media_type: media_type)
        end
      end
    end
  end

  def self.escape_path(path)
    escaped_path = path
    %w($ " { } [ ]).each do |char|
      escaped_path = escaped_path.gsub(/#{Regexp.escape(char)}/, "\\#{char}")
    end
    escaped_path
  end
end
