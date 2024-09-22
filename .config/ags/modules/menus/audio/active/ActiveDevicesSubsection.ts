const audio = await Service.import("audio");
import { getSinkIcon, getSourceIcon, setIconProps } from "icons";
import { DeviceType } from "../DeviceType";

export const ActiveDevicesSubsection = (deviceType: DeviceType) => {
  const deviceStream =
    deviceType === DeviceType.Sink ? audio.speaker : audio.microphone;

  const deviceString =
    deviceType === DeviceType.Sink ? "speaker" : "microphone";

  const getIcon = deviceType === DeviceType.Sink ? getSinkIcon : getSourceIcon;

  return Widget.Box({
    className: "active-audio-device-box",
    children: [
      Widget.Button({
        className: "volume-mute",
        vpack: "end",
        on_primary_click: () =>
          (deviceStream.is_muted = !deviceStream.is_muted),
        child: Widget.Icon({
          setup: (self) =>
            self.hook(audio, () =>
              setIconProps(
                self,
                getIcon(deviceStream.is_muted, deviceStream.volume),
              ),
            ),
        }),
      }),

      Widget.Box({
        vertical: true,
        children: [
          Widget.Label({
            hpack: "start",
            truncate: "end",
            label: audio.bind(deviceString).as((v) => v.description || ""),
          }),
          Widget.Slider({
            value: deviceStream.bind("volume"),
            className: "menu-slider",
            draw_value: false,
            min: 0,
            max: 1,
            onChange: ({ value }) => (deviceStream.volume = value),
          }),
        ],
      }),

      Widget.Label({
        className: "volume-percent-active",
        vpack: "end",
        xalign: 1,
        label: deviceStream.bind("volume").as((v) => `${Math.round(v * 100)}%`),
      }),
    ],
  });
};
