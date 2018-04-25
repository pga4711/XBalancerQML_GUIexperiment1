import QtQuick 2.9
import QtQuick.Controls 2.3
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
        id: toolBar
        //contentHeight: toolButton.implicitHeight //before.
        contentHeight: measurementPanelRowLayout.implicitHeight

        RowLayout {
            id: toolBarRowPayout
            anchors.fill: parent

            ToolButton {
                id: toolButton

                function inHomeForm() {
                    //Om depth är lika med 1är mindre än 1, så är vi utanför
                    if (stackView.depth == 1)
                    {
                        return false

                    }
                    else
                    {
                        return  true
                    }

                }


                icon {
                    name: "menu"
                    source: "files/images/ic_menu_black_48dp.png"
                }

                icon {
                    name: "back"
                    source: "files/images/ic_chevron_left_black_48dp.png"
                }


                /*
                text: {
                    if (stackView.depth > 1)
                    {
                        return "\u25C0"

                    }
                    else
                    {
                        return  "Menu \u2630"
                    }

                }
                */
                //MAKE THIS BUTTON BIGGER.



                //text: stackView.depth > 1 ? "\u25C0" : "Menu \u2630"
                font.pixelSize: Qt.application.font.pixelSize * 1.6
                onClicked: {

                    //Important GUI-logic:
                    if (stackView.depth > 1) {
                        stackView.pop()
                    } else {
                        drawer.open()
                    }

                    console.log("This is stackView.depth: " + stackView.depth)

                    console.log("          toolBar.width: " + toolBar.width);
                    console.log("         toolBar.height: " + toolBar.height);
                    console.log("  toolBar.implicitWidth: " + toolBar.implicitWidth);
                    console.log(" toolBar.implicitHeight: " + toolBar.implicitHeight);
                    console.log("  toolBar.contentHeight: " + toolBar.contentHeight);
                    console.log("   toolBar.contentWidth: " + toolBar.contentWidth);

                    console.log("          toolButton.width: " + toolButton.width);
                    console.log("         toolButton.height: " + toolButton.height);
                    console.log("  toolButton.implicitWidth: " + toolButton.implicitWidth);
                    console.log(" toolButton.implicitHeight: " + toolButton.implicitHeight);
                    console.log("  toolButton.contentHeight: " + toolButton.contentHeight);
                    console.log("   toolButton.contentWidth: " + toolButton.contentWidth);

                    console.log(" measurementPanelRowLayout.implicitHeight: " + measurementPanelRowLayout.implicitHeight);
                }
            }


            RowLayout {
                id: measurementPanelRowLayout

                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom


                anchors.centerIn: parent //?????????
                Label {
                    text: "L"
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 22
                }

                ColumnLayout {
                    id: leftDigitColumn
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Label {
                        text: "0,000 m/s"
                        wrapMode: Text.NoWrap
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 22
                    }

                    Label {
                        text: "0,0 degrees"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 22
                    }
                }

                ColumnLayout {
                    id: middleRpmAndMatrixColumn
                    Label {
                        color: "#2a262b"
                        text: "0 RPM"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 22
                    }

                    Label {
                        text: "No matrix"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 22
                    }
                }

                ColumnLayout {
                    id: rightDigitColumn
                    Label {
                        text: "0,000 m/s"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 22
                    }

                    Label {
                        text: "0,0 degrees"
                        font.pixelSize: 22
                    }
                }

                Label {
                    text: "R"
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    font.pixelSize: 22
                }
            }

            Label {
                text: stackView.currentItem.title
                color: "blue"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }
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
