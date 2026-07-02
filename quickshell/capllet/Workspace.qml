import QtQuick
import Quickshell.Hyprland
import "./wallust" as Theme

Row {
  spacing: 4

  Text {
    anchors.verticalCenter: parent.verticalCenter

    font {
      family: "Liga SFMono Nerd Font"
      letterSpacing: 1
      pixelSize: 10
      weight: 700
    }
    color: Theme.Colors.color0
    text: "ws"
  }

  Text {
    color: Theme.Colors.foreground
    anchors.verticalCenter: parent.verticalCenter
    font {
      family: "Liga SFMono Nerd Font"
      letterSpacing: 1
      pixelSize: 16
      weight: 700
    }
    text: {
      var mons = Hyprland.monitors.values;
      for (var i = 0; i < mons.length; i++) {
        if (mons[i].activeWorkspace && mons[i].activeWorkspace.name) {
          var wsNum = parseInt(mons[i].activeWorkspace.name, 10);
          if (!isNaN(wsNum)) {
            return wsNum - 1;
          }
        }
      }
      return "";
    }
  }
}
