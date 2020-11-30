//Program that implements a recursive decent parser
//Author: Eric Deck, Kyle Franq, Jeremiah Risinger

//This extension allows me to access characters in a string by string[index]
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}


//Global Variables
var count = 0
var statementArray = ["100.228-(2.45*(5.1-3)-2+3)$", "100-((2*(5-3)-2+3)$", "400$", "100-5-5-5+)5()$"]
var token: Character = "a"
var fixedStr = ""
var statementCount = 0
var isValid = true

//Converts the numbers in the string to character 'n' for easier processing
func setUpFullString(statement: String){
     var currSt: Character
     fixedStr = ""
     while(count < statement.count)
     {
        currSt = Character(statement[count])
        if(currSt.isNumber){
          while(currSt.isNumber || currSt == ".")
          {
            count += 1
            currSt = Character(statement[count])
          }
          currSt = "n"
        }
        else
        {
          currSt = Character(statement[count])
          count += 1
        }
        fixedStr += String(currSt)
     }
}

//Sets the token as the next character in the string
func get(){
  count += 1
  if(count > fixedStr.count-1)
  {
    isValid = false
  }
  else{
    token = Character(fixedStr[count])
  }
}

//Following are the grammar rules
func E()
{
  switch(token)
  {
    case "n":
      T()
      E1()
    case "(":
      T()
      E1()
    default:
      isValid = false
  }
}

func E1()
{
  switch(token)
  {
    case "+":
      get()
      T()
      E1()
    case "-":
      get()
      T()
      E1()
    case ")":
      break
    case "$":
      break
    default:
      isValid = false
  }
}

func T()
{
  switch(token)
  {
    case "n":
      F()
      T1()
    case "(":
      F()
      T1()
    default:
      isValid = false
  }
}

func T1()
{
  switch(token)
  {
    case "+":
      break
    case "-":
      break
    case "*":
      get()
      F()
      T1()
    case "/":
      get()
      F()
      T1()
    case ")":
      break
    case "$":
      break
    default:
      isValid = false
  }
}

func F()
{
  switch(token)
  {
    case "n":
      get()
    case "(":
      get()
      E()
      get()
    default:
      isValid = false
  }
}


//Main function
func main(){
    //Used to check each statment in the array
    for statements in statementArray {
        print("Statement: " + statements)
        setUpFullString(statement: statements)
        count = 0
        token = Character(fixedStr[count])
        E()
        if(isValid)
        {
          if(token == "$")
        {
          print("Valid Expression")
        }
        else
        {
          print("Invalid Expression")
        }
        }
        else{
          print("Invalid Expression")
        }
        isValid = true
        print("\n")
    }
}

main()