build_frontend:
	@npm run build --prefix bonne_app_frontend
	cp -a bonne_app_frontend/build/. bonne_app_api/public