# frozen_string_literal: true

module LayoutHelper
  MAIN_TITLE = "Task Roller App"

  def page_title
    return MAIN_TITLE if @title.nil?

    "#{MAIN_TITLE} | #{@title}"
  end

  def nav_link(title, path)
    css_class = "current-page" if request.path == path

    "<a class='#{css_class}' href='#{path}'>#{title}</a>"
  end
end
