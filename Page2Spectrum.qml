import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2


Page {

    title: qsTr("Page 2 SPECTRUMx")
    ColumnLayout {
        anchors.fill: parent


        ChartView {
            id: spectrumChartView
            title: "Spectra chart diagram"

            //animationOptions: ChartView.NoAnimation
            //theme: ChartView.ChartThemeHighContrast

            antialiasing: true

            Layout.fillHeight: true
            Layout.fillWidth: true

            ValueAxis {
                id: axisX
                min: 0
                max: 1000
                visible: true
            }

            ValueAxis {
                id: axisY
                min: 0
                max: 15
                visible: true
            }

            LineSeries {
                id: lineSeries1
                name: "signal 1"
                axisX: axisX
                axisY: axisY
            }

            Component.onCompleted:  {

                lineSeries1.append(0,0)
                lineSeries1.append(1,1)
                lineSeries1.append(99,2)
                lineSeries1.append(100,9)
                lineSeries1.append(101,2)
                lineSeries1.append(102,1)
                lineSeries1.append(299,1)
                lineSeries1.append(300,12)
                lineSeries1.append(301,1)
                lineSeries1.append(699,1)
                lineSeries1.append(700,5)
                lineSeries1.append(701,6)
                lineSeries1.append(702,1)
                lineSeries1.append(899,1.5)
                lineSeries1.append(900,13)
                lineSeries1.append(901,12)
                lineSeries1.append(902,1)
                lineSeries1.append(999,1)



                console.log("This is width: " + width + ". This is height: " + height)
            }

        }


/*
        ScrollView {
            id: buttonScrollView
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wheelEnabled: true

            clip: true

            ScrollBar.horizontal.interactive: true

            RowLayout {
                id: buttonRowLayout

                anchors.fill: parent //You should not use this?
                clip: true

                property int buttonPointSize: 40 //??

                Button {
                    id: button
                    text: "Help"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Y Zoom In"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Y Zoom Out"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "X Zoom In"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "X Zoom Out"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Left"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Right"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Measure"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Close"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }

            }


        }
*/
    }
}
