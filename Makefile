TARGET=asteroids
SRC=$(wildcard *.lua)
ZIPFLAGS= -9
ASSETS=assets
VERSION=0.9.0
WINURL32=https://bitbucket.org/rude/love/downloads/love-$(VERSION)-win32.zip
WINURL64=https://bitbucket.org/rude/love/downloads/love-$(VERSION)-win64.zip

all: $(TARGET).love win

$(TARGET): $(TARGET.love)

$(TARGET).love: $(SRC) $(ASSETS)
	zip $@ $(ZIPFLAGS) -r $^

love-$(VERSION)-win32.zip:
	wget $(WINURL32)

love-$(VERSION)-win64.zip:
	wget $(WINURL64)

$(TARGET)-win32: love-$(VERSION)-win32.zip $(TARGET).love
	rm -rf $@
	rm -rf love-$(VERSION)-win32
	unzip $<
	mv love-$(VERSION)-win32 $@
	cat $(TARGET).love >> $@/love.exe
	zip $@.zip -r $@

$(TARGET)-win64: love-$(VERSION)-win64.zip $(TARGET).love
	rm -rf $@
	rm -rf love-$(VERSION)-win64
	unzip $<
	mv love-$(VERSION)-win64 $@
	cat $(TARGET).love >> $@/love.exe
	zip $@.zip -r $@

win: $(TARGET)-win32 $(TARGET)-win64

clean:
	rm -rf love-*
	rm -f *.love
	rm -f *.zip
	rm -rf $(TARGET)-win*
