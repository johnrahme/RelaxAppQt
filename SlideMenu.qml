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
    Rectangle {
        id: slide_menu_
        width: parent.width *slide_size; height: parent.height
        x: parent.width * -slide_size
        visible: true
        anchors.top: parent.top
        color: "grey"



        //opacity: parent.menu_shown ? 1 : 0
        //Behavior on opacity { NumberAnimation { duration: 300 } }

        transform: Translate {
            id: slide_translate_
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }

        Button {
            text: "test"
        }

        Text {
            id: slide_T_
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -parent.width * 0.1
            //text: "Slide Menu Rules"
            font.pixelSize: 20
        }
    }

    MouseArea {
        width: parent.width * (1-slide_size); height: parent.height
        x: parent.width * slide_size
        anchors.top: parent.top
        enabled: slide_I_.menu_shown
        onClicked: slide_I_.toggleMenu();
    }

    //The menu Toggler
    Rectangle {
        id: slide_button_
        width: parent.width*0.16; height: parent.width*0.08
        anchors.top: parent.top
        anchors.left: parent.left
        scale: m_a_.pressed ? 0.95 : 1
        MouseArea {
            id: m_a_
            anchors.fill: parent
            onClicked: slide_I_.toggleMenu()
        }
        Image {
            anchors.fill: parent
            source: "/Images/menu_icon.png"
        }

        transform: Translate {
            id: slide_button_translate_
            x: 0
            Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
        }
    }

    function toggleMenu()
    {
        slide_translate_.x = slide_I_.menu_shown ? 0 : slide_I_.width * slide_size
        slide_button_translate_.x = slide_I_.menu_shown ? 0 : slide_I_.width * slide_size
        slide_I_.menu_shown = !slide_I_.menu_shown;
    }

}
