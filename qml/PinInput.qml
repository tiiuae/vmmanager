import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: root

    width: 240
    height: 40

    property string pin:  {
        return (pinDigit1.displayText + pinDigit2.displayText
                + pinDigit3.displayText + pinDigit4.displayText)
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

    Row {
        spacing: Constants.spacing*3
        anchors.centerIn: parent

        PinInputField {
            id: pinDigit1

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
