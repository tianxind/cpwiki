var myEditor = (function() {
	function insertWebImage(src) {
		// If the image source doesn't start with either http:// or https://, we need to
		// prepend http. Otherwise, rails will think this is http://our.website.url/XXXXX
		if (src.indexOf("http://") != 0 && src.indexOf("https://") != 0) {
			src = "http://" + src;
		}
		document.execCommand('insertImage', false, src);
		return src;
	}

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
							src = insertWebImage(src);
							// document.execCommand('insertImage', false, src);
						}
						replaceImageHTML(src, true);

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
	
	function replaceImageHTML(src, isLinked) {
		var originalStr = "<img src=\"" + src + "\">";
		var replaceStr = "";
		if (isLinked) {
			replaceStr = "<img class=\"resize wiki_image\" src=\"" + src + "\" type=\"web\"></img>";
		} else {
			replaceStr = "<img class=\"resize wiki_image\" src=\"" + src + "\" type=\"upload\"></img>";
		}
		var wikiSource = $(".edit_area")[0].innerHTML;
		wikiSource = wikiSource.replace(originalStr, replaceStr);
		$(".edit_area")[0].innerHTML = wikiSource;
	};
	
	// function replaceImageHTML(src) {
	// 	var originalStr = "<img src=\"" + src + "\">";
	// 	var replaceStr = "<img class=\"resize wiki_image\" src=\"" + src + "\"></img>";
	// 	var wikiSource = $(".edit_area")[0].innerHTML;
	// 	wikiSource = wikiSource.replace(originalStr, replaceStr);
	// 	$(".edit_area")[0].innerHTML = wikiSource;
	// };
	
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
		var dialogForm = "<div id=\"dialog-form\" title=\"插入图片\">" +
			"<form accept-charset=\"UTF-8\" action=\"/photos\" class=\"new_photo\" data-remote=\"true\"" +
			" enctype=\"multipart/form-data\" id=\"new_photo\" method=\"post\">" +
			"<input type=\"file\" name=\"file\" id=\"file\" value=\"\" class=\"text ui-widget-content ui-corner-all\" />" +
			"<input name=\"commit\" id=\"commit\" type=\"submit\" value=\"上传\" class=\"submit_button\">" +
		    "</form>" + 
			"</div>";

		// var dialogForm = "<div id=\"dialog-form\" title=\"插入图片\">" +
		// 	"<div style='display:inline-block;width:45%;'>" +
		// 	"<input type='radio' name='source' id='web' value='web' checked>网络图片" +
		// 	"<input type='radio' name='source' id='upload' value='upload'>本地图片" +
		// 	"</div>" +
		// 	"<div style='display:inline-block;width:54%;'>" +
		// 	"<form id=\"new_web_photo\">" + 
		// 	"<label for='photo[filename]'>图片地址</label>" +
		// 	"<input id=\"photo_filename\" name=\"photo[filename]\" size=\"30\" type=\"text\">" +
		// 	"<input id=\"commit_web\" value=\"确定\" type=\"submit\">" +
		// 	"</form>" +
		// 	"<form style='display:none' accept-charset=\"UTF-8\" action=\"/photos\" class=\"new_photo\" data-remote=\"true\"" +
		// 	" enctype=\"multipart/form-data\" id=\"new_photo\" method=\"post\">" +
		// 	"<input type=\"file\" name=\"file\" id=\"file\" value=\"\" class=\"text ui-widget-content ui-corner-all\" />" +
		// 	"<input name=\"commit\" id=\"commit\" type=\"submit\" value=\"上传\">" +
		//     "</form>" + 
		// 	"</div>";

		// var dialogForm = "<div id=\"dialog-form\" title=\"插入图片\">" +
		// 	"<div style='display:inline-block;width:45%;'>" +
		// 	"<input type='radio' name='source' id='web' value='web' checked>网络图片" +
		// 	"<input type='radio' name='source' id='upload' value='upload'>本地图片" +
		// 	"</div>" +
		// 	"<div style='display:inline-block;width:54%;'>" +
		// 	"<form accept-charset=\"UTF-8\" action=\"/photos/create_web_photo\" class=\"new_web_photo\" data-remote=\"true\" id=\"new_web_photo\" method=\"post\">" +
		// 	"<label for='photo[filename]'>图片地址</label>" +
		// 	"<input id=\"photo_filename\" name=\"photo[filename]\" size=\"30\" type=\"text\">" +
		// 	"<input id=\"commit_web\" value=\"确定\" type=\"submit\">" +
		// 	"</form>" +
		// 	// "<form accept-charset=\"UTF-8\" action=\"/photos\" class=\"new_photo\" data-remote=\"true\"" +
		// 	// " enctype=\"multipart/form-data\" id=\"new_photo\" method=\"post\">" +
		// 	// "<input type=\"file\" name=\"file\" id=\"file\" value=\"\" class=\"text ui-widget-content ui-corner-all\" />" +
		// 	// "<input name=\"commit\" id=\"commit\" type=\"submit\" value=\"上传\">" +
		//  //    "</form>" + 
		// 	"</div>" +
		// 	"</div>";
		var lastForm = $('form');
		lastForm = lastForm[lastForm.length - 1];
		$(dialogForm).insertAfter(lastForm);
		
		// Bind event to save filename 
		$('#file').change(function() {
			console.log("inside onchange for file field");
			// Set filename field to send to server
			$('#saved_filename').val($('#file').val());
			console.log($('#saved_filename').val());
		});

		// Bind event to confirm inserting web photo
		// $("#new_web_photo").submit(function(e) {
		// 	var src = $('#photo_filename').val();
		// 	console.log(src);
		// 	// $('.edit_area').focus();
		// 	// var sel = document.selection;
		// 	// if (sel) {
		// 	// var textRange = sel.createRange();
		// 	// document.execCommand('insertImage', false, src);
		// 	// textRange.collapse(false);
		// 	// textRange.select();
		// 	// } else {
		// 	document.execCommand('insertImage', false, src);
		// 	// }
		// 	replaceImageHTML(src, true);
		// 	$('#photo_filename').val("");
		// 	$("#dialog-form").dialog("close");
		// 	return false;
		// });

		// Bind event to switch form using radio button
		$('#web').click(function() {
			console.log("show web form");
			$('#new_web_photo').show();
			$('#new_photo').hide();
		});

		$('#upload').click(function() {
			console.log("show upload form");
			$('#new_web_photo').hide();
			$('#new_photo').show();
		});
		// Bind Ajax events
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
	}
	
	function isTextNode(node) {
		return node.nodeType == 3;
	}
	
	function addUploadDialog() {
		$("#dialog-form").dialog({
			autoOpen: false,
			height: 150,
			width: 400,
			modal: true
	    });	
	};
	
	return {
		makeEditor: function(editor, defaultText) {
			this.editor = editor;
			
			editor.innerHTML = defaultText;
			
			// Allows user to edit inside the editor
			editor.setAttribute("contenteditable", true);

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