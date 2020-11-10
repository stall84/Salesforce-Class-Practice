/**
 * Created by mstallings on 11/10/20.
 */

public class LeadConverter1 {

    public static void convert (String companyName) {

        List<Lead> leads = [SELECT Id FROM Lead WHERE Company = :companyName ];
        Database.LeadConvert lc = new Database.LeadConvert();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = TRUE LIMIT 1];
        for (Lead lead: leads) {
            lc.setLeadId(lead.Id);
            lc.setConvertedStatus(convertStatus.MasterLabel);
        }
        Database.LeadConvertResult lcr = Database.convertLead(lc);
        System.assert(lcr.isSuccess());
        System.debug('Converted lcr: ' + lcr);
    }

}