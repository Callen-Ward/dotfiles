import { Stream } from "types/service/audio";
import { DeviceType } from "../DeviceType";
import { icons, makeIcon } from "icons";

const audio = await Service.import("audio");

const DeviceButton = (
  device: Stream,
  makeDefault: (device: Stream) => Stream,
  icon,
  deviceString: string,
) =>
  Widget.Button({
    on_primary_click: () => makeDefault(device),
    child: Widget.Box({
      children: [
        makeIcon(icon),
        Widget.Label({
          hpack: "start",
          truncate: "end",
          label: device.description,
        }),
      ],
    }),
    setup: (self) =>
      self.hook(audio, () => {
        if (audio[deviceString].id === device.id) {
          self.class_names = ["menu-button", "available-devices-active-device"];
        } else {
          self.class_names = ["menu-button"];
        }
      }),
  });

export const AvailableDevicesSubsection = (deviceType: DeviceType) => {
  const icon =
    deviceType == DeviceType.Sink
      ? icons.audio.sink.high
      : icons.audio.source.unmuted;

  const devicesString =
    deviceType === DeviceType.Sink ? "speakers" : "microphones";

  const deviceString =
    deviceType === DeviceType.Sink ? "speaker" : "microphone";

  const makeDefault =
    deviceType == DeviceType.Sink
      ? (device: Stream) => (audio.speaker = device)
      : (device: Stream) => (audio.microphone = device);

  return Widget.Box({
    className: "menu-subsection",
    vertical: true,
    children: audio
      .bind(devicesString)
      .as((devices) =>
        devices.map((device) =>
          DeviceButton(device, makeDefault, icon, deviceString),
        ),
      ),
  });
};
