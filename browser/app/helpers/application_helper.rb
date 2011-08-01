module ApplicationHelper
  FLASH_TYPES = [:notice, :error, :alert]

  def flash_messages
    flash_tag = ""
    FLASH_TYPES.each do |type|
      flash_tag += content_tag(:div, flash[type], :class=>type) if flash[type]
    end
    flash_tag.html_safe
  end
end
