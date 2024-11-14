import customtkinter
from logic import Func

# Purpose : function used when a number key or button is pressed
# Pre : there should be a label defined in main
# Post : calls 'setNum()' on func, and updates label
def numberButton(func, label, num):
    func.setNum(num)
    if not func.operatorSet:
        label.configure(text=func.firstNum)
    else:
        label.configure(text=func.secondNum)

# Purpose : function used when clear key or button is pressed
# Pre : there should be a label defined in main
# Post : calls 'clear()' on func, and updates label
def clearButton(func, label):
    func.clear()
    label.configure(text="0.0")

# Purpose : function used when equals key or button is pressed
# Pre : there should be a label defined in main
# Post : calls 'getAnswer' on func, and updates label, if dividing by 0, outputs error
def equButton(func, label):
    if func.getAnswer():
        func.clear()
        label.configure(text="Error")
    else:
        label.configure(text=func.firstNum)

# Purpose : function used when percentage key or button is pressed
# Pre : there should be a label defined in main
# Post : calls 'getPerc()' on func, and updates label
def percButton(func, label):
    func.getPerc()
    if not func.operatorSet:
        label.configure(text=func.firstNum)
    else:
        label.configure(text=func.secondNum)

# Purpose : function used when negation key or button is pressed
# Pre : there should be a label defined in main
# Post : calls 'negate()' on func, and updates label
def negateButton(func, label):
    func.negate()
    if not func.operatorSet:
        label.configure(text=func.firstNum)
    else:
        label.configure(text=func.secondNum)

# Purpose: called when key is pressed or button is pressed for an operator
# Pre : there should be a label defined in main
# Post : calls 'setOperator()' on func, and updates label
def operatorButton(func, label, op):
    if func.setOperator(op):
        label.configure(text=func.firstNum)

# Buttons list
buttons = [
    ("C", 0, 0, lambda: clearButton(function, label)),
    ("+/-", 0, 1, lambda: negateButton(function, label)),
    ("%", 0, 2, lambda: percButton(function, label)),
    ("/", 0, 3, lambda: operatorButton(function, label, '/')),
    ("7", 1, 0, lambda: numberButton(function, label, '7')),
    ("8", 1, 1, lambda: numberButton(function, label, '8')),
    ("9", 1, 2, lambda: numberButton(function, label, '9')),
    ("x", 1, 3, lambda: operatorButton(function, label, 'x')),
    ("4", 2, 0, lambda: numberButton(function, label, '4')),
    ("5", 2, 1, lambda: numberButton(function, label, '5')),
    ("6", 2, 2, lambda: numberButton(function, label, '6')),
    ("-", 2, 3, lambda: operatorButton(function, label, '-')),
    ("1", 3, 0, lambda: numberButton(function, label, '1')),
    ("2", 3, 1, lambda: numberButton(function, label, '2')),
    ("3", 3, 2, lambda: numberButton(function, label, '3')),
    ("+", 3, 3, lambda: operatorButton(function, label, '+')),
    ("0", 4, 0, lambda: numberButton(function, label, '0')),
    ("POW", 4, 1, lambda: operatorButton(function, label, 'p')),
    (".", 4, 2, lambda: numberButton(function, label, '.')),
    ("=", 4, 3, lambda: equButton(function, label))
]

# Main
customtkinter.set_appearance_mode("system")
customtkinter.set_default_color_theme("dark-blue")

root = customtkinter.CTk()
root.title("Calculator")

frameText = customtkinter.CTkFrame(master = root, height=150, fg_color="white")
frameText.grid(row=0, column=0, padx=20, pady=(30,0), sticky="ew") 

function = Func()

label = customtkinter.CTkLabel(master=frameText, text="0.0", anchor="e", text_color="black", font=("Roboto", 30), height=90, width=400)
label.grid(row=0, column=0, pady=12, padx=0, sticky="ew")

buttonFrame = customtkinter.CTkFrame(master=root)
buttonFrame.grid(row=1, column=0, padx=20, pady=20)

mainButtonDim = 95
fontSize = 18
# Buttons
for (text, row, col, comm) in buttons:
    customtkinter.CTkButton(
        master=buttonFrame, 
        text=text, 
        height=mainButtonDim, 
        width=mainButtonDim,
        font=("Roboto", fontSize), 
        command=comm    
    ).grid(row=row, column=col, padx=10, pady=10)

# Keybinds
root.bind("c", lambda event: clearButton(function, label))
root.bind("n", lambda event: negateButton(function, label))
root.bind("%", lambda event: percButton(function, label))
root.bind("/", lambda event: operatorButton(function, label, "/"))
root.bind("7", lambda event: numberButton(function, label, "7"))
root.bind("8", lambda event: numberButton(function, label, "8"))
root.bind("9", lambda event: numberButton(function, label, "9"))
root.bind("*", lambda event: operatorButton(function, label, "x"))
root.bind("4", lambda event: numberButton(function, label, "4"))
root.bind("5", lambda event: numberButton(function, label, "5"))
root.bind("6", lambda event: numberButton(function, label, "6"))
root.bind("-", lambda event: operatorButton(function, label, "-"))
root.bind("1", lambda event: numberButton(function, label, "1"))
root.bind("2", lambda event: numberButton(function, label, "2"))
root.bind("3", lambda event: numberButton(function, label, "3"))
root.bind("+", lambda event: operatorButton(function, label, "+"))
root.bind("0", lambda event: numberButton(function, label, "0"))
root.bind("^", lambda event: operatorButton(function, label, "p"))
root.bind(".", lambda event: numberButton(function, label, "."))
root.bind("=", lambda event: equButton(function, label))
root.bind("<Return>", lambda event: equButton(function, label))

root.mainloop()