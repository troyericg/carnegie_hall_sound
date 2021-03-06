// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function(){
	
	//Outside code that lets me force all external links to open in a new window.
	$("a").click(function() {
	  link_host = this.href.split("/")[2];
	  document_host = document.location.href.split("/")[2];
	  if (link_host != document_host) {
	    window.open(this.href);
	    return false;
	  }
	});
	
	
	$(window).scroll(function(){
		var $win = $(this);
		
		$('div.event-entry').each(function(){
			
			var player = $(this).find('.column1-controls');
			var boxBottom = $(this).position().top + $(this).innerHeight();
			
			if ($win.scrollTop() >= $(this).offset().top - 60) {
				player.css({'position':'fixed','top':70, 'bottom':'auto' });
			} if ($win.scrollTop() - 105 >= boxBottom) {
				player.css({'position':'absolute', 'top':'auto', 'bottom':30 });
			} else if ($win.scrollTop() <= $(this).offset().top) {
				player.css({'position':'absolute', 'top': 30, 'bottom':'auto' });
			}
		});
		
	});
	
});