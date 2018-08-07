import os 
import sys

import glob

StorageClasses = ("class", "struct", "protocol", "enum")

header = """
import Foundation
import UIKit

"""

def extractFile(filename):
    f = open(filename, "r")
    groups = []
    names = []
    gi = -1
    mode = 0
    brace = 0
    for line in f.readlines():
        brace += line.count("{")
        brace -= line.count("}")
        if mode == 0:
            for sc in StorageClasses:
                if line.strip().startswith(sc):
                    gi = len(groups)
                    groups.append([])
                    groups[gi].append(line)
                    names.append(line[len(sc):line.find(':')].strip())
                    mode = 1
                    break
        elif mode == 1:
            groups[gi].append(line)
            if brace == 0:
                gi = -1 
                mode = 0
    classes = []
    for group in groups:
        classes.append("".join(group))
    return zip(names, classes)

if __name__ == "__main__":
    files = []
    for file in os.listdir(sys.argv[1]):
        if file.endswith(".swift"):
            if file == "AppDelegate.swift": continue
            files.append((file, extractFile(file)))
    for filename, file in files:
        folder = filename[:filename.index(".")]
        if not os.path.isdir(folder):
            os.mkdir(folder)
        for name, cls in file:
            f = open(os.path.join(folder, name + ".swift"), "w")
            f.write(header)
            f.write(cls)
            f.close()


