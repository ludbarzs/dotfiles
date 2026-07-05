pragma Singleton
import QtQuick
import Quickshell.Io

QtObject {
    id: root

    property color background: "#1e1e2e"
    property color foreground: "#cdd6f4"
    property color color0: "#45475a"
    property color color1: "#f38ba8"
    property color color2: "#a6e3a1"
    property color color3: "#f9e2af"
    property color color4: "#89b4fa"
    property color color5: "#f5c2e7"
    property color color6: "#94e2d5"
    property color color7: "#bac2de"
    property color color8: "#585b70"
    property color color9: "#f38ba8"
    property color color10: "#a6e3a1"
    property color color11: "#f9e2af"
    property color color12: "#89b4fa"
    property color color13: "#f5c2e7"
    property color color14: "#94e2d5"
    property color color15: "#a6adc8"

    property FileView colorFile: FileView {
        id: fileView
        path: Qt.resolvedUrl("./colors.json")
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            var data = JSON.parse(text())
            root.background = data.background
            root.foreground = data.foreground
            root.color0 = data.color0
            root.color1 = data.color1
            root.color2 = data.color2
            root.color3 = data.color3
            root.color4 = data.color4
            root.color5 = data.color5
            root.color6 = data.color6
            root.color7 = data.color7
            root.color8 = data.color8
            root.color9 = data.color9
            root.color10 = data.color10
            root.color11 = data.color11
            root.color12 = data.color12
            root.color13 = data.color13
            root.color14 = data.color14
            root.color15 = data.color15

            var p = fileView.path
            fileView.path = ""
            fileView.path = p
        }
    }
}
