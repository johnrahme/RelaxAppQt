import QtQuick 2.0

Rectangle {

    property alias sitting_MA_: sitting_MA_
    property alias lying_MA_: lying_MA_
    property alias translate: translate
    property string title: "Start"

    transform: Translate {
        id: translate
        x: 0
        Behavior on x { NumberAnimation { duration: 400; easing.type: Easing.OutQuad } }
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Välj din övning!"
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.05
        font.pixelSize: sitting_R_.width*0.2
        font.underline: true
    }

    Row {
        id: exRow
        anchors.centerIn: parent
        width: parent.width*0.8
        height: width*0.3
        //anchors.verticalCenter: parent.verticalCenter
        spacing: width*0.4
        Rectangle{
            id: sitting_R_
            width: parent.width*0.30
            height: parent.width*0.30
            Text{
                anchors.horizontalCenter: sitting_R_.horizontalCenter
                anchors.bottom: sitting_R_.top
                text:  "Sittande relaxövning"
                font.pixelSize: parent.width*0.15
            }

            Image{
                anchors.fill: parent
                width: parent.width*0.9
                height: parent.height*0.9
                anchors.centerIn: parent
                source: "Images/relaxSitting.png"

            }
            MouseArea{
                id: sitting_MA_
                anchors.fill: parent
            }
        }
        Rectangle{
            id: lying_R_
            width: parent.width*0.30
            height: parent.width*0.30
            Text{
                anchors.horizontalCenter: lying_R_.horizontalCenter
                anchors.bottom: lying_R_.top
                text:  "Liggande relaxövning"
                font.pixelSize: parent.width*0.15
            }

            Image{
                anchors.fill: parent
                width: parent.width*0.9
                height: parent.height*0.9
                anchors.centerIn: parent
                source: "Images/relaxLying.png"

            }
            MouseArea{
                id: lying_MA_
                anchors.fill: parent
            }
        }
    }
}

