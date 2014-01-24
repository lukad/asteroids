TARGET=asteroids.love
SRC=$(wildcard *.lua)
ZIPFLAGS= -9
ASSETS=assets

all: $(TARGET)

$(TARGET): $(SRC) $(ASSETS)
	zip $@ $(ZIPFLAGS) -r $^
