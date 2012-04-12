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

	var map = map_index();

	if($("#edit_note_handle").length == 1) {
		map_edit_note(map);

	} else if ($("#show_note_handle").length == 1) {
		map_show_note(map);
		
	} else {
		map.locateAndSetView(16);
	}

});

function map_index(){
	var map = new L.Map('map'),
			groupL = new L.LayerGroup(),
			userMarker = null,
			notes_ary = [];
	
	map_set(map);
	//map.locateAndSetView(16);
	
	set_nav_controls(map,map_click);
	load_notes(map);

	//map.fitBounds(new L.LatLngBounds(notes_ary));
	
	function map_click(e){

		userMarker = new L.Marker(e.latlng);
		$("#content_section #new_note_lat").attr("value", e.latlng.lat);
		$("#content_section #new_note_lon").attr("value", e.latlng.lng);
		var form = $("#new_note_handle").html();
		userMarker.bindPopup(form);

		groupL.addLayer(userMarker);

		map.addLayer(userMarker);
		userMarker.openPopup();

		handle_note_submit_response(userMarker);

	}
	
	return map;
	
};

function map_edit_note(map){
	var marker = locate_marker_popup("#edit_note_handle", map);
	handle_note_submit_response(marker);

};

function map_show_note(map){
	locate_marker_popup("#show_note_handle", map);

};

function locate_marker_popup(element_id, map){
	var note = $(element_id);
	var lat = note.find("#note_lat").attr("value");
	var lon = note.find("#note_lon").attr("value");

	var marker = set_marker(lat,lon,note.get(0))
	
	map.setView(new L.LatLng(lat, lon), 13);
	map.addLayer(marker);
	marker.openPopup();
	return marker;
};

function handle_note_submit_response(marker){

	$("form[data-remote]").each(function(i, form) {
		var f = $(form)
		f.on("ajax:success", function(evt, data, status, xhr) {
			marker.closePopup().bindPopup(xhr.responseText).openPopup();
		});
		
		f.find("#Submit").on("click", function(evt, data, status, xhr) {
			$.mobile.showPageLoadingMsg();
		});
		
		f.on("ajax:complete", function(evt, data, status, xhr) {
			$.mobile.hidePageLoadingMsg();
		});

		f.on("ajax:error", function(evt, xhr, status, error) {
			marker.closePopup().bindPopup("failed to edit, delete marker").openPopup();
		});
	});

};

function set_nav_controls(map, callback){
	
	$("#add_note").on("click",function(){ map.on('click', callback) });
	$("#navigate").on("click",function(){ map.off('click', callback) });
	
};

function load_notes(map){

	$("#load_notes").find("[type=note]").each(function(i, elm) {
		var lat = $(this).find('#note_lat').val(), 
				lon = $(this).find('#note_lon').val(), 
				html = $(this).addClass("popup").get(0);

		//notes_ary[i] = new L.LatLng(lat, lon);

		$(this).remove();
		var marker = set_marker(lat, lon, html);
		//groupL.addLayer(marker);
		map.addLayer(marker);
	});

};

function set_marker(lat,lon,html){

	marker = new L.Marker(new L.LatLng(lat, lon));
	marker.bindPopup(html);
	return marker;

};

function map_set(map){

	var cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/1b46adf1e17046928ee782e81563176c/997/256/{z}/{x}/{y}.png', {
		attribution : 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
		maxZoom : 18
	});

	map.addLayer(cloudmade);

};


