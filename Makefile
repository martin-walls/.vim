update:
	git submodule update --init --recursive
	git submodule update --remote
#	git submodule foreach 'git pull --recurse-submodules origin `git rev-parse --abbrev-ref HEAD`'

