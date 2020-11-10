/**
 * Created by mstallings on 11/9/20.
 */

public with sharing class SimpleSearch1 {

    String searchQuery = 'FIND \'' + searchStr1 + '\' IN ALL FIELDS RETURNING  Account (Id,Name,type),Contact(name,email),Opportunity(name,StageName)';

    List<List <sObject>> searchList = search.query(searchQuery);

    accList = ((List<Account>)searchList[0]);
    conList  = ((List<contact>)searchList[1]);
    optyList = ((List<Opportunity>)searchList[2]);

}