import { makeIcon } from "icons";
import { icons } from "icons";
import { Notification } from "types/service/notifications";

const Icon = ({ app_entry, app_icon }) => {
  let icon = icons.notifications.card.placeholder.icon;
  if (Utils.lookUpIcon(app_icon)) icon = app_icon;

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Icon({
    className: "notification-icon",
    icon,
  });
};

const Image = (notification: Notification) => {
  if (notification.image === undefined || !notification.image.length)
    return Icon(notification);

  return Widget.Box({
    className: "notification-image",
    css: `background-image: url("${notification.image}")`,
  });
};

const Header = (notification: Notification) => {
  return Widget.Box({
    className: "notification-card-header",
    hpack: "start",
    children: [
      Widget.Label({
        className: "notification-card-summary",
        label: notification.summary,
      }),
      Widget.Label({
        className: "notification-card-timestamp",
        label: new Date().toTimeString().slice(0, 5),
      }),
    ],
  });
};

const Body = (notification: Notification) => {
  return Widget.Label({
    hpack: "start",
    label: notification.body,
  });
};

const Action = (notification: Notification) => {
  if (notification.actions !== undefined && notification.actions.length > 0) {
    return Widget.Box({
      className: "notification-actions",
      children: notification.actions.map((action) => {
        return Widget.Button({
          on_primary_click: () => {
            if (action.id.includes("scriptAction:-")) {
              Utils.execAsync(
                `${action.id.replace("scriptAction:-", "")}`,
              ).catch((err) => console.error(err));
              notification.close();
            } else {
              notification.invoke(action.id);
            }
          },
          child: Widget.Box({
            child: Widget.Label({
              label: action.label,
              max_width_chars: 15,
              truncate: "end",
              wrap: true,
            }),
          }),
        });
      }),
    });
  }

  return Widget.Box();
};

const CloseButton = (notification: Notification) =>
  Widget.Box({
    className: "notification-close",
    hpack: "end",
    child: Widget.EventBox({
      on_primary_click: notification.close,
      child: makeIcon(icons.notifications.card.dismiss),
    }),
  });

export const NotificationCard = (notification: Notification) =>
  Widget.Box({
    attribute: notification.id,
    className: "notification-card",
    hpack: "end",
    children: [
      Widget.Box({
        vertical: true,
        children: [
          Widget.Box({
            children: [
              Image(notification),
              Widget.Box({
                vertical: true,
                className: "notification-content",
                children: [Header(notification), Body(notification)],
              }),
            ],
          }),
          Action(notification),
        ],
      }),
      CloseButton(notification),
    ],
  });
