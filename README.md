# kyutech-manual-note
note those small points that is meaningless but will cost lots of time...(like tool choosing, environment build)

On server, if you want to use java to program, please use intellij ide. Eclipse will need lots of packages to be installed, 
which cause endless error and conflict

java 自定义加载器，加载加密.class文件

put flatten.tcl into the same directory with xxxx.v file,
edit the third line: set design xxxx to the same name with xxxx.v file
run: dc_shell -64bit -f -flatten.tcl
got xxxx_flat.v & xxxx_flat.ddc files

as you don’t have reading rights on /home/stefan, you cannot see my files. But you have execution rights “x” which means you can access sub dirs.
chmod -R g+rw b17

 if you put the directory 16112011SAED_EDK90nm directly in ats17work/benchmarks, no need to adjust lib path in those .tcl files

 change rights to group can access:
 first
 chmod -R 775 xxxx
 then
 chmod -R g+s xxxx

 you can create a symbolic link in your home to make your life easier: ln -s /home/stefan/ats17work

 netlist: only has function logic connection information, no clock path, no position information
 syndft: insert scan chains, control max fan out of gates, until now, still no clock path. Just a moidified netlist

 chmod g+s may not work through VNC, but it will work through putty

echo: print the string at the screen