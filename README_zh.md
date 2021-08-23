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
$ source ~/.zshrc
```

## Alias Commands

#### git

- **gcmsg** git commit -m 

- **gacmsg** git add . && git commit -m

- **gacp** git add . && git commit -m message && git pull origin current branch && git push origin current branch

- **gsa** git submodule add

- **gsui** git submodule update --init --recursive

- **gsurm** git submodule update --recursive --remote --merge

- **ggplsurm** git pull origin $(git_main_branch) && git submodule update --recursive --remote --merge

- **ggpushall** git push all remote



#### system

- **showSystemVersion** Display system version

- **showPath** Display Path

- **showCPUTopProcess** Display the top 10 that the system occupies the most CPU

- **showMemoryTopProcess** Display the top 10 that the system occupies the most Memory


## 效果预览
![效果预览](/screenshot.png)

## License

MIT License