# Apex Service Layer Pattern

*Hello!* This repo shows an example of following service layer patterns as well as seperation of concerns using Apex Trigger, Trigger Handler, and Function classes.

This is my personal preferred method and general catch-all of implementation for Apex Triggers and Trigger Handlers because it:
* facilitates logic-less triggers and One Trigger Per Object, which itself has many benefits
  * (including fine grained control over order of execution)
* improves readability and Separation of Concerns
  * (this improved readability makes version control more fruitful as well)
* optionally facilitates selective disablement
* covers all events for a trigger to act upon 
  * (before insert, after insert, before update, after update, before delete, after delete, after undelete)

## Seperation of Concerns
The concerns can be simply separated into three basic questions:

1. When (trigger layer) - When will records be acted on?
2. What/Which (handler layer) - What actions will be taken? Which records will be acted on?
3. How (service layer) - How will those actions be performed? How are those criteria defined?

### Trigger

The trigger only worries about **when** as in **when** to act on an event. The following trigger serves as a catch-all template for all events that Apex has and calls the appropriate handler function for that specific event:

`trigger SampleTrigger on SObjectName (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    SampleTriggerHandler handler = new SampleTriggerHandler();
    if (Trigger.isInsert) {
        if (Trigger.isBefore) {
            handler.beforeInsert(Trigger.new);
        }
        else if (Trigger.isAfter) {
            handler.afterInsert(Trigger.new, Trigger.newMap);
        }
    }

    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            handler.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }
        else if (Trigger.isAfter) {
            handler.afterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
        }
    }

    if (Trigger.isDelete) {
        if (Trigger.isBefore) {
            handler.beforeDelete(Trigger.old, Trigger.oldMap);
        }
        else if (Trigger.isAfter) {
            handler.afterDelete(Trigger.old, Trigger.newMap);
        }
    } 

    if (Trigger.isUndelete) {
        if (Trigger.isAfter) {
            handler.afterUndelete(Trigger.new, Trigger.newMap);
        }
    }
}`


### Handler

The handler worries about **what/which** and it is simple to identify what logic is being run based on specific trigger events:

`public with sharing class SampleTriggerHandler implements TriggerHandlerInterface{

    public void beforeInsert(List<SObject> newList) {
        SObjectFunctions.functionName(newList);
    }
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap) {

    }
    public void beforeUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap) {

    }
    public void afterUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap) {

    }
    public void beforeDelete(List<SObject> oldList, map<Id, SObject> oldMap) {

    }
    public void afterDelete(List<SObject> oldList, map<Id, SObject> oldMap) {

    }
    public void afterUndelete(List<SObject> newList, map<Id,SObject> newMap) {

    }
}`

### Optional: TriggerHandler interface

Moreover, it implements a TriggerHandler interface so that each SObject trigger handler class has the same signatures for their functions, and can contain different implementation of said functions. *If you do not want to implement the trigger handler this way, you can specify the List and map types as your desired SObject and leave out the* `implement TriggerHandler` *part of the TriggerHandler class.* The interface class is:

`public interface TriggerHandler {
    void beforeInsert(List<SObject> newList);
    void afterInsert(List<SObject> newList, Map<Id, SObject> newMap);
    void beforeUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap);
    void afterUpdate(List<SObject> oldList, map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap);
    void beforeDelete(List<SObject> oldList, map<Id, SObject> oldMap);
    void afterDelete(List<SObject> oldList, map<Id, SObject> oldMap);
    void afterUndelete(List<SObject> newList, map<Id,SObject> newMap);
}`

**Note** that because of the parameterized method signatures containing lists and maps of type *SObject*, the fuction classes will have to cast the SObject type to your desired SObject type such as SObject to Account (if there is a better way to do this, please let me know).

### Service

The Service answers the **how** questions: 

`public with sharing class SObjectFunctions {

    public static void functionName(List<SObject> newList) {
        // you will need to cast the SObject type of the records as your desired SObject Type
        List<DesiredSObject> newRecords = new List<DesiredSObject>();
        for(SObject s : newList) {
            newRecords.add((DesiredSObjectType) s);
        }

        // additional functions/logic here
    }
}`

Again, this helps with readability and for Apex class testing logic because you can call these functions as you wish. **Note** that the functions inside the class must be static in order to not have to instantiate the SObjectFunctions class.