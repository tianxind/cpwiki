module ApplicationHelper
  def formatted(text)
    return text == nil ? "" : text.html_safe
  end
end
