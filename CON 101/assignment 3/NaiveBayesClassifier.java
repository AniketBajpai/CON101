import java.io.*;
import java.util.*;
import java.lang.Math.*;

public class NaiveBayesClassifier
{
  public static HashMap< String, Integer > newsgroup ;
  public static HashMap< String, int[] > feature ;
  public static HashMap< String, double[] > P ;

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

  public static void process(File f){
    BufferedReader br = null;
    String contents;
    String[] sp; String type; int typenum; String[] wordarray;
    try {
			br = new BufferedReader(new FileReader(f));

			while ((contents = br.readLine()) != null) {
				sp = contents.split("\t");
        type = sp[0]; wordarray = sp[1].split(" ");
        typenum = newsgroup.get(type);
        for( String s: wordarray){
          if(!feature.containsKey(s)){
            int[] a = new int[8];
            a[typenum] = 1;
            feature.put(s,a);
          }
          else {
            (feature.get(s))[typenum]++;
          }
        }

			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null)br.close();
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
    /*for(Map.Entry m:feature.entrySet()){
      System.out.print(m.getKey()+" ");
      int[] arr = (int[]) m.getValue();
      for(int j=0;j<8;j++){ System.out.print(arr[j]+" "); }
      System.out.println();
    }*/
  }

  public static void train(){
    int V = feature.size(); // Size of vocabulary
    int[] F = new int[8];   // Total frequency of each type
    for(int i=0;i<8;i++){ F[i]=0; }
    for(Map.Entry m:feature.entrySet()){
      int[] arr = (int[]) m.getValue();
      for(int j=0;j<8;j++){ F[j]+=arr[j]; }
    }
    /*for(int i=0;i<8;i++){ System.out.print(F[i]+" "); }
    System.out.println();*/
    for(Map.Entry m:feature.entrySet()){
      String k = (String) m.getKey();
      int[] arr = (int[]) m.getValue();
      double[] d = new double[8];
      for(int i=0;i<8;i++){ d[i] = Math.log((double)(arr[i]+1)) - Math.log((double)(F[i]+V)); }
      P.put(k,d);
    }
    /*for(Map.Entry m:P.entrySet()){
      System.out.print(m.getKey()+" ");
      double[] arr = (double[]) m.getValue();
      for(int j=0;j<8;j++){ System.out.print(arr[j]+" "); }
      System.out.println();
    }*/
  }

  public static void test(File f){
    BufferedReader br = null;
    String contents;
    String[] sp; String[] wordarray;
    int correct =0; int wrong =0;
    try {
			br = new BufferedReader(new FileReader(f));

			while ((contents = br.readLine()) != null) {
				sp = contents.split("\t");
        wordarray = sp[1].split(" ");
        double[] prob = new double[8];
        for(int i=0;i<8;i++){ prob[i]=0; }
        for( String s: wordarray){
          if(feature.containsKey(s)) {
            for(int i=0;i<8;i++){ prob[i]+=(P.get(s))[i]; }
          }
        }
        /*System.out.println(contents);
        for(int i=0;i<8;i++){ System.out.print(prob[i]); }
        System.out.println();*/
        int group=0; double m = prob[0];
        for(int i=1;i<8;i++){
          if(prob[i]>m){ m=prob[i];group=i; }
        }
        /*System.out.println(contents+" "+group);*/
        if(group==newsgroup.get(sp[0])){ correct++; }
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
		}
    double accuracy = (double)correct/(double)(correct+wrong);
    //System.out.println(correct+" "+wrong);
    System.out.println("Accuracy = "+accuracy);
  }

  public static void main( String[] args) throws IOException {
    feature = new HashMap< String, int[] >();
    newsgroup = new HashMap< String, Integer >();
    setnewsgroup();
    File f0 = new File("file_0.txt");
    File f1 = new File("file_1.txt");
    File f2 = new File("file_2.txt");
    File f3 = new File("file_3.txt");
    File f4 = new File("file_4.txt");
    //File f = new File("file.txt");
    process(f0);
    process(f1);
    process(f2);
    process(f3);
    //process(f4);
    P = new HashMap< String, double[] >();
    train();
    test(f4);
  }

}
