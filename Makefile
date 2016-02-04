all:
	swift build -Xcc -fblocks -Xlinker -lBlocksRuntime -Xlinker -ldispatch

clean:
	rm -rf Packages


