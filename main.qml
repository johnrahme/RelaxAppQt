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

    color: "white"
    Image{
    anchors.fill: parent
    source: "Images/background.jpg"
    }
    property var currentVisible: start_V_
    property int diagonal: Math.sqrt(Math.pow(height, 2)+Math.pow(width, 2))

    Banner{
        id: banner
        anchors.top : parent.top
        width: parent.width
        height: diagonal*0.09
        m_a_.onClicked: menu_V_.toggleMenu()
        nav_T_.text: getNav()
        z:+1
    }

    Start {
        id:start_V_
        opacity: menu_V_.menu_shown ? 0.5:1
        anchors.top: banner.bottom
        width: parent.width
        height: parent.height-banner.height
        visible: true
        sitting_MA_.onClicked: {
            hideShow(player_V_)
            player_V_.info_L.text = "Sittande relaxövning"
            player_V_.mediaPlayer.source  = baseDir+"/Audio/ProgSittande.m4a"
            //delay(500, function(){player_V_.mediaPlayer.source  = baseDir+"/Audio/ProgSittande.m4a"})
        }
        lying_MA_.onClicked: {
            hideShow(player_V_)
            player_V_.info_L.text = "Liggande relaxövning"
            player_V_.mediaPlayer.source  = baseDir+"/Audio/ProgLiggande.m4a"
            //delay(500, function(){player_V_.mediaPlayer.source  = baseDir+"/Audio/ProgLiggande.m4a"})
        }
        transform: Translate {
            id: translate
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }
    }

    Player{
        id:player_V_
        opacity: menu_V_.menu_shown ? 0.5:1
        width: parent.width
        height: parent.height-banner.height
        anchors.top: banner.bottom
        mediaPlayer.source: baseDir+"/Audio/ProgLiggande.m4a"
        info_L.text: "Liggande relaxövning"
        visible: false
        playButton.enabled: mediaPlayer.hasAudio ? true:false

        }
    SlideMenu {
        id: menu_V_
        width: parent.width
        height: parent.height-banner.height
        anchors.top: banner.bottom
        start_B.onClicked: {hideShow(start_V_); toggleMenu();}
        media_B.onClicked: {hideShow(player_V_); toggleMenu();}
    }


    Timer {
        id: timer
    }


    //---Functions, should be in c++ Prop---

    function hideShow(qml){
        start_V_.visible = true;

        player_V_.visible = true;
        qml.visible = true;
        currentVisible.translate.x = the_App_.width;
        currentVisible = qml;
        qml.translate.x = 0;



    }

    // A function to delay time
    function delay(delayTime, cb) {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.triggered.connect(cb);
        timer.start();
    }

    function getNav(){
        if(menu_V_.menu_shown){
            return "Meny"
        }

        else
            return currentVisible.title
    }
}
