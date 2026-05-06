import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets

Item {
    id: root

    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""
    property int sectionWidgetIndex: -1
    property int sectionWidgetsCount: 0

    readonly property string screenName: screen?.name ?? ""
    readonly property real capsuleHeight: Style.getCapsuleHeightForScreen(screenName)
    readonly property real barFontSize: Style.getBarFontSizeForScreen(screenName)
    readonly property real contentWidth: row.implicitWidth + Style.marginM * 2
    readonly property real contentHeight: capsuleHeight

    property string currentLayout: "..."
    property string currentIcon: "layout-grid"

    implicitWidth: contentWidth
    implicitHeight: contentHeight

    Process {
        id: watcher
        command: ["mmsg", "-w", "-l"]
        running: true
        stdout: SplitParser {
            onRead: data => {
                var parts = data.trim().split(/\s+/)
                if (parts[0] !== root.screenName) return
                var raw = parts[2]
                var names = {
                    "T":  "Tile",
                    "S":  "Scroller",
                    "G":  "Grid",
                    "M":  "Monocle",
                    "K":  "Deck",
                    "CT": "Center",
                    "RT": "Right",
                    "VS": "V-Scroller",
                    "VT": "V-Tile"
                }
                var icons = {
                    "T":  "layout-columns",
                    "S":  "layout-sidebar-right",
                    "G":  "layout-grid",
                    "M":  "square",
                    "K":  "layers-subtract",
                    "CT": "layout-distribute-horizontally",
                    "RT": "layout-align-right",
                    "VS": "layout-sidebar-right-collapse",
                    "VT": "layout-rows"
                }
                root.currentLayout = names[raw] || raw
                root.currentIcon = icons[raw] || "layout-grid"
            }
        }
    }

    Rectangle {
        id: visualCapsule
        x: Style.pixelAlignCenter(parent.width, width)
        y: Style.pixelAlignCenter(parent.height, height)
        width: root.contentWidth
        height: root.contentHeight
        color: mouseArea.containsMouse ? Color.mHover : Style.capsuleColor
        radius: Style.radiusL
        border.color: Style.capsuleBorderColor
        border.width: Style.capsuleBorderWidth

        RowLayout {
            id: row
            anchors.centerIn: parent
            spacing: Style.marginS

            NIcon {
                icon: root.currentIcon
                color: Color.mPrimary
            }

            NText {
                id: layoutLabel
                text: root.currentLayout
                color: Color.mOnSurface
                pointSize: barFontSize
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
    }
}
