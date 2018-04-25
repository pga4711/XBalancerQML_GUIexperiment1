import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3



Page {
    id: page
    width: 500
    height: 400

    //Problem!!!!!!! Ger varning, man får inte göra såhär.
    anchors.fill: parent

    title: qsTr("Home123")

    ColumnLayout {
        id: mainColumnLayout
        anchors.fill: parent
/*
        RowLayout {
            id: measurementPanelRowLayout

            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

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
        end of RowLayout
        */

        Image {
            id: image
            fillMode: Image.PreserveAspectFit
            Layout.fillHeight: true
            Layout.fillWidth: true

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            source: "files/images/XbalancerOnlycirclesBIG2.jpg"
        }

        ScrollView {
            id: buttonScrollView
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wheelEnabled: true

            clip: true

            ScrollBar.horizontal.interactive: true


            RowLayout {
                id: buttonRowLayout

                anchors.fill: parent
                clip: true


                Button {
                    id: button
                    text: "Help"
                    font.pointSize: 35
                }
                Button {
                    text: "Print"
                    font.pointSize: 35
                }
                Button {
                    text: "Stop"
                    font.pointSize: 35
                }
                Button {
                    text: "Measure"
                    font.pointSize: 35
                }
                Button {
                    text: "Exit"
                    font.pointSize: 35
                }
                Button {
                    text: "Static Couple"
                    font.pointSize: 35
                }
                Button {
                    text: "Remove weights"
                    font.pointSize: 35
                }
                Button {
                    text: "Split On"
                    font.pointSize: 35
                }
                Button {
                    text: "Change Unit"
                    font.pointSize: 35
                }
                Button {
                    text: "Trace On"
                    font.pointSize: 35
                }

            }
        }
    }
}
