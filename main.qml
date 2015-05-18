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
        visible: true
        sitting_MA_.onClicked: {
            hideShow(player_V_)
            player_V_.info_L.text = "Sittande relaxövning"
            player_V_.mediaPlayer.source  = baseDir+"/Audio/ProgSittande.m4a"
        }
        lying_MA_.onClicked: {
            hideShow(player_V_)
            player_V_.info_L.text = "Liggande relaxövning"
            player_V_.mediaPlayer.source  = baseDir+"/Audio/ProgLiggande.m4a"
        }
    }

    Player{
        id:player_V_
        anchors.fill: parent
        mediaPlayer.source: baseDir+"/Audio/ProgLiggande.m4a"
        info_L.text: "Liggande relaxövning"
        visible: false
        playButton.enabled: mediaPlayer.hasAudio ? true:false
        }
    SlideMenu {
        id: menu_V_
        anchors.fill: parent
        start_B.onClicked: {hideShow(start_V_); toggleMenu();}
        media_B.onClicked: {hideShow(player_V_); toggleMenu();}
    }

    //---Functions, should be in c++ Prop---

    function hideShow(qml){
        start_V_.visible = false;
        player_V_.visible = false;
        qml.visible = true;
    }

}
