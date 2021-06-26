# Girino

Patched and repackaged Girino code from the [Girino Instructable](http://www.instructables.com/id/Girino-Fast-Arduino-Oscilloscope/) as a standalone C++ project.

## Build

The only prerequisite is the Arduino software installed somewhere and whose location needs to be set at the top of the Makefile (`ARDUINO_DIR`). I'm using an old 1.8.9 version, but it shouldn't matter since Girino doesn't rely on specific Arduino libraries.

``` Bash
make
```

## Upload

I'm using an Arduino board as an ISP, but any other programmer will work, simply adjust the corresponding variables accordingly (`arduino_dir`, `port`, `baudrate` and `programmer`).

``` Bash
./upload
```

The firmware is uploaded directly into the MCU (an ATmega328P by the way), without bootloader.
As such, it will reduces the initialization which could matter.
