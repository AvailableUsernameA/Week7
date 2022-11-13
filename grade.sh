# Create your grading script here

#set -e

CPATH=".:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar:student-submission/"

rm -rf student-submission
git clone $1 student-submission

if [[ -f student-submission/ListExamples.java ]]
then
    echo $?
else
    echo "ListExamples.java doesn't exist"
    exit 1
fi

touch student-submission/ListExamples.java
mv student-submission/ListExamples.java .

javac -cp $CPATH TestListExamples.java 2>compError.txt

if [[ $? -eq 0 ]]
then
    echo "compile success"
else
    echo "compile failed"
    cat compError.txt
    exit 1
fi 

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples 1>codeError.txt
java -cp $CPATH GradeServer 2022