#include "head.h"
#include <iostream>

void printMainMenu();
void printDetailedMenu();
int getGrade();

int main() {
	Student_Database mySchool;
	std::string firstName, lastName, subjectName, entry;
	int grade;
	double classGrade;
	char command;
	
	std::ifstream infile("data.txt");
	mySchool.input(infile);
	infile.close();

	do {
		printMainMenu();
		std::cin >> command;
		if(command == 'p' || command == 'P') {
			mySchool.printStudents();
		} else if (command == 'g' || command == 'G') {
			std::cin.clear();
			std::cout << "Please enter the grade you'd like to view (K - 12) : ";
			grade = getGrade();
			try {
				if(mySchool.validateGrade(grade)) {
					mySchool.printGrade(grade);
				}
			} catch(std::string caught) {
				std::cout << caught;
			}
		} else if (command == 'a' || command == 'A') {
			std::cin.clear();
			std::cout << "First Name : ";
			std::cin >> firstName;
			std::cout << "Last Name : ";
			std::cin >> lastName;
			std::cout << "Grade : ";
			grade = getGrade();
			try {
				if (mySchool.validateGrade(grade)) {
					mySchool.addStudent(grade, firstName, lastName);
				}
			} catch (std::string caught) {
				std::cout << caught;
			}
		} else if (command == 'd' || command == 'D') {
			std::cin.clear();
			std::cout << "First Name : ";
			std::cin >> firstName;
			std::cout << "Last Name : ";
			std::cin >> lastName;
			std::cout << "Grade : ";
			grade = getGrade();
			try {
				if (mySchool.validateGrade(grade)) {
					do {
						auto theStudent = mySchool.getStudent(grade, firstName, lastName);
						// Checks if the student exists if they don't, asks if they want to add them 
						if (!mySchool.doesExist(grade, theStudent)) { 
							do {
								std::cout << "This student does not exist!\nWould you like to add them? (Y/N) ";
								std::cin >> command;
								if (command == 'y' || command == 'Y') {
									mySchool.addStudent(grade, firstName, lastName);
									theStudent = mySchool.getStudent(grade, firstName, lastName);
								} else if (!(command == 'n' || command == 'N')) {
									std::cout << "Sorry! That command is not recognized. Please try again." << std::endl;
								}
								std::cin.clear();
							} while(command != 'y' && command != 'Y' && command != 'n' && command != 'N');
						}
						if (command != 'n' && command !='N') {
							mySchool.printDetailsFromData(theStudent);
							printDetailedMenu();
							std::cin >> command;
							if (command == 'a' || command == 'A') { // add subject
								std::cout << "Subject name : ";
								std::cin >> subjectName;
								std::cout << "Class grade : ";
								std::cin >> classGrade;
								try {
									mySchool.addSubjectToStudent(theStudent, subjectName, classGrade);
								} catch(std::string caught) {
									std::cout << caught;
								}
							} else if (command == 'r' || command == 'R') { // remove subject
								std::cout << "Subject name : ";
								std::cin >> subjectName;
								mySchool.rmSubjectFromStudent(theStudent, subjectName);
							} else if (command == 'b' || command == 'B') { // go back

							} else { // input validation
								std::cout << "Sorry! That command is not recognized. Please try again." << std::endl;
							}
						}
					} while (command != 'b' && command != 'B' && command != 'n' && command != 'N');
				}
			} catch (std::string caught) {
				std::cout << caught;
			}
		} else if (command == 'r' || command == 'R') { // remove student
			std::cin.clear();
			std::cout << "First Name : ";
			std::cin >> firstName;
			std::cout << "Last Name : ";
			std::cin >> lastName;
			std::cout << "Grade : ";
			grade = getGrade();
			try {
				if (mySchool.validateGrade(grade)) {
					auto theStudent = mySchool.getStudent(grade, firstName, lastName);
					if (!mySchool.doesExist(grade, theStudent)) { // if student alread does not exist
						std::cout << "That student does not exist!" << std::endl;
					} else {
						mySchool.eraseStudent(theStudent, grade);
					}
				}
			} catch (std::string caught) {
				std::cout << caught;
			}
		} else if (command == 'c' || command == 'C') {
			mySchool.clear();
		} else if (command == 's' || command == 'S') {
			std::ofstream outfile("data.txt");
			mySchool.output(outfile);
			outfile.close();
			std::cout << "Successfully saved!" << std::endl;
		}
		 else if (command == 'q' || command == 'Q') { // quit program
		} else { // input validation
			std::cout << "Sorry! That command is not recognized. Please try again." << std::endl; 
		}
	} while (command != 'q' && command != 'Q');

	// Output entries
	std::ofstream outfile("data.txt");
	mySchool.output(outfile);
	outfile.close();

	return 0;
}

void printMainMenu() {
	std::cout << "Choose Action:\n P) Print all students\n G) Print one grade\n A) Add student\n R) Remove student\n D) Print details of specific student\n C) Clear Students\n S) Save\n Q) Quit" << std::endl;
}

void printDetailedMenu() {
	std::cout << "Would you like to :\n A) Add Subject\n R) Remove subject\n B) Go Back" << std::endl;
}

int getGrade() {			
    std::string input;
    std::cin >> input;
    // Check if input is "k"
    if (input == "k" || input == "K") {
        return 0;  
    }
    // Convert to integer
    return std::stoi(input);
}



