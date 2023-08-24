# Update domain value
Rails.application.config.session_store :cookie_store, key: "_booklist", domain: "localhost"