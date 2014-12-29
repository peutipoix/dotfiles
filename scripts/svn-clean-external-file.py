# written by Thomas Watnedal
# http://stackoverflow.com/questions/239340/automatically-remove-subversion-unversioned-files

import os
import re

def removeall(path):
    if not os.path.isdir(path):
        os.remove(path)
        return
    files=os.listdir(path)
    for x in files:
        fullpath=os.path.join(path, x)
        if os.path.isfile(fullpath):
            os.remove(fullpath)
        elif os.path.isdir(fullpath):
            removeall(fullpath)
    os.rmdir(path)

unversionedRex = re.compile('^ ?[\?ID] *[1-9 ]*[a-zA-Z]* +(.*)')
for l in  os.popen('svn status --no-ignore -v').readlines():
    match = unversionedRex.match(l)
    if match: removeall(match.group(1))

