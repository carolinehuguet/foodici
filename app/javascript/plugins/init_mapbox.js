import mapboxgl from 'mapbox-gl';
// import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  // mapboxgl.accessToken = 'pk.eyJ1IjoibmluZGlzcyIsImEiOiJja2h6MXNibWcwc3pkMnlsdG4xbTF0czlwIn0.VROpUFRln5-oEGHXpWT7IQ';
  // var map = new mapboxgl.Map({
  // container: 'map', // container id
  // style: 'mapbox://styles/mapbox/streets-v11', // style URL
  // center: [-74.5, 40], // starting position [lng, lat]
  // zoom: 9 // starting zoom
  // });

  // MAP -----------------------------------------------------------------------
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/nindiss/ckhz2yl98095b19omglv8mb54'
    });


    // MARKERS -----------------------------------------------------------------

    // const markers = JSON.parse(mapElement.dataset.markers);
    // markers.forEach((marker) => {
    //   new mapboxgl.Marker()
    //     .setLngLat([ marker.lng, marker.lat ])
    //     .addTo(map);
    // });
  }
};




// EXPORTS ---------------------------------------------------------------------
export { initMapbox };
