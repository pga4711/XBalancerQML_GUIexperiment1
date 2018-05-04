import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2



//I dont know how to do a "Component" properly. I get binding loop detected in my Page4TestWithDualViews when i try to do as i understand it.
//I dont use this file for the moment.
PolarChartView {
    id: customPolarCV
    title: "Generic polarCV"
    //anchors.fill: parent
    legend.visible: false
    antialiasing: true



/*
    Component.onCompleted: {

        series1.append(45,  200)
        series1.append(40,  110)
        console.log("HELLO")
    }
    */



        /*

          Vänster: 90 grader, 30 mm/s           30 * 1.2 = ~36                   mikrometer
                   80 grader, 10 mm/s
          Höger: då kan vi ta dom som är

          */


}
