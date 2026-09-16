// ============================================================
// Fedora Slate — iteration 2
//
// TOP BAR:
// [launcher] [pager dots] .... [ Tue 09:08 ] .... [tray]
//
// BOTTOM:
// centered autohiding app dock
//
// WARNING: removes all existing Plasma panels.
// ============================================================


// ---------- helpers ----------

function widgetExists(type) {
    return knownWidgetTypes.includes(type);
}

function addWidget(panel, type) {
    if (!widgetExists(type)) {
        print("Widget not installed: " + type);
        return null;
    }

    return panel.addWidget(type);
}


// ---------- remove existing panels ----------

const oldPanels = [...panelIds];

for (const id of oldPanels) {
    const panel = panelById(id);

    if (panel) {
        panel.remove();
    }
}


// ============================================================
// TOP BAR
// ============================================================

const top = new Panel();

top.location = "top";
top.height = 30;

top.lengthMode = "fill";
top.alignment = "center";
top.hiding = "none";


// ---------- left side ----------

// Application launcher
const launcher = addWidget(
    top,
    "org.kde.plasma.kickoff"
);


// Pager Dots
//
// We try a few plausible plugin IDs because third-party plasmoid
// IDs don't always match their display name.
//
// If none are installed, fall back to Plasma's normal pager.

const pagerCandidates = [
    "pat.pagerdots",
    "com.github.patruxs.pagerdots",
    "org.kde.plasma.pagerdots",
    "pagerdots"
];

let pager = null;

for (const type of pagerCandidates) {
    if (widgetExists(type)) {
        pager = top.addWidget(type);
        print("Using pager: " + type);
        break;
    }
}

if (!pager) {
    print("Pager Dots not found. Falling back to stock pager.");
    pager = addWidget(
        top,
        "org.kde.plasma.pager"
    );
}


// ============================================================
// CENTER CLOCK
// ============================================================

// Flexible spacer
const leftSpacer = addWidget(
    top,
    "org.kde.plasma.panelspacer"
);


// Clock
const clock = addWidget(
    top,
    "org.kde.plasma.digitalclock"
);

if (clock) {
    clock.currentConfigGroup = ["Appearance"];

    // 24h time
    clock.writeConfig("use24hFormat", 2);

    // No seconds
    clock.writeConfig("showSeconds", false);

    // Show day/date alongside time
    clock.writeConfig("showDate", true);
    clock.writeConfig("dateDisplayFormat", "BesideTime");

    // Keep date compact
    clock.writeConfig("dateFormat", "custom");
    clock.writeConfig("customDateFormat", "ddd");

    clock.reloadConfig();
}


// Flexible spacer
const rightSpacer = addWidget(
    top,
    "org.kde.plasma.panelspacer"
);


// ============================================================
// RIGHT SIDE
// ============================================================

const tray = addWidget(
    top,
    "org.kde.plasma.systemtray"
);


// ============================================================
// BOTTOM DOCK
// ============================================================

const dock = new Panel();

dock.location = "bottom";
dock.height = 52;

dock.lengthMode = "fit";
dock.alignment = "center";
dock.offset = 0;

dock.hiding = "autohide";


// Icons-only Task Manager
const tasks = addWidget(
    dock,
    "org.kde.plasma.icontasks"
);


// ============================================================
// APPLY
// ============================================================

top.reloadConfig();
dock.reloadConfig();

print("Fedora Slate iteration 2 applied.");
