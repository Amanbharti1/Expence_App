import { Application } from "@hotwired/stimulus"
import "highcharts"
import "require chartkick"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
