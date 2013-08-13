makeWYSIWYG = (editor) ->
  
  # Allows user to edit inside the editor
  editor.setAttribute "contenteditable", true
  
  # Get the html button and add click event
  html_button = $(".makeWYSIWYG_viewHTML")[0]
  html_button.addEventListener "click", (e) ->
    alert editor.innerHTML
    
    # Prevent submitting form
    e.preventDefault()

  
  # Get the format buttons
  buttons = $("button[data-tag]")
  console.log buttons.length
  i = 0

  while i < buttons.length
    buttons[i].addEventListener "click", (e) ->
      tag = @getAttribute("data-tag")
      switch tag
        when "createLink"
          link = prompt("Please specify the link.")
          document.execCommand "createLink", false, link  if link
        when "insertImage"
          src = prompt("Please specify the link of the image.")
          document.execCommand "insertImage", false, src  if src
        when "heading"
          
          # The browser doesn't support "heading" command, we use an alternative
          document.execCommand "formatBlock", false, "<" + @getAttribute("data-value") + ">"
        when "subtitle"
          console.log "title button clicked"
          range = window.getSelection().getRangeAt(0)
          console.log range
          editor.innerHTML = "<p class='subtitle'>小呆呆</p></br>"
        
        #var horizontalline = document.createElement("div");
        #					horizontalline.className = "horizontalline"; 
        #					range.endContainer.parentNode.appendChild(horizontalline);
        else
          document.execCommand tag, false, @getAttribute("data-value")

      e.preventDefault()

    i++
	
  # editor.keypress (e) ->
  #  if e.keyCode is 13
  #    range = window.getSelection().getRangeAt(0)
  #    range.collapsed and range.startContainer is editor
      
      # Insert a new <p></p>
  #    startTag = range.startContainer

  
  #var subtitle_button = $("a[data-tag]")[0];
  #	subtitle_button.addEventListener('click', function(e) {
  #		var range = window.getSelection().getRangeAt(0);
  #		console.log(range);
  #		e.preventDefault();
  #	});
  editor