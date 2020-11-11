/**
 * Created by mstallings on 11/11/20.
 */

public class LeadConverterFinal {

    // Taken from Daris' repo


    public static void convert () {
        // First, Generate List of all (can also be limited) Leads filtering by their converted status
        List<Lead> leadList = [SELECT Id, LastName, Company FROM Lead WHERE IsConverted = FALSE ORDER BY Company];
        // Second Create a Set (to prevent duplicates of companies) to hold Companies on the Leads
        Set<String> companyList = new Set<String>();
        System.debug('Lead List Initial Size: ' + leadList.size());

        // Loop over lead list to pull off the company name and push into the companylist Set
        for (Lead ld : leadList) {
            companyList.add(ld.Company);
        }
        System.debug('Company List Set Size: ' + companyList.size());

        // With a non-duplicate Set of Company Names that our leads belong to, query the database for those companies and
        // add them to their own List. Interestingly Salesforce/Apex does not require you to cast the string Company name
        // of the lead to a 'Name' type on the Account object
        List<Account> accList = [SELECT Name, Id FROM Account WHERE Name IN :companyList];

        // Instantiating an Array[]like-List (notice the right side of assignment it is actually a List) on the LeadConvert 'Class' (Method on the Database Class)
        Database.LeadConvert[] lcList = new List<Database.LeadConvert>();

        // The Lead Status for each Lead we convert will have to have it's Lead Status field converted to TRUE
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = TRUE LIMIT 1];

        // Now you have to nest a for loop to first loop over the list of Leads, then for each of those loop through the
        // List of Account Names and match the fields on the lead. Assign the in-situo lead being converted to a temporary in-loop
        // 'lc' lead convert object (for later updating the list of leads to convert (lcList)

        for (Lead myLead : leadList) {
            for (Account acc : accList) {
                // If the account name matches the lead's company name, put it in a lead convert list to hold for insert/update later
                if(acc.Name.toLowerCase() == myLead.Company.toLowerCase()) {
                    Database.LeadConvert lc = new Database.LeadConvert();
                    lc.setLeadId(myLead.Id);
                    lc.setAccountId(acc.Id);
                    lc.setConvertedStatus(convertStatus.MasterLabel);
                    lcList.add(lc);
                }
            }
        }

        for(Database.LeadConvert conv : lcList) {
            System.debug('First Lead Match ' + conv.getLeadId() + 'Account ID matched ' + conv.getAccountId());
        }

        System.debug('Final list of leads matched to convert: ' + lcList.size());
        Database.LeadConvertResult[] lcr = Database.convertLead(lcList);
    }

}