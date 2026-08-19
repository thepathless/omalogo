import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.Commons
import qs.Ui
import "DistroModel.js" as DistroModel

BarWidget {
  id: root
  moduleName: "omalogo"

  property string currentDistroKey: root.setting("distro", "arch")
  readonly property var currentDistro: DistroModel.findDistro(currentDistroKey)

  function updateDistro(key) {
    root.currentDistroKey = key
    var entry = { id: root.moduleName }
    for (var k in root.settings) if (k !== "id") entry[k] = root.settings[k]
    entry.distro = key

    // Applied locally first so UI changes reactively
    root.settings = entry

    if (root.bar && root.bar.shell && typeof root.bar.shell.updateEntryInline === "function") {
      root.bar.shell.updateEntryInline(root.moduleName, entry)
    }
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.currentDistro ? root.currentDistro.icon : "\ue900"
    fontFamily: (root.currentDistro && root.currentDistro.font === "omarchy") ? "omarchy" : (root.bar ? root.bar.fontFamily : Style.font.family)
    horizontalMargin: 7.5
    tooltipText: root.currentDistro ? root.currentDistro.name : "Omarchy"

    onPressed: function(btn) {
      if (!root.bar) return
      if (btn === Qt.RightButton) {
        root.bar.run("xdg-terminal-exec")
      } else if (btn === Qt.MiddleButton) {
        distroPickerPopup.open = !distroPickerPopup.open
      } else {
        root.bar.run("omarchy-shell shell toggle omarchy.menu '{\"menu\":\"root\"}'")
      }
    }

    onWheelMoved: function(delta) {
      if (!root.bar) return
      if (delta < 0) {
        root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"e+1\" })"))
      } else if (delta > 0) {
        root.bar.run("hyprctl dispatch " + Util.shellQuote("hl.dsp.focus({ workspace = \"e-1\" })"))
      }
    }
  }

  // -------------------------------------------------------------
  // Distribution Logo Picker
  // -------------------------------------------------------------
  PopupCard {
    id: distroPickerPopup
    anchorItem: root
    bar: root.bar
    contentWidth: Style.space(300)
    contentHeight: fittedContentHeight(popupLayout.implicitHeight)
    open: false
    triggerMode: "click"

    Column {
      id: popupLayout
      width: parent.width
      spacing: Style.spacing.sm

      // Header Row
      Row {
        width: parent.width
        spacing: Style.spacing.md

        BorderSurface {
          width: Style.space(36)
          height: Style.space(36)
          radius: Style.cornerRadius
          color: Qt.rgba(Color.accent.r, Color.accent.g, Color.accent.b, 0.12)
          anchors.verticalCenter: parent.verticalCenter

          Text {
            anchors.centerIn: parent
            text: root.currentDistro ? root.currentDistro.icon : "\ue900"
            font.family: (root.currentDistro && root.currentDistro.font === "omarchy") ? "omarchy" : Style.font.family
            font.pixelSize: Style.font.title
            color: Color.accent
          }
        }

        Column {
          width: parent.width - Style.space(76)
          spacing: 1
          anchors.verticalCenter: parent.verticalCenter

          Text {
            text: "Application Logo"
            color: Color.foreground
            font.family: Style.font.family
            font.pixelSize: Style.font.subtitle
            font.bold: true
          }

          Text {
            text: "Select status bar branding"
            color: Color.muted
            font.family: Style.font.family
            font.pixelSize: Style.font.caption
          }
        }

        Button {
          iconText: "\udb80\udd56"
          tooltipText: "Close"
          anchors.verticalCenter: parent.verticalCenter
          onClicked: distroPickerPopup.close()
        }
      }

      PanelSeparator { foreground: Color.foreground }

      // Distribution Catalog List
      Item {
        id: distroList
        width: parent.width
        height: Math.min(Style.space(260), distroListView.contentHeight)

        ListView {
          id: distroListView
          anchors.fill: parent
          clip: true
          model: DistroModel.allDistros()
          spacing: Style.space(2)

          delegate: BorderSurface {
            id: itemRow
            required property var modelData

            readonly property bool isCurrent: modelData.key === root.currentDistroKey
            readonly property bool isHovered: mouseItem.containsMouse

            width: distroListView.width
            height: Style.space(32)
            radius: Style.cornerRadius
            color: isCurrent
              ? Qt.rgba(Color.accent.r, Color.accent.g, Color.accent.b, 0.16)
              : (isHovered ? Qt.rgba(Color.foreground.r, Color.foreground.g, Color.foreground.b, 0.08) : "transparent")

            Row {
              anchors.fill: parent
              anchors.leftMargin: Style.spacing.controlPaddingX
              anchors.rightMargin: Style.spacing.controlPaddingX
              spacing: Style.spacing.md

              Text {
                width: Style.space(22)
                text: modelData.icon
                font.family: modelData.font === "omarchy" ? "omarchy" : Style.font.family
                font.pixelSize: Style.font.title
                color: itemRow.isCurrent ? Color.accent : Color.foreground
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
              }

              Text {
                width: parent.width - Style.space(56)
                text: modelData.name
                font.family: Style.font.family
                font.pixelSize: Style.font.body
                font.bold: itemRow.isCurrent
                color: itemRow.isCurrent ? Color.accent : Color.foreground
                elide: Text.ElideRight
                anchors.verticalCenter: parent.verticalCenter
              }

              Text {
                visible: itemRow.isCurrent
                text: "✓"
                font.family: Style.font.family
                font.pixelSize: Style.font.body
                font.bold: true
                color: Color.accent
                anchors.verticalCenter: parent.verticalCenter
              }
            }

            MouseArea {
              id: mouseItem
              anchors.fill: parent
              hoverEnabled: true
              cursorShape: Qt.PointingHandCursor
              onClicked: {
                root.updateDistro(itemRow.modelData.key)
                distroPickerPopup.close()
              }
            }
          }
        }
      }

      PanelSeparator { foreground: Color.foreground }

      // Footer Navigation Summary
      Row {
        width: parent.width
        spacing: Style.spacing.xs

        Text {
          text: "Left-click: Apps  •  Right-click: Terminal  •  Scroll: Workspaces"
          color: Color.muted
          font.family: Style.font.family
          font.pixelSize: Style.font.caption
          anchors.verticalCenter: parent.verticalCenter
        }
      }
    }
  }
}
