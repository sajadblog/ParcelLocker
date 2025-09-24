import QtQuick 2.3
import QtTest 1.0

TestCase {
    name: "MainController"

    function test_properties() {
        mainController.isConnected = true
        compare(mainController.isConnected, true)
    }
}
