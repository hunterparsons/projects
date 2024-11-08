#include "head.h"
#include <iostream>

void Student::printStudentDetails() {
	if (grade == 0) {
		std::cout << lastName <<", " << firstName << " | Grade : K" << std::endl;
	} else {
		std::cout << lastName <<", " << firstName << " | Grade : " << grade << std::endl;
	}
	printSubjects();
}

void Student::printSubjects() {
	for (int i = 0; i < subjects.size(); i++) {
		subjects[i].printSubject();
	}
}

void Student::printStudentBasics() {
	std::cout << lastName <<", " << firstName << std::endl;
}


void Student::addSubject(std::string & subjName, const double & grade) {
	if (subjName[0] > 96) {
		subjName[0] -= 32;
	}
	subjects.push_back(Subject(subjName, grade));
}

void Student::deleteSubject(std::string & subjName) {
	if (subjName[0] > 96) {
		subjName[0] -= 32;
	}
	std::vector<Subject>::iterator erasedSubject = findSubject(subjName);
	// If subject is not found
	if (erasedSubject == subjects.end()) {
		std::cout << firstName << " " << lastName << " is not in " << subjName << "!" << std::endl;
		return;
	}
	subjects.erase(erasedSubject);
}

void Student::changeGrade(const double & newGrade, const std::string & subject) {
	std::vector<Subject>::iterator newGradeSubject = findSubject(subject);
	// If subject is not found
	if (newGradeSubject == subjects.end()) {
		std::cout << firstName << " " << lastName << " is not in " << subject << "!" << std::endl;
		return;
	}
	newGradeSubject -> subjectGradeChange(newGrade);
}

void Student::inInfo(std::ifstream & infile) {
	double fileGrade;
	std::string fileClass;
	std::getline(infile, fileClass);
	infile >> fileGrade;
	addSubject(fileClass, fileGrade);
}

void Student::outInfo(std::ofstream & outfile) {
	outfile << firstName << std::endl << lastName << std::endl;
	for (Subject sub : subjects) {
		sub.outSubInfo(outfile);
	}
}

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

bool Student::isStudent(const std::string & first, const std::string & last) {
	if (lastName == last && firstName == first) {
		return true;
	}
	return false;
}

bool Student::isBefore(std::string last) {
	if (lastName[0] < last[0]) {
		return true;
	}
	return false;
}