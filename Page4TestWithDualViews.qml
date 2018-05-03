import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2

Page {
    title: qsTr("Page 4 Test!!!!!!!!")

    RowLayout {
        anchors.fill: parent //???????????
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

        CustomPolarChartView1 {
            id: leftCPCV
            title: "Left Polar Diagram"
            anchors.fill: parent

           // width:100
            //height: 100
        }

/*
        Button {
            text: "buttonfoo"
        }*/
    }



}
