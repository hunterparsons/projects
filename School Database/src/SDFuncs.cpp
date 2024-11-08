#include "head.h"
#include <iostream>

// Purpose : this function prints out all the students in the database with basic info
// Pre : none
// Post : should output all students names to console as well as the grade they're in and a number associated with each.
void Student_Database::printStudents() {
	for (int grade = 0; grade < 13; grade++) {
		if (grade == 0) {
			std::cout << "Grade : K"<< std::endl;
		} else {
			std::cout << "Grade : " << grade << std::endl; 
		}
		for (int i = 0; i < students[grade].size(); i++) {
			std::cout << " " << i + 1 << ") ";
			students[grade][i].printStudentBasics();
		}
	}
	std::cout<<"\n";
}

// Purpose : should print the entirety of one grade
// Pre : 'grade' should be between 0 and 12
// Post : prints out all students names of students[grade], as well as some formatting
void Student_Database::printGrade(int & grade) {
	if (grade == 0) {
		std::cout << "Grade : K"<< std::endl;
	} else {
		std::cout << "Grade : " << grade << std::endl; 
	}
	for(int i = 0; i < students[grade].size(); i++) {
		std::cout << " " << i + 1 << ") ";
		students[grade][i].printStudentBasics();
	}
}

// Purpose : adds a subject and grade to one student
// Pre : 'classGrade' should be greater than 0
// Post : if `classGrade' < 0 the function tells the user that can't be done, and returns. Otherwise, 'addSubject()' is called for the pointer and the subject is pushed back to the end of the 'subjects' vector
void Student_Database::addSubjectToStudent(const std::vector<Student>::iterator & stud, std::string & subjName, const double & classGrade) {
	if (classGrade < 0) {
		throw ("You can't enter a negative grade.\n");
	}
	stud -> addSubject(subjName, classGrade);
}

// Purpose : 
// Pre : student should have the class, or else the next function will alert that the action is not possible.
// Post :
void Student_Database::rmSubjectFromStudent(const std::vector<Student>::iterator & stud, std::string & subjName) {
	stud -> deleteSubject(subjName);
}

void Student_Database::printDetailsFromData(const std::vector<Student>::iterator & stud) {
	stud -> printStudentDetails();
}

void Student_Database::addStudent(int & grade, std::string & first, std::string & last) {
	if (first[0] > 96) {
		first[0] -= 32;
	}
	if (last[0] > 96) {
		last[0] -= 32;
	}
	if(students[grade].empty()) {
		students[grade].push_back(Student(first, last, grade));
		return;
	}
	std::vector<Student>::iterator iter = students[grade].begin();
	while (iter -> isBefore(last) && iter != students[grade].end()) {
		iter++;
	}
	students[grade].insert(iter, Student(first, last, grade));
}

void Student_Database::eraseStudent(const std::vector<Student>::iterator & stud, int & grade) {
	students[grade].erase(stud);
}

// '/' = new class
// '~' = new student
void Student_Database::output(std::ofstream & outfile) {
	for (int curClass = 0; curClass < 13; curClass++) {
		outfile << "/" << std::endl;
		for (Student stud : students[curClass]) {
			outfile << "~"<<std::endl;
			stud.outInfo(outfile);
		}
	}
}

void Student_Database::input(std::ifstream & infile) {
	std::string line;
	std::string firstName;
	std::string lastName;
	std::getline(infile, line);
	int grade = 0;
	while(getline(infile, line) && grade < 13) { 
		if (line == "~") {
			std::getline(infile, firstName);
			std::getline(infile, lastName);
			addStudent(grade, firstName, lastName);
		} else if (line == "`") {
			(students[grade].end() - 1) -> inInfo(infile); // the student just added
		} else if (line == "/") {
			grade++;
		}
	}
}

void Student_Database::clear() {
	for (int currGrade = 0; currGrade < 13; currGrade++) {
		while(!students[currGrade].empty()) {
			eraseStudent(students[currGrade].begin(), currGrade);
		}
	}
}

bool Student_Database::doesExist(int & grade, const std::vector<Student>::iterator & stud) {
	if (stud == students[grade].end()) {
		return false;
	}
	return true;
}

bool Student_Database::validateGrade(const int & grade) {
	if (!(grade > 0 && grade < 13)) {
		throw(std::to_string(grade) +  " is not a valid grade!\n");
		return false;
	}
	return true;
}

std::vector<Student>::iterator Student_Database::getStudent(int & grade, std::string & first, std::string & last) {
	if (first[0] > 96) {
		first[0] -= 32;
	}
	if (last[0] > 96) {
		last[0] -= 32;
	}
	std::vector<Student>::iterator i = students[grade].begin();
	if (students[grade].empty()) {
		return i;
	}
	while (!(i -> isStudent(first, last)) && i != students[grade].end()) {
		i++;
	}
	return i;
}