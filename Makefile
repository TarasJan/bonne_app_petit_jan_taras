# Move frontend build to backend
build_frontend:
	@npm run build --prefix bonne_app_frontend
	cp -a bonne_app_frontend/build/. bonne_app_api/public

# Deploy to fly.io
deploy: 
	cd bonne_app_api && fly launch

# Run Selenium automation
automation: 
	cd bonne_app_automation && bundle exec rspec