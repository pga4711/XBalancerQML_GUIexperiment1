import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtCharts 2.2

Page {
    id: currentPage
    //id: mainWindow //BAD NAME. This is just for a quick connect to automatic-textSize concept.
    title: qsTr("Page: HomeForm.qml")

    property int buttonPointSize: 30
    property string foo: "hellofrom curr page"


    ColumnLayout {
        anchors.fill: parent

        GridLayout {
            id: polarChartViewGrid
            //anchors.fill: parent //???????????

            Layout.fillHeight: true
            Layout.fillWidth: true
            columns: parent.width > parent.height ? -1 : 1

            PolarChartView {
                id: leftCPCV
                title: "Left Polar Diagram"

                legend.visible: false
                antialiasing: true
                Layout.fillHeight: true
                Layout.fillWidth: true

                property double currentDiagramMaxValueLeftCPCV: 0  //This is to get access to max in axisRadialLeft.max
                property double currentMaxLimitLeftCPCV: 0
                property double currentMinLimitLeftCPCV: 0




                ValueAxis {
                    id: axisAngularLeft
                    min: 0
                    max: 360
                    tickCount: 9
                }
                ValueAxis {
                    id: axisRadialLeft
                    min: 0

                    max: leftCPCV.currentDiagramMaxValueLeftCPCV
                    tickCount: 6
                    visible: true
                    onMaxChanged: {console.log("MAX changed on left and MAX is " + max) }
                }

                SplineSeries {
                    id: seriesLeft
                    axisAngular: axisAngularLeft
                    axisRadial: axisRadialLeft
                    pointsVisible: true
                    color: "#FF4136" //RED. but it is very thin?
                }

                //DATA
                ListModel {
                    id: balancingModelLeft1

                    ListElement {
                        a: 200 //angle
                        r: 10  //radius
                    }

                    ListElement {
                        a: 170 //angle
                        r: 7  //radius
                    }

                    ListElement {
                        a: 215 //angle
                        r: 6  //radius
                    }
                    ListElement {
                        a: 207;
                        r: 4
                    }
                    ListElement {
                        a: 195
                        r: 3
                    }
                    ListElement {
                        a: 197
                        r: 2
                    }
                }


                //PRESENTATION + PRESENTATION.with.BUSINESS_that_depends_on_DATA
                Button {
                    id: zoomOutButtonLeftCPCV
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 8


                    text: "-"

                    //font.pointSize: 25 * 2
                    font.pointSize: currentPage.buttonPointSize*2
                    onClicked: {
                        var possibleDiagramMaxValue = parent.currentDiagramMaxValueLeftCPCV*1.15
                        var worstCaseMaxZoomValue = parent.currentMaxLimitLeftCPCV*1.2

                        //console.log("possibleDiagramMaxValue: " + possibleDiagramMaxValue)
                        //console.log("worstCaseMaxZoomValue  : " + worstCaseMaxZoomValue)

                        if (possibleDiagramMaxValue > worstCaseMaxZoomValue)
                        {
                            parent.currentDiagramMaxValueLeftCPCV = worstCaseMaxZoomValue
                        }
                        else
                        {
                            parent.currentDiagramMaxValueLeftCPCV = possibleDiagramMaxValue  //Things are OK, we could zoom out with 15%
                        }

                    }
                }

                Button {
                    id: zoomInButtonLeftCPCV
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 8



                    text: "+"
                    font.pointSize: currentPage.buttonPointSize*2
                    //font.pointSize: 25

                    onClicked: {
                        var possibleDiagramMaxValue = parent.currentDiagramMaxValueLeftCPCV*0.85 //15% zoomning
                        var worstCaseMinZoomValue =  parent.currentMinLimitLeftCPCV*1.2

                        if (possibleDiagramMaxValue < worstCaseMinZoomValue)
                        {
                            //Oh, if we zoom now it will zoom to a unwanted fit. Then, instead, set to absolute minimum zoom instead.
                            parent.currentDiagramMaxValueLeftCPCV = worstCaseMinZoomValue
                        }
                        else
                        {
                            parent.currentDiagramMaxValueLeftCPCV = possibleDiagramMaxValue//Do 15% zooming, things will look good
                        }
                    }
                }





                //Populate PRESENTATION with exemplified DATA  AND get MAX and MIN value of the list
                Component.onCompleted: {

                    //populate seriesLeft
                    for (var i = 0; i < balancingModelLeft1.count ; i++)
                    {
                        seriesLeft.append(balancingModelLeft1.get(i).a,balancingModelLeft1.get(i).r);
                        //console.log("appending " + balancingModelLeft1.get(i).r)
                    }

                    //Calculate max value of the listmodel
                    var currMaxValue = 0;

                    for (var j = 0; j < balancingModelLeft1.count ; j++)
                    {
                        if (currMaxValue < balancingModelLeft1.get(j).r)
                            currMaxValue = balancingModelLeft1.get(j).r
                    }

                    //console.log("This was the largest number of LEFT: " + currMaxValue)


                    //Let other code to know the max-value
                    currentMaxLimitLeftCPCV = currMaxValue

                    //Set the leftCPCV to fit to the max value. The max value is +20% to get a clear view.
                    currentDiagramMaxValueLeftCPCV = currentMaxLimitLeftCPCV * 1.2

                    //console.log("Soo, this is currentDiagramMaxValueLeftCPCV: " + currentDiagramMaxValueLeftCPCV);


                    //Calculate min value of the listmodel
                    //balancingModelLeft1 CANNOT BE ZERO IN SIZE FOR THE MOMENT

                    var currMinValue = balancingModelLeft1.get(0).r
                    for (var k = 0; k < balancingModelLeft1.count ; k++)
                    {
                        if (currMinValue> balancingModelLeft1.get(k).r)
                        {
                            //The old value was larger than the current comparing value. Let's save our new smaller value.
                            currMinValue = balancingModelLeft1.get(k).r
                        }
                    }

                    //console.log("This was the smallest number: " + currMinValue)
                    currentMinLimitLeftCPCV = currMinValue
                    //console.log("This is the currentMinLimitLeftCPCV: " + currentMinLimitLeftCPCV)

                }


            }

            PolarChartView {
                //rightPolarChartView
                id: rightCPCV
                title: "Right Polar Diagram"
                legend.visible: false
                antialiasing: true
                Layout.fillHeight: true;
                Layout.fillWidth: true
                //titleFont.pointSize: 40

                //Binding { target: rightCPCV.titleFont ; property: "pointSize"; value: currentPage.buttonPointSize }


                property double currentDiagramMaxValueRightCPCV: 0  //This is to get access to max in axisRadialRight.max
                property double currentMaxLimitRightCPCV: 0
                property double currentMinLimitRightCPCV: 0

                ValueAxis {
                    id: axisAngularRight
                    min: 0
                    max: 360
                    tickCount: 9


                    //This "Binding" gives: qrc:/main.qml:213:5: QML StackView: initialItem: qrc:/HomeForm.qml:236 Cannot assign to non-existent default property
                    //Binding { target: axisAngularRight.titleFont ; property: "pointSize"; value: currentPage.buttonPointSize }

                    Component.onCompleted: {
                        console.log("This is titleFont:" + titleFont.pointSize )

                        //Does not even tell it does not work.
                        titleFont.pointSize = Qt.binding( function() { return currentPage.buttonPointSize } )
                        console.log("Does not work ight?")
                        titleFont.pointSize= 40
                        console.log("This is titleFont:" + titleFont.pointSize )
                    }
                }

                ValueAxis {
                    id: axisRadialRight
                    min: 0
                    max: rightCPCV.currentDiagramMaxValueRightCPCV
                    tickCount: 6
                    visible: true
                    onMaxChanged: {console.log("MAX changed on left and MAX is " + max) }
                }

                SplineSeries {
                    id: seriesRight
                    axisAngular: axisAngularRight
                    axisRadial: axisRadialRight
                    pointsVisible: true
                }

                //DATA
                ListModel {
                    id: balancingModelRight1

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


                //PRESENTATION + PRESENTATION.with.BUSINESS_that_depends_on_DATA
                Button {
                    id: zoomOutButtonRightCPCV
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 8
                    anchors.bottomMargin: 8



                    text: "-"
                    font.pointSize: currentPage.buttonPointSize*2
                    //font.pointSize: 25
                    onClicked: {
                        var possibleDiagramMaxValue = parent.currentDiagramMaxValueRightCPCV*1.15
                        var worstCaseMaxZoomValue = parent.currentMaxLimitRightCPCV*1.2

                        console.log("possibleDiagramMaxValue: " + possibleDiagramMaxValue + "  (polarChartViewGrid.currentDiagramMaxValueRightCPCV*1.15)")
                        console.log("worstCaseMaxZoomValue  : " + worstCaseMaxZoomValue +  "  (polarChartViewGrid.currentMaxLimitRightCPCV*1.2)")

                        if (possibleDiagramMaxValue > worstCaseMaxZoomValue)
                        {
                            parent.currentDiagramMaxValueRightCPCV = worstCaseMaxZoomValue
                        }
                        else
                        {
                            parent.currentDiagramMaxValueRightCPCV = possibleDiagramMaxValue  //Things are OK, we could zoom by out 15%
                        }

                    }
                }

                Button {
                    id: zoomInButtonRightCPCV
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 8
                    anchors.bottomMargin: 8


                    text: "+"
                    //font.pointSize: 25
                    font.pointSize: currentPage.buttonPointSize*2

                    onClicked: {
                        var possibleDiagramMaxValue = parent.currentDiagramMaxValueRightCPCV*0.85 //15% zoomning
                        var worstCaseMinZoomValue =  parent.currentMinLimitRightCPCV*1.2

                        if (possibleDiagramMaxValue < worstCaseMinZoomValue)
                        {
                            //Oh, if we zoom now it will zoom to a unwanted fit. Then, instead, set to absolute minimum zoom instead.
                            parent.currentDiagramMaxValueRightCPCV = worstCaseMinZoomValue
                        }
                        else
                        {
                            parent.currentDiagramMaxValueRightCPCV = possibleDiagramMaxValue//Do 15% zooming, things will look good
                        }
                    }
                }


                //Populate PRESENTATION with exemplified DATA  AND get MAX and MIN value of the list
                Component.onCompleted: {

                    //populate seriesRight


                    for (var i = 0; i < balancingModelRight1.count ; i++)
                    {
                        seriesRight.append(balancingModelRight1.get(i).a,balancingModelRight1.get(i).r);
                        //console.log("appending " + balancingModelRight1.get(i).r)
                    }

                    //Calculate max value of the listmodel
                    var currMaxValue = 0;

                    for (var j = 0; j < balancingModelRight1.count ; j++)
                    {
                        if (currMaxValue < balancingModelRight1.get(j).r)
                            currMaxValue = balancingModelRight1.get(j).r
                    }

                    //console.log("This was the largest number: " + currMaxValue)


                    //Let other code to know the max-value
                    currentMaxLimitRightCPCV = currMaxValue

                    //Set the rightCPCV to fit to the max value. The max value is +20% to get a clear view.
                    currentDiagramMaxValueRightCPCV = currentMaxLimitRightCPCV * 1.2

                    //console.log("Soo, this is currentDiagramMaxValueRightCPCV: " + currentDiagramMaxValueRightCPCV);


                    //Calculate min value of the listmodel
                    //balancingModelRight1 CANNOT BE ZERO IN SIZE FOR THE MOMENT

                    var currMinValue = balancingModelRight1.get(0).r
                    for (var k = 0; k < balancingModelRight1.count ; k++)
                    {
                        if (currMinValue> balancingModelRight1.get(k).r)
                        {
                            //The old value was larger than the current comparing value. Let's save our new smaller value.
                            currMinValue = balancingModelRight1.get(k).r
                        }
                    }

                    //console.log("This was the smallest number: " + currMinValue)
                    currentMinLimitRightCPCV = currMinValue
                    //console.log("This is the currentMinLimitRightCPCV: " + currentMinLimitRightCPCV)

                }
            }
        }

        ScrollView {
            id: buttonScrollView
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            wheelEnabled: true

            clip: true

            ScrollBar.horizontal.policy: Qt.platform.os==="windows" ? ScrollBar.AsNeeded : ScrollBar.AlwaysOff

            RowLayout {
                id: buttonRowLayout
                anchors.fill: parent //You should not use this?
                clip: true

                //property int buttonPointSize: 40 //??

                Button {
                    id: button
                    text: "Help"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Print"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Stop"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Measure"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Exit"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Static Couple"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Remove weights"
                    font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Split On"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Change Unit"
                     font.pointSize: currentPage.buttonPointSize
                }
                Button {
                    text: "Trace On"
                     font.pointSize: currentPage.buttonPointSize
                }
            }


        }



    }


}

