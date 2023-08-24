Rails.application.config.middleware.insert_before 0, Rack::Cors do
    # Repeat this block for all environments (prod, staging, etc.)
    allow do
        origins "http://localhost:3001"
        resource "*", headers: :any, methods: [:get, :put, :post, :patch, :delete, :options, :head],
        credentials: true
    end
end
