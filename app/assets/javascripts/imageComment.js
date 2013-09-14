// Add comment button to all images in wiki content
function addCommentButtonToImages() {
	var images = $('.wiki_image');
	console.log(images);
	var addCommentButton = $('#add_comment');
	var hoveredImage = false;
	images.mouseenter(function(e) {
		// console.log("show add comment button");
		hoveredImage = this;
		var offset = $(this).offset();
		var top = offset.top - $('.right_container').offset().top;
		var left = offset.left - $('.left_sidebar').width() - $('.homepage_content').css('marginLeft');
		addCommentButton.show();
		addCommentButton.css({
			top: top + 'px',
			left: left + 'px'
		});
	});
	images.mouseleave(function(e) {
		if (e.relatedTarget === addCommentButton) {
	    	return;
		}
		addCommentButton.hide();
		hoveredImage = false;
	});
	addCommentButton.mouseleave(function(e){
		if (e.relatedTarget === hoveredImage) {
	    	return;	
		}
		addCommentButton.hide();
		hoveredImage = false;
	});

	var len = images.length;
	for (var i = 0; i < len; ++i) {
		console.log($(images[i]).attr('src'));
		// var link = $("<a href='/photos/lookup?src='" + escape($(images[i]).attr('src')) + "'></a>");
		var imageSrc = $(images[i]).attr('src');
		if (imageSrc.indexOf("/images/") == 0) {
			imageSrc = imageSrc.replace("/images/", "");
		}
		var link = jQuery('<a/>', {
    		'href': '/photos/lookup?src=' + encodeURIComponent(imageSrc)
		})
		link.append($(images[i]).clone());
		console.log(link);
		$(images[i]).replaceWith(link);
	}
}