import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Othello")

    Column {
        Repeater {
            model: 8
            Row {
                Repeater {
                    model: 8
                    Square {
                        squareStatus: 1
                        size: window.width / 8
                    }
                }
            }
        }
    }
}
