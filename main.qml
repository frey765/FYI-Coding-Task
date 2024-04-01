import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1040
    height: 680
    title: "AnalogClocks"

    // Interactive Analog Clock
    Item {
        id: interactiveClock
        width: 500
        height: parent.height

        anchors.left: parent.left

        property int minutes: 37
        property int hours: 3

        Rectangle {
            width: 100
            height: 100

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: interactiveClockTitle
                font.pixelSize: 30
                font.family: "Comic Sans MS"
                color: "black"
                text: "Interactive Analog Clock"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                font.pixelSize: 30
                font.family: "Comic Sans MS"
                color: "black"
                text: interactiveClock.hours + ":" + interactiveClock.minutes
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: interactiveClockTitle.bottom
            }
        }

        Rectangle {
            id: interactiveClockFace
            width: 400
            height: 400
            anchors.centerIn: parent
            border.color: "green"
            border.width: 2
            radius: width / 2
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: 12
                Item {
                    required property int index

                    height: interactiveClockFace.height
                    rotation: index * 30
                    x: interactiveClockFace.width / 2
                    y: 0

                    Rectangle {
                        height: 15
                        width: 4
                        color: "black"
                        radius: 2
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 4
                        }
                    }

                    Text {
                        x: 0
                        y: interactiveClockFace.height * 0.06
                        rotation: 360 - index * 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: index == 0 ? 12 : index
                        font.pixelSize: 20
                        font.family: "Comic Sans MS"
                    }
                }
            }

            Rectangle {
                anchors.centerIn: parent
                height: 12
                width: 12
                radius: width / 2
                color: "black"
                z: 1
            }

            Rectangle {
                id: interactiveClockMinuteHand

                width: 3
                height: 300
                radius: 2

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "green" }
                    GradientStop { position: 0.6; color: "transparent" }
                }

                MouseArea {
                    anchors.fill: parent
                    drag.target: parent

                    onPositionChanged: {
                        var angle = (Math.atan2(mouseX, mouseY) * 180 / Math.PI);   // get the angle in degrees
                        if (angle < 0) angle += 360;
                        interactiveClock.minutes = Math.round(angle * 60 / 360) % 60;           // get the minutes value
                    }
                }

                rotation: 360 / 60 * (interactiveClock.minutes % 60)    // the rotation angle between each minute mark on the clock face
                antialiasing: true
                anchors.centerIn: interactiveClockFace
            }

            Rectangle {
                id: interactiveClockHourHand

                width: 4
                height: 250
                radius: 2

                gradient: Gradient {
                    GradientStop { position: 0.0; color: "black" }
                    GradientStop { position: 0.6; color: "transparent" }
                }

                MouseArea {
                    anchors.fill: parent
                    drag.target: parent

                    onPositionChanged: {
                        var angle = (Math.atan2(mouseX, mouseY) * 180 / Math.PI);      // get the angle in degrees
                        if (angle < 0) angle += 360;
                        interactiveClock.hours = Math.round(angle * 12 / 360) % 12;                // get the minutes value
                    }
                }

                rotation: (360 / 12 * (interactiveClock.hours % 12)) + (360 / 12 * (interactiveClock.minutes / 60))    // the rotation angle of the hour hand taking into consideration the minutes that have passed
                antialiasing: true
                anchors.centerIn: interactiveClockFace
            }
        }
    }

    // Live Clock
    Item {
        id: liveClock
        width: 500
        height: parent.height

        anchors.right: parent.right

        property int seconds: 0
        property int minutes: 0
        property int hours: 0

        function updateTime() {
            seconds = new Date().getSeconds()
            minutes = new Date().getMinutes()
            hours = new Date().getHours()
        }

        Timer {
            id: timer
            repeat: true
            interval: 1000
            running: true
            triggeredOnStart: true

            onTriggered: liveClock.updateTime()
        }

        Rectangle {
            width: 100
            height: 100

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: liveClockTitle
                font.pixelSize: 30
                font.family: "Comic Sans MS"
                color: "black"
                text: "Live Analog Clock"
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                font.pixelSize: 30
                font.family: "Comic Sans MS"
                color: "black"
                text: liveClock.hours + ":" + liveClock.minutes + ":" + liveClock.seconds
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: liveClockTitle.bottom
            }
        }

        Rectangle {
            id: liveClockFace
            width: 400
            height: 400
            anchors.centerIn: parent
            border.color: "blue"
            border.width: 2
            radius: width / 2
            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: 12

                Item {
                    required property int index

                    height: liveClockFace.height
                    // transformOrigin: Item.bottom
                    rotation: index * 30
                    x: liveClockFace.width / 2
                    y: 0

                    Rectangle {
                        height: 15
                        width: 4
                        color: "black"
                        radius: 2
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 4
                        }
                    }

                    Text {
                        x: 0
                        y: liveClockFace.height * 0.06
                        rotation: 360 - index * 30
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: index == 0 ? 12 : index
                        font.pixelSize: 20
                        font.family: "Comic Sans MS"
                    }
                }
            }

            Rectangle {
                anchors.centerIn: parent
                height: 12
                width: 12
                radius: width / 2
                color: "black"
                z: 1
            }

            Item {
                id: liveClockSecondHand

                Rectangle {
                    width: 1
                    height: 170
                    color: "red"
                    radius: 2
                    anchors {
                        horizontalCenter: liveClockSecondHand.horizontalCenter
                        bottom: liveClockSecondHand.verticalCenter
                    }
                    antialiasing: true
                }

                rotation: 360 / 60 * (liveClock.seconds % 60)      // the rotation angle between each second mark on the clock face
                antialiasing: true
                anchors.centerIn: liveClockFace
            }

            Item {
                id: liveClockMinuteHand

                Rectangle {
                    width: 3
                    height: 150
                    color: "blue"
                    radius: 2
                    anchors {
                        horizontalCenter: liveClockMinuteHand.horizontalCenter
                        bottom: liveClockMinuteHand.verticalCenter
                    }
                    antialiasing: true
                }

                rotation: 360 / 60 * (liveClock.minutes % 60)    // the rotation angle between each minute mark on the clock face
                antialiasing: true
                anchors.centerIn: liveClockFace
            }

            Item {
                id: liveClockHourHand

                Rectangle {
                    width: 4
                    height: 125
                    color: "black"
                    radius: 2
                    anchors {
                        horizontalCenter: liveClockHourHand.horizontalCenter
                        bottom: liveClockHourHand.verticalCenter
                    }
                    antialiasing: true
                }

                rotation: (360 / 12 * (liveClock.hours % 12)) + (360 / 12 * (liveClock.minutes / 60))  // the rotation angle of the hour hand taking into consideration the minutes that have passed
                antialiasing: true
                anchors.centerIn: liveClockFace
            }
        }
    }
}
