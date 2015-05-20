import QtQuick 2.0

Rectangle {
    color:"black"
    property alias m_a_: m_a_
    property alias nav_T_:nav_T_

    Text {
        id: nav_T_
        anchors.centerIn: parent
        text: "Navigation"
        color: "white"
    }

    Rectangle {
        id: slide_button_
        width: parent.width*0.20; height: parent.height*0.7
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.width*0.05
        MouseArea {
            id: m_a_
            anchors.fill: parent
        }
        Image {
            anchors.fill: parent
            source: "/Images/menu_icon.png"
        }
    }
}

