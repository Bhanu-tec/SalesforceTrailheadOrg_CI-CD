public class nasa {
  /*  public static void Permutation(String Str){
        // If string is empty
        if (Str.length() == 0) {
            System.debug(ans + " ");
            return;
        } 
    }*/

 public static void permutationWithRepeation(String str1) {
  System.debug('The given string is: PQR');
  System.debug('The permuted strings are:');
  showPermutation(str1, '');
 }

 public static void showPermutation(String str1, String NewStringToPrint) {

  if (NewStringToPrint.length() == str1.length()) {
   System.debug(NewStringToPrint);
   return;
  }
  for (integer i = 0; i < str1.length(); i++) {

   showPermutation(str1, NewStringToPrint + str1.charAt(i));
  }
 }
}