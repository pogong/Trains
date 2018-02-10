#!/usr/bin/env python
# encoding:utf-8

import fileinput
import os
import sys


def push():
    print("push")

    os.system("git status")
    cm = raw_input("commit: ")
    add = "git add ."
    cm = "git commit -m '%s'" % cm
    push = "git push origin master"
    os.system(add)
    os.system(cm)
    os.system(push)
    cmd()
    return

def push_tag():
    print("tag")
    tag = raw_input("tag: ")
    os.system("git tag %s" %tag)
    os.system("git push --tags")
    cmd()
    return

def repo_push():
    #pod repo push O2Specs KWWorkRecordComponent.podspec  --allow-warnings
    print("repo")
    print("repo in")
    dir = os.getcwd()
    ilist = os.listdir(dir)
    for i in ilist:
        if i.endswith(".podspec"):
            podspec = i
            break
    specs = "O2Specs" #需要手动修改
    repo_push = "pod repo push %s %s --allow-warnings --verbose --use-libraries" %(specs,podspec)
    os.system(repo_push)
    cmd()
    return
def check():
    sources = "https://git.coding.net/pogong/O2Specs.git,https://github.com/CocoaPods/Specs"#远程仓库地址
    # pod lib lint --sources='' --allow-warnings
    os.system("pod lib lint --sources='%s' --allow-warnings --verbose --use-libraries" %sources)
    cmd()
    return

def cmd():
    command = raw_input("CMD: ")
    print("command: %s" %command)
    if command == "push" :
        push()
        print("pushasadas")
    elif command == "tag":
        push_tag()
    elif command == "exit":
        sys.exit()
    elif command == "repo":
        repo_push()
    elif command == "check":
        check()
    else:
        print("请输入:'push','tag','repo','check','exit'")
        cmd()
    return

cmd()
