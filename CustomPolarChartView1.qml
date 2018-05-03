import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2


PolarChartView {
    id: customPolarCV

    title: "Generic polarCV"

    //anchors.fill: parent

    legend.visible: false
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
        max: 240
        tickCount: 6
        visible: true

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
//Add data dymanic

    Component.onCompleted: {
        /*
        for (var i = 0; i <= 360; i++) {
            series1.append(i, Math.random()*10);
            series2.append(i, Math.random()*10);

        }*/


        series1.append(45,  200)
        series1.append(40,  110)
        //??
        console.log(this.id + "axisRadial.tickCount:      "+axisRadial.tickCount);
        console.log(customPolarCV.id + "axisRadial.minorTickCount: "+axisRadial.minorTickCount);
    }

}
