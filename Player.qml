import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.0
import QtQuick.Controls.Styles 1.3

Rectangle {
    property alias mediaPlayer: mediaPlayer
    property alias info_L: info_L
    property alias positionSlider: positionSlider
    property alias playButton: playButton
    property alias translate: translate
    property string title: "Spelare"

    Image{
        anchors.fill: parent
        source: "Images/background.jpg"
    }

    transform: Translate {
        id: translate
        x: parent.width
        Behavior on x { NumberAnimation { duration: 700; easing.type: Easing.OutQuad } }
    }


    MediaPlayer {
        id: mediaPlayer
        autoPlay: false
        source: "/Audio/ScottyPirate.mp3"
    }
    ColumnLayout {
        id: column
        anchors.bottomMargin: parent.height*0.1
        anchors.margins: 9
        anchors.fill: parent

        Text {
            id: info_L
            anchors.centerIn: parent
            text: "The title!"
            font.pixelSize: parent.width*0.05
        }

        RowLayout {
            id: row
            anchors.top: info_L.bottom
            anchors.topMargin: parent.height*0.1

            Label {
                id: positionLabel

                readonly property int minutes: Math.floor(mediaPlayer.position / 60000)
                readonly property int seconds: Math.round((mediaPlayer.position % 60000) / 1000)

                text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
            }

            Slider {
                id: positionSlider

                Layout.fillWidth: true
                maximumValue: mediaPlayer.duration

                property bool sync: false
                updateValueWhileDragging: true


                onValueChanged: {
                    if (!sync)
                        mediaPlayer.seek(value)
                }

                Connections {
                    target: mediaPlayer
                    onPositionChanged: {
                        positionSlider.sync = true
                        positionSlider.value = mediaPlayer.position
                        positionSlider.sync = false
                    }
                }
                style: SliderStyle {
                    groove: Rectangle {
                        implicitWidth: 200
                        implicitHeight: 8
                        color: "black"
                        border.color: "grey"
                        border.width: 2
                        radius: 8
                    }
                    handle: Rectangle {
                        anchors.centerIn: parent
                        color: control.pressed ? "white" : "blue"
                        border.color: "#092CAA"
                        border.width: 2
                        implicitWidth: 34
                        implicitHeight: 34
                        radius: 20

                    }
                }
            }


            Label {
                id: positionLabel2

                readonly property int minutes: Math.floor(mediaPlayer.duration / 60000)
                readonly property int seconds: Math.round((mediaPlayer.duration % 60000) / 1000)

                text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
            }
        }

        Rectangle {
            id: playButton
            anchors.top: row.bottom
            anchors.margins: width/2
            width: parent.width*0.1
            height: width
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
            //text: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
            Image {
                anchors.fill: parent
                source: mediaPlayer.playbackState == MediaPlayer.PlayingState ? "Images/player_pause.png" : "Images/player_play.png"
            }
            enabled: mediaPlayer.hasAudio
            //iconSource: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/pause-16.png" : "qrc:/play-16.png"
            MouseArea{
                anchors.fill: parent
                onClicked: mediaPlayer.playbackState === MediaPlayer.PlayingState ? mediaPlayer.pause() : mediaPlayer.play()
            }

       }
        Rectangle {
            id: restartButton
            anchors.top: row.bottom
            anchors.left: playButton.right
            anchors.margins: width/2

            width: parent.width*0.1
            height: width
            Image {
                anchors.fill: parent
                source: "Images/player_restart.png"
            }
            enabled: mediaPlayer.hasAudio
            //iconSource: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/pause-16.png" : "qrc:/play-16.png"
            MouseArea{
                anchors.fill: parent
                onClicked: mediaPlayer.seek(0);
            }

        }
    }
}

