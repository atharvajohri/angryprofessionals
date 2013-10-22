$(document).ready(function(){
	resizeScreen();
	$(window).resize(function(){
		resizeScreen();
	})
	bindEvents();
	setupPopups();
	getPosts(null, function(){
		setupMasonry();		
	});
	
});

var msnry; 

function bindEvents(){
//	$("#signup").click(function(){
//		$("#signup-popup").fadeIn(300);
//	});
	
}

function setupMasonry(){
	msnry = new Masonry( $("#posts-viewport")[0], {
		// options
		itemSelector: '.post-container',
		gutter: 30
	});
}

function showAdvice(){
}

function getPosts(id, successCallback, prepend){
	var url = (id ? "/post/getPost/"+id : "/post/getPost")
	$.ajax ({
		url : url,
		type: "POST",
		success: function(data){
			if (prepend)
				$("#posts-viewport").prepend(data);
			else
				$("#posts-viewport").html(data);
			
			if ( msnry )
				msnry.prepended($(".post-"+id));
			if (successCallback){
				successCallback();
			}
		},
		error: function(data){
			console.log(data);
			showServerMessage("Something went wrong... Please try again later.");
		}
		
	});
}

function setupPopups(){
	$("#post-btn").click(function(){
		$("#main-overlay").fadeIn(300);
		$("body").addClass("no-scroll");
		$("#post-popup").fadeIn(300);
	});
	
	$("#close-post").click(function(){
		$("#main-overlay").fadeOut(300);
		$("body").removeClass("no-scroll");
		$("#post-popup").fadeOut(300);
		$(".new-post-field").val("");
	});
	
	$("#close-advice").click(function(){
		$("#main-overlay").fadeOut(300);
		$("body").removeClass("no-scroll");
		$("#add-advice-container").fadeOut(300);
		$("#advice-id").val("");
	});
	
	$(".add-advice-btn").die();
	$(".add-advice-btn").live("click", function(){
		$("#add-advice-container").fadeIn(300);
		$("#main-overlay").fadeIn(300);
		$("body").addClass("no-scroll");
		$("#advice-id").val($(this).attr("rel"));
	});
	
	centerPopups();
}

function addAdviceCallback(data){
	console.log(data);
	if (data.blankText){
		showServerMessage("Advice text cannot be empty.");
		$(".advice-text-input").focus();
	}else{
		$("#close-advice").click();
		if (data.success){
			showServerMessage("Successfully added advice!")
//			getPosts(data.post.id, null, true);
		}else{
			showServerMessage("Something went wrong... Please try again later.")
		}
	}
}

function addPostCallback(data){
	console.log(data);
	if (data.blankText){
		showServerMessage("Post text cannot be empty.");
		$(".post-text").focus();
	}else{
		$("#close-post").click();
		if (data.success){
			showServerMessage("Successfully posted")
			getPosts(data.post.id, null, true);
		}else{
			showServerMessage("Something went wrong... Please try again later.")
		}
	}
}

function showServerMessage(message){
	$("#server-message").html(message);
	$("#server-message-container").stop().fadeIn(100).delay(1200).fadeOut(100);
}

function centerPopups(){
	$(".popup, #server-message-container").each(function(){
		var popup = $(this);
		popup.css("left", ($(window).width() - popup.width())/2 + "px")
	});
}

function resizeScreen(){
	var bodyHeight = $(window).height() - $("#header-container").height() - $("#footer-container").height();
	$("#body-container").css("min-height", bodyHeight+"px")	
}