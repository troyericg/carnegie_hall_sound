// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .



$(document).ready(function(){
	
	// on hover: Display event date info 
	$('.gallery-img-container').hover(function(e){
		$('.tooltip-gallery').stop().show();
		$(this).mousemove(function(e){
			var alph = $(this);
			var tooltip = $('.tooltip-gallery');
			var yPos = alph.offset().top; 
			var xPos = alph.offset().left;
			$('.tooltip-gallery-box').html(alph.attr('attr-date') + "<br />" + alph.attr('attr-loc'));
			tooltip.css({'left': xPos - 121, 'top': yPos - 320 });
		});
		}, function(){
			$('.tooltip-gallery').hide();
	});
	
	// on hover: Display audio info 
	$('.column1-controls').hover(function(){
		
		$('.tooltip-list').stop().delay(1000).fadeIn();
		
		$(this).mousemove(function(e){
			var alph = $(this);
			var yPos = alph.offset().top; 
			var xPos = alph.offset().left;
			var tooltip = $('.tooltip-list');
			
			tooltip.css({'left': xPos - 80, 'top': yPos - 295 });
		});
		}, function(){
			$('.tooltip-list').fadeOut('fast');
	});
	
	// on scroll: Unhook nav
	$(window).scroll(function() {
		var $win = $(this);
		var $nav = $('div#nav');
	    
		if (!$nav.hasClass("fixed") && ($win.scrollTop() + 10 > $nav.offset().top)) {
			$nav.addClass("fixed").data("top", $nav.offset().top);
		} else if ($nav.hasClass("fixed") && ($win.scrollTop() < $nav.data("top"))) {
			$nav.removeClass("fixed");
	}});
	
	//on click: scroll back to top
	$('div#nav h2').click(function(){
		$('html, body').animate({scrollTop: 0},'fast');
	});
	
	
	//-------------------- FILTERS --------------------//
	
	// on click: clear filters
	$('li#allEvents').click(function(){
		$('li').removeClass('tagged'); $(this).addClass('tagged');
		
		$('div.gallery-img-container, div.event-entry').each(function(){
			$(this).find($('.swf-player')).remove();
			$(this).show();
		});
	});
	
	// on click: show only carnegie hall events
	$('li#carnAudio').click(function(){
		$('li').removeClass('tagged'); $(this).addClass('tagged');
		
		$('div.gallery-img-container, div.event-entry').each(function(){
			$(this).hide();
			$(this).find($('.swf-player')).remove();
			var audioID = $(this).attr('attr-audioID');
			if (audioID != "" ) {
				$(this).show();
			}
		});
	});
	
	// on click: show only non-carnegie hall events
	$('li#non-carnEvents').click(function(){
		$('li').removeClass('tagged'); $(this).addClass('tagged');
		
		$('div.gallery-img-container, div.event-entry').each(function(){
			$(this).hide();
			$(this).find($('.swf-player')).remove();
			var presenter = $(this).attr('attr-presenter');
			if (presenter != "CARNEGIE HALL PRESENTS" ) {
				$(this).show();
			}
		});
	});
	
	
});
