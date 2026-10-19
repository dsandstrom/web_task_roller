# frozen_string_literal: true

module LayoutHelper
  MAIN_TITLE = "Task Roller App"

  TAG_ICONS =
    %w[backspace bug bulb calendar cart fireball flask fork-repo gear globe
       help image money network notifications options paintbucket plane
       pull-request ribbon scissors settings share speakerphone stopwatch
       textsms trophy umbrella].freeze

  def page_title
    return MAIN_TITLE if @title.nil?

    "#{MAIN_TITLE} | #{@title}"
  end

  def menu(links)
    nav(links, "menu")
  end

  def page_nav(links)
    content_for :page_nav do
      nav(links, "page-nav")
    end
  end

  def icon(name)
    "<i class=\"icon-#{name}\"></i>"
  end

  def top_link
    <<~HTML
      <p class="top-link-wrapper">
        <a href="#top">#{icon('arrow-up')} Top</a>
      </p>
    HTML
  end

  def type_color_options
    color_tags =
      %w[default blue brown green purple red yellow].map do |color|
        <<~HTML
          <span class="issue-type-tag roller-type-color-#{color}">
            <span>#{titleize(color)}</span>
          </span>
        HTML
      end

    color_tags.join
  end

  def type_icon_options
    color_tags =
      TAG_ICONS.map do |name|
        <<~HTML
          <span class="issue-type-tag roller-type-color-default">
            <i class="icon-#{name}"></i>
            <span>#{titleize(name)}</span>
          </span>
        HTML
      end

    color_tags.join
  end

  private

    def nav_link(title, path, path_regex = nil)
      css_class =
        if (!path_regex.nil? && path_regex.match?(request.path)) ||
           request.path == path
          "current-page"
        end

      "<a class='#{css_class}' href='#{path}'>#{title}</a>"
    end

    def nav(links, css_class)
      nav_links =
        links.map do |title, path, path_regex|
          nav_link(title, path, path_regex)
        end

      <<~HTML
        <p class="#{css_class}">
          #{nav_links.join("\n")}
        </p>
      HTML
    end

    def titleize(word)
      word = word.gsub(/[-_]/, " ")
      parts = word.split(/\s+/)
      parts =
        parts.map do |part|
          "#{part[0].upcase}#{part[1..]}"
        end
      parts.join(" ")
    end
end
