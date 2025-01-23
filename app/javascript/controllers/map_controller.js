import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxDraw from "@mapbox/mapbox-gl-draw";

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      language: "pt"
    })

    this.draw = new MapboxDraw({
      displayControlsDefault: false,
      // Select which mapbox-gl-draw control buttons to add to the map.
      controls: {
          polygon: true,
          trash: true
      }
    });
    this.map.addControl(this.draw);

    this.map.on('draw.create', (e) => this.#updateArea(e));
    this.map.on('draw.delete', (e) => this.#updateArea(e));
    this.map.on('draw.update', (e) => this.#updateArea(e));

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #updateArea(e) {
    console.log("E: ", e);
    console.log("THIS: ", this);
    var data = this.draw.getAll();
    console.log("DATA: ", data.features[0].geometry.coordinates);

    const url = "/schools?search=fraldas"
    fetch(url, {
      headers: {
        "Accept": "application/json"
      }
    })
      .then(response => response.json())
      .then(data => {
        console.log("Data received from server:", data);
        this.updateMarkers(data.markers);
      })
      .catch(error => {
        console.error("Error fetching data:", error);
      });
  }

  updateMarkers(newMarkers) {
    this.markersValue = newMarkers;
    this.#clearMarkers();
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #addMarkersToMap() {
    this.markers = this.markersValue.map((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.marker_tooltip_html)

      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      return new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #clearMarkers() {
    if (this.markers) {
      this.markers.forEach(marker => marker.remove());
    }
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
