public with sharing class SearchController {

    @AuraEnabled
    public static List<sObject> aSearch(String objectName, List<String> fields, String searchTerm, Id conId){
        List<AccountContactRelation> acrList = [SELECT ContactId, AccountId FROM AccountContactRelation WHERE ContactID = :conId];
        // List<Id> accId = new List<Id>();
        String accId = '(';
        for(AccountContactRelation aIds : acrList) {
            // accId.add(aIds.AccountId);
            accId += '\''+aIds.AccountId+'\',';
        }
        accId = accId.substring(0,accId.length()-1);
        accId += ')';
        System.debug(accId);
        System.debug(conId);
        String searchKeyword = searchTerm + '*';
        String returningQuery = '';
        returningQuery = objectName+' ( Id, '+String.join(fields,',')+' WHERE ID IN '+accId+')';
        String query = 'FIND :searchKeyword IN ALL FIELDS RETURNING  '+returningQuery+' LIMIT 20';
        System.debug(' query '+query);
        List<List<sObject>> searchRecords = Search.Query(Query);
        system.debug(searchRecords);
        return searchRecords.get(0);
    }
       
    @AuraEnabled
    public static List<sObject> search(String objectName, List<String> fields, String searchTerm){
        String searchKeyword = searchTerm + '*';
        String returningQuery = '';
        returningQuery = objectName+' ( Id, '+String.join(fields,',')+')';
        String query = 'FIND :searchKeyword IN ALL FIELDS RETURNING '+returningQuery+' LIMIT 20';
        System.debug(' query '+query);
        List<List<sObject>> searchRecords = Search.Query(Query);
        return searchRecords.get(0);
    }



    
}