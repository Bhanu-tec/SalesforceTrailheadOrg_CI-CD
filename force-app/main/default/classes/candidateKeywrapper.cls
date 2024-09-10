public with sharing class candidateKeywrapper
{
public Integer Key{get;set;}
public Candidate__c can{get;set;}


public candidateKeywrapper(Integer inkey, Candidate__c incan)

{
 Key=inkey;
 can=incan;
 }
 
 }