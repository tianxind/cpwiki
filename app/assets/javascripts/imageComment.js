// Add comment button to all images in wiki content
function addCommentButtonToImages() {
	var images = $('.wiki_image');
	var addCommentButton = $('#add_comment');
	var hoveredImage = false;
	var len = images.length;
	for (var i = 0; i < len; ++i) {
		console.log($(images[i]).attr('src'));
		var imageSrc = $(images[i]).attr('src');
		if (imageSrc.indexOf("/images/") == 0) {
			imageSrc = imageSrc.replace("/images/", "");
		}
		var link = jQuery('<a/>', {
    		'href': '/photos/lookup?src=' + encodeURIComponent(imageSrc),
    		'target': '_blank'
		})
		link.append($(images[i]).clone());
		console.log(link);
		$(images[i]).replaceWith(link);
	}

    var images = $('.wiki_image')
    images.mouseenter(function(e) {
		console.log("show add comment button");
		console.log($(this).height());
		console.log($(this).width());
		hoveredImage = this;
		var offset = $(this).offset();
		var top = offset.top - $('.right_container').offset().top;
		homepageContentMarginLeft = parseInt($('.homepage_content').css('marginLeft').split("px")[0]);
		var left = offset.left - $('.left_sidebar').width() - homepageContentMarginLeft;
		addCommentButton.show();
		addCommentButton.css({
			top: top + 'px',
			left: left + 'px'
		});
		// console.log("addCommentButton left:" + addCommentButton.css('left'));
	});
	images.mouseleave(function(e) {
	    console.log("hide add comment button");
		if (e.relatedTarget === addCommentButton) {
	      return;
		}
		addCommentButton.hide();
		hoveredImage = false;
	});
}