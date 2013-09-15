module ApplicationHelper
  # Defines how long a snippet should be
  MAX_SNIPPET_LENGTH = 30

  def formatted(text)
    return text == nil ? "" : text.html_safe
  end

  def removeTags(text)
    # Remove html tags
    text.gsub("<div>", "")
    text.gsub("</div>", "")
    text.gsub("<p>", "")
    text.gsub("</p>", "")
    text.gsub("<b>", "")
    text.gsub("</b>", "")
    text.gsub("<em>", "")
    text.gsub("</em>", "")
  end

  def make_snippet(text)
  	if (!text) then return "" end
  	# This doesn't return the formatted text yet. Need to decide
  	# tomorrow what to return (formatted or pure text)
    # Remove all <div> tags. <br> tags and <img> tags and its innerHTML.
  	if (text.length < MAX_SNIPPET_LENGTH) 
  		return removeTags(text)
  	else
  		return removeTags(text[0..MAX_SNIPPET_LENGTH]) + "..."
  	end
  end
end
