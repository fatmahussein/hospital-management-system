import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "hidden"];
  timeout = null;

  search() {
    clearTimeout(this.timeout);

    const query = this.inputTarget.value.trim();
    if (query.length < 2) {
      this.resultsTarget.innerHTML = "";
      return;
    }

    this.timeout = setTimeout(() => {
      fetch(`/patients/search.json?query=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
          console.log("Received patients:", data);

          this.resultsTarget.innerHTML = "";

          data.forEach(patient => {
            const li = document.createElement("li");
            li.textContent = patient.name;
            li.dataset.id = patient.id;
            li.className = "cursor-pointer hover:bg-gray-100 px-4 py-2";
            li.addEventListener("click", () => this.select(patient));
            this.resultsTarget.appendChild(li);
          });
        });
    }, 300); // debounce
  }

  select(patient) {
    this.inputTarget.value = patient.name;
    this.hiddenTarget.value = patient.id;
    this.resultsTarget.innerHTML = "";
  }
}
