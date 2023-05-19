import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    property bool highlighted: false

    property string pin:  {
        return (pinDigit1.displayText + pinDigit2.displayText
                + pinDigit3.displayText + pinDigit4.displayText)
    }

    onHighlightedChanged: {
        if(highlighted)
            highlightTimer.start()
    }

    onVisibleChanged: {
        if (visible) {
            pinDigit1.focus = true
            //initialize all fields
            pinDigit1.text = ""
            pinDigit2.text = ""
            pinDigit3.text = ""
            pinDigit4.text = ""
        }
    }

    signal accepted()

    width: 240
    height: 40

    Timer {
        id: highlightTimer

        interval: 1500
        repeat: false
        onTriggered: highlighted = false
    }

    Row {
        spacing: Constants.spacing*3
        anchors.centerIn: parent

        PinInputField {
            id: pinDigit1

            highlighted: root.highlighted

            onTextChanged: {
                if(pinDigit1.text.length != 0) {
                    pinDigit2.focus = true
                }
            }

            Keys.onPressed: {
                if(event.key === Qt.Key_Backspace) {
                    pinDigit1.text = ""
                }
                else {
                    if (pinDigit1.text.length != 0) {
                        pinDigit2.focus = true
                        pinDigit2.text = event.text
                    }
                }
            }
        }

        PinInputField {
            id: pinDigit2

            highlighted: root.highlighted

            onTextChanged: {
                if(pinDigit2.text.length != 0) {
                    pinDigit3.focus = true
                }
            }

            Keys.onPressed: {
                if(event.key === Qt.Key_Backspace) {
                    pinDigit1.focus = true
                    if (pinDigit2.text.length === 0) {
                        pinDigit1.text = ""
                    }
                    else {
                        pinDigit2.text = ""
                    }
                }
                else {
                    if (pinDigit2.text.length != 0) {
                        pinDigit3.focus = true
                        pinDigit3.text = event.text
                    }
                }
            }
        }

        PinInputField {
            id: pinDigit3

            highlighted: root.highlighted

            onTextChanged: {
                if(pinDigit3.text.length != 0) {
                    pinDigit4.focus = true
                }
            }

            Keys.onPressed: {
                if(event.key === Qt.Key_Backspace) {
                    pinDigit2.focus = true
                    if (pinDigit3.text.length === 0) {
                        pinDigit2.text = ""
                    }
                    else {
                        pinDigit3.text = ""
                    }
                }
                else {
                    if (pinDigit3.text.length != 0) {
                        pinDigit4.focus = true
                        pinDigit4.text = event.text
                    }
                }
            }
        }

        PinInputField {
            id: pinDigit4

            highlighted: root.highlighted

            Keys.onPressed: {
                if(event.key === Qt.Key_Backspace) {
                    pinDigit3.focus = true
                    if (pinDigit4.text.length === 0) {
                        pinDigit3.text = ""
                    }
                    else {
                        pinDigit4.text = ""
                    }
                }
            }

            onAccepted: {
                accepted()
            }
        }
    }
}
