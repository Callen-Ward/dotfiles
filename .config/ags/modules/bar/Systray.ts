const systemtray = await Service.import("systemtray");

const SysTrayItem = (item) =>
  Widget.Button({
    child: Widget.Icon().bind("icon", item, "icon"),
    tooltipMarkup: item.bind("tooltip_markup"),
    onPrimaryClick: (_, event) => item.activate(event),
    onSecondaryClick: (_, event) => item.openMenu(event),
  });

export const SysTray = () =>
  Widget.Box({
    classNames: ["bar-widget", "systray"],
    children: systemtray.bind("items").as((i) => i.map(SysTrayItem)),
  });
