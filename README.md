# Persi Zsh Theme

[README](/README.md "README") | [中文文档](/README_zh.md "中文文档")

---

## Features [Optional]

- added plugin zsh_reload wd git gitignore git-flow git-flow-avh docker npm node golang wp-cli composer yarn
- Some commonly used aliases

## Require

- zsh
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh "oh-my-zsh")

## Installation 

```sh
$ git clone --depth=1 https://github.com/persiliao/persi-zsh-theme
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

- **showCPUTopProcess** Display the top 10 that the system occupies the most CPU
- **showMemoryTopProcess** Display the top 10 that the system occupies the most Memory

  

## Preview
![Preview](/screenshot.png)

## License

**MIT License**

## Support

![Jetbrains](https://github.com/persiliao/static-resources/blob/master/jetbrains-logos/jetbrains-variant-4.svg)