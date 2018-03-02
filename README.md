# kyutech-manual-note
note those small points that is meaningless but will cost lots of time...(like tool choosing, environment build)

On server, if you want to use java to program, please use intellij ide. Eclipse will need lots of packages to be installed, 
which cause endless error and conflict

java 自定义加载器，加载加密.class文件

put flatten.tcl into the same directory with xxxx.v file,
edit the third line: set design xxxx to the same name with xxxx.v file
run: dc_shell -64bit -f -flatten.tcl
got xxxx_flat.v & xxxx_flat.ddc files

as you don’t have reading rights on /home/stefan, you cannot see my files. But you have execution rights “x” which 
means you can access sub dirs.
chmod -R g+rw b17

 if you put the directory 16112011SAED_EDK90nm directly in ats17work/benchmarks, no need to adjust lib path in those 
 .tcl files

 change rights to group can access:
 first
 make all the parent directorys 
 chmod g+x xxx
 then
 chmod -R g+rwx xxxx

 you can create a symbolic link in your home to make your life easier: ln -s /home/stefan/ats17work

 netlist: only has function logic connection information, no clock path, no position information
 syndft: insert scan chains, control max fan out of gates, until now, still no clock path. Just a moidified netlist
 
 
 *.sdc file: design constraint file.
 a design constraint refers to some limitation on the conditions under which a system is developed, or on the 
 requirements of the system.

 command to give every scan chain a independent clock pin, (use kyupi)
 grouping porject, jp.ac.kyutech.ci.grouping package, -d b20_25_10_scan.vg -separate_clocks b20_25_10_scan2.vg

 need \nocite{*} before \bibliographystyle{IEEEtran}, to pull all references in before any \cite{xxxx} has been used.
 or error will occur
 
  chmod g+s may not work through VNC, but it will work through putty
  (shell trough vnc may lack of some rights, mkdir also didn't work, better to use putty)
 
 echo: print the string at the screen
 
 git, make a private group shared repository,
 mkdir xxxx
 cd xxxx
 git init --bare --shared=group
 access this repository
 git clone ssh://Username@$ip/$directory

 use:
 git fetch origin
 git diff master origin/master
 to check difference. If it is all ok, use:
 git merge origin/master
 to merge the change (Here, we assum that your branch is "master")
 
 Simultaneous switching of clock
 gates can lead to high peak power and high di/dt which can stress the
 power distribution networks, so in fact it's not a good idea to keep the clocks low-skew all over the circuit.
 
 excessive IR-drop:
 leads to excessive delay
 if too large, flip-flops may lose their data
 
 Slew is the clock transition, or how long it takes for the clock to switch
 Slower slew means slower timing and lower power
 So a proper shape (slop) of slew, can reduce dynamic power while at the same time meeting the timing constraints
 
 Intellectual Property
 A design or verification unit that is pre-packed and available for licensing.
 
 As design sizes continue to grow, proliferation of internal and external protocols, along with aggressive power 
 requirements are driving an explosion in the number of asynchronous clocks in today’s SoCs
 
 clock gating: used to gate blocks and areas that will only be activated when they are needed
 
 Simultaneous Switching Noise: excessive switching activity will not only cause IR-drop and then cause delay,
 but will also cause ground bounce, make ground voltage not a zero status any more, and cause wrong data
 
 to get the history version, one '^' means one version back
 git show HEAD^^ ATS17.tex >ATS17base.tex
 
 to get right level_position info,
 we need to first acess the level0, then the whole circuit will be sorted.
 
 add these after \maketitle, to get page number
 \thispagestyle{fancy} 
 \lhead{}  
 \chead{}
 \rhead{}  
 \lfoot{}  
 \cfoot{\thepage}  
 %\thepage means the currunt page number  
 \rfoot{} 
 \renewcommand{\headrulewidth}{0pt}
 %set 0pt will cancel the headrule  
 \renewcommand{\footrulewidth}{0pt} 
 %set 0pt will cancel the the footrule  
 \pagestyle{fancy}  
 \cfoot{\thepage} 
 
 added dpro.v into IWLS_benchmarks_2005_V_1.0/itc99/netlist
 modified design_list, added dpro
 
 /opt: store software package under /root
 
 ~/ means /home/user; .filename means hidden filev
 
 when you change .bashrc file, and do source ~/.bashrc then get if: Expression Syntax error(式構文？)
 don't worry, check your shell name by 'echo $SHELL', to see if it is bash or not.
 if not, do 'chsh -s /bin/bash' to change default shell to bash permanently.
 
 constructors of subclasses extend from KyupiApp should only setup command line option, should not contain parameter initialization.
 
 to use latexdiff, you need first install latexdiff from MiKTex package manger, then install ActivePerl, 
 notice that although you can get old records rom "git show HEAD", but they contain some special preambles and cannot be
 accepted by latexdif (at least for windows)
 
 The main difference between ATS17 work and other dft modify methods is, we reduce local WSA to avoid local dynamic excessive IR-drop,
 others only made efforts to reduce peek WSA or average WSA globally, but problem may still exist locally.
 And the difference between reference 17, is their method is not optimal and they cannot prove they are pattern independent,
 also they did a good job, but our method is more universal, optimal and totally pattern independent.

in java random.nextInt(bound), will generate random int number from 0 ~ (bound - 1)

if anything need c compiler on windows, better to install vs, after build, use vs to compile.

Install scipoptsuite and its java interface:
1.Install VS for c++ compiler
2.Check out JSCIPOpt from github
3.wget http://scip.zib.de/download/release/scipoptsuite-5.0.1.tgz -o scipoptsuite-5.0.1.tgz under JSCIPOpt
4.cmake and build
5.add "C:\Users\ZhangYucong\Documents\Research\JSCIPOpt\scipoptsuite-5.0.1\build\bin" into the enviroment path
6.add "-Djava.library.path=C:\Users\ZhangYucong\Documents\Research\JSCIPOpt\build\Release" into the VM options
