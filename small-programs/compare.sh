#!/bin/bash

#  compare.sh
#  small-programs
#
#  Created by Jesus Orduna on 12/19/14.
#  Copyright (c) 2014 Brown University. All rights reserved.

leftFile="$1"
rightFile="$2"
/Applications/Xcode.app/Contents/Applications/FileMerge.app/Contents/MacOS/FileMerge -left $leftFile -right $rightFile &
