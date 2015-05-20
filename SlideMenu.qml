import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.3

Item {
    id: slide_I_
    property bool menu_shown: false
    property double slide_size: 0.3
    property alias start_B: start_B
    property alias media_B: media_B
    Rectangle {
        id: slide_menu_
        width: parent.width *slide_size; height: parent.height
        x: parent.width * -slide_size
        visible: true
        anchors.top: parent.top
        color: "grey"

        MouseArea {
            id: underlaying_MA_
            anchors.fill: parent
        }


        //opacity: parent.menu_shown ? 1 : 0
        //Behavior on opacity { NumberAnimation { duration: 300 } }

        transform: Translate {
            id: slide_translate_
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }
         //START OF CONTENT//
        Button {
            id: start_B
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.topMargin: parent.width/5
            anchors.top: parent.top
            width: parent.width*0.6
            height: parent.width*0.3
            text: "Övningar"
            visible: true
        }
        Button {
            anchors.topMargin: parent.width/5
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.top: start_B.bottom
            id: media_B
            width: parent.width*0.6
            height: parent.width*0.3
            text: "Nu spelas"
            visible: true
        }

        ListView {
            anchors.fill: parent
            model: MenuModel{}
            delegate: Text{
                text: name
            }
            visible: false
        }

        //END OF CONTENT//

    }

    MouseArea {
        width: parent.width * (1-slide_size); height: parent.height
        x: parent.width * slide_size
        anchors.top: parent.top
        enabled: slide_I_.menu_shown
        onClicked: slide_I_.toggleMenu();
    }

    //The menu Toggler

    function toggleMenu()
    {
        slide_translate_.x = slide_I_.menu_shown ? 0 : slide_I_.width * slide_size
        slide_I_.menu_shown = !slide_I_.menu_shown;
    }


}
