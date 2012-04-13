/**
 * @author Jose Luis Saldivar
 */

$(function(){
	set_nav_loading();
	
})

function set_nav_loading(){

	$("a#Map").on("click", function(evt, data, status, xhr) {
		$.mobile.showPageLoadingMsg();
	});
	
	$("a#Note").on("click", function(evt, data, status, xhr) {
		$.mobile.showPageLoadingMsg();
	});

};