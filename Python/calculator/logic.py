class Func:
    def __init__(self):
        self.firstNum = ""
        self.operator = '+'
        self.secondNum = ""
        self.operatorSet = False
        self.foundAnswer = False


    def setNum(self, num):
        if not self.operatorSet:
            if self.foundAnswer:
                self.clear()
            self.firstNum += num
        else:
            self.secondNum += num


    def setOperator(self, operator):
        returnType = False
        if self.operatorSet:
            self.getAnswer()
            returnType = True
        self.operatorSet = True
        self.operator = operator
        return returnType


    def getAnswer(self):
        if self.firstNum == '':
            self.firstNum = '0'
        if self.secondNum == '':
            self.secondNum = '0'
        if self.operator == '+':
            self.firstNum = float(self.firstNum) + float(self.secondNum)
        elif self.operator == '-':
            self.firstNum = float(self.firstNum) - float(self.secondNum)
        elif self.operator == '/':
            if int(self.secondNum) == 0:
                return 1
            self.firstNum = float(self.firstNum) / float(self.secondNum)
        elif self.operator == 'x':
            self.firstNum = float(self.firstNum) * float(self.secondNum)
        elif self.operator == 'p':
            self.firstNum = float(self.firstNum) ** float(self.secondNum)
        self.secondNum = ""
        self.foundAnswer = True
        self.operatorSet = False
        return 0


    def clear(self):
        self.operatorSet = False
        self.foundAnswer = False
        self.firstNum = ""
        self.secondNum = ""


    def negate(self):
        if not self.operatorSet and not self.foundAnswer:
            self.firstNum = float(self.firstNum) * -1
        else:
            self.secondNum = float(self.secondNum) * -1


    def getPerc(self):
        if not self.operatorSet:
            self.firstNum = float(self.firstNum) / 100
        else:
            self.secondNum = float(self.secondNum) / 100
            