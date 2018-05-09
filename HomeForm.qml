import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2

Page {
    title: qsTr("Page HomeForm.qml")


    ColumnLayout {
        anchors.fill: parent

        GridLayout {
            id: polarChartViewGrid
            anchors.fill: parent //???????????
            columns: parent.width > parent.height ? -1 : 1

            property int maxValueAsProp //Should be moved outside this scope?

            ListModel {
                id: balancingModel1

                ListElement {
                    a: 45 //angle
                    r: 7  //radius
                }
                ListElement {
                    a: 40;
                    r: 5
                }
                ListElement {
                    a: 42
                    r: 3
                }

                ListElement {
                    a: 41
                    r: 1.5
                }

                ListElement {
                    a: 41.5
                    r: 200
                }

                ListElement {
                    a: 41
                    r: 1.1
                }

                ListElement {
                    a: 40.9
                    r: 1.01
                }
            }

            PolarChartView {
                id: leftCPCV
                title: "Left Polar Diagram"

                legend.visible: false
                antialiasing: true

                Layout.fillHeight: true
                Layout.fillWidth: true

                PinchArea {
                    pinch.target: leftCPCV
                    Component.onCompleted:  {
                        console.log("This is pinch.enabled: " + enabled)
                        console.log("This is pinch.active: " + pinch.active)
                    }
                    onPinchStarted: {
                        console.log("onPinchStarted")


                    }

                    onPinchUpdated: { console.log("onPinchUpdated") }
                    onPinchFinished: { console.log("onPinchFinished") }
                }
                ValueAxis {
                    id: axisAngularLeft
                    min: 0
                    max: 360
                    tickCount: 9
                }
                ValueAxis {
                    id: axisRadialLeft
                    min: 0
                    max: 40//SKA ÄNDRAS AUTOMATISKT VI TESTAR INTE HÄR NU
                    //max = maxValueOfRadialList(?)
                    tickCount: 6
                    visible: true

                }

                SplineSeries {
                    id: seriesLeft
                    axisAngular: axisAngularLeft
                    axisRadial: axisRadialLeft
                    pointsVisible: true
                    color: "#FF4136" //RED. but i think i have to change it...make it more theme-like


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

                    tickCount: 9
                }

                ValueAxis {
                    id: axisRadialRight
                    min: 0
                    //max: 240//max = maxValueOfRadialList(?)
                    max: polarChartViewGrid.maxValueAsProp * 1.2 //?????????????????????????????? RISKY I DONT KNOW
                    tickCount: 6
                    visible: true

                    onMaxChanged: {console.log("MAX changed and MAX is " + max) }

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

                    //populate seriesRight
                    for (var i = 0; i < balancingModel1.count ; i++)
                    {
                        seriesRight.append(balancingModel1.get(i).a,balancingModel1.get(i).r);
                        console.log("appending " + balancingModel1.get(i).r)
                    }


                }

                Button {

                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    text: "+"
                    font.pointSize: 25
                    onClicked: {parent.zoomIn() }

                }

                Button {

                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    text: "-"
                    font.pointSize: 25
                    onClicked: parent.zoomOut()

                }
            }


            Component.onCompleted: {

                //Calculate max value of the listmodel
                var currMaxValue = 0;
                for (var i = 0; i < balancingModel1.count ; i++)
                {
                    console.log("This is balancingModel1: {" + balancingModel1.get(i).a + ", " + balancingModel1.get(i).r + " }" )
                    if (currMaxValue < balancingModel1.get(i).r)
                    {
                        console.log("A new maxvalue detected. Current value "+ currMaxValue + " are going to be replaced by " + balancingModel1.get(i).r)
                        currMaxValue = balancingModel1.get(i).r
                    }
                    else
                        console.log("The value "+ balancingModel1.get(i).r + " are not the current largest number.")
                }
                console.log("This was the largest number: " + currMaxValue)
                maxValueAsProp = currMaxValue //???????????????????????????????

                console.log("This is children: " + children)

            }


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

                anchors.fill: parent //You should not use this?
                clip: true

                property int buttonPointSize: 40 //??

                Button {
                    id: button
                    text: "Help"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Print"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Stop"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Measure"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Exit"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Static Couple"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Remove weights"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Split On"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Change Unit"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
                Button {
                    text: "Trace On"
                    font.pointSize: buttonRowLayout.buttonPointSize
                }
            }
        }
    }


}

