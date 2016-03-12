function gmap_show(vendor) {
  if ((vendor.latitude == null) || (vendor.longitude == null) ) {    // validation check if coordinates are there
    return 0;
  }

  handler = Gmaps.build('Google');    // map init
  handler.buildMap({ provider: {}, internal: {id: 'geolocation'}}, function(){
    markers = handler.addMarkers([    // put marker method
      {
        "lat": vendor.latitude,    // coordinates from parameter company
        "lng": vendor.longitude,
        "picture": {    // setup marker icon
          "url": 'http://www.planet-action.org/img/2009/interieur/icons/orange-dot.png',
          "width":  32,
          "height": 32
        },
        "infowindow": "<b>" + vendor.company + "</b> " + company.website
      }
    ]);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(12);    // set the default zoom of the map
  });
}