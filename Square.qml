import QtQuick 2.0

Item {
    id: square

    property int squareStatus: 0
    property int size: 100

    width: size
    height: size

    Rectangle {
        width: size
        height: size
        color: "green"
        border.color: "black"
        border.width: size / 100

        Rectangle {
            anchors.centerIn: parent
            width: parent.width / 10 * 9
            height: parent.width / 10 * 9
            color: squareStatus === 1 ? "white"
                 : squareStatus === 2 ? "black" : "transparent"
            radius: parent.width / 2

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked")
                }
            }
        }
    }
}
