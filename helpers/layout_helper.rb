# frozen_string_literal: true

module LayoutHelper
  MAIN_TITLE = "Task Roller App"

  def page_title
    return MAIN_TITLE if @title.nil?

    "#{MAIN_TITLE} | #{@title}"
  end
end
