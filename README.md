# GitHub.vim
> Another github v3 api implemented in viml

[![Build Status](https://travis-ci.org/wsdjeg/GitHub.vim.svg?branch=master)](https://travis-ci.org/wsdjeg/GitHub.vim)
[![Gitter](https://badges.gitter.im/wsdjeg/GitHub.vim.svg)](https://gitter.im/wsdjeg/GitHub.vim?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)
[![Version 0.1.2](https://img.shields.io/badge/version-0.1.1-yellow.svg?style=flat-square)](https://github.com/wsdjeg/GitHub.vim/releases)
[![Support Vim 7.4 or above](https://img.shields.io/badge/support-%20Vim%207.4%20or%20above-yellowgreen.svg?style=flat-square)](https://github.com/vim/vim-win32-installer)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](LICENSE)
[![Doc](https://img.shields.io/badge/doc-%3Ah%20github-orange.svg?style=flat-square)](doc/github.txt)

## Intro
This is a viml library to access the Github API v3. With it, you can manage
Github resources (repositories, user profiles, organizations, etc.) from viml
scripts.

It is WIP, it will covers the full API.

Should you have any question, any remark, or if you find a bug, or if there is
something you can do with the API but not with Github-api.vim, please open an issue.

## Activity

### Event

#### List public events

```
    github#api#activity#List_events()
```

##### List repository events

```
    github#api#activity#List_repo_events(owner,repo)
```

##### List issue events for a repository

##### List public events for a network of repositories
```
    github#api#activity#List_net_events(owner,repo)
```
##### List public events for an organization
```
    github#api#activity#List_org_events(org)
```
##### List events that a user has received
```
    github#api#activity#List_user_events(user)
```
##### List public events that a user has received
```
    github#api#activity#List_public_user_events(user)
```
##### List events performed by a user
```
    github#api#activity#Performed_events(user)
```
##### List public events performed by a user
```
    github#api#activity#Performed_events(user)
```
##### List events for an organization
```
    github#api#activity#List_user_org_events(user,org,password)
```
#### Notifications
##### Notification Reasons
##### List your notifications
```
    github#api#activity#List_notifications(user,password)
```
##### List your notifications in a repository
```
    github#api#activity#List_notifications_for_repo(onwer,repo,user,password)
```
##### Mark as read
```
    github#api#activity#Mark_All_as_read(user,password,last_read_at)
```
##### Mark notifications as read in a repository
```
    github#api#activity#Mark_All_as_read_for_repo(owner,repo,user,password,last_read_at)
```
##### View a single thread
```
    github#api#activity#Get_thread(id,user,password)
```
##### Mark a thread as read
```
    github#api#activity#Mark_thread(id,user,password)
```
##### Get a Thread Subscription
```
    github#api#activity#Get_thread_sub(id,user,password)
```
##### Set a Thread Subscription
```
    github#api#activity#Set_thread_sub(id,user,password,subscribed,ignored)
```
##### Delete a Thread Subscription
```
    github#api#activity#Del_thread_sub(id,user,password)
```
#### Starring
##### List Stargazers
```
    github#api#activity#List_stargazers(owner,repo)
```
##### List repositories being starred
##### Check if you are starring a repository
```
    github#api#activity#CheckStarred(owner,repo,user,password)
```
##### Star a repository
```
    github#api#activity#Star(owner,repo,user,password)
```
##### Unstar a repository
```
    github#api#activity#Unstar(owner,repo,user,password)
```
#### Watching
##### List watchers
```
    github#api#activity#List_watchers(owner,repo)
```
##### List repositories being watched
List repositories being watched by a user.
```
    github#api#activity#List_watched_repo(user)
```
List repositories being watched by the authenticated user.
```
    github#api#activity#List_auth_watched_repo(user,password)
```
##### Get a Repository Subscription
```
    github#api#activity#Check_repo_Sub(owner,repo,user,password)
```
##### Set a Repository Subscription
```
    github#api#activity#Set_repo_sub(owner,repo,user,password,sub,ignore)
```
##### Delete a Repository Subscription
```
    github#api#activity#Del_repo_sub(owner,repo,user,password)
```
#### Gists
##### Authentication
##### Truncation
##### List a user's gists
```
    github#api#gist#List(user)
```
##### List a authenticated user's gists
```
    github#api#gist#ListAll(user,password)
```
##### List all public gists
```
    github#api#gist#ListPublic(since)
```
##### List starred gists
```
    github#api#gist#ListStarred(user,password,since)
```
##### Get a single gist
```
    github#api#gist#GetSingle(id)
```
##### Get a specific revision of a gist
```
    github#api#gist#GetSingleSha(id,sha)
```
##### Create a gist
```
    github#api#gist#Create(desc,filename,content,public,user,password)
```
##### Edit a gist
```
    github#api#gist#Edit(desc,filename,content,public,user,password,id)
```
##### List gist commits
```
    github#api#gist#ListCommits(id)
```
##### Star a gist
```
    github#api#gist#Star(user,password,id)
```
##### Unstar a gist
```
    github#api#gist#Unstar(user,password,id)
```
##### Check if a gist is starred
```
    github#api#gist#CheckStar(user,password,id)
```
##### Fork a gist
```
    github#api#gist#Fork(user,password,id)
```
##### List gist forks
```
    github#api#gist#ListFork(user,password,id)
```
##### Delete a gist
```
    github#api#gist#Del(user,password,id)
```
##### Custom media types
##### Comments
##### List comments on a gist
```
    github#api#gist#ListComments(id)
```
##### Get a single comment
```
    github#api#gist#GetComment(gistid,commentid)
```
##### Create a comment
```
    github#api#gist#CreateComment(id,user,password,body)
```
##### Edit a comment
```
    github#api#gist#EditComment(id,user,password,body)
```
##### Delete a comment
```
    github#api#gist#DelComment(gistid,id,user,password)
```
##### Custom media types
### Issues
- List all issues assigned to the authenticated user across all
visible repositories including owned repositories, member
repositories, and organization repositories:
```
    github#api#issues#List_All(user,password)
```
- List all issues across owned and member repositories assigned
to the authenticated user:
```
    github#api#issues#List_All_for_User(user,password)
```
- List all issues for a given organization assigned to the
authenticated user:
```
    github#api#issues#List_All_for_User_In_Org(org,user,password)
```
- List issues for a repository:
```
    github#api#issues#List_All_for_Repo(owner,repo)
```
- Get a single issue:
```
    github#api#issues#Get_issue(owner,repo,num)
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
    github#api#issues#Create(owner,repo,user,password,json)
```
- Edit an issue:
```
    github#api#issues#Edit(owner,repo,num,user,password,json)
```
- Lock an issue:
```
    github#api#issues#Lock(owner,repo,num,user,password)
```
- Unlock an issue:
```
    github#api#issues#Unlock(owner,repo,num,user,password)
```
#### assignees
##### list-assignees
This call lists all the available assignees to which issues may be assigned.
```
    github#api#issues#List_assignees(owner,repo)
```
##### check-assignees
```
    github#api#issues#Check_assignee(owner,repo,assignee)
```
##### add-assignees-to-an-issue
```
    github#api#issues#Addassignee(owner,repo,num,assignees,user,password)
```
##### remove-assignees-from-an-issue
```
    github#api#issues#Removeassignee(owner,repo,num,assignees,user,password)
```
#### Comments
##### List comments on an issue
```
    github#api#issues#List_comments(owner,repo,num,since)
```
##### List comments in a repository
```
    github#api#issues#List_All_comments(owner,repo,sort,desc,since)
```
##### Get a single comment
```
    github#api#issues#Get_comment(owner,repo,id)
```
##### Create a comment
```
    github#api#issues#Create_comment(owner,repo,num,json,user,password)
```
##### Edit a comment
```
    github#api#issues#Edit_comment(owner,repo,id,json,user,password)
```
##### Delete a comment
```
    github#api#issues#Delete_comment(owner,repo,id,user,password)
```
##### Custom media types
#### Events
##### List events for an issue
```
    github#api#issues#List_events(owner,repo,num)
```
##### List events for a repository
```
    github#api#issues#List_events_for_repo(owner,repo)
```
##### Get a single event
```
    github#api#issues#Get_event(owner,repo,id)
```
#### Labels
##### List all labels for this repository
```
    github#api#labels#GetAll(owner,repo)
```
##### Get a single label
```
    github#api#labels#Get(owner,repo,name)
```
##### Create a label
```
    github#api#labels#Create(owner,repo,user,password,label)
```
##### Update a label
```
    github#api#labels#Update(owner,repo,user,password,label)
```
##### Delete a label
```
    github#api#labels#Delete(owner,repo,name,user,password)
```
##### List labels on an issue
```
    github#api#labels#List(owner,repo,num)
```
##### Add labels to an issue
```
    github#api#labels#Add(owner,repo,num,labels,user,password)
```
##### Remove a label from an issue
```
    github#api#labels#Remove(owner,repo,num,name,user,password)
```
##### Replace all labels for an issue
```
    github#api#labels#Replace(owner,repo,num,labels,user,password)
```
##### Remove all labels from an issue
```
    github#api#labels#RemoveAll(owner,repo,num,user,password)
```
##### Get labels for every issue in a milestone
```
    github#api#labels#ListAllinMilestone(owner,repo,num)
```
#### Milestones
##### List milestones for a repository
```
    github#api#issues#ListAllMilestones(owner,repo,state,sort,direction)
```
##### Get a single milestone
```
    github#api#issues#GetSingleMilestone(owner,repo,num)
```
##### Create a milestone
```
    github#api#issues#CreateMilestone(owner,repo,milestone,user,password)
```
##### Update a milestone
```
    github#api#issues#UpdateMilestone(owner,repo,num,milestone,user,password)
```
##### Delete a milestone
```
    github#api#issues#DeleteMilestone(owner,repo,num,user,password)
```
