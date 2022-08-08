@isTest
public with sharing class Object_BC_Controller_Test {
    @testSetup static void setup(){
        // Create common test accounts
        List<Object_A__c> testObjectA = new List<Object_A__c>();
        for(Integer i=0;i<20;i++) {
            testObjectA.add(new Object_A__c(Name = 'TestObjectA '+i));
        }
        insert testObjectA;
        List<Object_B__c> testObjectB = new List<Object_B__c>();
        for(Integer i=0;i<20;i++) {
            testObjectB.add(new Object_B__c(Name = 'TestObjectB '+i,Object_A__c= testObjectA[0].Id));
            
        }
        insert testObjectB; 
        List<Object_C__c> testObjectC = new List<Object_C__c>();
        for(Integer i=0;i<20;i++) {
            testObjectC.add(new Object_C__c(Name = 'TestObjectC '+i,Object_B__c= testObjectB[0].Id));
        }
        insert testObjectC;         
    }
    @isTest static void makeData(){
        string jsonRsult = Object_BC_Controller.getObject_B_CList(2, 1);
        system.assert(!string.isBlank(jsonRsult), 'Check if json is not empty');
    }
}