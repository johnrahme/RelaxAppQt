import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.0

ApplicationWindow {
    title: qsTr("Hello World")
    width: Screen.width
    height: Screen.height
    visible: true

    Player{
        id:player
        anchors.fill: parent
        mediaPlayer.source: "Audio/ScottyPirate.mp3"
        }
}
