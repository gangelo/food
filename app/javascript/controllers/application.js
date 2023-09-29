// Import Bootstrap JavaScript
import "bootstrap/dist/js/bootstrap";

// Start and configure Stimulus
import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = true;
window.Stimulus = application;
export { application };
