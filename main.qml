import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 480
    height: 213
    title: qsTr("Othello")

    Column {
        Rectangle {
            width: window.width
            height: window.height - window.width
            Text {
                id: name
                text: qsTr("text")
            }
        }

        Othello {
            size: window.height < window.width ? window.height : window.width
        }
    }
}
