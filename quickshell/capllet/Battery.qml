import QtQuick
import Quickshell.Services.UPower
import "./wallust" as Theme

Row {
    spacing: 5

    Text {
        id: batteryIcon
        text: {
            var d = UPower.displayDevice
            if (!d.ready) return "?"
            if (d.state === UPowerDeviceState.Charging) return "󰂄"
            else if (d.percentage >= 0.80) return "󰁹"
            else if (d.percentage >= 0.60) return "󰂀"
            else if (d.percentage >= 0.40) return "󰁾"
            else if (d.percentage >= 0.20) return "󰁼"
            else return "󰁺"
        }
        color: {
            var d = UPower.displayDevice
            if (!d.ready) return "#1AB30D"
            if (d.state === UPowerDeviceState.Charging) return "#1AB30D"
            if (d.percentage <= 0.50) return "#FFA500"
            if (d.percentage <= 0.20) return "#BA0908"
            return "#1AB30D"
        }
        font {
            family: "Liga SFMono Nerd Font"
            pixelSize: 16
            weight: 500
        }
        rotation: 90
        transformOrigin: Item.Center
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: {
            var d = UPower.displayDevice
            return d.ready ? Math.round(d.percentage * 100) + "%" : "?"
        }
        color: Theme.Colors.foreground
        font {
            family: "Liga SFMono Nerd Font"
            pixelSize: 14
            weight: 600
        }
        anchors.verticalCenter: parent.verticalCenter
    }
}
