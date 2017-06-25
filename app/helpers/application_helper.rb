module ApplicationHelper

  def resolution_label(width)
    if width
      if width < 1280
        return 'SD'
      elsif width < 1920 && height <= 720
        return '720p'
      elsif width < 3840 && height <= 1080
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

  def filter_link(label, url, active_on)
    classes = ['btn', 'btn-default']
    classes << 'active' if params[:filter] == active_on
    link_to label, url, class: classes.join(' ')
  end

  def flash_messages
    str = ""
    [:error, :warning, :success].each do |kind|
      str += content_tag :div, flash[kind], class: "alert alert-#{kind}" if flash[kind]
    end

    return str
  end

end
