#!/bin/bash

PROJECT_NAME=`git remote -v|head -n1|awk '{print $2}'|sed -e 's,.*:\(.*/\)\?,,' -e 's/\.git$//'`
AUTHOR_NAME=`git config user.name`
AUTHOR_EMAIL=`git config user.email`
CLASS_NAME="Test"
HEADER_FILE="test.hpp"
SOURCE_FILE="test.cpp"

fileComment() {
        echo "/* File:    $2" > $2
        echo " * Project: $1" >> $2
        echo " * Author:  $AUTHOR_NAME <$AUTHOR_EMAIL>" >> $2
        echo " *" >> $2
        echo " * Copyright (C) 2016 $AUTHOR_NAME" >> $2
        echo " *" >> $2
        echo " * This program is free software: you can redistribute it and/or modify" >> $2
        echo " * it under the terms of the GNU Affero General Public License, version 3," >> $2
        echo " * as published by the Free Software Foundation." >> $2
        echo " *" >> $2
        echo " * This program is distributed in the hope that it will be useful," >> $2
        echo " * but WITHOUT ANY WARRANTY; without even the implied warranty of" >> $2
        echo " * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the" >> $2
        echo " * GNU Affero General Public License for more details." >> $2
        echo " *" >> $2
        echo " * You should have received a copy of the GNU Affero General Public License" >> $2
        echo " * along with this program. If not, see <http://www.gnu.org/licenses/>." >> $2
        echo " */" >> $2
        echo "" >> $2
}

deleteCheck() {
        if [ -f $1 ]; then
                read -r -p "File: $1 already exists. Overwrite? (y/N) " RESPONSE
                case $RESPONSE in
                        [yY][eE][sS]|[yY])
                                rm -rf $1;;
                        *)
                                echo "$1 is not going to be generated."
                                ;;
                esac
        fi
}

createHeader() {
        INCLUDE_LOCK="ILOCK_${PROJECT_NAME^^}_${CLASS_NAME^^}_HPP"
        NAMESPACE="${PROJECT_NAME,,}" 
        deleteCheck $HEADER_FILE
        fileComment $PROJECT_NAME $HEADER_FILE
        echo "#if !defined($INCLUDE_LOCK)" >> $HEADER_FILE 
        echo "#define $INCLUDE_LOCK" >> $HEADER_FILE 
        echo "" >> $HEADER_FILE
        echo "namespace $NAMESPACE {" >> $HEADER_FILE
        echo "" >> $HEADER_FILE
        echo "class $CLASS_NAME {" >> $HEADER_FILE
        echo "public:" >> $HEADER_FILE
        echo "        $CLASS_NAME();" >> $HEADER_FILE
        echo "        virtual ~$CLASS_NAME();" >> $HEADER_FILE
        echo "" >> $HEADER_FILE
        echo "private:" >> $HEADER_FILE
        echo "        $CLASS_NAME(const $CLASS_NAME&) = delete;" >> $HEADER_FILE
        echo "        $CLASS_NAME& operator=(const $CLASS_NAME&) = delete;" >> $HEADER_FILE
        echo "};" >> $HEADER_FILE
        echo "" >> $HEADER_FILE
        echo "} // namespace $NAMESPACE" >> $HEADER_FILE
        echo "" >> $HEADER_FILE
        echo "#endif // $INCLUDE_LOCK" >> $HEADER_FILE
}

createSource() {
        deleteCheck $SOURCE_FILE
        fileComment $PROJECT_NAME $SOURCE_FILE
        echo "#include \"$HEADER_FILE\"" >> $SOURCE_FILE
        echo "" >> $SOURCE_FILE
        echo "namespace $NAMESPACE {" >> $SOURCE_FILE
        echo "" >> $SOURCE_FILE
        echo "$CLASS_NAME::$CLASS_NAME() {" >> $SOURCE_FILE
        echo "}" >> $SOURCE_FILE
        echo "" >> $SOURCE_FILE
        echo "$CLASS_NAME::~$CLASS_NAME() {" >> $SOURCE_FILE
        echo "}" >> $SOURCE_FILE
        echo "" >> $SOURCE_FILE
        echo "} // namespace $NAMESPACE" >> $SOURCE_FILE

} 

testCompile() {
        echo -n "Test compilation... "
        OBJ_FILE=`mktemp`
        RESULT=`g++ -std=c++11 -Wall -Wextra -c $SOURCE_FILE -o $OBJ_FILE 2>&1 >/dev/null|tee /dev/stderr`
        if [ "$RESULT" == "" ]; then
                echo "OK"
        else
                echo "FAILED"
        fi
        rm -rf $OBJ_FILE
} 

generate() {
        echo "Generating header file: $HEADER_FILE..."
        createHeader
        echo "Generating source file: $SOURCE_FILE..."
        createSource
        testCompile
}

if [ "$1" == "" ]; then
        echo "Usage: newclass.sh ClassName"
        exit 0
fi

CLASS_NAME="$1"
HEADER_FILE="${1,,}.hpp"
SOURCE_FILE="${1,,}.cpp"

generate
