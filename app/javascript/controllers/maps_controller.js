import { Controller } from "@hotwired/stimulus"
import L from "leaflet"


// Connects to data-controller="maps"
export default class extends Controller {
  static targets = ["container"]

  connect() {
    this.createMap()
    this.getTasks().then(tasks => {
      if (tasks.length > 0) {
        const points = tasks.map(task => [task.latitude, task.longitude]);
        this.map.fitBounds(points);
        tasks.forEach(task => this.addMarker(task))
      } else {
        this.map.setView([37.7749, -122.4194], 12);
      }
    });
  }

  createMap() {
    this.map = L.map(this.containerTarget)

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(this.map);
  }

  addMarker(task) {
    const { name, latitude, longitude } = task;
    L.marker([latitude, longitude])
      .addTo(this.map)
      .bindPopup(`<div>${name}</div>`);
  }
  

  async getTasks() {
    try {
      const response = await fetch('/tasks_map', {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        }
      });
      const tasks = await response.json();
      return tasks;
    } catch (error) {
      return [];
    }
  }

  disconnect() {
    this.map.remove();
  }
}
