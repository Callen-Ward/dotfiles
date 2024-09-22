import { getSinkIcon, icons, setIconProps } from "icons";
import { openMenu } from "./utils";
import Gdk from "types/@girs/gdk-3.0/gdk-3.0";

const audio = await Service.import("audio");

export const Volume = () =>
  Widget.Button({
    classNames: ["bar-widget", "volume"],
    child: Widget.Box({
      children: [
        Widget.Box({
          child: Widget.Icon({
            setup: (self) =>
              self.hook(audio, () =>
                setIconProps(
                  self,
                  getSinkIcon(audio.speaker.is_muted, audio.speaker.volume),
                ),
              ),
          }),
        }),
        Widget.Label({
          label: audio.speaker
            .bind("volume")
            .as((v) => Math.round(v * 100).toString() + "%"),
        }),
      ],
    }),
    on_primary_click: (clicked: any, event: Gdk.Event) => {
      openMenu(clicked, event, "audiomenu");
    },
  });
