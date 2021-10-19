update:
	git submodule update --init --recursive
	git submodule update --remote
#	git submodule foreach 'git pull --recurse-submodules origin `git rev-parse --abbrev-ref HEAD`'

install:
	git submodule add https://github.com/$(pkg) pack/mrw/start/$(pkg)
	git add .gitmodules pack/mrw/start/$(pkg)
	git commit -m `Installed $(pkg)`
