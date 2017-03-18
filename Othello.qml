import QtQuick 2.0

Item {
    id: othello

    property int size: 100

    width: size
    height: size

    Column {
        Repeater {
            model: 8
            Row {
                Repeater {
                    model: 8
                    Square {
                        squareStatus: 1
                        squareSize: size / 8
                    }
                }
            }
        }
    }

//    Component.onCompleted: {
//        console.log(othello.size)
//    }

}
