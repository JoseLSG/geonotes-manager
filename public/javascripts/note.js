/**
 * @author Jose Luis Saldivar
 */

$(function(){
	set_loading_splash();
	
})

function set_loading_splash(){
	
	$("div.leaflet-popup-pane").on("DOMNodeInserted", function(){

		$("a#edit").on("click", function(evt, data, status, xhr) {
			$.mobile.showPageLoadingMsg();
		});

		$("a#delete").on("click", function(evt, data, status, xhr) {
			$.mobile.showPageLoadingMsg();
		});
		
		$("a.tag").on("click", function(evt, data, status, xhr) {
			$.mobile.showPageLoadingMsg();
		});

	});

};