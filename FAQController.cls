public class FAQController {    
    public String searchInput {get;set;}
    public List<FAQ__c> matchingQuestion{get;set;}
    public String errorMessage {get;set;}
    public List<FAQ__c> FAQList = [SELECT Question__c, Answer__c FROM FAQ__c];
    public FAQ__c newFAQ = new FAQ__c();
    public List<FAQ__c> newFAQList = new List<FAQ__c>();

    //The questions in FAQ records are checked to see if they contain the user's string input
    //If the user inputs a string that is not contained in an existing FAQ question,
    //a new FAQ record is created with the input as a question with a placeholder answer.
    public void QandA() {
        try {
            String textBox = '%' + this.searchInput + '%';
            if (String.isEmpty(this.searchInput)) {
                FAQList = [SELECT Question__c, Answer__c FROM FAQ__c];
            }
            else {
                FAQList = [SELECT Question__c, Answer__c FROM FAQ__c WHERE Question__c LIKE :textBox];
                if (FAQList.isEmpty()) {
                    newFAQ.Question__c = this.searchInput;
                    newFAQ.Answer__c = 'We do not have an answer for this question yet.';
                    FAQList.add(newFAQ);
                    insert newFAQ;
                }
            }
        }
        catch (Exception e){
            this.errorMessage = 'Please enter a question in the text box before clicking the serach button.';
            this.matchingQuestion = new List<FAQ__c>();
        }        
    }

    //The whole list of FAQ records are returned if the text input is empty
    public List<FAQ__c> getupdatedFAQ () {
        if (FAQList.isEmpty()) {
            newFAQ.Question__c = this.searchInput;
            newFAQ.Answer__c = '';
            newFAQList.add(newFAQ);
            return newFAQList;
        }
        else {
            return FAQList;
        }
    } 
}