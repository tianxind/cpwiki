var Tagger = (function() {
	var container, xPos, yPos;
	// function getCurrentTime () {
	// 	var currentdate = new Date(); 
	// 	return currentdate.getFullYear() + "-"
	//         + ("0" + (currentdate.getMonth() + 1)).slice(-2) + "-" 
	//         + ("0" + currentdate.getDate()).slice(-2) + " "  
	//         + currentdate.getHours() + ":"  
	//         + currentdate.getMinutes() + ":" 
	//         + currentdate.getSeconds();
	// }

	function insertTag(xpos, ypos, comment) {
		this.container.append("<div class=\"tag\">" + comment + "</div>");
	}

	// xInput and yInput are input boxes (JQuery object) recording x and y pos
	// of the tag.
	return {
		makeTagger: function (photo, container, dialogForm, xInput, yInput, photoId) {
			this.xPos = xInput;
			this.yPos = yInput;
			this.container = container;
			$(function() {
    			dialogForm.dialog({
	      			autoOpen: false,
	      			resizable: false,
	      			height: 200,
	      			modal: true,
	      			buttons: {
	        			Cancel: function() {
	          				$(this).dialog( "close" );
	        			},
	        			"提交": function() {
	        				xpos = xInput.val();
	        				ypos = yInput.val();
	        				comment = $("#comment").val();
	         	 			$.ajax({
	         	 				type: "POST",
		    					url: "/tags",
		    					dataType: "html",
		    					data: "comment=" + comment + "&xpos=" + xpos + "&ypos="
		    						+ ypos + "&photo_id=" + photoId.val(),
		    					success: function(){
		    						alert("success");
		    						dialogForm.dialog("close");
		    						insertTag(xpos, ypos, comment);
		     					},
		     					error: function(){
		     						alert("Post failed");
		     						dialogForm.dialog("close");
		     					}
							});
	        			}
	      			}
    			});
			});

			photo.click(function(e) {
				dialogForm.dialog("open");
				dialogForm.dialog("option", { position: [e.pageX + 5, e.pageY + 5] });
				xInput.val(e.pageX);
				yInput.val(e.pageY);
			});
		}
	}	
})();