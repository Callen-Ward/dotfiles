import { DropdownMenu } from "../DropdownMenu";
import { NotificationCard } from "../../notifications/NotificationCard";
import { icons, makeIcon } from "icons";

const notifications = await Service.import("notifications");

export const NotificationMenu = () => {
  const list = Widget.Box({
    vertical: true,
    children: notifications.popups.map(NotificationCard),
  });

  const remove = (_, id: number) => {
    list.children.find((n) => n.attribute === id)?.destroy();
  };

  const add = (_, id: number) => {
    const n = notifications.getNotification(id);
    if (n) list.children = [NotificationCard(n), ...list.children];
  };

  list
    .hook(notifications, add, "dismissed")
    .hook(notifications, remove, "closed");

  return DropdownMenu({
    name: "notificationmenu",
    child: Widget.Box({
      vertical: true,
      children: [
        Widget.Box({
          className: "menu-section",
          children: [
            Widget.Label({
              className: "menu-section-heading",
              label: "Notifications",
            }),
            Widget.Button({
              hpack: "end",
              hexpand: true,
              className: "notificationmenu-clear",
              on_primary_click: notifications.clear,
              child: makeIcon(icons.notifications.tray.clear),
            }),
          ],
        }),
        Widget.Box({
          child: list,
        }),
      ],
    }),
  });
};
