import { icons, setIconProps } from "icons";
import { openMenu } from "./utils";
import Gdk from "types/@girs/gdk-3.0/gdk-3.0";

const notifications = await Service.import("notifications");

const getIcon = (notificationCount: number) =>
  notificationCount > 0
    ? icons.notifications.tray.nonEmpty
    : icons.notifications.tray.empty;

export const Notifications = () =>
  Widget.Button({
    classNames: ["bar-widget", "notifications"],
    child: Widget.Icon({
      setup: (self) =>
        self.hook(notifications, () => {
          setIconProps(self, getIcon(notifications.notifications.length));
        }),
    }),

    on_primary_click: (clicked: any, event: Gdk.Event) => {
      openMenu(clicked, event, "notificationmenu");
    },
  });
