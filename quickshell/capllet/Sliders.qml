import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "./wallust" as Theme
import Quickshell.Services.Pipewire

RowLayout {
  id: sliderRow
  Layout.fillWidth: true
  Layout.rightMargin: 15
  Layout.leftMargin: 15
  height: 36 

  Slider {
    Layout.fillWidth: true
    from: 1
    value: 25
    to: 100
  }

  Slider {
    Layout.fillWidth: true
    from: 1
    value: 25
    to: 100
  }

}
