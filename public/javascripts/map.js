/*
 * map.js:
 * 	Handles all Leaflet map settings and logic
 * 
 * author: Jose Saldivar (neo.jls@gmail.com)
 * 
 */

//  After extended search and trials, needed to use the 'ready' function and include map.js directly on a non-ajax-loaded 'map page' 
//	since using load(),on("initpage",..), etc doesn't seem to be working properly in current nor RC jquery mobile version

$(function() {
	var map = new L.Map('map');
	map_set(map);
	//Event handling - pick up coordinates where user click
	map.on('click', function(e){
		var latlngStr = '(' + e.latlng.lat.toFixed(3) + ', ' + e.latlng.lng.toFixed(3) + ')';
		var popup = new L.Popup();
		popup.setLatLng(e.latlng);
		popup.setContent(latlngStr);
		map.openPopup(popup);
	});
	
});

function map_set(map){
	var cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/1b46adf1e17046928ee782e81563176c/997/256/{z}/{x}/{y}.png', {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
    maxZoom: 18
	});
	
	map.addLayer(cloudmade);
	map.locateAndSetView(16);
};