git submodule init --update

设置vimrc
1. linux下创建~/.vimrc, windows下创建~/_vimrc, 输入以下内容：
    source ~/vimfiles/.vimrc

2. 编辑.vimrc, 根据操作系统改变mysys 的返回值，"linux"或者"windows"。

3. 编译command_T.
   linux: 
    cd bundle/commandT/ruby/command_t/
    ruby extconf.rb
    make & make install

   windows:
    (a) Install DevKit
        Install the latest DevKit. The latest one, not the one listed on GitHub downloads.
        http://github.com/downloads/oneclick/rubyinstaller/DevKit-tdm-32-4.5.1-20101214-1400-sfx.exe 
        I extracted DevKit into C:\Ruby192\DevKit\, then cd C:\Ruby192\DevKit\ and ran the perscribed ruby dk.rb init and ruby dk.rb install

    (b) This may not be required, but I did it just for giggles. In your _vimrc add this:
        let s:ruby_path = 'C:\Ruby192\bin'
        let g:ruby_path = 'C:\Ruby192\bin'
        Just to make sure you have a Gvim with a working ruby, issue this Gvim command: : ruby 1
        If you get an error, then lord knows. :-)

    (c) Open the “Start Command Prompt With Ruby” in your Start menu program group for Ruby
        In that new prompt, load the DevKit vars: C:\Ruby192\DevKit\devkitvars.bat
        Go to the makefile: cd yourvimfiles\plugins\ruby\command-t
        Run the config: ruby extconf.rb
        make and make install
        Good luck!



