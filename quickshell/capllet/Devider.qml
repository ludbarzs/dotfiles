import QtQuick
import "./wallust" as Theme
Rectangle {
  id: divider
  anchors.top: idleRow.bottom
  anchors.left: parent.left
  anchors.right: parent.right
  anchors.leftMargin: 14
  anchors.rightMargin: 14
  height: 1
  color: Qt.rgba(Theme.Colors.foreground.r, Theme.Colors.foreground.g, Theme.Colors.foreground.b, 0.15)
  opacity: bar.expanded ? 1 : 0
  Behavior on opacity {
    NumberAnimation { duration: 150 }
  }
}
