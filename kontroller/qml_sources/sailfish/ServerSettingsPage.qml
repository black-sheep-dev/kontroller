import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.eu.tgcm 1.0

Dialog {
    property string serverUuid: ""
    property bool newServer: false
    KodiServiceDiscovery {
        id: serviceDiscovery
    }

    function selectingServer__()
    {
        return newServer && !__serverSelected
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: theCol.height
        DialogHeader
        {}
        Column {
            id:theCol
            spacing:10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top:parent.top

            PageHeader {
                title: qsTr("Server Settings")
            }

            BusyIndicator {
                running: newServer && serviceDiscovery.discovering && !__serverSelected
                size: BusyIndicatorSize.Large
                anchors.horizontalCenter: parent.horizontalCenter
                visible: running
            }
            Label {
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Discovering servers, please wait...");
                wrapMode: Text.Wrap
                visible: newServer && serviceDiscovery.discovering && !__serverSelected
            }
            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("The following servers have been discovered, click one to select it:")
                width:parent.width - 2*x
                visible: newServer && !__serverSelected && serviceDiscovery.servers.length >= 1
                wrapMode: Text.Wrap
                anchors.left: parent.left
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.right: parent.right
                anchors.rightMargin: Theme.horizontalPageMargin
            }

            Label {
                x: Theme.horizontalPageMargin
                text: qsTr("No server found, make sure an instance of kodi is running on the same network, and device wifi is enabled.")
                width:parent.width - 2*x
                wrapMode: Text.Wrap
                visible: newServer && !__serverSelected && !serviceDiscovery.discovering && serviceDiscovery.servers.length === 0
            }

            SilicaListView {
                visible: selectingServer__()
                width:parent.width
                height: serviceDiscovery.servers.length * Theme.itemSizeMedium
                model: serviceDiscovery.servers
                delegate: ListItem {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: Theme.itemSizeMedium
                    DetailItem {
                        label: model.modelData.hostname
                        value: model.modelData.address
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    onClicked: {
                        selectServer(model.modelData)
                    }
                }
            }
            // spacer
            Item {
                height: Theme.paddingLarge
                width: 1
                visible: selectingServer__()
            }

            Item {
                id: addServerGroup
                height: row.height
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                Label {
                    Icon {
                        source:"image://theme/icon-m-add"
                        id: theIcon
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    text: qsTr("Enter details manually")
                    leftPadding: theIcon.width
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                   // width: parent.width
                }
                MouseArea {
                    anchors.fill:parent
                    onClicked: __serverSelected = true
                }
                visible: selectingServer__()
            }

            TextField {
                id:serverName
                text: appSettings.server(serverUuid).name
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                label:qsTr("Server name");
                placeholderText: qsTr("Server name")
                visible: !selectingServer__()
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: serverAddress.focus = true
            }

            TextField {
                id: serverAddress
                text: appSettings.server(serverUuid).serverAddress
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhPreferNumbers
                label:qsTr("Server address");
                placeholderText: qsTr("Server address");
                visible: !selectingServer__()
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: serverLogin.focus = true
            }

            TextField {
                id: serverLogin
                text: appSettings.server(serverUuid).login
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                inputMethodHints: Qt.ImhNoAutoUppercase
                label:qsTr("Login");
                placeholderText: qsTr("Login");
                visible: !selectingServer__()
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: serverPassword.focus = true
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                text: qsTr("Password used to authenticate to kodi. Leave blank if no password is used. Note that it \
will be stored unencrypted on the device.")
                visible: !selectingServer__()
            }

            TextField {
                id: serverPassword
                text: appSettings.server(serverUuid).password
                anchors.left: parent.left;
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                inputMethodHints: Qt.ImhNoAutoUppercase
                label:qsTr("Password");
                placeholderText: qsTr("Password");
                visible: !selectingServer__()
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: serverPort.focus = true
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                text: qsTr("TCP port used to connect to the server. Unless you changed it in kodi, \
the default value should be fine. You need to enable remote access in kodi, otherwise notifications \
will not function properly.")
                visible: !selectingServer__()
            }

            TextField {
                id: serverPort
                text: appSettings.server(serverUuid).serverPort
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                validator: IntValidator { bottom: 1; top: 65535 }
                inputMethodHints: Qt.ImhDigitsOnly
                label:qsTr("Server port")
                placeholderText: qsTr("Server port")
                visible: !selectingServer__()
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: serverHttpPort.focus = true
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                text: qsTr("HTTP port used to connect to the server. Unless you changed it in kodi, \
the default value (8080) should be fine. \
You need to enable HTTP remote access in kodi for this to work.")
                visible: !selectingServer__()
            }
            TextField {
                id : serverHttpPort
                text: appSettings.server(serverUuid).serverHttpPort
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                validator: IntValidator{ bottom:1; top:65535}
                inputMethodHints: Qt.ImhDigitsOnly
                label:qsTr("Web port")
                placeholderText: qsTr("Web port")
                visible: !selectingServer__()
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: serverHttpPort.focus = false
            }
            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                text: qsTr("Select here the volume plugin to use. Default (Kodi) is to use kodi integrated \
volume. If using an amplifier to control the volume, select the corresponding plugin and configure it \
to make the remote control the amplifier volume.")
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                color: Theme.highlightColor
                wrapMode: Text.WordWrap
                visible: !selectingServer__()
            }
            ComboBox {
                id: serverVolumePlugin
                anchors.left: parent.left
                anchors.right: parent.right
                label: qsTr("Volume plugin")
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Kodi")
                    }
                    MenuItem {
                        text: qsTr("Minidsp")
                        onClicked: miniDSPAddress.focus = true
                    }
                }
                Component.onCompleted: {
                    if(appSettings.server(serverUuid).volumePluginName === "Minidsp")
                        currentIndex = 1;
                    else
                        currentIndex = 0;
                }
                visible: !selectingServer__()
            }
            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                text: qsTr("IP address of the minidsp device")
                visible: serverVolumePlugin.currentIndex === 1 && !selectingServer__()
            }
            TextField {
                id : miniDSPAddress
                text: appSettings.server(serverUuid) && appSettings.server(serverUuid).volumePluginName === "Minidsp"?
                    appSettings.server(serverUuid).volumePluginParameters.address:""
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhPreferNumbers
                label:qsTr("Minidsp ip address")
                placeholderText: qsTr("Minidsp ip address")
                visible: serverVolumePlugin.currentIndex === 1 && !selectingServer__()
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: miniDSPAddress.focus = false
            }

            ComboBox {
                id: serverWakeUpPlugin
                anchors.left: parent.left
                anchors.right: parent.right
                label: qsTr("WakeUp plugin")
                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("None")
                    }
                    MenuItem {
                        text: qsTr("WakeOnLan")
                        onClicked: wakeUpMacAddress.focus = true
                    }
                }
                Component.onCompleted: {
                    if(appSettings.server(serverUuid).wakeUpPluginName === "WolWakeUp")
                        currentIndex = 1;
                    else
                        currentIndex = 0;
                }
                visible: !selectingServer__()
                onCurrentItemChanged: {
                    if(currentIndex == 1)
                    {
                        refreshMacAddress()
                    }
                }
            }
            LinkedLabel {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                color: Theme.highlightColor
                plainText: qsTr("Wake On Lan generally requires configuration on the server. See https://github.com/Julien-Blanc-tgcm/kontroller/blob/master/README.md#WakeOnLan for help enabling it.")
                visible: serverWakeUpPlugin.currentIndex === 1 && !selectingServer__()
            }

            TextField {
                id : wakeUpMacAddress
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhPreferNumbers
                validator: RegExpValidator { regExp: /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/ }
                label:qsTr("Device mac address")
                placeholderText: qsTr("Device mac address")
                visible: serverWakeUpPlugin.currentIndex === 1 && !selectingServer__()
                Component.onCompleted: {
                    if(appSettings.server(serverUuid) && appSettings.server(serverUuid).wakeUpPluginName === "WolWakeUp")
                        text = appSettings.server(serverUuid).wakeUpPluginParameters.macAddress;
                    else
                        text = ""
                }
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: wakeUpMacPort.focus = true
            }
            TextField {
                id : wakeUpMacPort
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhPreferNumbers
                validator: IntValidator{ bottom:1; top:65535}
                label:qsTr("Wake up port")
                placeholderText: qsTr("Wake up port")
                visible: serverWakeUpPlugin.currentIndex === 1 && !selectingServer__()
                Component.onCompleted: {
                    if(appSettings.server(serverUuid) && appSettings.server(serverUuid).wakeUpPluginName === "WolWakeUp")
                        text = appSettings.server(serverUuid).wakeUpPluginParameters.port;
                    else
                        text = 9; // default value
                }
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: wakeUpMacPort.focus = false
            }


