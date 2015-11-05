import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class MemAssignment
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

	public static void main ( String args [])
	{
		BufferedReader br = null;
    // TreeMap<String,VarLife> used to store variables since find and insertion are both frequent
    TreeMap<String,VarLife> varmap = new TreeMap<String,VarLife>();
    int line = 1;
		try {
      String statement;
			br = new BufferedReader(new FileReader("input.txt"));

			while ((statement = br.readLine()) != null) {
				//Reading variables from all statements into a TreeMap<String,VarLife>
        ArrayList<String> vars = varsInStatement(statement);
        for(String v: vars){
          if(varmap.containsKey(v)){
            VarLife life = varmap.get(v);
            life.setend(line);
          }
          else {
            VarLife life = new VarLife(line,line);
            varmap.put(v,life);
          }
        }
        line++;
			}
		} catch (IOException e) {
			System.out.println(e);
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}

    // Here the entire file has been read and the TreeMap<String,VarLife> contains all variables in the file
    int[] numvar = new int[line];    // array is initialized to 0
    int maxvar = 0; // Find maximum value in an array java
    for( VarLife life: varmap.values()){
      //System.out.println(life.getstart()+" "+life.getend());
      for(int i=life.getstart(); i<=life.getend(); i++){
        numvar[i]++;
      }
  	}
    for(int n: numvar){
      //System.out.println(n);
      if(maxvar<n){ maxvar = n; }
    }
    System.out.println("Maximum number of memory blocks needed = "+maxvar);
  }
}

class VarLife
{
  private int startline;
  private int endline;

  public VarLife(){
    this.startline = 0;
    this.endline = 0;
  }

  public VarLife(int start, int end){
    this.startline = start;
    this.endline = end;
  }

  public int getstart(){ return this.startline; }
  public int getend(){ return this.endline; }

  public void setstart(int start){
    this.startline = start;
  }

  public void setend(int end){
    this.endline = end;
  }

}
