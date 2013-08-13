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
	console.log(buttons.length);
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
				
				case 'subtitle':
					console.log("title button clicked");
					var range = window.getSelection().getRangeAt(0);
					console.log(range);
					editor.innerHTML="<p class='subtitle'>小呆呆</p></br>";
					/*var horizontalline = document.createElement("div");
					horizontalline.className = "horizontalline"; 
					range.endContainer.parentNode.appendChild(horizontalline);*/
			    break;
			    
				default:
					document.execCommand(tag, false, this.getAttribute('data-value'));
			}
			
			e.preventDefault();
		});
	}
	
	editor.keypress(function(e) {
		if (e.keyCode == 13) {
			var range = window.getSelection().getRangeAt(0);
			if (range.collapsed && range.startContainer == editor) {
				// Insert a new <p></p>
			}
			startTag = range.startContainer
		}
	});
	/*var subtitle_button = $("a[data-tag]")[0];
	subtitle_button.addEventListener('click', function(e) {
		var range = window.getSelection().getRangeAt(0);
		console.log(range);
		e.preventDefault();
	});*/ 
	return editor;
};