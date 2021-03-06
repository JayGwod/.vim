# 国得杰的 vim 配置方案

总体的原则和思想是发挥 VIM 编辑器本身的功能和作用，插件的安装和使用要保持克制
（[How To Learn Vim: A Four Week Plan](https://medium.com/actualize-network/how-to-learn-vim-a-four-week-plan-cd8b376a9b85)）
，即使安装插件，也尽量不破坏 VIM 的固有操作逻辑。这样的好处是即使换了操作环境，
也能快速上手 VIM 而不会带来使用的不便。

## VIM 的版本要求

要想发挥本配置方案的全部潜力需要使用 VIM 8 以上版本，否则将不能使用 VIM 的真彩色
主题配色以及异步响应（ALE 插件需要用到）等机制。

### 颜色主题安装

```shell
git clone https://github.com/lifepillar/vim-solarized8.git \
    ~/.vim/pack/themes/opt/solarized8
```

### VIM 8 的安装方法

[Ubuntu下 VIM 的安装方法](http://tipsonubuntu.com/2016/09/13/vim-8-0-released-install-ubuntu-16-04/):

```shell
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
```

[MAC 下 VIM 的安装方法](https://www.zhihu.com/question/34113076/answer/112866522):

```shell
brew install vim --with-lua --with-override-system-vi
```

### PIP 依赖安装

这里安装的依赖主要与Python的语法检查与自动补全有关，虚拟环境下PIP包需要重新安装：

```shell
pip install autopep8
pip install isort
pip install yapf
pip install pylint
pip install pynvim
```

## VIM 的基本配置

- 配色方案：[solarized8_flat](https://github.com/lifepillar/vim-solarized8)
- 打开句法高亮：`syntax enable`
- 设置空格和制表符
- 设置自动缩进
- 打开行号
- 用 tab 在子文件夹中查找文件
- 将大写锁定键更改为 CTRL 并使用 CTRC C 退出插入模式

## Markdown 的配置方案

Markdown 的语法采用：
[GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/)

主要参考文章：

- [Vim 与 Markdown，实现键不离手](https://www.jianshu.com/p/fa8c56e1aa52)
- [玩转 vim 之文件操作篇[视频]](https://zhuanlan.zhihu.com/p/33153561)
- [玩转 vim 之分屏狂魔如何编辑多个文件[视频]](https://zhuanlan.zhihu.com/p/33710608)
- [vim + git，还可以这么玩[视频]](https://zhuanlan.zhihu.com/p/36756099)
- [Vimer 的心路历程--Python & Markdown](https://zhuanlan.zhihu.com/p/36900365)
- [vim 撸码必备插件之 autoformat 与 ale[视频]](https://zhuanlan.zhihu.com/p/34428176)
- [Vim 之代码异步检测插件 ALE -- 实时检查 verilog 等代码的正确性](https://segmentfault.com/a/1190000016405629)

### 格式调整

```vimscript
let g:ale_fixers = {
 \  'python': ['add_blank_lines_for_python_control_statements','autopep8','isort','yapf','remove_trailing_lines','trim_whitespace'],
 \  'markdown': ['prettier','remove_trailing_lines','trim_whitespace'],
 \}
```

通过如上配置后，就可以实现 python 格式或者 markdown 格式的自动调整（注意若没有反
应，请查看有没有安装相应软件，比如 markdown 的 prettier，需要自己去官网把它安装
了，ale 才会自动调用）。

### 语法检查

ale 的 linter 都要自己安装，还好系统一般都是有 gcc, python, gofmt 之类的。
markdown 的 linter 需要额外安装：`gem install mdl`

```vimscript
" only enable these linters
let g:ale_linters = {
\    'markdown': ['mdl']
\}
```

### 语法高亮

作为纯文本格式，如何在 Markdown 文档中快速找到所需要的内容，是影响 Markdown 编辑
体验的一个关键因素。作为最佳的状态，如果编辑时能提供和阅读时一样的排版或样式，那
么 Markdown 的编写就可以既高效又简洁美观了。因此，一个好的 Markdown 编辑器应该能
尽可能地减小 Markdown 作为标记语言与生俱来的编辑与阅读之间的割裂感。

语法高亮是一个比较好的折中的解决方案。试想，如果加粗、斜体等都使用粗体和斜体来高
亮，代码块、链接等都使用和渲染时差不多的样式来高亮，那么其实编辑和阅读也就差不多
都是那么回事了。至于说“折中”，是因为有部分流行的 Markdown 编辑器完全采用 所见即
所得 的方式，编辑时，输入一个文本后马上渲染为对应的 HTML 显示；对于这种做法，见
仁见智，但是我觉得和 Markdown 的设计理念背道而驰，可以说是另一个极端。

Vim 本来也支持 Markdown 的语法高亮，但是做得还不够好。我使
用[gabrielelana/vim-markdown](https://github.com/gabrielelana/vim-markdown)插件
来增强高亮。

### 大纲

大纲有助于写文章时能时刻抓住文章的结构，对文章有一个整体的控制。

对于 Vimer 来说，提到大纲，估计第一反应就是大名鼎鼎
的[majutsushi/tagbar](https://github.com/majutsushi/tagbar)但是，该插件默认是不
支持 Markdown 的。

其实，主要产生 ctags 格式的输出，tagbar 就能渲染。网上已经有很多教程，例如只要添
加 markdown2ctags.py 就可以实现在 tagbar 中显示 Markdown 的大纲目录了。

### 渲染阅读

[iamcco/markdown-preview.vim](https://github.com/iamcco/markdown-preview.vim)是
一个同时支持 Windows, Linux 和 MacOS 的 Markdown 预览插件。通过以下配置，基本就
可以做到一个按键预览当前笔记了。

```
let g:mkdp_path_to_chrome="chrome"
let g:mkdp_auto_close=0
nmap <F7> <Plug>MarkdownPreview
nmap <F6> <Plug>StopMarkdownPreview
```

### 笔记管理

笔记管理直接使用插
件[scrooloose/nerdtree](https://github.com/scrooloose/nerdtree)即可。该插件还支
持收藏夹，可以对应到笔记本的概念。

## vim 的一般操作

### 分屏编辑多个文件

window 常用操作：

- `:split`横分屏
- `:vsplit`竖分屏
- `:split filepath`分屏打开文件

buffer 常用操作：

- `:buf 2` 第二个 buffer
- `:bn` 下一个 buffer
- `:bp` 上一个 buffer
- `:bd` 关闭当前 buffer

tab 常用操作：

- `:tabe` Open a new tab.
- `:tabe [file]` Open a new tab with [file].
- `:tabc` Close current tab.
- `gt` Move to next tab.
- `gT` Move to previous tab.

### vim + git

- [在 vim 里使用 git 命令](https://link.zhihu.com/?target=https%3A//github.com/tpope/vim-fugitive)
- [vim 里显示文件变动](https://link.zhihu.com/?target=https%3A//github.com/airblade/vim-gitgutter)
- [git commit 浏览器](https://link.zhihu.com/?target=https%3A//github.com/junegunn/gv.vim)

### 文件管理和查找

- [junegunn/vim-plug](https://github.com/junegunn/vim-plug): 插件管理，速度很快
  。推荐使用

- [vim-startify](https://github.com/mhinz/vim-startify): Vim 启动界面

- [ctrlp](https://github.com/kien/ctrlp.vim): 模糊搜索，快速定位文件

- [silversearcher](https://github.com/ggreer/the_silver_searcher): 一个快速的代
  码命令行搜索工具 ag

- [ag.vim](https://github.com/rking/ag.vim): 使用 ag 在 vim 里搜索内容

- [mattn/gist-vim](http://github.com/mattn/gist-vim): 将 gist 功能集成进 Vim 的
  插件 对于一些凌散，不成文的内容，可以先把放进 Vim，粗糙的整理一下然后放进
  gist（写 Todo，以免忘记后面要干啥）。
