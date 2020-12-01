import { Controller } from "stimulus"
import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

export default class extends Controller {
  static targets = [ "address", "transportation" ]

  connect() {

  }

  triggerMap(event) {
    const address = this.addressTarget.value
    console.log(address)

    // const transportation = this.currentTarget.text
    const transportation = event.currentTarget.getAttribute("for")
    console.log(transportation)

    fetch(`/shops?address=${address}&transportation=${transportation}`, { headers: { accept: "application/json" } })
    .then(response => response.json())
    .then((data) => {
      // reinitialiser la map
      console.log(data);

      // MAP -----------------------------------------------------------------------
      const mapElement = document.getElementById('map');

      // MARKERS -----------------------------------------------------------------
      const fitMapToMarkers = (map, markers) => {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
        map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
      };

      // MAP -----------------------------------------------------------------------
      if (mapElement) {
        mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
        const map = new mapboxgl.Map({
          container: 'map',
          style: 'mapbox://styles/nindiss/ckhz2yl98095b19omglv8mb54'
        });


        // MARKERS -----------------------------------------------------------------
        const markers = data.markers;
        markers.forEach((marker) => {
          const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

            // Create a HTML element for your custom marker
            const element = document.createElement('div');
            element.className = 'marker';
            element.style.backgroundImage = `url('${marker.image_url}')`;

            // Pass the element as an argument to the new marker
            new mapboxgl.Marker(element)
              .setLngLat([marker.lng, marker.lat])
              .setPopup(popup)
              .addTo(map);
        });

        // STARTING MARKER -----------------------------------------------------------------
        const startingMarker = data.starting_marker;
        var el = document.createElement('div');
        el.className = 'starting-marker';

        new mapboxgl.Marker(el)
            .setLngLat([ startingMarker.lng, startingMarker.lat ])
            .addTo(map);

        fitMapToMarkers(map, markers);
        map.setCenter([startingMarker.lng, startingMarker.lat]);
      }
    // Scroller redirect_to root_path(anchor: "map-section")
    document.getElementById("map-section").scrollIntoView();
    });
  }
}
