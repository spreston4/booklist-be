# Update domain value
if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, key: "_booklist", domain: "localhost"
else
    Rails.application.config.session_store :cookie_store, key: "_booklist"
end