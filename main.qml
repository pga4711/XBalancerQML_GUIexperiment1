import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true

    width: 640
    height: 480

    title: qsTr("Stack")

    /*
    header: Button {
        width: 70
        height: 70

        anchors.left: parent.left
        anchors.top: parent.top
        text: "HELLO1234"
        onClicked: { console.log("This is text"); }
    }
    */

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        //Alltså den här. Om man är på stackView.depth = 1. Då visas meny-ikonen. Sen så poppas inte stackview om det är =1, utan då öppnas drawer.
        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "Menu \u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {

                console.log("This is stackView.depth: " + stackView.depth)
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            color: "blue"
            anchors.centerIn: parent
        }

    }


    Drawer {
        id: drawer
        width: window.width * 0.33
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1 - Resonance Test")
                width: parent.width
                onClicked: {
                    stackView.push("Page1Form.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2 - Spectrum")
                width: parent.width
                onClicked: {
                    stackView.push("Page2Form.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }
}



///   Se först   Help | Print | Stop | Measure | Exit
//    Andra      Static Couple | Remove weight | Split on | Change unit | Trace On
