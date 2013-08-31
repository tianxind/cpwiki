var myEditor = (function() {
	function addButtonEventListeners(editor) {
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
						replaceImageHTML(src);
						/*var image = $("img[src='" + src + "']");
						console.log(image);
						image.mouseenter(function(e) {
							console.log("show delete button");
							var rect = image[0].getBoundingClientRect();
							var top = rect.top + $(document).scrollTop() + $(editor).scrollTop();
							var left = rect.left + $(document).scrollLeft() + $(editor).scrollLeft();
							console.log("top: " + top + ", left: " + left);
							var deleteButton = $(".delete_button")[0];
							deleteButton.style.visibility = 'visible';
							deleteButton.style.top = top + "px";
							deleteButton.style.left = left + "px";
							hoveredImage = image[0];
						});
			
						image.mouseleave(function(e) {
							console.log("hide delete button");
							var deleteButton = $(".delete_button")[0];
							if (e.relatedTarget == deleteButton) {
								return;
							}
							deleteButton.style.visibility = 'hidden';
							hoveredImage = false;
						});*/

					break;
			
					case 'title':
						// The browser doesn't support "heading" command, we use an alternative
						document.execCommand('formatBlock', false, '<' + this.getAttribute('data-value') + '>');
					break;
					
					case 'uploadImage':
						// Need to make sure the editor is in focus!!!
						$("#dialog-form").dialog("open");
					break;
					
					/*case 'test':
						$(".edit_area")[0].innerHTML = "<img class=\"resize\" src=\"/images/1_呆黑猫.jpg\"" +
						"contenteditable=\"false\">" +
						"</img>";
					break;*/
				    
					default:
						document.execCommand(tag, false, this.getAttribute('data-value'));
				}
		
				e.preventDefault();
			});	
		}
	};
	
	// The image where the user has his/her cursor on
	var hoveredImage = false;
	
	function hideDeleteButton(e) {
		console.log("hide delete button");
		var deleteButton = $(".delete_button")[0];
		if (e.relatedTarget == deleteButton) {
			return;
		}
		deleteButton.style.visibility = 'hidden';
	}

	/*function showDeleteButton(image) {
		console.log("show delete button");
		var rect = image.getBoundingClientRect();
		var top = rect.top + $(document).scrollTop() + editor.scrollTop();
		var left = rect.left + $(document).scrollLeft() + editor.scrollLeft();
		var deleteButton = $(".delete_button")[0];
		deleteButton.style.visibility = 'visible';
		deleteButton.style.top = top + "px";
		deleteButton.style.left = left + "px";
		hoveredImage = image;
	}

	function leaveDeleteButton(e) {
		console.log("left delete button");
		if (e.relatedTarget == hoveredImage) {
			return;
		}
		var deleteButton = $(".delete_button")[0];
		deleteButton.style.visibility = 'hidden';
		hoveredImage = false;
	}*/
	
	function replaceImageHTML(src) {
		var originalStr = "<img src=\"" + src + "\">";
		var replaceStr = "<img class=\"resize\" src=\"" + src + "\"></img>";
		var wikiSource = $(".edit_area")[0].innerHTML;
		wikiSource = wikiSource.replace(originalStr, replaceStr);
		$(".edit_area")[0].innerHTML = wikiSource;
	};
	
	function insertDeleteButton() {
		$("body").append("<button class=\"delete_button\">Delete</button>");
		$(".delete_button").mouseleave(function(e) {
			console.log("left delete button");
			if (e.relatedTarget == hoveredImage) {
				return;
			}
			var deleteButton = $(".delete_button")[0];
			deleteButton.style.visibility = 'hidden';
			hoveredImage = false;
		});
		
		$(".delete_button").click(function(e) {
			hoveredImage.remove();
			e.preventDefault();
		});
	};
	
	function insertDialogForm() {
		var dialogForm = "<div id=\"dialog-form\" title=\"Insert Image\">" +
			"<form accept-charset=\"UTF-8\" action=\"/photos\" class=\"new_photo\" data-remote=\"true\"" +
			" enctype=\"multipart/form-data\" id=\"new_photo\" method=\"post\">" +
			"<div style=\"margin:0;padding:0;display:inline\">" +
			"<fieldset>" +
			"<input type=\"file\" name=\"file\" id=\"file\" value=\"\" class=\"text ui-widget-content ui-corner-all\" />" +
			"<input name=\"commit\" id=\"commit\" type=\"submit\" value=\"Upload\">" +
			"</fiedset>" +
		    "</form>" + 
			"</div>";
			
		/*var dialogForm = "<div id=\"dialog-form\" title=\"Insert Image\">" +
			"<ul>" +
			"<li><a href=\"#tab-web\">网络图片</a></li>" +
			"<li><a href=\"#tab-local\">本地上传</a></li>" + 
			"</ul>" +
			"<div id=\"tab-web\">" +
			"<input type=\"text\" name=\"url\" id=\"url\" class=\"text ui-widget-content ui-corner-all\" />" +
			"</div>" +
			"<div id=\"tab-local\">" +
			"<form accept-charset=\"UTF-8\" action=\"/photos\" class=\"new_photo\" data-remote=\"true\"" +
			" enctype=\"multipart/form-data\" id=\"new_photo\" method=\"post\">" +
			"<div style=\"margin:0;padding:0;display:inline\">" +
			"<fieldset>" +
			"<input type=\"file\" name=\"file\" id=\"file\" value=\"\" class=\"text ui-widget-content ui-corner-all\" />" +
			"<input name=\"commit\" id=\"commit\" type=\"submit\" value=\"Upload\">" +
			"</fiedset>" +
		    "</form>" + 
			"</div>" +
			"</div>" +
			"</div>" +
			"</div>";*/
		var lastForm = $('form');
		lastForm = lastForm[lastForm.length - 1];
		$(dialogForm).insertAfter(lastForm);
	
		$('#file').change(function() {
			console.log("inside onchange for file field");
			// Set filename field to send to server
			$('#saved_filename').val($('#file').val());
			console.log($('#saved_filename').val());
		});
		
		// Bind Ajax events
		$('#dialog-form').on('ajax:success', function() {
			console.log("inside Ajax success callback");
			var original_filename = $('#saved_filename').val();
			var paths = original_filename.split('\\');
			var filename = paths[paths.length - 1];
			var src = "/images/" + $("#current_user").val() + "_" + filename;
			document.execCommand('insertImage', false, src);
			replaceImageHTML(src);
			
			// Bind event to show delete button
			/*var image = $("img[src='" + src + "']");
			image.mouseenter(function(e) {
				console.log("show delete button");
				var rect = image[0].getBoundingClientRect();
				var top = rect.top + $(document).scrollTop() + $(editor).scrollTop();
				var left = rect.left + $(document).scrollLeft() + $(editor).scrollLeft();
				var deleteButton = $(".delete_button")[0];
				deleteButton.style.visibility = 'visible';
				deleteButton.style.top = top + "px";
				deleteButton.style.left = left + "px";
				hoveredImage = image[0];
			});
			
			image.mouseleave(function(e) {
				console.log("hide delete button");
				var deleteButton = $(".delete_button")[0];
				if (e.relatedTarget == deleteButton) {
					return;
				}
				deleteButton.style.visibility = 'hidden';
				hoveredImage = false;
			});*/
			
			$("#dialog-form").dialog("close");

			// remove file input and bind onchange again
			$("#file").remove();
			var fileInput = $("<input type=\"file\" name=\"file\" id=\"file\" value=\"\" class=\"text ui-widget-content ui-corner-all\" />");
			fileInput.insertBefore($('#commit'));
			$('#file').change(function() {
				console.log("inside onchange for file field");
				// Set filename field to send to server
				$('#saved_filename').val($('#file').val());
				console.log($('#saved_filename').val());
			});
			
			// Insert image src into all_images div
			$("#all_images").append("<input type=\"hidden\" id=\"images[]\" name=\"images[]\" value=\"" + 
				$("#current_user").val() + "_" + filename + "\"/>");
		});
	}
	
	function isTextNode(node) {
		return node.nodeType == 3;
	}
	
	function addUploadDialog() {
		$("#dialog-form").dialog({
			autoOpen: false,
			height: 200,
			width: 350,
			modal: true
	    });	
	};
	
	return {
		makeEditor: function(editor, defaultText) {
			this.editor = editor;
			
			editor.innerHTML = defaultText;
			
			// Allows user to edit inside the editor
			editor.setAttribute("contenteditable", true);
			/*editor.click(function(){
				$(this).children('img').attr('contenteditable','false');
			});*/
			
			// Add listeners for onclick events
			addButtonEventListeners(editor);
			
			// Insert dialog form after the last form on page
			insertDialogForm();
			
			// Configure upload image dialog 
			addUploadDialog();
			
			insertDeleteButton();
		}
	};
})();