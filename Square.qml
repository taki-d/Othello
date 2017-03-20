import QtQuick 2.0

Item {
    id: square

    property int squareStatus: 0
    property int squareSize: 100
    property int position: 0

    signal onClickedSquare(int index);

    width: squareSize
    height: squareSize

    Rectangle {
        width: squareSize
        height: squareSize
        color: "green"
        border.color: "black"
        border.width: squareSize / 100

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
                    console.log("Pos:" + position)
                    onClickedSquare(position)
                }
            }
        }
    }
}
