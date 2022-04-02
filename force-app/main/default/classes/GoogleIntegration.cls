public class GoogleIntegration {
     private static string key = '720126377253-ciqbd69bd2honsi88oh7gcn4vps8msb2.apps.googleusercontent.com';
    //API Secret
    private Static string secert = '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';
    //API Redirect. Use your Lightning Tab or Lightning community URL
    private Static string redirect_uri = 'https://cloudanalogycom-bf-dev-ed.lightning.force.com/c/GoogleApp.app';
    private static string authUrl='https://accounts.google.com/o/oauth2/v2/auth';
    private static string scope='https://www.googleapis.com/auth/contacts.readonly https://www.googleapis.com/auth/documents';
    private static string tokenUrl='https://accounts.google.com/o/oauth2/token';
     @AuraEnabled
    public static String createAuthURL() {
        callout_Setting__mdt callout = callout_Setting__mdt.getInstance('Google_Setting');
        
        String key = EncodingUtil.urlEncode(callout.Clinet_Key__c,'UTF-8');
        String uri = EncodingUtil.urlEncode(callout.Redirect_URI__c,'UTF-8');
        String authuri = '';
        authuri = callout.oauth_url__c+'?'+
        'scope='+'https://www.googleapis.com/auth/contacts.readonly https://www.googleapis.com/auth/documents'+
        '&client_id='+callout.Clinet_Key__c+
        '&redirect_uri='+callout.Redirect_URI__c+
        '&response_type=code'+
        '&access_type=offline'+
        '&prompt=consent'+
        '&include_granted_scopes=true';
    
        return authuri;
    }

    @AuraEnabled
    public static boolean doGetAccessToken(String code)
    {
        callout_Setting__mdt cout = callout_Setting__mdt.getInstance('Google_Setting');
        //Getting access token from google
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(cout.tokenUrl__c);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        
        // String messageBody ='code='+code+'&client_id='+key+
        //     '&client_secret='+secert+
        //     '&redirect_uri='+redirect_uri+
        //     '&grant_type=authorization_code';
        String messageBody ='code='+code+'&client_id='+cout.Clinet_Key__c+
            '&client_secret='+cout.Client_Secret__c+
            '&redirect_uri='+cout.Redirect_URI__c+
            '&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
       	system.debug('messageBody:'+messageBody);
        
        Http callout = new Http();
        String responseText;
        HttpResponse response = callout.send(req);
        if(response.getStatusCode()==200){
            responseText = response.getBody();
            system.debug('responseText:'+responseText);
            Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
            User_Google_Data__c us = new User_Google_Data__c();
            us.User_Id__c = UserInfo.getUserId();
            us.Token_Type__c =  String.valueOf(responseMap.get('token_type'));
            us.Scope__c = String.valueOf(responseMap.get('scope'));
            us.Refresh_Token__c = String.valueOf(responseMap.get('refresh_token'));
            us.Access_Token__c = String.valueOf(responseMap.get('access_token'));
            us.Expires_In_Seconds__c =(Integer)(responseMap.get('expires_in'));
            us.Name = UserInfo.getName();
            DateTime dtTime = System.now().addSeconds(Integer.valueOf(us.Expires_In_Seconds__c));
            us.Expire_In__c = dtTime;
            insert us;
        }     
        // responseText = response.getBody();
        // system.debug('responseText:'+responseText);
        // Map<String,object> responseMap =(Map<String,object>)JSON.deserializeUntyped(responseText) ;  
        // String token =  String.valueOf(responseMap.get('access_token'));
        // system.debug('token:'+token);
        
        //Update token in custom metadata 
        // MetadataService.UpdateCustomMetadata(token);
        return true;
    }

    public static void doRefreshToken(){
        HttpRequest httpReq = new HttpRequest();
        HttpResponse httpRes = new HttpResponse();
        List<User_Google_Data__c> userCredentials = new List<User_Google_Data__c>();
        callout_Setting__mdt cout = callout_Setting__mdt.getInstance('Google_Setting');
        userCredentials = [SELECT User_Id__c ,Token_Type__c ,Scope__c ,Refresh_Token__c ,Access_Token__c ,Expires_In_Seconds__c ,Name  FROM User_Google_Data__c WHERE User_Id__c = :UserInfo.getUserId()];

        if(cout != null  && userCredentials.size() > 0){
            httpReq.setMethod('POST');
            httpReq.setEndpoint(cout.tokenUrl__c);  
            // httpReq.setHeader('Host', 'www.googleapis.com');
            // httpReq.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            httpReq.setTimeout(12000);
            // String requestBody = 'client_id='+cout.Clinet_Key__c+'&client_secret'=cout.Client_Secret__c+'&grant_type=refresh_token&redirect_uri'
            String requestBody = 'refresh_token='+userCredentials[0].Refresh_Token__c+'&client_id='+cout.Clinet_Key__c+'&client_secret='+cout.Client_Secret__c;
            requestBody+= '&grant_type=refresh_token&redirect_uri='+cout.Redirect_URI__c;
            System.debug('#### requestBody '+requestBody);
            httpReq.setBody(requestBody);
            try{
                httpRes = (new Http()).send(httpReq);
                System.debug('httpReq::::'+httpReq);
                System.debug('#### requestBody '+httpRes);
                if(httpRes.getStatusCode() ==   200){
                    String response = httpRes.getBody();
                    Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response);  
                    System.debug('responseMap::::'+responseMap);
                    userCredentials[0].Access_Token__c = (String)responseMap.get('access_token');
                    userCredentials[0].Expires_In_Seconds__c =(Integer)(responseMap.get('expires_in'));
                    DateTime dtTime = System.now().addSeconds(Integer.valueOf(userCredentials[0].Expires_In_Seconds__c));
                    userCredentials[0].Expire_In__c = dtTime;
                    update userCredentials;
                }
            }catch(Exception e){
               
            }
        }
    }

    
    
    @AuraEnabled
    public static String getContacts(){
        // callout_Setting__mdt cout = callout_Setting__mdt.getInstance('Google_Setting');
      
        callout_Setting__mdt cout = callout_Setting__mdt.getInstance('Google_Setting');
        List<User_Google_Data__c> userCredentials = new List<User_Google_Data__c>();
        userCredentials = [SELECT User_Id__c ,Token_Type__c ,Scope__c ,Refresh_Token__c ,Access_Token__c ,Expires_In_Seconds__c ,Name  FROM User_Google_Data__c WHERE User_Id__c = :UserInfo.getUserId()];
        System.debug('here i am'+userCredentials);
        List<googleContactInfo> googleContactInfotList = new List<googleContactInfo>();
        if(userCredentials.size()>0){
            System.debug('here i am');
            Http http = new Http();

            HttpRequest req = new HttpRequest();
    
            req.setEndpoint('https://www.google.com/m8/feeds/contacts/yogesh.arora@cloudanalogy.com/full?alt=json');
    
    
            req.setHeader('Authorization', 'Bearer ' + userCredentials[0].Access_Token__c);
    
            req.setMethod('GET');
    
            req.setTimeout(60 * 1000);
    
            HttpResponse response = http.send(req);
            System.debug('response'+response);
            System.debug('Access_Token__c::::'+response.getBody());
            String bodyprint= response.getbody().replace('$','NN');

            bodyprint = bodyprint.replace('id','googleId');
            getContactList result = (getContactList)JSON.deserialize(bodyprint, getContactList.class);

            List<getContactList.entry>  entryList = result.feed.entry;

            

            for(getContactList.entry entryObj: entryList){

                googleContactInfo googleContactInfoObj = new googleContactInfo();

                googleContactInfoObj.name = entryObj.title.NNt.replace('googleId','id');

                List<String> emailList = new List<String>();

                for(getContactList.gdNNemail emailObj : entryObj.gdNNemail){

                    String emailAddress = emailObj.address.replace('googleId','id');

                    emailList.add(emailAddress);   
                    System.debug(emailAddress);
                }

                googleContactInfoObj.email = emailList;

                List<String> phoneList = new List<String>();

                if(entryObj.GdNNphoneNumber != null){

                    for(getContactList.GdNNphoneNumber phoneObj : entryObj.GdNNphoneNumber){

                        String phoneNumber = phoneObj.uri;

                        phoneList.add(phoneNumber);   

                    }

                }
                googleContactInfoObj.phone = phoneList;

                 /* String contactId = entryObj.googleId.NNt.replace('http://www.google.com/m8/feeds/contacts/yogesh.arora@cloudanalogy.com/base/','');
            // getContactList result = (getContactList)JSON.deserialize(bodyprint, getContactList.class);
            
                 Http http1 = new Http();    

                HttpRequest req1 = new HttpRequest();

                req1.setEndpoint('https://www.google.com/m8/feeds/photos/media/yogesh.arora@cloudanalogy.com/'+contactId);

                req1.setHeader('Authorization', 'OAuth '+userCredentials[0].Access_Token__c);

                req1.setMethod('GET');

                req1.setTimeout(60 * 1000);

                HttpResponse response1 = http1.send(req1);

                if (response1.getStatusCode() == 200) {

                    System.debug('The status is ok: ' +

                                response1.getStatusCode() + ' ' + response1.getStatus());   

                } else {

                    System.debug('response1.getBody():::'+response1.getBody());

                }    

                String image = EncodingUtil.base64Encode(response1.getBodyAsBlob());

                googleContactInfoObj.photourl = image;*/

                googleContactInfotList.add(googleContactInfoObj);
            }

            System.debug('googleContactInfoObj:::::'+googleContactInfotList);
        }
        return JSON.serialize(googleContactInfotList);
    }


    @AuraEnabled
    public static Boolean checkAccessToken(){
        List<User_Google_Data__c> userCredentials = new List<User_Google_Data__c>();
        userCredentials = [SELECT User_Id__c ,Expire_In__c ,Token_Type__c ,Scope__c ,Refresh_Token__c ,Access_Token__c ,Expires_In_Seconds__c ,Name  FROM User_Google_Data__c WHERE User_Id__c = :UserInfo.getUserId()];
        if(!userCredentials.isEmpty()){
            if(userCredentials[0].Expire_In__c > System.now() && userCredentials[0].Expire_In__c > System.now().addSeconds(180)){
                return true;
            }
            else{
                doRefreshToken();
                return true;
            }
        }
        return false;

    }

    @AuraEnabled
    public static Boolean createDoc(String title,String textContent){
        
      if(checkAccessToken()){
        callout_Setting__mdt cout = callout_Setting__mdt.getInstance('Google_Setting');
        List<User_Google_Data__c> userCredentials = new List<User_Google_Data__c>();
        userCredentials = [SELECT User_Id__c ,Token_Type__c ,Scope__c ,Refresh_Token__c ,Access_Token__c ,Expires_In_Seconds__c ,Name  FROM User_Google_Data__c WHERE User_Id__c = :UserInfo.getUserId()];
        System.debug('here i am'+userCredentials);
        List<googleContactInfo> googleContactInfotList = new List<googleContactInfo>();
        if(userCredentials.size()>0){
            System.debug('here i am');
            Http http = new Http();

            HttpRequest req = new HttpRequest();
    
            // req.setEndpoint('https://docs.googleapis.com/v1/documents');
            req.setEndpoint('https://docs.googleapis.com/v1/documents');
    
    
            req.setHeader('Authorization', 'Bearer ' + userCredentials[0].Access_Token__c);
            req.setMethod('POST');
            req.setBody('{  "title": \"'+title+'\"}');
            req.setHeader('Content-Type','text/plain');
            req.setTimeout(60 * 1000);
            HttpResponse response = http.send(req);
            if(response.getStatusCode()==200){
                Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody()); 
                String docId = (String)responseMap.get('documentId');
                String revisionId = (String)responseMap.get('revisionId');
                Http http1 = new Http();

                HttpRequest req1 = new HttpRequest();
                req1.setEndpoint('https://docs.googleapis.com/v1/documents/'+docId+':batchUpdate');
        
        
                req1.setHeader('Authorization', 'Bearer ' + userCredentials[0].Access_Token__c);
                req1.setMethod('POST');
                req1.setBody('{ "requests": [{"insertText": {"text":\"'+textContent+'\","location": {"index": 1}}}],"writeControl": {"requiredRevisionId": \"'+revisionId+'\"}}');
                req1.setHeader('Content-Type','text/plain');
                req1.setTimeout(60 * 1000);
                HttpResponse response1 = http.send(req1);
                System.debug(response1);
                if(response1.getStatusCode()==200){
                    return true;
                }else{
                    return false;
                }
            }
            
        }
      }
      return false;
       
    }
    public class getAccessToken {
        @AuraEnabled
        public String access_token {get; set;}
        @AuraEnabled
        public String token_type {get; set;}
        @AuraEnabled
        public String expires_in {get; set;}
        @AuraEnabled
        public String scope {get; set;}
        @AuraEnabled
        public String jti {get; set;}

    }

    public class googleContactInfo {
        @AuraEnabled
        public string name{get; set;}
        @AuraEnabled
        public List<String> email{get; set;}
        @AuraEnabled
        public List<string> phone{get; set;}
        @AuraEnabled
        public String photourl{get; set;}

    }
}