import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2

Page {
    title: qsTr("Page 3 Test")

    RowLayout {
        anchors.fill: parent
           Button {
               text: "Button1"
           }
           Button {
               text: "Button2"
           }
    }

    PolarChartView {
        id: polarCV

        title: "Philips testpolarchart"

        anchors.fill: parent

        //legend.visible: false
        antialiasing: true

        ValueAxis {
            id: axisAngular
            min: 0
            max: 360
            tickCount: 9
        }
        ValueAxis {
            id: axisRadial
            min: 0
            max: 20
            tickCount: 6

        }

        SplineSeries {
            id: series1
            axisAngular: axisAngular
            axisRadial: axisRadial
            pointsVisible: true
        }
        ScatterSeries {
            id: series2
            axisRadial: axisRadial
            axisAngular: axisAngular
            markerSize: 10
        }
    //Add data dymanically

        Component.onCompleted: {
            for (var i = 0; i <= 360; i+=20) {
                series1.append(i, Math.random()*10);
                series2.append(i, Math.random()*10);
            }
            console.log("axisRadial.tickCount:      "+axisRadial.tickCount);
            console.log("axisRadial.minorTickCount: "+axisRadial.minorTickCount);
        }

    }

}
