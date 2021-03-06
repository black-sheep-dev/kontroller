TEMPLATE = app

CONFIG += sailfish
QT += qml quick core network
CONFIG(sailfish) {
  CONFIG += sailfishapp
  CONFIG += sailfishapp_i18n
  message(sailfish)
} else {
  QT += widgets
}

PKGCONFIG += sailfishsilica

CONFIG+=c++1z # c++17 not supported by current qmake

SOURCES += main.cpp \
    ../lib/arp/macaddressfinder.cpp \
    downloadlocation.cpp \
    kodiservicediscovery.cpp \
    libraryservice.cpp \
    musicservice.cpp \
    sbiconimageprovider.cpp \
    statusservice.cpp \
    playlistservice.cpp \
    systemservice.cpp \
    videoservice.cpp \
    deviceinformation.cpp \
    artistinformationservice.cpp \
    albumsrequest.cpp \
    songsrequest.cpp \
    albuminformationservice.cpp \
    musiccontrol.cpp \
    videocontrol.cpp \
    movieinformationservice.cpp \
    tvshowinformationservice.cpp \
    tvshowseasonsrequest.cpp \
    seasoninformationservice.cpp \
    tvshowepisodesrequest.cpp \
    utils.cpp \
    episodeinformationservice.cpp \
#    playlistcontrol.cpp \
    playlistitem.cpp \
    subtitle.cpp \
    client.cpp \
    playinginformation.cpp \
    file.cpp \
    player.cpp \
    playerservice.cpp \
    applicationsettings.cpp \
    remote.cpp \
    audiostream.cpp \
    server.cpp \
    themeinformation.cpp \
    downloadservice.cpp \
    volumeplugin.cpp \
    kodivolumeplugin.cpp \
    minidspvolumeplugin.cpp \
    ../lib/minidsplib/query.cpp \
    ../lib/minidsplib/reply.cpp \
    ../lib/mdns/sbzeroconfservicediscovery.cpp \
    ../lib/mdns/sbzeroconfservicerecord.cpp \
    ../lib/mdns/dnspacket.cpp \
    wakeupplugin.cpp \
    wolwakeupplugin.cpp


CONFIG(sailfish) {
    RESOURCES += qml_sources/sailfish/qml.qrc
#    OTHER_FILES += qml/sailfish/kontroller.qml \
#        qml/sailfish/cover/CoverPage.qml \
#        qml/sailfish/KontrollerMain.qml \
#        qml/sailfish/AlbumInformationPage.qml

} else {
#    RESOURCES += qml_sources/generic/qml.qrc
    message("Adding generic components to resources")
}

INCLUDEPATH += ../qjsonrpc/src \
    ../lib

QMAKE_CXXFLAGS = -Wall -Werror

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)


equals(ANDROID_TARGET_ARCH, armeabi-v7a) {
  LIBS += -L../qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_2_1-Release/src
  LIBS += -L../qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_5_1-Release/src
} else {
  CONFIG(sailfishapp) {
    LIBS += -L../qjsonrpc/src

#    LIBS += -L/home/whity/dev/build/qjsonrpc-MerSDK_SailfishOS_armv7hl-Release/src
  } else {
  LIBS += -L../qjsonrpc-Desktop_Qt_5_2_1_GCC_64bit-Debug/src
  LIBS += -L../qjsonrpc/src
  }
}

CONFIG(sailfishapp) {
  DEFINES+= SAILFISH_TARGET
  TARGET = harbour-kontroller
}

TRANSLATIONS += \
        translations/harbour-kontroller-en.ts \
        translations/harbour-kontroller-fr.ts \
        translations/harbour-kontroller-ru.ts \
        translations/harbour-kontroller-sv.ts \
        translations/harbour-kontroller-de.ts

TRANSLATION_SOURCES += $$PWD/*.cpp \
    $$PWD/qml_sources/sailfish/*.qml

#LIBS += -L../build-qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_2_1-Debug/src
LIBS += -lqjsonrpc

HEADERS += \
    ../lib/arp/macaddressfinder.h \
    downloadlocation.h \
    kodiservicediscovery.h \
    libraryservice.h \
    musicservice.h \
    sbiconimageprovider.h \
    statusservice.h \
    playlistservice.h \
    systemservice.h \
    videoservice.h \
    deviceinformation.h \
    artistinformationservice.h \
    utils.h \
    albumsrequest.h \
    songsrequest.h \
    albuminformationservice.h \
    musiccontrol.h \
    videocontrol.h \
    movieinformationservice.h \
    tvshowinformationservice.h \
    tvshowseasonsrequest.h \
    seasoninformationservice.h \
    tvshowepisodesrequest.h \
    episodeinformationservice.h \
#    playlistcontrol.h \
    playlistitem.h \
    subtitle.h \
    client.h \
    playinginformation.h \
    file.h \
    player.h \
    playerservice.h \
    applicationsettings.h \
    remote.h \
    audiostream.h \
    server.h \
    themeinformation.h \
    downloadservice.h \
    volumeplugin.h \
    kodivolumeplugin.h \
    minidspvolumeplugin.h \
    ../lib/mdns/sbzeroconfservicediscovery.h \
    ../lib/mdns/sbzeroconfservicerecord.h \
    ../lib/mdns/dnspacket.h \
    wakeupplugin.h \
    wolwakeupplugin.h

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    OTHER_FILES += \
        android/AndroidManifest.xml
}

CONFIG(sailfishapp) {
  OTHER_FILES +=
        translations/*.ts \

}

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
#    ANDROID_EXTRA_LIBS = ../qjsonrpc-Android_pour_armeabi_v7a_GCC_4_8_Qt_5_5_1-Release/src/libqjsonrpc.so
    ANDROID_EXTRA_LIBS = ../qjsonrpc-android/src/libqjsonrpc.so
}

CONFIG(sailfishapp) {
DISTFILES += kontroller.prf \
    harbour-kontroller.desktop


qml_sources.files = qml_sources/sailfish
qml_sources.path = /usr/share/$${TARGET}/qml

disticons.files = icons/sailfish/*
disticons.path = /usr/share/$${TARGET}/assets

#OTHER_FILES += icons/sailfish/*
SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

INSTALLS += qml_sources disticons

#lib.path = /usr/share/harbour-kontroller/lib/
#lib.files += ../qjsonrpc/src/libqjsonrpc.so.1

#INSTALLS += lib
}
