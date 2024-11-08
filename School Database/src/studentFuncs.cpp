#include "head.h"
#include <iostream>

// Purpose : print out specific details of student, subjects with grades, their grade level, first and last name.
// Pre : none.
// Post : should output name of student as well as their grade level and any subjects if they have any.
void Student::printStudentDetails() {
	if (grade == 0) {
		std::cout << lastName <<", " << firstName << " | Grade : K" << std::endl;
	} else {
		std::cout << lastName <<", " << firstName << " | Grade : " << grade << std::endl;
	}
	for (int i = 0; i < subjects.size(); i++) {
		subjects[i].printSubject();
	}
}

// Purpose : prints the basic details of a single student, their first and last name.
// Pre : none.
// Post : should print out the last name, then the first name of the student.
void Student::printStudentBasics() {
	std::cout << lastName <<", " << firstName << std::endl;
}

// Purpose : Adds subject to students subjects.
// Pre : 'grade' should be between 0 and 12.
// Post : if 'subjName' is not already capitalized, it capitalizes subject, then adds it to student's 'subjects'.
void Student::addSubject(std::string & subjName, const double & grade) {
	if (subjName[0] > 96) {
		subjName[0] -= 32;
	}
	subjects.push_back(Subject(subjName, grade));
}

// Purpose : deletes subject of 'subjName' from 'subjects' vector.
// Pre : none.
// Post : if 'subjName' is not already capitalized, it capitalizes subject, then looks for subject, and if found erases, otherwise throws statement saying that subject doesn't exist
void Student::deleteSubject(std::string & subjName) {
	if (subjName[0] > 96) {
		subjName[0] -= 32;
	}
	std::vector<Subject>::iterator erasedSubject = findSubject(subjName);
	// If subject is not found
	if (erasedSubject == subjects.end()) {
		throw (firstName + " " + lastName + " is not in " + subjName + "!\n");
		return;
	}
	subjects.erase(erasedSubject);
}

// Purpose : changes student's grade for a particular subject.
// Pre : 'newGrade' should be greater than or equal to 0.
// Post : if the student is in the subject, changes grade for subject, otherwise throws statement saying student is not in subject.
void Student::changeGrade(const double & newGrade, const std::string & subject) {
	std::vector<Subject>::iterator newGradeSubject = findSubject(subject);
	// If subject is not found
	if (newGradeSubject == subjects.end()) {
		throw (firstName + " " + lastName + " is not in " + subject + "!\n");
		return;
	}
	newGradeSubject -> subjectGradeChange(newGrade);
}

// Purpose : inputs info of student from the infile.
// Pre : none.
// Post : inputs data into student based on the infile.
void Student::inInfo(std::ifstream & infile) {
	double fileGrade;
	std::string fileClass;
	std::getline(infile, fileClass);
	infile >> fileGrade;
	addSubject(fileClass, fileGrade);
}

// Purpose : outputs student's info to the outfile
// Pre : none
// Post : should output all of the students data to the outfile, if the outfile does not exist, it creates one.
void Student::outInfo(std::ofstream & outfile) {
	outfile << firstName << std::endl << lastName << std::endl;
	for (Subject sub : subjects) {
		sub.outSubInfo(outfile);
	}
}

// Purpose : finds subject in the students subjects vector and returns iterator to it.
// Pre : none.
// Post : if the subject does exist, returns iterator to subject, otherwise, returns the end of the vector, if vector is empty, also returns end.
std::vector<Subject>::iterator Student::findSubject(std::string subjectName) {
	std::vector<Subject>::iterator i = subjects.begin();
	if(subjects.empty()) {
		return i;
	}
	while (!(i -> checkSubject(subjectName)) && i != subjects.end()) {
		i++;
	}
	return i;
}

// Purpose : Checks if the student's name matches the passed in name
// Pre : none
// Post : returns true if the 'lastName' and 'last' and then 'firstName' and 'first' match.
bool Student::isStudent(const std::string & first, const std::string & last) {
	if (lastName == last && firstName == first) {
		return true;
	}
	return false;
}

// Purpose : checks if the first character of the student is before the first character of the passed in string.
// Pre : first character of passed in string should be capital.
// Post : returns true if the students last name comes before the passed in string, false otherwise
bool Student::isBefore(std::string last) {
	if (lastName[0] < last[0]) {
		return true;
	}
	return false;
}