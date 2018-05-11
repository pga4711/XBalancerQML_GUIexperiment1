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


}
