OKML = ocamlbuild
OKFLAGS = -I src
TARGET = main.native

$(TARGET):
	$(OKML) $(OKFLAGS) $(TARGET)
	mkdir -p bin
	mv main.native ./bin

run: $(TARGET)
	$(TARGET)
#	ocamlbuild -I src main.native

clean:
	rm -rf ./_build
	rm -rf ./bin/main.native