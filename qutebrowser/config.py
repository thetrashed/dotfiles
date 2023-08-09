# Avoiding flake8 errors
c = c
config = config

# Load autoconfig.yml
config.load_autoconfig(False)

# Custom binds
config.bind("<Ctrl-j>", "download-open", mode="normal")
config.bind("M", "hint links spawn mpv {hint-url}", mode="normal")
c.bindings.key_mappings = {"<Alt>": "<Super>"}

# Adblocking
c.content.blocking.enabled = True
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt",
    "https://easylist.to/easylist/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://pgl.yoyo.org/adservers",
]
c.content.blocking.hosts.lists = [
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
]

# Minimizing fingerprinting
# https://wiki.archinlinux.org/title/qutebrowser
c.content.headers.user_agent = (
    "Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0"
)
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = {
    "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
}
c.content.webgl = False
c.content.canvas_reading = True

c.content.javascript.clipboard = "access-paste"

c.content.dns_prefetch = False
c.content.geolocation = False

# Startup stuff
c.url.default_page = "https://duckduckgo.com/"
c.url.start_pages = ["https://news.ycombinator.com/news"]
c.url.searchengines = {"DEFAULT": "https://duckduckgo.com/?q={}"}

c.auto_save.session = True
c.auto_save.interval = 60000  # 1 minute

# Cookies and Protocol handling
config.set("content.cookies.accept", "no-3rdparty")
config.set("content.cookies.accept", "all", "*://drive.google.com/*")
config.set(
    "content.register_protocol_handler", False, "https://mail.proton.me#mailto=%25s"
)

# Misc stuff
c.content.autoplay = False
c.content.pdfjs = False
c.content.notifications.enabled = False
c.statusbar.show = "in-mode"
c.completion.show = "auto"

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
