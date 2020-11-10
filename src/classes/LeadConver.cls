/**
 * Created by mstallings on 11/10/20.
 */

// Class/Methods to convert existing Leads who have already existing Accounts to Contacts on those Accounts

public class LeadConver {
    // Test method will first try by taking manual input of company name
    public static void convert(String compName) {
        List<Lead> leads = [SELECT Id, Name FROM Lead WHERE Company =:compName ];
        List<Lead> leadsToConvert = new List();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = TRUE LIMIT 1];
        for (Lead l: leads) {
                Database.LeadConvert tempLC = new Database.LeadConvert();
                tempLC.setLeadId(l.Id);
                tempLC.setConvertedStatus(convertStatus.MasterLabel);
                leadsToConvert.add(tempLC);
                }

        lc = Database.convertLead(leadsToConvert);
        for (Database.LeadConvertResult lctemp: lc) {
            system.debug(lctemp.getAccountId());
            system.debug(lctemp.getAccountId());
        }
    }
}

