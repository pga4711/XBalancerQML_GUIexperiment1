import QtQuick 2.9
import QtQuick.Controls 2.2

Page {
    width: 600
    height: 400


    title: qsTr("Page 1 QML!!! non ui")


    Label {
        id: label1
        text: qsTr("You are on Page 1 QML!!!!! non ui")
        anchors.top: parent.top
        anchors.left: parent.left
        font.pointSize: mainWindow.buttonPointSize
        Component.onCompleted: {console.log("4") }
    }

    Button {
        id: button1
        text: "hello press meX"

        anchors.top: label1.bottom
        anchors.left: parent.left
        font.pointSize: mainWindow.buttonPointSize

        Component.onCompleted: {console.log("3") }
    }


    Button {
        text: "hello press meX2"
        anchors.top: button1.bottom
        anchors.left: parent.left
        font.pointSize: mainWindow.buttonPointSize
        Component.onCompleted: {console.log("2") }
    }


    Component.onCompleted:  {console.log("1") }


}
