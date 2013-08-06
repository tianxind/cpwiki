function makeWYSIWYG(editor) {
	// Allows user to edit inside the editor
	editor.setAttribute("contenteditable", true);
	
	// Get the html button and add click event
	var html_button = $(".makeWYSIWYG_viewHTML")[0];
	html_button.addEventListener('click', function(e) {
		alert(editor.innerHTML);
		
		// Prevent submitting form
		e.preventDefault();
	});
	
	// Get the format buttons
	var buttons = $("button[data-tag]");
	
	for (var i = 0; i < buttons.length; i++) {
		buttons[i].addEventListener('click', function(e) {
			var tag = this.getAttribute('data-tag');
			switch(tag) {
				case 'createLink':
					var link = prompt('Please specify the link.');
					if (link) {
						document.execCommand('createLink', false, link);
					}
				break;
				
				case 'insertImage':
					var src = prompt('Please specify the link of the image.');
					if (src) {
						document.execCommand('insertImage', false, src);
					}
				break;
				
				case 'heading':
					// The browser doesn't support "heading" command, we use an alternative
					document.execCommand('formatBlock', false, '<' + this.getAttribute('data-value') + '>');
				break;
				
			    default:
					document.execCommand(tag, false, this.getAttribute('data-value'));
			}
			
			e.preventDefault();
		});
	}
	return editor;
};