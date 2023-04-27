# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "slim-select", to: "https://ga.jspm.io/npm:slim-select@2.4.5/dist/slimselect.es.js"
pin "leaflet", to: "https://ga.jspm.io/npm:leaflet@1.9.3/dist/leaflet-src.js"
