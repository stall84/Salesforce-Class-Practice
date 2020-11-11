/**
 * Created by mstallings on 11/10/20.
 */

public class LeadConverter1 {
    // This was taken directly from a blogpost where somehow the author/original-coder got away without typing any of the Lists
    // Seen here, So I had to guess at those
    // When run this particular code creates duplicate accounts and is made for taking a string input of a Company/Account, so couldn't be used anyway
    public static void convert (String companyName) {

        List<Lead> leads = [SELECT Id FROM Lead WHERE Company = :companyName ];
        List<Database.LeadConvert> leadsToConvert = new List<Database.LeadConvert>();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = TRUE LIMIT 1];
        for (Lead lead: leads) {
            Database.LeadConvert lc = new Database.LeadConvert();
            lc.setLeadId(lead.Id);
            lc.setConvertedStatus(convertStatus.MasterLabel);
            leadsToConvert.add(lc);
        }
          List<Database.LeadConvertResult> leadsConverted = Database.convertlead(leadsToConvert);
          for (Database.LeadConvertResult lctemp: leadsConverted) {
              System.debug('Converted AccountID: ' + lctemp.getAccountId());
              System.debug('Converted Contact ID: ' + lctemp.getContactId());
          }
//        System.debug('Lead Convert Holding Variable: ' + lc);
//        Database.LeadConvertResult lcr = Database.convertLead(lc);
//        System.assert(lcr.isSuccess());
//        System.debug('Converted lcr: ' + lcr);
    }



//    public static void getLeadsMaptoaccount() {
//        List<Lead> lds = [Select id, company from lead where isconverted = false and convertedaccountid = null];
//
//        Map<String, Lead> leadCompanyMap = new Map<string, Lead>();
//
//        For(Lead ld : lds) {
//            leadCompanyMap.put(ld.company, ld);
//        }
//
//        Map<id, account> accts = [Select id from Account where name in :leadCompanyMap.keySet()];
//
//        List<contacts> contactsd =  [Select id, account from contacts where accou

}