/*            TextSwitch {
                id: serverHasZones
                text:qsTr("Use multiples zones")
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                checked:settings.server(serverUuid).hasZones
                onCheckedChanged: {
                    settings.server(serverUuid).setHasZones(serverHasZones.checked);
                    pushOrPullZonePage();
                }
            }

            Label {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.horizontalPageMargin
                anchors.rightMargin: Theme.horizontalPageMargin
                color:Theme.highlightColor
                text:qsTr("Zones uses different audio output. Go to next page to learn for current zones.")
                wrapMode: Text.WordWrap
            } */
        }
    }

    onAccepted: {
        appSettings.server(serverUuid).setName(serverName.text)
        appSettings.server(serverUuid).setPassword(serverPassword.text);
        appSettings.server(serverUuid).setServerAddress(serverAddress.text);
        appSettings.server(serverUuid).setServerHttpPort(serverHttpPort.text);
        appSettings.server(serverUuid).setServerPort(serverPort.text);
        appSettings.server(serverUuid).setLogin(serverLogin.text);
        if(serverVolumePlugin.currentIndex === 0)
            appSettings.server(serverUuid).setVolumePluginName("Kodi");
        else
        {
            appSettings.server(serverUuid).setVolumePluginName("Minidsp");
            appSettings.server(serverUuid).setVolumePluginParameters({"address": miniDSPAddress.text});
        }
        if(serverWakeUpPlugin.currentIndex === 0)
            appSettings.server(serverUuid).setWakeUpPluginName("None");
        else
        {
            appSettings.server(serverUuid).setWakeUpPluginName("WolWakeUp");
            appSettings.server(serverUuid).setWakeUpPluginParameters({"macAddress": wakeUpMacAddress.text,
                                                                      "port": parseInt(wakeUpMacPort.text)})
        }

        appSettings.save();
        if(appClient.server.uuid === serverUuid)
        { // we are using this server, we need to refresh it
            appClient.refresh();
        }
    }

    onRejected: {
        if(newServer)
        {
            appSettings.deleteServer(serverUuid);
        }
    }

    Component.onCompleted: {
        if(newServer)
            serviceDiscovery.startDiscovery()
    }

    MacAddressFinder {
        id: macAddressFinder
    }

    function refreshMacAddress()
    {
        if(appSettings.server(serverUuid))
        {
            var mac = macAddressFinder.readMacAddress(appSettings.server(serverUuid).serverAddress);
            if(mac && mac.length > 0)
            {
                wakeUpMacAddress.text = mac;
            }
        }
    }

    function pushOrPullZonePage()
    {
        console.log("pushhere");
//        if(chkIgnoreWifi.checked)
//        {
//            console.log("pushAttached");
//            zones = pageStack.pushAttached(Qt.resolvedUrl("ManageZones.qml"));
//        }
//        else if(zones)
//            pageStack.popAttached(zones);
    }

    property bool __serverSelected: false

    function selectServer(item) {
        serverHttpPort.text = item.port
        serverAddress.text = item.address
        serverName.text = item.hostname
        __serverSelected = true;
    }
}
