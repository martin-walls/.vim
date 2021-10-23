init:
	git submodule update --init --recursive

update:
	# git submodule update --remote
	git submodule foreach 'git pull --recurse-submodules origin `git rev-parse --abbrev-ref HEAD`'

