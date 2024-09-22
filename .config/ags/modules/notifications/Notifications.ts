const notifications = await Service.import("notifications");

import { NotificationCard } from "./NotificationCard";

export const Notifications = (monitor = 0) => {
  notifications.popupTimeout = 7000;
  notifications.cacheActions = true;

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
    .hook(notifications, remove, "dismissed")
    .hook(notifications, add, "notified")
    .hook(notifications, remove, "closed");

  return Widget.Window({
    name: "notifications-window",
    monitor,
    anchor: ["top", "right"],
    child: Widget.Box({
      className: "notifications-window",
      css: "min-width: 1px; min-height: 1px;",
      vertical: true,
      child: list,
    }),
  });
};
