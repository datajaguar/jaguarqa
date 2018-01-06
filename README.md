## Instruction on Running automated test for jaguar database
Updated by Andrew Zhang, 12/4/2017 (Draft)
UPdated: 01/05/2008

Added two folders: 
work-staging (some testing script are still in trial)
work-performance (performance related test scripts; we compare with other databases, such mongoDb and Cassandra)

This framework consists of the following components/folders:

bin: all the utililty and customized functions.
sh: shell scripts for running the test.
work: test result files and logs.
data: data files for testing.
bas: storrs baseline for the comparison
sql: sql scripts


##### Motivation: 
Able to run anywhere on the one of the server that has jaguar server installed. 
Automated test cases will check the results (successful or failure) at the end of the test under the work directory 

Jaguar database automation enables automated test cases with minimum manual operation. 

Here are a few requirement and dependencies  
#### 1) Succesful Installation
Make sure to have a successful installation either on a single server or cluster, and all server started/stopped without errors 
#### 2) Download the test framework
We can download the test anywhere on the server, for example:

```
/home/andrew/t/azhang
(andrew@ssd)\>git clone https://github.com/datajaguar/jaguarqa.git
```
Structure and Descriptions: 
```
$QA_HOME/sh: where automation scripts are located. 
$QA_HOME/bin: some predefined executable tests, such as "loginj". 
$QA_HOME/bas: baseline for the comparison. 
$QA_HOME/work: the work directory; all the test results are here (we can rename and archive the result into such as: 
$QA_HOME/work_import_export_sql_v2.8.1.1_10_17 
```

#### 3) Set Two System Variables 
System environment settings requires: 
```
JAGUAR_HOME 
QA_HOME 
```

Also update the PATH accordingly. For example (on andrew@ssd): 
```
export JAGUAR_HOME=/home/$LOGNAME/jaguar
export QA_HOME=/home/andrew/t/azhang/jaguarqa`
export PATH=$QA_HOME/bin:$QA_HOME/sh:$JAGUAR_HOME/bin:$PATH
```

##### Tips for a successful env settings:
Before we start to run the automated test, please make sure all the following four commands can be run and obtain a reasonable outputs as a verificaiton :

```
/home/andrew
(andrew@ssd)\>echo $JAGUAR_HOME
/home/andrew/jaguar

/home/andrew
(andrew@ssd)\>echo $QA_HOME
/home/andrew/t/azhang/jaguarqa

/home/andrew
(andrew@ssd)\>which jag
~/jaguar/bin/jag

/home/andrew/t/azhang/jaguarqa
(andrew@ssd)\>which loginj
~/t/azhang/jaguarqa/bin/loginj
```

#### 4) Run the test from the $QA_HOME/sh
We should be able run test cases from anywhere on the server where we have test cases downloaded; however, it's easier to kick out the test from:

```
$QA_HOME/sh 
Step 1: run import_export_sql.sh 
/home/andrew/t/azhang/qa/sh 
(andrew@ssd)\>import_export_sql.sh 
 
Step 2: Check result: 
/home/andrew/t/azhang/qa/work 
(andrew@ssd)\>ls *.suc | wc 
      2       2      57 
  
/home/andrew/t/azhang/qa/work 
(andrew@ssd)\>ls *.diff | wc 
ls: cannot access *.diff: No such file or directory 
      0       0       0 
```

If no *.diff files found, we regard the automation are successful. 

#### 5) Tips to save work dirtories

It's up to testers to keep the work directory. For example, we can save a work directory by attaching a version number to archiev the test results for each release:

```
/home/andrew/t/azhang/Jaguar_QA_HOME
(andrew@ssd)\>ls -l
total 48
drwxrwxrwx 2 andrew andrew 4096 Nov 10 20:08 bas
drwxrwxrwx 2 andrew andrew   54 Nov 10 20:19 bin
drwxrwxrwx 2 andrew andrew   58 Nov 10 19:25 data
drwxrwxrwx 2 andrew andrew 4096 Oct 23 14:48 jaguarMainFunc_log
drwxrwxrwx 2 andrew andrew   24 Oct 23 14:48 jaguarTestData
drwxrwxrwx 2 andrew andrew    6 Oct 23 14:48 log
-rwxrwxr-x 1 andrew andrew 4189 Nov 10 21:36 README.md
drwxrwxrwx 2 andrew andrew 4096 Nov 10 21:31 sh
drwxrwxrwx 2 andrew andrew 4096 Nov 10 20:16 sql
drwxrwxr-x 2 andrew andrew 4096 Nov 10 21:31 work
drwxrwxrwx 2 andrew andrew 4096 Nov 10 20:08 work_11_10
drwxrwxrwx 2 andrew andrew 4096 Oct 23 14:48 work_2.8.2.3
drwxrwxrwx 2 andrew andrew 4096 Oct 23 14:48 work_2.7.9

```


#### Other Notes: 
Each test case (automation script) is independent from each other, which means that we can run each one individually, or in the a group. ##### Some pro and con: 
###### Pro: 
Able to run individually and not interfere each other 
We can pick any one for a particular purpose  
###### Con: 
Some of the the setup is duplicated, which might take some extra time to run the automation. 
 
 
 
  
### Note: Run testing on Windows
#### If we install MSYS-1.0.11.exe on windows and set system enviroment variable correctly, we should be able to run the same test on windows as well; however, we currenty encounted a permission issues!

For example, we can set a .bash_profile on the home directory for the convenience on windows:

#### 1)  Set env for jaguar and QA testing
```
/home/Andrew
(Andrew@AZHANG1)\>vi .bash_profile

export PS1="
\$PWD
($LOGNAME@`uname -n`)\>"

export JAGUAR_HOME=/c/AGZ1/jaguar-enterprise-2.8.2
export QA_HOME=/c/AGZ1/jaguar_QA_HOME
export PATH="$QA_HOME/bin":"$JAGUAR_HOME/bin":$PATH

alias qa='cd $QA_HOME'
alias jaguar='cd $JAGUAR_HOME'
```

#### 2) Run this command to set the environment:
```
/home/Andrew
(Andrew@AZHANG1)\>. .bash_profile
```

#### 3) Down load the test framework from github:
```
/home/Andrew
(Andrew@AZHANG1)\>git clone https://github.com/andrewzhang1/Jaguar_QA_Home.git
```

#### 4) Run the test at:

```
/c/AGZ1/jaguar_QA_HOME/sh
(Andrew@AZHANG1)\>
```

#### Note: Currently, we ran into a permission issue on windows:
```
 /c/AGZ1/jaguar_QA_HOME/bin
(Andrew@AZHANG1)\>ls -l
total 87
-rwxr-xr-x 1 Andrew Administrators   575 Nov 10 20:23 compare_result.sh
-rw-r--r-- 1 Andrew Administrators 86368 Nov 10 20:23 diff
-rw-r--r-- 1 Andrew Administrators   273 Nov 10 20:23 loginj

/c/AGZ1/jaguar_QA_HOME/bin
(Andrew@AZHANG1)\>which loginj
which: loginj: unknown command
```

### In progress..
- Clean up diff files;
- Creating more test cases;
- Trying to fix binary diff files or find a workaround;
- Add status at the end of test, such as: total *suc files and *diff files

Your comments and advice are warmly welcome! 

Andrew Zhang
agz1117@hotmail.com
