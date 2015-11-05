import java.util.*;
public class Test
{
  private static final String[] operators = { "{","}","[","]","<",">","=","(",")","+","-","*","/","?","!",";","," };

  static ArrayList<String> varsInStatement(String statement){
    for(String op: operators){
      statement = statement.replace(op," ");
    }
    //System.out.println(statement);
    statement = statement.trim();
    String[] vars = statement.split("\\s+");   // Split string on basis of any number of whitespaces
    ArrayList<String> varlist = new ArrayList<String>(Arrays.asList(vars)) ;
    return varlist ;
  }

  public static void main(String[] args){
    /* String statement = "(x + y) = z;";
    ArrayList<String> vars = varsInStatement(statement);
    System.out.println(vars.size());
    for(String s: vars){
      System.out.println(s);
    } */

    int[] arr = new int[10];
    for(int i:arr){ System.out.println(i); }
  }
}
