import { DropdownMenu } from "../DropdownMenu";
import { ActiveDevices } from "./active/ActiveDevices";
import { AvailableDevices } from "./available/AvailableDevices";

export const AudioMenu = () => {
  return DropdownMenu({
    name: "audiomenu",
    child: Widget.Box({
      className: "menu-contents",
      vertical: true,
      children: [ActiveDevices(), AvailableDevices()],
    }),
  });
};
