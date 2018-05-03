import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 720

    title: qsTr("Stack")


    header: ToolBar {
        id: toolBar
        //contentHeight: toolButton.implicitHeight //before.
        contentHeight: measurementPanelRowLayout.implicitHeight

        RowLayout {
            id: toolBarRowPayout
            anchors.fill: parent

            ToolButton {
                id: toolButton

                font.pixelSize: Qt.application.font.pixelSize * 1.6

                icon {
                    source: {
                        if (stackView.depth == 1) {
                            return "files/images/ic_menu_black_48dp.png"
                        }
                        else {
                            return "files/images/ic_chevron_left_black_48dp.png"
                        }
                    }
                }

                onClicked: {
                    //Swap Form:
                    if (stackView.depth > 1) {
                        stackView.pop()
                    } else {
                        drawer.open()
                    }

                    console.log("This is stackView.depth: " + stackView.depth)
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


            ItemDelegate {
                text: qsTr("Page 3 - PhilipsChartTest")
                width: parent.width
                onClicked: {
                    stackView.push("Page3Test.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 4 - TestWithDualViews")
                width: parent.width
                onClicked: {
                    stackView.push("Page4TestWithDualViews.qml")
                    drawer.close()
                }
            }

        }
    }

    StackView {
        id: stackView
        //
        initialItem: "HomeForm.ui.qml"
        //initialItem: "Page3Test.qml"
        //:/
        anchors.fill: parent
    }
}



///   Se först   Help | Print | Stop | Measure | Exit
//    Andra      Static Couple | Remove weight | Split on | Change unit | Trace On
