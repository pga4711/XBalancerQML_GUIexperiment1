import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

///Ahhh,
Page {
    id: page
    width: 500
    height: 400


    anchors.fill: parent
    title: qsTr("Home123")

    ColumnLayout {
        id: mainColumnLayout
        anchors.fill: parent

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

        Image {
            id: image
            fillMode: Image.PreserveAspectFit
            Layout.fillHeight: true
            Layout.fillWidth: true

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            source: "files/images/XbalancerOnlycirclesBIG.jpg"
        }

        ScrollView {
            id: buttonScrollView
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wheelEnabled: true

            clip: true

            ScrollBar.horizontal.interactive: true

            RowLayout {
                id: buttonRowLayout
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.fill: parent
                clip: true

                Button {
                    text: "Help"
                    font.pointSize: 15
                }
                Button {
                    text: "Print"
                    font.pointSize: 15
                }
                Button {
                    text: "Stop"
                    font.pointSize: 15
                }
                Button {
                    text: "Measure"
                    font.pointSize: 15
                }
                Button {
                    text: "Exit"
                    font.pointSize: 15
                }
                Button {
                    text: "Static Couple"
                    font.pointSize: 15
                }
                Button {
                    text: "Remove weights"
                    font.pointSize: 15
                }
                Button {
                    text: "Split On"
                    font.pointSize: 15
                }
                Button {
                    text: "Change Unit"
                    font.pointSize: 15
                }
                Button {
                    text: "Trace On"
                    font.pointSize: 15
                }
            }
        }
    }
}
