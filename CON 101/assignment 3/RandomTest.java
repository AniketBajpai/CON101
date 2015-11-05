import java.io.*;
import java.util.Random;
import java.util.HashMap;
public class RandomTest
{
  public static HashMap< String, Integer > newsgroup ;

  public static void setnewsgroup(){
    newsgroup.put("talk.politics.mideast",0);
    newsgroup.put("talk.politics.guns",1);
    newsgroup.put("talk.politics.misc",2);
    newsgroup.put("talk.religion.misc",3);
    newsgroup.put("rec.sport.baseball",4);
    newsgroup.put("rec.sport.hockey",5);
    newsgroup.put("rec.motorcycles",6);
    newsgroup.put("rec.autos",7);
  }

  public static void main(String[] args){
    newsgroup = new HashMap< String, Integer >();
    setnewsgroup();
    BufferedReader br = null;
    Random rand = new Random();
    String contents;
    String[] sp; String[] wordarray;
    int correct =0; int wrong =0;
    try {
      File f = new File("file_0.txt");
      br = new BufferedReader(new FileReader(f));

      while ((contents = br.readLine()) != null) {
        sp = contents.split("\t");
        wordarray = sp[1].split(" ");

        int r = rand.nextInt(8);

        if(r==newsgroup.get(sp[0])){ correct++; }
        else { wrong++; }
      }
    } catch (IOException e) {
      e.printStackTrace();
    } finally {
      try {
        if (br != null)br.close();
      } catch (IOException ex) {
        ex.printStackTrace();
      }

      double accuracy = (double)correct/(double)(correct+wrong);
      //System.out.println(correct+" "+wrong);
      System.out.println("Accuracy = "+accuracy);
    }
  }
}
