import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {
    id: page
    width: 500
    height: 400

    //Problem!!!!!!! This anchors.fill: parent gives a Warning.
    //anchors.fill: parent
    anchors.centerIn: parent //så då?

    title: qsTr("Home123")

    ColumnLayout {
        id: mainColumnLayout
        anchors.fill: parent

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
