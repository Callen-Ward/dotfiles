import Icon from "types/widgets/icon";

App.addIcons(`${App.configDir}/assets`);

export const makeIcon = (icon: { icon: string; scaleFactor: number }) =>
  Widget.Icon({
    css: `font-size: ${icon.scaleFactor}em;`,
    icon: icon.icon,
  });

export const setIconProps = (
  thingy: Icon<unknown>,
  icon: { icon: string; scaleFactor: number },
) => {
  thingy.icon = icon.icon;
  thingy.css = `font-size: ${icon.scaleFactor}em;`;
};

export const icons = {
  menu: { icon: "my-nix-snowflake-symbolic", scaleFactor: 1 },
  workspaces: {
    nonEmpty: {
      icon: "fa-circle-dot-symbolic",
      scaleFactor: 1,
    },
    empty: {
      icon: "fa-circle-regular-symbolic",
      scaleFactor: 1,
    },
  },
  audio: {
    sink: {
      muted: {
        icon: "material-volume-off-symbolic",
        scaleFactor: 1.2,
      },
      low: {
        icon: "material-volume-down-symbolic",
        scaleFactor: 1.2,
      },
      high: { icon: "material-volume-up-symbolic", scaleFactor: 1.2 },
    },
    source: {
      muted: { icon: "material-mic-off-symbolic", scaleFactor: 1.2 },
      unmuted: { icon: "material-mic-symbolic", scaleFactor: 1.2 },
    },
  },
  notifications: {
    tray: {
      nonEmpty: {
        icon: "material-notifications-unread-symbolic",
        scaleFactor: 1.2,
      },
      empty: {
        icon: "material-notifications-symbolic",
        scaleFactor: 1.2,
      },
      clear: { icon: "material-close-symbolic", scaleFactor: 1.2 },
    },
    card: {
      placeholder: { icon: "my-nix-snowflake-symbolic", scaleFactor: 1 },
      dismiss: { icon: "material-close-symbolic", scaleFactor: 1.2 },
    },
  },
};

export const getSinkIcon = (isMuted: boolean | null, volume: number) => {
  if (isMuted) return icons.audio.sink.muted;

  return volume > 0.5 ? icons.audio.sink.high : icons.audio.sink.low;
};

export const getSourceIcon = (isMuted: boolean | null) =>
  isMuted ? icons.audio.source.muted : icons.audio.source.unmuted;
