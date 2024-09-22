import { ActiveDevicesSubsection } from "./ActiveDevicesSubsection";
import { DeviceType } from "../DeviceType";

export const ActiveDevices = () =>
  Widget.Box({
    className: "menu-section",
    vertical: true,
    children: [
      Widget.Label({
        className: "menu-section-heading",
        hpack: "start",
        label: "Volume",
      }),
      ActiveDevicesSubsection(DeviceType.Sink),
      Widget.Box({
        className: "menu-subsection-divider",
      }),
      ActiveDevicesSubsection(DeviceType.Source),
    ],
  });
