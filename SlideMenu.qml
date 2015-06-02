import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.3
import QtGraphicalEffects 1.0

Item {
    id: slide_I_
    property bool menu_shown: false
    property double slide_size: 0.5
    property alias start_B: start_B
    property alias media_B: media_B
    property int number_of_menu_buttons:2
    property int button_height: (0.5/number_of_menu_buttons)*height
    property int button_padding: (0.5/(number_of_menu_buttons+1))*height
    property int button_width: width * 0.5*0.5
    property int button_text_size: button_width/5

    Rectangle {
        id: slide_menu_
        width: parent.width *slide_size; height: parent.height
        x: parent.width * -slide_size
        visible: true
        anchors.top: parent.top
        color: "grey"
        RectangularGlow{
            opacity: menu_shown ? 1:0
            anchors.fill: parent
            glowRadius: 30
            color: "black"
            cornerRadius: 0
            z: -1
            Behavior on opacity {NumberAnimation {duration: 300}}
        }

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
            anchors.topMargin: button_padding
            anchors.top: parent.top
            width: button_width
            height: button_height
            Text{
                anchors.centerIn: parent
                text: "Övningar"
                font.pixelSize: button_text_size
            }
            visible: true
        }
        Button {
            id: media_B
            anchors.topMargin: button_padding
            anchors.horizontalCenter:parent.horizontalCenter
            anchors.top: start_B.bottom
            width: button_width
            height: button_height
            Text{
                anchors.centerIn: parent
                text: "Nu spelas"
                font.pixelSize: button_text_size
            }
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
