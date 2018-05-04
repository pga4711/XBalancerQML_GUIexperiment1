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

            legend.visible: false
            antialiasing: true

            Layout.fillHeight: true
            Layout.fillWidth: true

            ValueAxis {
                id: axisAngularLeft
                min: 0
                max: 360
                tickCount: 9
            }
            ValueAxis {
                id: axisRadialLeft
                min: 0
                max: 40//SKA ÄNDRAS AUTOMATISKT
                //max = maxValueOfRadialList(?)
                tickCount: 6
                visible: true

            }

            SplineSeries {
                id: seriesLeft
                axisAngular: axisAngularLeft
                axisRadial: axisRadialLeft
                pointsVisible: true
                color: "#FF4136"
                Component.onCompleted: {
                    console.log("This is color: " + color)
                }

            }

            Component.onCompleted: {
                seriesLeft.append(90, 30)
                seriesLeft.append(80, 10)
                console.log("Hello from Left")
            }

        }

        PolarChartView {
            id: rightCPCV
            title: "Right Polar Diagram"

            legend.visible: false
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

            SplineSeries {
                id: seriesRight
                axisAngular: axisAngularRight
                axisRadial: axisRadialRight
                pointsVisible: true
                Component.onCompleted: {
                    console.log("This is color: " + color)
                }

            }

            Component.onCompleted: {
                console.log("Hello from PolarChartView right")
                seriesRight.append(45,  200)
                seriesRight.append(40,  110)
            }
        }
    }

    Component.onCompleted: {
        console.log("Hello from PAGE4")
    }
}
