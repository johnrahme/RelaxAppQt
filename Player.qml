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
            font.underline: true
            text: "The title!"
            font.pixelSize: parent.width*0.05
        }

        RowLayout {
            id: row
            Button {
                id: playButton
                text: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
                enabled: mediaPlayer.hasAudio
                //iconSource: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/pause-16.png" : "qrc:/play-16.png"
                onClicked: mediaPlayer.playbackState === MediaPlayer.PlayingState ? mediaPlayer.pause() : mediaPlayer.play()
            }
            Button {
                id: restartButton
                text: "Restart"
                enabled: mediaPlayer.hasAudio
                //iconSource: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/pause-16.png" : "qrc:/play-16.png"
                onClicked: mediaPlayer.seek(0);
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
                            color: "gray"
                            radius: 8
                        }
                        handle: Rectangle {
                            anchors.centerIn: parent
                            color: control.pressed ? "white" : "lightgray"
                            border.color: "gray"
                            border.width: 2
                            implicitWidth: 34
                            implicitHeight: 34
                            radius: 12

                        }
                    }
            }

            Label {
                id: positionLabel

                readonly property int minutes: Math.floor(mediaPlayer.position / 60000)
                readonly property int seconds: Math.round((mediaPlayer.position % 60000) / 1000)

                text: Qt.formatTime(new Date(0, 0, 0, 0, minutes, seconds), qsTr("mm:ss"))
            }
        }
    }
}

