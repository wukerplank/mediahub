module ApplicationHelper

  def resolution_label(width)
    if width
      if width < 1280
        return 'SD'
      elsif width < 1920
        return '720p'
      elsif width < 3840
        return '1080p'
      elsif width >= 3840
        return '4K'
      else
        return '???'
      end
    else
      return '???'
    end
  end

end
