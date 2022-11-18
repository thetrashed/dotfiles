#!/bin/env python3
import os
import json
import subprocess
import lz4.block


open_tabs = subprocess.getoutput('ls -t ~/.mozilla/firefox*/*/sessionstore-backups/recovery.jsonlz4 | sed q')

with open(open_tabs, "rb") as f:
    magic = f.read(8)
    jdata = json.loads(lz4.block.decompress(f.read()).decode("utf-8"))

tabs = []
for win in jdata["windows"]:
    for tab in win["tabs"]:
        i = int(tab["index"]) - 1
        urls = tab["entries"][i]["url"]
        if ("serx.ml" in urls):
            continue
        tabs.append(urls)

with open(os.path.join(os.path.expanduser('~'), '.open_tabs.txt'), 'w') as f:
    f.write('\n'.join(tabs))
