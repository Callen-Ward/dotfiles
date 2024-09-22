import { icons, setIconProps } from "icons";

// TODO: make this work for multi-monitor setups
const hyprland = await Service.import("hyprland");

export const Workspaces = (monitor = 0) =>
  Widget.Box({
    classNames: ["bar-widget", "workspaces"],
    children: Array.from({ length: 9 }, (_, i) => i + 1).map((i) =>
      Widget.Button({
        attribute: i,
        on_primary_click: () =>
          hyprland.messageAsync(`dispatch workspace ${i}`),
        className: hyprland.active.workspace
          .bind("id")
          .transform((active_id) => (active_id === i ? "active" : "")),

        child: Widget.Icon({
          setup: (self) =>
            self.hook(hyprland, () => {
              setIconProps(
                self,
                hyprland.getWorkspace(i)?.windows || 0 > 0
                  ? icons.workspaces.nonEmpty
                  : icons.workspaces.empty,
              );
            }),
        }),
      }),
    ),
  });
