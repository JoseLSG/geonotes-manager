/*
 * map.js:
 * 	Handles all Leaflet map settings and logic
 * 
 * author: Jose Saldivar
 * 
 */

//  After extended search and trials, needed to use the 'ready' function and include map.js directly on a non-ajax-loaded 'map page' 
//	since using load(),on("initpage",..), etc doesn't seem to be working properly in current nor RC jquery mobile version

$(function() {
	var map = new L.Map('map');
	var groupL = new L.LayerGroup();
	var userMarker = null;
	
	map_set(map);
	
	//Event handling - add_note mode/navigate mode
	$("#add_note").on("click",function(){ map.on('click', map_click) });
	$("#navigate").on("click",function(){ map.off('click', map_click) });
	
	function map_click(e){
		userMarker = new L.Marker(e.latlng);
		//var popup = new L.Popup().setLatLng(e.latlng).setContent("Edit content Stub");
		
		$("#content_section #note_lat").attr("value", e.latlng.lat);
		$("#content_section #note_lon").attr("value", e.latlng.lng);
		var form = $("#form_handle").html();
		userMarker.bindPopup(form);
		
		groupL.addLayer(userMarker);
		
		map.addLayer(userMarker);
		userMarker.openPopup();
		
		//handle new note submit closing popup
		$("form[data-remote]").each(function(i, form){
			 var f = $(form)
			 f.on("ajax:success", function(evt, data, status, xhr){ 
	            userMarker.closePopup().bindPopup(xhr.responseText).openPopup();
	        })
	        
			 f.on("ajax:error", function(evt, xhr, status, error){ 
	            userMarker.closePopup().bindPopup("failed to create, delete marker").openPopup();
	        })
		});
		
	}
	

});



function map_set(map){
	var cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/1b46adf1e17046928ee782e81563176c/997/256/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
    maxZoom: 18
	});
	
	map.addLayer(cloudmade);
	map.locateAndSetView(16);
};