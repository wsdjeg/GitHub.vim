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

[![Throughput Graph](https://graphs.waffle.io/wsdjeg/GitHub.vim/throughput.svg)](https://waffle.io/wsdjeg/GitHub.vim/metrics/throughput)

Should you have any question, any remark, or if you find a bug, or if there is
something you can do with the API but not with Github-api.vim, please open an issue.

## Install

It is easy to install the lib via vim plugin manager:

```vim
call dein#add('wsdjeg/GitHub.vim')
```

## Usage

