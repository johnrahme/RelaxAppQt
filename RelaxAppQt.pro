TEMPLATE = app

QT += qml quick widgets multimedia

SOURCES += main.cpp

QTPLUGIN''= qtaudio_coreaudio
QTPLUGIN ''= qtmedia_audioengine
QTPLUGIN''= qavfcamera
QTPLUGIN += qavfmediaplayer

DATA_FILES = $$PWD/Audio/ScottyPirate.mp3

RESOURCES += qml.qrc \
    pirate.qrc \
    images.qrc \
    audioliggande.qrc \
    audiosittande.qrc

OTHER_FILES = \
            Audio/ScottyPirate.mp3

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    Audio/ScottyPirate.mp3 \
    Audio/ProgLiggande.m4a

ios {
message(For iOS!!)
data.files = Audio
QMAKE_BUNDLE_DATA += data
}
