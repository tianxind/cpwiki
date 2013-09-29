module Sanitize
  def sanitize_tag(wiki, tag)
  	pos = 0
  	start_part = tag[0..tag.length - 2]
  	tag_len = start_part.length
    while pos < wiki.length
      start_div_tag = wiki.index(start_part, pos)
      if start_div_tag == nil then break end
      pos = start_div_tag + tag_len
      end_start_tag = wiki.index(">", pos)  # search for the end of start <div> tag
      if end_start_tag == nil then break end
      wiki.slice!(start_div_tag + tag_len..end_start_tag - 1)
    end
  end

  def sanitize(wiki)
  	# Remove all contents in <div> starting tags
  	sanitize_tag(wiki, "<div>")
    # Remove all contents in <span> starting tags
    sanitize_tag(wiki, "<span>")
  end
end