import { AvailableDevicesSubsection } from "./AvailableDevicesSubsection";
import { DeviceType } from "../DeviceType";

export const AvailableDevices = () =>
  Widget.Box({
    classNames: ["menu-section", "available-devices"],
    vertical: true,
    children: [
      Widget.Label({
        className: "menu-section-heading",
        label: "Sinks",
        hpack: "start",
      }),
      AvailableDevicesSubsection(DeviceType.Sink),
      Widget.Box({
        className: "menu-subsection-divider",
      }),
      Widget.Label({
        className: "menu-section-heading",
        label: "Sources",
        hpack: "start",
      }),
      AvailableDevicesSubsection(DeviceType.Source),
    ],
  });
