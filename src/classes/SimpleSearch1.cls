/**
 * Created by mstallings on 11/9/20.
 */

public class SimpleSearch1 {

  public static List<Contact> searchForContacts(String lastname, String mailPostCode) {
      List<Contact> contacts =
      [SELECT ID, Name, LastName, MailingPostalCode FROM Contact WHERE LastName = :lastname AND MailingPostalCode = :mailPostCode] ;
      System.debug('Found Contacts: ' + contacts);
              return contacts;

  }

}
