import mapboxgl from 'mapbox-gl';
// import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {

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
