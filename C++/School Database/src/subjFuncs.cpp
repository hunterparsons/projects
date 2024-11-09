#include "head.h"
#include <iostream>

// Purpose : prints out subject and the grade.
// Pre : none.
// Post : outputs 'subjectName' and 'classGrade' to console with some formatting.
void Subject::printSubject() {
	std::cout << subjectName << ": "<<classGrade << "%" << std::endl;
}

// Purpose : changes grade for class.
// Pre : none.
// Post : changes grade for specific subject.
void Subject::subjectGradeChange(const double & newGrade) {
	classGrade = newGrade;
}

// Purpose : outputs subject info to console.
// Pre : none.
// Post : subject name and grade will be put into txt file on consecutive lines.
void Subject::outSubInfo(std::ofstream & outfile) {
	outfile << "`\n" << subjectName << std::endl << classGrade << "\n";
}

// Purpose : checks to see if subject name match passed in string.
// Pre : none
// Post : returns true if names match, false otherwise.
bool Subject::checkSubject(std::string sName) {
	if (sName == subjectName) {
		return true;
	}
	return false;
}