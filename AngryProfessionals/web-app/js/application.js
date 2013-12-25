$(document).ready(function(){
	resizeScreen();
	$(window).resize(function(){
		resizeScreen();
	});
	bindEvents();
	setupPopups();
});

var msnry, pm; 

function getCurrentYear(){
	return (new Date().getFullYear());
}

function bindEvents(){
//	$("#signup").click(function(){
//		$("#signup-popup").fadeIn(300);
//	});
	$("#ap-archives").click(function(){
		window.location.hash = "archives";
	});
	$("#our-story-btn").click(function(e){
		window.location.hash = "ourstory";
		e.stopPropagation();
	});
	$("#header-content-container").click(function(){
		window.location.hash = "";
	});
	$(window).bind('hashchange', function() {
		$("#archive-filter").addClass("hide");
		$("#ap-our-story").addClass("hide");
		$("#posts-viewport").removeClass("hide");
		var hash = window.location.hash;
		if (hash == "#archives"){
			showArchivesFilter();
		}
		else if (hash == "#ourstory"){
			showOurStory();
		}else {
			if (msnry)
				msnry.destroy();
			getPosts(null, function(){
				setupMasonry();		
			});
		}
	});
	
	$(window).trigger("hashchange");
}

function showOurStory(){
	$("#ap-our-story").removeClass("hide");
	$("#posts-viewport").addClass("hide");
}

function showArchivesFilter(){
	$("#archive-filter").removeClass("hide");
	$("#af-year").val(getCurrentYear());
	$("#af-search").click(function(){
		var requestData = {
			"title": $("#af-title").val(),
			"year": $("#af-year").val(),
			"month": $("#af-month").val()
		};
		$.ajax({
			url:"/post/getFilteredPosts",
			data: requestData,
			success: function(data){
				msnry.destroy();
				$("#posts-viewport").html(data);
				setupMasonry();
			},
			error: function(data){
				showServerMessage("Something went wrong... Please try again later.");
			}
		});
	});	
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
			showPosts(data, prepend, id);
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

function showPosts(postData, prepend, id){
	if (prepend)
		$("#posts-viewport").prepend(postData);
	else
		$("#posts-viewport").html(postData);
	
	if ( msnry && id )
		msnry.prepended($(".post-"+id));
}

function setupPopups(){
	pm = new PostModel();
	ko.applyBindings(pm, $("#add-advice-container")[0]);
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
		var post = $(this).attr("rel");
		pm.advice([]);
		getAdviceForPost(post, function(){
			$("#add-advice-container").fadeIn(300);
			$("#main-overlay").fadeIn(300);
			$("body").addClass("no-scroll");
			$("#advice-id").val(post);	
		});
	});
	centerPopups();
}

function PostModel(){
	var self = this;
	self.advice = ko.observableArray();
	self.adviceExists = ko.computed(function(){
		return advice.length > 0;
	});
}

var Advice = function(){
	var self = this;
	
	self.name = ko.observable();
	self.text = ko.observable();
}

function populateAdvice(adviceSet){
	
}

function getAdviceForPost(post, callback){
	$.ajax({
		url: "/post/getAdviceForPost",
		data: {"post": post},
		type: "POST",
		success: function(adviceData){
			for (var i in adviceData){
				var adviceModel = new Advice();
				adviceModel.name(adviceData[i].name);
				adviceModel.text(adviceData[i].text);
				pm.advice.push(adviceModel);
			}
			if (callback)
				callback();
		},
		error: function(data){
			console.log("error advice set");
		}
	});
}

function addAdviceCallback(data){
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
	$(".popup").css("max-height", ($(window).height()-100) + "px")
}