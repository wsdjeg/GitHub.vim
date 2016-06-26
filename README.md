### GitHub-api.vim
[![Build Status](https://travis-ci.org/wsdjeg/GitHub-api.vim.svg?branch=master)](https://travis-ci.org/wsdjeg/GitHub-api.vim)
[![Gitter](https://badges.gitter.im/wsdjeg/GitHub-api.vim.svg)](https://gitter.im/wsdjeg/GitHub-api.vim?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Version 0.1.2](https://img.shields.io/badge/version-0.1.1-yellow.svg?style=flat-square)](https://github.com/wsdjeg/GitHub-api.vim/releases)
[![Support Vim 7.4 or above](https://img.shields.io/badge/support-%20Vim%207.4%20or%20above-yellowgreen.svg?style=flat-square)](https://github.com/vim/vim-win32-installer)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![Doc](https://img.shields.io/badge/doc-%3Ah%20githubapi-orange.svg?style=flat-square)](doc/githubapi.txt)
[![Powered by vital.vim](https://img.shields.io/badge/powered%20by-vital.vim-80273f.svg?style=flat-square)](https://github.com/vim-jp/vital.vim)
#### [Intro](#intro-1)
#### [Activity](#activity-2)
- [Events](#events)
 - [List public events](#list-public-events)
 - [List repository events](#list-repository-events)
 - [List issue events for a repository](#list-issue-events-for-a-repository)
 - [List public events for a network of repositories](#list-public-events-for-a-network-of-repositories)
 - [List public events for an organization](#list-public-events-for-an-organization)
 - [List events that a user has received](#list-events-that-a-user-has-received)
 - [List public events that a user has received](#list-public-events-that-a-user-has-received)
 - [List events performed by a user](#list-events-performed-by-a-user)
 - [List public events performed by a user](#list-public-events-performed-by-a-user)
 - [List events for an organization](#list-events-for-an-organization)
- [Notifications](#notifications)
 - [Notification Reasons](#notification-Reasons)
 - [List your notifications](#list-your-notifications)
 - [List your notifications in a repository](#list-your-notifications-in-a-repository)
 - [Mark as read](#mark-as-read)
 - [Mark notifications as read in a repository](#mark-notifications-as-read-in-a-repository)
 - [View a single thread](#view-a-single-thread)
 - [Mark a thread as read](#mark-a-thread-as-read)
 - [Get a Thread Subscription](#get-a-Thread-Subscription)
 - [Set a Thread Subscription](#set-a-Thread-Subscription)
 - [Delete a Thread Subscription](#delete-a-Thread-Subscription)
- [Starring](#starring)
 - [List Stargazers](#list-stargazers)
 - [List repositories being starred](#list-repositories-being-starred)
 - [Check if you are starring a repository](#check-if-you-are-starring-a-repository)
 - [Star a repository](#star-a-repository)
 - [Unstar a repository](#unstar-a-repository)
- [Watching](#watching)
 - [List watchers](#list watchers)
 - [List repositories being watched](#list repositories being watched)
 - [Get a Repository Subscription](#get a Repository Subscription)
 - [Set a Repository Subscription](#set a Repository Subscription)
 - [Delete a Repository Subscription](#delete a Repository Subscription)
 - Check if you are watching a repository (LEGACY)
 - Watch a repository (LEGACY)
 - Stop watching a repository (LEGACY)

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
- [Comments](#comments)
 - [List comments on an issue](#list-comments-on-an-issue)
 - [List comments in a repository](#list-comments-in-a-repository)
 - [Get a single comment](#get-a-single-comment)
 - [Create a comment](#create-a-comment)
 - [Edit a comment](#edit-a-comment)
 - [Delete a comment](#delete-a-comment)
 - [Custom media types](#custom-media-types)
- [Events](#events)
 - [List events for an issue](#List-events-for-an-issue)
 - [List events for a repository](#List-events-for-a-repository)
 - [Get a single event](#Get-a-single-event)

#### [Migration](#migration-8)
#### [Miscellaneous](#miscellaneous-9)
#### [Organizations](#organizations-10)
#### [Pull Requests](#pull_requests-11)
#### [Reactions](#reactions-12)
#### [Repositories](#repositories-13)
#### [Search](#search-14)
#### [Users](#users-15)
#### [Enterprise](#enterprise-16)

### Intro
This is a viml library to access the Github API v3. With it, you can manage
Github resources (repositories, user profiles, organizations, etc.) from viml
scripts.

It is WIP, it will covers the full API.

Should you have any question, any remark, or if you find a bug, or if there is
something you can do with the API but not with Github-api.vim, please open an issue.

### Activity
#### Event
##### List public events
```
    githubapi#activity#List_events()
```
##### List repository events
```
    githubapi#activity#List_repo_events(owner,repo)
```
##### List issue events for a repository
##### List public events for a network of repositories
```
    githubapi#activity#List_net_events(owner,repo)
```
##### List public events for an organization
```
    githubapi#activity#List_org_events(org)
```
##### List events that a user has received
```
    githubapi#activity#List_user_events(user)
```
##### List public events that a user has received
```
    githubapi#activity#List_public_user_events(user)
```
##### List events performed by a user
```
    githubapi#activity#Performed_events(user)
```
##### List public events performed by a user
```
    githubapi#activity#Performed_events(user)
```
##### List events for an organization
```
    githubapi#activity#List_user_org_events(user,org,password)
```
#### Notifications
##### Notification Reasons
##### List your notifications
```
    githubapi#activity#List_notifications(user,password)
```
##### List your notifications in a repository
```
    githubapi#activity#List_notifications_for_repo(onwer,repo,user,password)
```
##### Mark as read
```
    githubapi#activity#Mark_All_as_read(user,password,last_read_at)
```
##### Mark notifications as read in a repository
```
    githubapi#activity#Mark_All_as_read_for_repo(owner,repo,user,password,last_read_at)
```
##### View a single thread
```
    githubapi#activity#Get_thread(id,user,password)
```
##### Mark a thread as read
```
    githubapi#activity#Mark_thread(id,user,password)
```
##### Get a Thread Subscription
```
    githubapi#activity#Get_thread_sub(id,user,password)
```
##### Set a Thread Subscription
```
    githubapi#activity#Set_thread_sub(id,user,password,subscribed,ignored)
```
##### Delete a Thread Subscription
```
    githubapi#activity#Del_thread_sub(id,user,password)
```
#### Starring
##### List Stargazers
##### List repositories being starred
##### Check if you are starring a repository
##### Star a repository
##### Unstar a repository

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
This call lists all the available assignees to which issues may be assigned.
```
    githubapi#issues#List_assignees(owner,repo)
```
##### check-assignees
```
    githubapi#issues#Check_assignee(owner,repo,assignee)
```
##### add-assignees-to-an-issue
```
    githubapi#issues#Addassignee(owner,repo,num,assignees,user,password)
```
##### remove-assignees-from-an-issue
```
    githubapi#issues#Removeassignee(owner,repo,num,assignees,user,password)
```
#### Comments
##### List comments on an issue
```
    githubapi#issues#List_comments(owner,repo,num,since)
```
##### List comments in a repository
```
    githubapi#issues#List_All_comments(owner,repo,sort,desc,since)
```
##### Get a single comment
```
    githubapi#issues#Get_comment(owner,repo,id)
```
##### Create a comment
```
    githubapi#issues#Create_comment(owner,repo,num,json,user,password)
```
##### Edit a comment
```
    githubapi#issues#Edit_comment(owner,repo,id,json,user,password)
```
##### Delete a comment
```
    githubapi#issues#Delete_comment(owner,repo,id,user,password)
```
##### Custom media types
#### Events
##### List events for an issue
```
    githubapi#issues#List_events(owner,repo,num)
```
##### List events for a repository
```
    githubapi#issues#List_events_for_repo(owner,repo)
```
##### Get a single event
```
    githubapi#issues#Get_event(owner,repo,id)
```
