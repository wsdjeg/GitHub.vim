### GitHub-api.vim
[![Build Status](https://travis-ci.org/wsdjeg/GitHub-api.vim.svg?branch=master)](https://travis-ci.org/wsdjeg/GitHub-api.vim)
[![Version 0.1.2](https://img.shields.io/badge/version-0.1.1-yellow.svg?style=flat-square)](https://github.com/wsdjeg/GitHub-api.vim/releases) 
[![Support Vim 7.4 or above](https://img.shields.io/badge/support-%20Vim%207.4%20or%20above-yellowgreen.svg?style=flat-square)](https://github.com/vim/vim-win32-installer)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![Doc](https://img.shields.io/badge/doc-%3Ah%20githubapi-orange.svg?style=flat-square)](doc/githubapi.txt) 
[![Powered by vital.vim](https://img.shields.io/badge/powered%20by-vital.vim-80273f.svg?style=flat-square)](https://github.com/vim-jp/vital.vim)

an impl of github v3 api via viml.

#### [Intro](#intro-1)
#### [Activity](#activity-2)
#### [Gist](#gist-3)
#### [Activity](#activity-4)
#### [Gists](#gists-5)
#### [Git Data](#git_date-6)
#### [Issues](#issues-7)
- [Assignees](#assignees)
 - [List assignees](#list-assignees)
 - [Check assignee](#check-assignees)
 - [Add assignees to an Issue](#add-assignees-to-an-issue)
 - [Remove assignees from an Issue](#remove-assignees-from-an-issue)

#### [Migration](#migration-8)
#### [Miscellaneous](#miscellaneous-9)
#### [Organizations](#organizations-10)
#### [Pull Requests](#pull_requests-11)
#### [Reactions](#reactions-12)
#### [Repositories](#repositories-13)
#### [Search](#search-14)
#### [Users](#users-15)
#### [Enterprise](#enterprise-16)


### Issues
- List all issues assigned to the authenticated user across all
visible repositories including owned repositories, member
repositories, and organization repositories:
```
    githubapi#issues#List_All(user,password)
```
- List all issues across owned and member repositories assigned
to the authenticated user:
```
    githubapi#issues#List_All_for_User(user,password)
```
- List all issues for a given organization assigned to the
authenticated user:
```
    githubapi#issues#List_All_for_User_In_Org(org,user,password)
```
- List issues for a repository:
```
    githubapi#issues#List_All_for_Repo(owner,repo)
```
- Get a single issue:
```
    githubapi#issues#Get_issue(owner,repo,num)
```
- Create an issue:
```
    {
        "title": "Found a bug",
        "body": "I'm having a problem with this.",
        "assignee": "octocat",
        "milestone": 1,
        "labels": [
            "bug"
        ]
    }
    githubapi#issues#Create(owner,repo,user,password,json)
```
- Edit an issue:
```
    githubapi#issues#Edit(owner,repo,num,user,password,json)
```
- Lock an issue:
```
    githubapi#issues#Lock(owner,repo,num,user,password)
```
- Unlock an issue:
```
    githubapi#issues#Unlock(owner,repo,num,user,password)
```
#### assignees
##### list-assignees
##### check-assignees
##### add-assignees-to-an-issue
##### remove-assignees-from-an-issue
