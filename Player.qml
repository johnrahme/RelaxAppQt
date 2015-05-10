import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtMultimedia 5.0
import QtQuick.Controls.Styles 1.3

Item {
    property alias mediaPlayer: mediaPlayer

    MediaPlayer {
        id: mediaPlayer
        autoPlay: false
        readonly property string title: !!metaData.author && !!metaData.title
                                        ? qsTr("%1 - %2").arg(metaData.author).arg(metaData.title)
                                        : metaData.author || metaData.title || source
    }
    ColumnLayout {
        id: column
        anchors.margins: 9
        anchors.fill: parent

        Label {
            id: infoLabel

            elide: Qt.ElideLeft
            verticalAlignment: Qt.AlignVCenter
            text: mediaPlayer.errorString || mediaPlayer.source
            Layout.minimumHeight: infoLabel.implicitHeight
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        RowLayout {
            id: row

            Button {
                id: openButton

                text: qsTr("...")
                Layout.preferredWidth: openButton.implicitHeight
                onClicked: fileDialog.open()

                FileDialog {
                    id: fileDialog

                    folder : musicUrl
                    title: qsTr("Open file")
                    nameFilters: [qsTr("MP3 files (*.mp3)"), qsTr("All files (*.*)")]
                    onAccepted: mediaPlayer.source = fileDialog.fileUrl
                }
            }

            Button {
                id: playButton

                enabled: mediaPlayer.hasAudio
                Layout.preferredWidth: playButton.implicitHeight
                iconSource: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "qrc:/pause-16.png" : "qrc:/play-16.png"
                onClicked: mediaPlayer.playbackState === MediaPlayer.PlayingState ? mediaPlayer.pause() : mediaPlayer.play()
            }

            Slider {
                id: positionSlider

                Layout.fillWidth: true
                maximumValue: mediaPlayer.duration

                property bool sync: false

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

