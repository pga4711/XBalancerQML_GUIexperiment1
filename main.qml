import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

/*
  The name today (2018-09-04) of this project/repo is XBalancerQML_GUIexperiment. Actually it contains two things.
  1st: The whole navigation solution for the app. This is a quite simple solution. But it is quite complex at the end.
  And this is also very sensisitve. We have to be careful when doing specific descisions. We will also do advanced
  non-noobie-friendly things like Dynamic binding. We will have multidingings too.
  2st: This app also contain the view that will be at the lowest level of the stack, namely the "polar chart diagram" where we can see where the unbalance is located on the planes.

  The problem today. All other views/projects/repos like ToolLibraryProject, TrialRunProject, TrialRunProject apps must fit and look nice when we are pluggin them into this navigation solution.


  The name of this app is a bit misleading, but a good guess of what the app/project really is. A name with these parts would be good today:
  XBalancerQML_NavigationSolutionWithPolarChartDiargram_Project - This is too long. Then we short it down:
  XBalancerQML_NavSolutionWithPCD_Project


  A future name of this app/repo would be like:
  XBalancerQML_NavigationSolutionProject

  If i would like to insert a project in this app temporary i could name this project
  XBalancerQML_NavigationSolutionWithPolarChartDiargramAndToolLibrary_Project - too long
  XBalancerQML_NavSolutionWithPCDAndToolLib_Project -  about 49 chars   a bit long but ...

  */

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 1280
    height: 720

    property int buttonPointSize: Qt.application.font.pixelSize * changeTextSizeSlider.value
    property int lastVisibility: 4 //For the fullscreen feature. Not tested 100%

    header: ToolBar {
        id: toolBar       

        ColumnLayout {
            anchors.fill: parent

            ColumnLayout {
                id: debugColumnLayout
                //Column dicatorlike items
                Label { //SM means Stack Main. Maybe we could call it AW like in ApplicationWindow instead
                    id: debugLabel0
                    text: "SM. This is buttonpointsize: " + mainWindow.buttonPointSize
                    font.pointSize: Qt.application.font.pixelSize*0.7
                }

                Label {
                    id: debugLabel1
                    text: "SM. Qt.application.font.pixelSize: " + Qt.application.font.pixelSize + " . Slider value: " + changeTextSizeSlider.value
                    font.pointSize: Qt.application.font.pixelSize*0.7
                }

                RowLayout {
                    id: sliderRow //Bad name, but this slide thing is only for debugging?

                    Label {
                        id: changeTextSizeLabel
                        text: "Change text size: "
                    }
                    Slider {
                        id: changeTextSizeSlider
                        from: 0.1
                        value: 1.2 //!!!
                        to: 5
                        implicitHeight: 20 //a bit risky,
                        implicitWidth: mainWindow.width-changeTextSizeLabel.width

                    }
                }


                RowLayout {
                    //row friendly items
                    Switch {
                        id: switchFullScreen
                        text: "#"
                        font.pointSize: mainWindow.buttonPointSize
                        onClicked: {
                            if (visualPosition===1) {
                                mainWindow.lastVisibility = mainWindow.visibility//Save the current visibility for later usage
                                mainWindow.visibility = Window.FullScreen
                            }
                            else {
                                mainWindow.visibility = mainWindow.lastVisibility //Assign the last visiblity
                            }
                        }                        
                    }
                    Button {
                        text: "Debug1"
                    }
                }

                visible: hideDebugRowLayout.visualPosition===1 ? false : true
            }

            RowLayout {
                id: toolBarRowPayout


                ToolButton {
                    id: toolButton                   
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                    Layout.fillHeight: true
                    Layout.minimumWidth: height

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

                    background: Rectangle {
                        width: toolButton.width
                        height: toolButton.height
                        color: Qt.darker("#33333333", toolButton.enabled && (toolButton.checked || toolButton.highlighted) ? 1.5 : 1.0)
                        opacity: enabled ? 1 : 0.3
                        visible: toolButton.down || (toolButton.enabled && (toolButton.checked || toolButton.highlighted))
                    }

                    Component.onCompleted: {console.log("toolBtn  This is width: "+width+"This is height: " + height)}
                }

                Item {
                    Layout.fillWidth: true
                }

                RowLayout { //This thing with L and R and transducer digits are a bit experimental.
                    id: measurementPanelRowLayout

                    //Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                    Label {
                        text: "L"
                        Layout.fillHeight: false
                        Layout.fillWidth: false
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pointSize: mainWindow.buttonPointSize*1.6
                    }

                    ColumnLayout {
                        id: leftDigitColumn
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        Label {
                            text: "0,000 m/s"
                            wrapMode: Text.NoWrap
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: mainWindow.buttonPointSize*1.6
                        }

                        Label {
                            text: "0,0 degrees"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: mainWindow.buttonPointSize*1.6
                        }
                    }

                    ColumnLayout {
                        id: middleRpmAndMatrixColumn
                        Label {
                            color: "#2a262b"
                            text: "0 RPM"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: mainWindow.buttonPointSize*1.6
                        }

                        Label {
                            text: "No matrix"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: mainWindow.buttonPointSize*1.6
                        }
                    }

                    ColumnLayout {
                        id: rightDigitColumn
                        Label {
                            text: "0,000 m/s"
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            font.pointSize: mainWindow.buttonPointSize*1.6
                        }

                        Label {
                            text: "0,0 degrees"
                            font.pointSize: mainWindow.buttonPointSize*1.6 //22
                        }
                    }

                    Label {
                        text: "R"
                        Layout.fillHeight: false
                        Layout.fillWidth: false
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pointSize: mainWindow.buttonPointSize*1.6
                    }

                }

                Item {

                    Layout.fillWidth: true
                }

                Label {
                    text: stackView.currentItem.title
                    font.pointSize: mainWindow.buttonPointSize
                    color: "blue"

                }

                Switch {
                    id: hideDebugRowLayout
                    font.pointSize: mainWindow.buttonPointSize
                    text: visualPosition===1 ? "" : "Hide debugRow"
                }
            }
        }
    }

    Drawer {
        id: drawer
        width: mainWindow.width * 0.33 //TODO
        height: mainWindow.height //todo

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1 - Resonance Test")
                font.pointSize: mainWindow.buttonPointSize*1.3
                width: parent.width
                onClicked: {
                    stackView.push("Page1Form.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2 - Spectrum")
                width: parent.width
                font.pointSize: mainWindow.buttonPointSize*1.3
                onClicked: {
                    stackView.push("Page2Spectrum.qml")
                    drawer.close()
                }
            }

            ItemDelegate {
                text: qsTr("Page 3 - PhilipsChartTest")
                width: parent.width
                font.pointSize: mainWindow.buttonPointSize*1.3
                onClicked: {
                    stackView.push("Page3Test.qml")
                    drawer.close()
                }
            }
            /*
            ItemDelegate {
                text: qsTr("Page 4 - TestWithDualViews")
                width: parent.width
                onClicked: {
                    stackView.push("Page4TestWithDualViews.qml")
                    drawer.close()
                }
            }
            */

        }
    }

    StackView {
        id: stackView        
        initialItem: "HomeForm.qml"        
        anchors.fill: parent
    }
}
