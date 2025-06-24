public class Driver{
 public static void main(String[]args){
  //Variables of the test cases are pre-declared.
  //This allows you to copy/paste the entire test case and just change the variables.
  String a;
  String b;
  String whole;
  String part;
  String number;
  
  
  //Single test case myCompareTo:
  a="cat";
  b="dog";
  System.out.println("Expected same sign: "+ a.compareTo(b) +" vs my function: "+StringMethods.myCompareTo(a,b)); 

  
  //Single test case myIndexOf:
  whole = "Hello";
  part = "He";
  System.out.println("Expected "+ whole.indexOf(part) +" vs my function: "+ "REPLACE THIS WITH YOUR myIndexOf CALL" );  
    
  //Single test case parseInt:
  number = "152";
  int actual = Integer.parseInt(number);
  int guess  = -9999999;//replace with your parse function
  System.out.println("Expected "+ actual +" vs my function: "+ guess+" "+(actual==guess));
 }
}
