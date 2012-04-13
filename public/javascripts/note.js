/**
 * @author Jose Luis Saldivar
 */

$(function(){
	set_loading_splash();
	
})

function set_loading_splash(){
	set_spinner_events();
	$("div.leaflet-popup-pane").on("DOMNodeInserted", function(){
		set_spinner_events();
	});

};

function set_spinner_events(){
	$("a#edit").on("click", function(evt, data, status, xhr) {
		$.mobile.showPageLoadingMsg();
	});

	$("a#delete").on("click", function(evt, data, status, xhr) {
		$.mobile.showPageLoadingMsg();
	});
	
	$("a.tag").on("click", function(evt, data, status, xhr) {
		$.mobile.showPageLoadingMsg();
	});
}
