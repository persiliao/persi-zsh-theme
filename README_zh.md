# Persi Zsh Theme

[README](/README.md "README") | [中文文档](/README_zh.md "中文文档")

---

## 特性 [可选]

- 添加插件 zsh_reload wd git gitignore git-flow git-flow-avh docker npm node golang wp-cli composer yarn
- 一些常用的Alias Commands

## 依赖

- zsh
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh "oh-my-zsh")

## 安装 

```sh
$ git clone --depth=1 https://github.com/persiliao/persi-zsh-theme.git
$ cd persi-zsh-theme
$ ./install_persi.zsh
$ omz reload
```

## Alias Commands

| Alias      | Command                                             | Example                              |
|:-----------|:----------------------------------------------------|:-------------------------------------|
| `gcmsg`    | `git commit -m`                                     | `gcmsg Updated README.md`            |
| `gcmsgd`   | `git commit --amend -m`                             | `gcmsgd Modify last commit message`  |
| `gacmsg`   | `git add . && git commit -m`                        | `gacmsg Add new feature`             |
| `gsurm`    | `git submodule update --recursive --remote --merge` |                                      |


| Alias                   | Example                                                        |
|:------------------------|:---------------------------------------------------------------|
| `showSystemVersion`     | `Display system version`                                       |
| `showPath`              | `Display Path`                                                 |
| `showCPUTopProcess`     | `Display the top 10 that the system occupies the most CPU`     |
| `showMemoryTopProcess`  | `Display the top 10 that the system occupies the most Memory`  |

## 效果预览
![效果预览](/screenshot.png)

## License

MIT License
