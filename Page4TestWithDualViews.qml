import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2

Page {
    title: qsTr("Page 4 Test!!!!!!!!")

    GridLayout {
        anchors.fill: parent //???????????

        PolarChartView {
            id: leftCPCV
            title: "Left Polar Diagram"

            //legend.visible: false
            antialiasing: true

            Layout.fillHeight: true
            Layout.fillWidth: true

            ValueAxis {
                id: axisAngularLeft
                min: 0
                max: 360
                //max = maxValueOfRadialList(?)
                tickCount: 9
            }
            ValueAxis {
                id: axisRadialLeft
                min: 0
                max: 240
                tickCount: 6
                visible: true

            }

            SplineSeries {
                id: seriesLeft
                axisAngular: axisAngularLeft
                axisRadial: axisRadialLeft
                pointsVisible: true
            }

            Component.onCompleted: {
                seriesLeft.append(240,  200)
                seriesLeft.append(220,  110)
                console.log("Hello from Left")
            }

        }

        PolarChartView {
            id: rightCPCV
            title: "Right Polar Diagram"

            // legend.visible: false
            antialiasing: true
            Layout.fillHeight: true;
            Layout.fillWidth: true

            ValueAxis {
                id: axisAngularRight
                min: 0
                max: 360
                //max = maxValueOfRadialList(?)
                tickCount: 9
            }

            ValueAxis {
                id: axisRadialRight
                min: 0
                max: 240
                tickCount: 6
                visible: true

            }

            //Dual SplineSeries in the same QML-file seems to cause a SIGSEGV
            /*
            SplineSeries {
                id: seriesRight
                axisAngular: axisAngularLeft
                axisRadial: axisRadialLeft
                pointsVisible: true
            }
            */

            Component.onCompleted: {
                console.log("Hello from PolarChartView right")
                //seriesRight.append(45,  200)
                //seriesRight.append(40,  110)
            }
        }
    }

    Component.onCompleted: {
        console.log("Hello from PAGE4")
    }
}
