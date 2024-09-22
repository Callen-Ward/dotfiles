const hyprland = await Service.import("hyprland");
import { globalMousePos } from "globals";

const moveBoxToCursor = (self: any) => {
  globalMousePos.connect("changed", async ({ value }) => {
    const currentHyprlandMonitor = hyprland.monitors.find(
      (m) => m.id === hyprland.active.monitor.id,
    );
    const dropdownWidth = self.child.get_allocation().width;

    let monitorWidth = currentHyprlandMonitor?.width;
    let monitorHeight = currentHyprlandMonitor?.height;

    if (monitorWidth === undefined || monitorHeight === undefined) {
      return;
    }

    let marginRight = monitorWidth - dropdownWidth / 2;
    marginRight = marginRight - value[0];
    let marginLeft = monitorWidth - dropdownWidth - marginRight;

    if (marginRight < 0) {
      marginRight = 0;
      marginLeft = monitorWidth - dropdownWidth;
    }

    if (marginLeft < 0) {
      marginLeft = 0;
      marginRight = monitorWidth - dropdownWidth;
    }

    self.set_margin_left(marginLeft);
    self.set_margin_right(marginRight);
    self.set_margin_bottom(monitorHeight);
  });
};

export const DropdownMenu = ({ name, child }) =>
  Widget.Window({
    name,
    className: name,
    exclusivity: "ignore",
    layer: "top",
    anchor: ["top", "right"],
    visible: false,
    child: Widget.EventBox({
      on_primary_click: () => App.closeWindow(name),
      on_secondary_click: () => App.closeWindow(name),
      child: Widget.Box({
        className: "dropdown-menu-container",
        child: Widget.EventBox({
          on_primary_click: () => true,
          on_secondary_click: () => true,
          setup: (self: any) => moveBoxToCursor(self),
          child: Widget.Box({
            child: Widget.Revealer({
              revealChild: false,
              setup: (self) =>
                self.hook(App, (_, wname, visible) => {
                  if (wname === name) self.reveal_child = visible;
                }),
              transition: "none",
              child: Widget.Box({
                className: "dropdown-menu",
                can_focus: true,
                children: [child],
              }),
            }),
          }),
        }),
      }),
    }),
  });
