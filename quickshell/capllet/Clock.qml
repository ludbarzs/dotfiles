import QtQuick
import Quickshell
import "./wallust" as Theme

Item {
  implicitWidth: label.implicitWidth
  implicitHeight: label.implicitHeight

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }

  Text {
    id: label
    anchors.verticalCenter: parent.verticalCenter
    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: Theme.Colors.foreground
    font {
      family: "Liga SFMono Nerd Font"
      letterSpacing: 1
      pixelSize: 16
      weight: 700
    }
  }
}
