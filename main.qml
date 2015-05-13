import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.3

ApplicationWindow {
    id: the_App_
    title: qsTr("Hello World")
    width: Screen.width
    height: Screen.height
    visible: true

    Start {
        id:start_V_
        anchors.fill: parent
    }

    Player{
        id:player_V_
        anchors.fill: parent
        mediaPlayer.source: baseDir+"/Audio/ScottyPirate.mp3"
        info_L.text: "Scotty!"
        playButton.enabled: menu_V_.menu_shown && mediaPlayer.hasAudio ? false:true
        positionSlider.enabled: menu_V_.menu_shown && mediaPlayer.hasAudio ? false:true
        }

    SlideMenu {
        id: menu_V_
        anchors.fill: parent
    }

}
