*** Settings ***

Library   Process


*** Test Cases ***

Version
   ${result} =   Run Process   docker   run   --tty
   ...   yuma123/yangcli:2.11
   ...   yangcli   --version

   Log To Console   \n${result.stderr}\n

   Should Be Equal As Integers   ${result.rc}   0   non-zero return code
   Should Be Equal As Strings
   ...   ${result.stdout.strip()}
   ...   yangcli version 2.11-0
