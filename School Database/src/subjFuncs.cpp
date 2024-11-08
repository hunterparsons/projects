#include "head.h"
#include <iostream>

void Subject::printSubject() {
	std::cout << subjectName << ": "<<classGrade << "%" << std::endl;
}

void Subject::subjectGradeChange(const double & newGrade) {
	classGrade = newGrade;
}

void Subject::outSubInfo(std::ofstream & outfile) {
	outfile << "`\n" << subjectName << std::endl << classGrade << "\n";
}

bool Subject::checkSubject(std::string sName) {
	if (sName == subjectName) {
		return true;
	}
	return false;
}