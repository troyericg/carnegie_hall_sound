// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

// Finds the player ID (which is currently set to a bogus value), then updates it on click, need to somehow pass it to the swf object. 
// Builds the whole player from scratch on click, if dynamically updating it doesn't work. 


$(document).ready(function(){
	
	// On Click: Play button builds player from scratch, feeding in the audio ID.
	$('div.gallery-img-container').click(function(){
		var audioID = "t8440011a8e11";
		
		//if ( $('div.gallery-img-container').html().length < 1 ) {
			var swfPlayer = $('<object></object>').addClass('swf-player').attr('type','application/x-shockwave-flash')
					.attr('id','embedded_player_' + audioID)
					.attr('name','embedded_player_' + audioID)
					.attr('width','157')
					.attr('height','157')
					.attr('data','http://mediaservice.mirror-image.com/plugins/player.swf')
					// .attr('autoplay',"true")
					.attr('wmode','transparent');

			$('<param>').attr('name','allowfullscreen').attr('value','true').appendTo(swfPlayer);
			$('<param>').attr('name','allowscriptaccess').attr('value','always').appendTo(swfPlayer);
			$('<param>').attr('name','autoplay').attr('value','true').appendTo(swfPlayer);
			$('<param>').attr('name','base').attr('value','http://mediaservice.mirror-image.com').appendTo(swfPlayer);
			$('<param>').attr('name','flashVars').attr('value','t=' + audioID + '&amp;autoplay=true').appendTo(swfPlayer);
			$('<param>').attr('name','movie').attr('value','http://mediaservice.mirror-image.com/plugins/player.swf').appendTo(swfPlayer);
			$('<param>').attr('name','wmode').attr('value','transparent').appendTo(swfPlayer);

			swfPlayer.appendTo($(this));
			
		//}
		
	});
	
	$(this).find('object').fadeOut('slow');
	
});