module PageTitleHelper
  # Sets the page title which is composed of 3 elements
  #   1) The Site name
  #   2) A separator
  #   3) The title of each page

  def site_title
    data.config.site.title
  end

  def title_separator
    data.config.site.title_separator
  end

  def render_page_title
    if !current_page.data.title.blank?
      title = current_page.data.title
    else
      title = @dynamic_title
    end

    raise 'You must provide a page title for your page!' if title.blank?

    if current_resource.url == '/'
      "brett.cool"
    else
      "#{title}"
    end
  end
end
