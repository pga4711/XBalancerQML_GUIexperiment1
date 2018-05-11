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

            property double currentDiagramMaxValue  //This is to get access to max in axisRadiaRight.max

            property double currentMaxLimit
            property double currentMinLimit

            ListModel {
                id: balancingModel1

                ListElement {
                    a: 47 //angle
                    r: 20  //radius
                }

                ListElement {
                    a: 47 //angle
                    r: 8  //radius
                }

                ListElement {
                    a: 45 //angle
                    r: 7  //radius
                }
                ListElement {
                    a: 40;
                    r: 6
                }
                ListElement {
                    a: 42
                    r: 3
                }
                ListElement {
                    a: 41
                    r: 2
                }
            }

            PolarChartView {
                id: leftCPCV
                title: "Left Polar Diagram"

                legend.visible: false
                antialiasing: true

                Layout.fillHeight: true
                Layout.fillWidth: true

                //funkar inte:
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
                    //max: polarChartViewGrid.maxValueAsProp * 1.2 //?????????????????????????????? RISKY I DONT KNOW , i do something else than this now
                    max: polarChartViewGrid.currentDiagramMaxValue
                    tickCount: 6
                    visible: true

                    onMaxChanged: {console.log("MAX changed and MAX is " + max) }
                }

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
                    text: "-"
                    font.pointSize: 25
                    onClicked: {
                        var possibleDiagramMaxValue = polarChartViewGrid.currentDiagramMaxValue*1.15
                        var worstCaseMaxZoomValue = polarChartViewGrid.currentMaxLimit*1.2

                        console.log("currentDiagramMaxValue : " + polarChartViewGrid.currentDiagramMaxValue)
                        console.log("currentMaxLimit        : " + polarChartViewGrid.currentMaxLimit)

                        console.log("possibleDiagramMaxValue: " + possibleDiagramMaxValue + "  (polarChartViewGrid.currentDiagramMaxValue*1.15)")
                        console.log("worstCaseMaxZoomValue  : " + worstCaseMaxZoomValue +  "  (polarChartViewGrid.currentMaxLimit*1.2)")

                        if (possibleDiagramMaxValue > worstCaseMaxZoomValue)
                             polarChartViewGrid.currentDiagramMaxValue = worstCaseMaxZoomValue
                        else
                             polarChartViewGrid.currentDiagramMaxValue = possibleDiagramMaxValue  //Things are OK, we could zoom by out 15%
                    }
                }

                Button {
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    text: "+"
                    font.pointSize: 25

                    onClicked: {
                        var possibleDiagramMaxValue = polarChartViewGrid.currentDiagramMaxValue*0.85 //15% zoomning
                        var worstCaseMinZoomValue =  polarChartViewGrid.currentMinLimit*1.2

                        if (possibleDiagramMaxValue < worstCaseMinZoomValue)
                        {
                            //Oj, det blir innanför gränsen. Sätt istället till absolut minsta tillåtna skala.
                            polarChartViewGrid.currentDiagramMaxValue = worstCaseMinZoomValue
                        }
                        else
                        {
                            polarChartViewGrid.currentDiagramMaxValue = possibleDiagramMaxValue//Gör 15% zoomning,
                        }
                    }
                }
            }


            Component.onCompleted: {

                //Denna Component.onCompleted körs endast 1 gång.
                //Calculate max value of the listmodel
                var currMaxValue = 0;
                for (var i = 0; i < balancingModel1.count ; i++)
                {
                    if (currMaxValue < balancingModel1.get(i).r)
                    {
                        currMaxValue = balancingModel1.get(i).r
                    }
                }
                console.log("This was the largest number: " + currMaxValue)
                //                maxValueAsProp = currMaxValue //???????????????????????????????

                currentMaxLimit = currMaxValue  //Nu har jag hittat maxvärdet. Spara maxvärdet i den hära globala currentMaxLimit som zoomfunktionen kan få nytta av.
                currentDiagramMaxValue = currentMaxLimit * 1.2  //Vyn ska alltid börja med att man ser punktens område +20% extra i polardiagrammet. Detta sätts bara en gång. Typ default är detta.


                console.log("Soo, this is currentDiagramMaxValue: " + currentDiagramMaxValue);


                //Calculate min value of the listmodel
                //balancingModel1 CANNOT BE ZERO IN SIZE FOR THE MOMENT

                var currMinValue = balancingModel1.get(0).r
                for (var j = 0; j < balancingModel1.count ; j++)
                {
                    if (currMinValue> balancingModel1.get(j).r)
                    {
                        //The old value was larger than the current comparing value. Let's save our new smaller value.
                        currMinValue = balancingModel1.get(j).r
                    }
                }

                console.log("This was the smallest number: " + currMinValue)
                currentMinLimit = currMinValue
                console.log("This is the currentMinLimit: " + currentMinLimit)

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

