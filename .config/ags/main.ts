import { Bar } from "./modules/bar/Bar";
import { AudioMenu } from "./modules/menus/audio/AudioMenu";
import { NotificationMenu } from "./modules/menus/notification/NotificationMenu";
import { Notifications } from "./modules/notifications/Notifications";

const scss = `${App.configDir}/scss/main.scss`;
const css = `/tmp/ags-style.css`;
Utils.exec(`sassc ${scss} ${css}`);

App.config({
  windows: [Bar(0), AudioMenu(), NotificationMenu(), Notifications(0)],
  style: css,
});
