import { Clock } from "./Clock";
import { Menu } from "./Menu";
import { SysTray } from "./Systray";
import { Volume } from "./Volume";
import { Workspaces } from "./Workspaces";
import { Notifications } from "./Notifications";

export const Bar = (monitor: number) =>
  Widget.Window({
    name: "bar",
    className: "bar",
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
    layer: "bottom",
    monitor,
    child: Widget.CenterBox({
      className: "bar-centerbox",
      hexpand: true,
      startWidget: Widget.Box({
        child: Widget.Box({
          className: "bar-widgets-left",
          children: [Menu(), Workspaces(monitor)],
        }),
      }),
      centerWidget: Widget.Box({
        child: Widget.Box({
          className: "bar-widgets-center",
          children: [Clock()],
        }),
      }),
      endWidget: Widget.Box({
        hpack: "end",
        child: Widget.Box({
          className: "bar-widgets-right",
          children: [Volume(), SysTray(), Notifications()],
        }),
      }),
    }),
  });
