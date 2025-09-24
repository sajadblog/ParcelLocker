import QtQuick 2.3
import QtTest 1.0

TestCase {
    name: "DoorControl"

    function test_open() {
        mainController.isConnected = false
        var result = doorController.open("")
        compare(result, false)
    }

    function test_close() {
        mainController.isConnected = false
        var result = doorController.close("")
        compare(result, false)

    }
}
