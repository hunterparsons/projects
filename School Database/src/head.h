// Name       : head.h
// Programmer : Hunter Parsons
// Date       : 11/5/2024

#ifndef HEAD_H
#define HEAD_H
#include <vector>
#include <string>
#include <fstream>

class Subject {
	private:
		std::string subjectName;
		double classGrade;
	public:
		Subject() : subjectName(""), classGrade(100) {}
		Subject(std::string sName, double cGrade) : subjectName(sName), classGrade(cGrade) {}
		void printSubject();
		void subjectGradeChange(const double & newGrade);
		void outSubInfo(std::ofstream & outfile);
		bool checkSubject(std::string subjectName);
};

class Student {
	private:
		std::string firstName;
		std::string lastName;
		std::vector<Subject> subjects;
		int grade;
	public:
		// Constructors
		Student() : firstName(""), lastName(""), grade(0) {} // default constructor
		Student(const std::string & first, const std::string & last, int gradeLevel) :  firstName(first), lastName(last), grade(gradeLevel) {}

		// Functions
		void printStudentBasics();
		void printStudentDetails();
		void printSubjects();
		void addSubject(std::string & subjName, const double & grade);
		void deleteSubject(std::string & subjName);
		void changeGrade(const double & newGrade, const std::string & subject);
		void inInfo(std::ifstream & infile);
		void outInfo(std::ofstream & outfile);
		bool isStudent(const std::string & first, const std::string & last);
		bool isBefore(std::string last);
		std::vector<Subject>::iterator findSubject(std::string subjectName);
	
};

class Student_Database {
	private:
		std::vector<std::vector<Student> > students;
	public:
		Student_Database() : students(13) {} // default constructor
		void printStudents();
		void printGrade(int & grade);
		void printDetailsFromData(const std::vector<Student>::iterator & stud);
		void addStudent(int & grade, std::string & first, std::string & last);
		void eraseStudent(const std::vector<Student>::iterator & stud, int & grade);
		void addSubjectToStudent(const std::vector<Student>::iterator & stud, std::string & subjName, const double & classGrade);
		void rmSubjectFromStudent(const std::vector<Student>::iterator & stud, std::string & subjName);
		void output(std::ofstream & outfile);
		void input(std::ifstream & infile);
		void clear();
		bool validateGrade(const int & grade);
		bool doesExist(int & grade, const std::vector<Student>::iterator & stud);
		std::vector<Student>::iterator getStudent(int & grade, std::string & first, std::string & last);

};

#endif