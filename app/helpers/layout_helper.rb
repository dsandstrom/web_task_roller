# frozen_string_literal: true

module LayoutHelper
  MAIN_TITLE = "Task Roller App"

  def page_title
    return MAIN_TITLE if @title.nil?

    "#{MAIN_TITLE} | #{@title}"
  end

  def nav_link(title, path, path_regex = nil)
    css_class =
      if (!path_regex.nil? && path_regex.match?(request.path)) ||
         request.path == path
        "current-page"
      end

    "<a class='#{css_class}' href='#{path}'>#{title}</a>"
  end
end
