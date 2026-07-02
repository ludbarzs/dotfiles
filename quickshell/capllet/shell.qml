import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.UPower

import "./wallust" as Theme

Variants {
  model: Quickshell.screens;
  ShellRoot {
    function refresh() {
      Hyprland.refreshMonitors();
      Hyprland.refreshWorkspaces();
      Hyprland.refreshToplevels();
    }
    Component.onCompleted: {
      refresh()
    }

    PanelWindow {
      property bool expanded: false
      WlrLayershell.layer: WlrLayer.Overlay
      exclusiveZone: 0
      id: bar
      anchors {
        bottom: true
      }
      margins.top: 0
      margins.bottom: 0
      implicitHeight: 130 //36
      implicitWidth: 500
      color: "transparent"


      Rectangle {
        // Styling for capplet
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(Theme.Colors.background.r, Theme.Colors.background.g, Theme.Colors.background.b, 0.82)
        radius: 18
        height: bar.expanded ? 130 : 36
        width: bar.expanded ? 500 : 400
        Behavior on height {
          NumberAnimation { 
            duration: 300
            easing.type: Easing.OutCubic
          }
        }
        Behavior on width {
          NumberAnimation { 
            duration: 400
            easing.type: Easing.OutCubic
          }
        }
        border {
          color: Qt.rgba(Theme.Colors.foreground.r, Theme.Colors.foreground.g, Theme.Colors.foreground.b, 0.15)
          width: 1
        }
        HoverHandler {
          id: hoverHandler
          onHoveredChanged: bar.expanded = hoverHandler.hovered
        }

        // Row main bar
        RowLayout {
          id: idleRow
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.leftMargin: 15
          anchors.rightMargin: 15
          height: 36 

          // Workspace 
          Workspace{}

          Item { Layout.fillWidth: true }

          Clock {}

          Item { Layout.fillWidth: true }

          Battery{}
        }

        Devider{}

        ColumnLayout {
          id: expandedColumn
          anchors.top: idleRow.bottom
          anchors.right: parent.right
          anchors.left: parent.left
          anchors.topMargin: 8
          anchors.horizontalCenter: parent.horizontalCenter
          opacity: bar.expanded ? 1 : 0
          visible: opacity > 0

          Behavior on opacity {
            NumberAnimation { duration: 150 }
          }

          Sliders{}

        }

      }

    }
  }
}
