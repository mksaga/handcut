let map;

async function initMap(latitude, longitude) {
  // The location of Uluru
  const position = { lat: latitude, lng: longitude };
  // Request needed libraries.
  //@ts-ignore
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

  // The map, centered at Uluru
  map = new Map(document.getElementById("map"), {
    zoom: 4,
    center: position,
    mapId: "DEMO_MAP_ID",
  });

  // The marker, positioned at Uluru
  const marker = new AdvancedMarkerElement({
    map: map,
    position: position,
    title: "Uluru",
  });
}

Hooks.RestaurantMap = {
    mounted() {
          // The location of Uluru
        const position = { lat: latitude, lng: longitude };
        // Request needed libraries.
        //@ts-ignore
        const { Map } = google.maps.importLibrary("maps");
        const { AdvancedMarkerElement } = google.maps.importLibrary("marker");

        // The map, centered at Uluru
        map = new Map(document.getElementById("map"), {
            zoom: 4,
            center: position,
            mapId: "DEMO_MAP_ID",
        });

        // The marker, positioned at Uluru
        const marker = new AdvancedMarkerElement({
            map: map,
            position: position,
            title: "Uluru",
        });

    }
}
