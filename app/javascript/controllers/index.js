import { Application } from "@hotwired/stimulus";

import MapController from "./map_controller";


const application = Application.start();

application.register("map", MapController);

export default application;
