import { Application } from "@hotwired/stimulus";

import MapController from "./map_controller";
// import SearchController from "./search_controller";


const application = Application.start();

application.register("map", MapController);
// application.register("search", SearchController);

export default application;
