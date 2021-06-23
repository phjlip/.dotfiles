# type: ignore

# config.load_autoconfig(False)

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.content.notifications.enabled = False
c.url.start_pages = ["google.com"]
c.url.searchengines = {"DEFAULT": "https://www.google.com/search?q={}",
                        "ddg": "https://duckduckgo.com/?q={}"}
c.auto_save.session = True

config.bind("<space>sl" , "set-cmd-text -s :session-load", mode="normal")
config.bind("<space>ss" , "set-cmd-text -s :session-save", mode="normal")
