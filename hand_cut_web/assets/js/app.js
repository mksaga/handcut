// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
// import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"

let Hooks = {}

Hooks.RestaurantMap = {
  mounted() {
    // Pull attributes off of <figure data-*> HTML attributes
    let latitude = parseFloat(this.el.dataset.lat);
    let longitude = parseFloat(this.el.dataset.long);
    let name = this.el.dataset.name;
    initMap(latitude, longitude, name);
  }
}

Hooks.ResultsMap = {
  mounted() {
    // Pull results from socket state
    this.pushEvent("get_restaurant_results", {}, (reply) => {
      initResultsMap(reply.results, reply.area, reply.key);
    });
  }
}

Hooks.Copy = {
  mounted() {
    let { to } = this.el.dataset;
    this.el.addEventListener("click", (ev) => {
      ev.preventDefault();
      let text = document.querySelector(to).dataset.value;
      navigator.clipboard.writeText(text)

      // show "Copied" tag, then hide
      copiedText = document.getElementById("copied-text");
      copiedText.classList.remove("is-hidden");
      setInterval(() => copiedText.classList.add("is-hidden"), 750);
    });
  },
}

Hooks.BackHook = {
  mounted() {
    this.el.addEventListener("click", (ev) => history.go(-1))
  }
}

async function initMap(latitude, longitude, name) {
  // Request needed libraries
  const { Map } = await google.maps.importLibrary("maps");
  const position = { lat: latitude, lng: longitude };
  map = new Map(document.getElementById("map"), {
    zoom: 15,
    center: position,
  });

  // Add marker
  await google.maps.importLibrary("marker");
  const simpleMarker = new google.maps.Marker({
    position: position,
    map,
    title: name,
    // label: {
    //     text: name,
    //     color: "#C70E20",
    //     fontWeight: "bold"
    // },
    // icon: {
    //     url: "http://maps.google.com/mapfiles/ms/icons/red-dot.png",
    //     labelOrigin: new google.maps.Point(68, 32),
    //     size: new google.maps.Size(32,32),
    //     anchor: new google.maps.Point(16,32)
    // },
  })
}

function computeCenter(results) {
  let avgLatitude = 0.0, avgLongitude = 0.0;
  for (i in results) {
    avgLatitude += results[i].lat
    avgLongitude += results[i].lng
  }
  return {
    lat: avgLatitude / results.length,
    lng: avgLongitude / results.length,
  }
}

function getZoomLevel(area) {
  const DEFAULT_ZOOM_LEVEL = 13
  let customZoomLevels = {
    "ny_manhattan": 13,
    "nj_paterson": 13,
    "nj_jersey_city": 13,
    "ny_queens": 11,
  }
  if (area in customZoomLevels) {
    return customZoomLevels[area]
  }
  return DEFAULT_ZOOM_LEVEL
}

async function initResultsMap(results, area, mapsKey) {
  g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))};
  ({key: mapsKey, v: "beta"});
  // Request needed libraries.
  const { Map } = await google.maps.importLibrary("maps");
  await google.maps.importLibrary("marker");

  // Calculate center of results to center map
  const center = computeCenter(results);

  zoomLevel = getZoomLevel(area);

  map = new Map(document.getElementById("results-map"), {
    zoom: zoomLevel,
    center: center,
    mapTypeId: "roadmap",
    disableDefaultUI: true,
    zoomControl: true,
  });

  // Add a marker for each result
  let markers = new Array(results.length)
  for (i in results) {
    let position = { lat: results[i].lat, lng: results[i].lng }
    markers[i] = new google.maps.Marker({
      position,
      map,
      label: results[i].label,
    })
  }
}


// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken }, hooks: Hooks })

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

