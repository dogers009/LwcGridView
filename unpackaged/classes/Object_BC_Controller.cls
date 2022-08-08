public with sharing class Object_BC_Controller {
    @AuraEnabled
    public static String getObject_B_CList(Integer pageSize, Integer pageNumber){
        String jsonDT = '';
         
        Integer offset = (pageNumber - 1) * pageSize;
         
        Integer totalRecords = [SELECT COUNT() FROM Object_C__c];
        Integer recordEnd = pageSize * pageNumber;
         
        ObjectCDTWrapper objDT =  new ObjectCDTWrapper();  
        objDT.pageSize = pageSize;
        objDT.pageNumber = pageNumber;
        objDT.recordStart = offset + 1;
        objDT.recordEnd = totalRecords >= recordEnd ? recordEnd : totalRecords;
        objDT.totalRecords = totalRecords;
        objDT.objC = [select id,Name,CreatedDate,Object_B__r.Name,Object_B__r.CreatedDate
        from Object_C__c LIMIT :pageSize OFFSET :offset];
        jsonDT = JSON.serialize(objDT);
        return jsonDT;
    }
     
    public class ObjectCDTWrapper {
        public Integer pageSize {get;set;}
        public Integer pageNumber {get;set;}
        public Integer totalRecords {get;set;}
        public Integer recordStart {get;set;}
        public Integer recordEnd {get;set;}
        public List<Object_C__c> objC {get;set;}
    }
}