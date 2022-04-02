Public class Test123 {
    //Method to call Google Map API and fetch the address recommendations 
    @AuraEnabled
    public static String getAddressRecommendations(String searchText){
        String apiKey = '';//YOUR_API_KEY
        String result = null;
        try{
            if(searchText != null){
                String apiUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + searchText.replace(' ', '%20') + '&key=AIzaSyDk7d0BBzplAnuz3qczORiSaBBxj4sPcQk'; 
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(apiUrl);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                if(statusCode == 200){
                    result = res.getBody();
                }
            }
        } catch(exception e){
            System.debug(e.getMessage());
        }
        return result;
    }
    
    //Method to call Google Map API and fetch the address details by placeId 
    @AuraEnabled
    public static String getAddressDetailsByPlaceId(String placeId){
        String apiKey = '';//YOUR_API_KEY
        String result = null;
        try{
            if(placeId != null){
                String apiUrl = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=' + placeId.replace(' ', '%20') + '&key=' + apiKey; 
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(apiUrl);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                if(statusCode == 200){
                    result = res.getBody();
                }
            }
        } catch(exception e){
            System.debug(e.getMessage());
        }
        return result;
    }
    
    //Method to update the address on Account
    @AuraEnabled
    public static void updateAddressDetails(String jsonAddress) {
        Address addressDetail = (Address)JSON.deserialize(jsonAddress, Address.Class);
        if(addressDetail != null && !String.isBlank(addressDetail.Id)) {
            Account acc = new Account();
            acc.Id = addressDetail.Id;
            acc.BillingState = addressDetail.state;
            acc.BillingCity = addressDetail.city;
            acc.BillingCountry = addressDetail.country;
            acc.BillingPostalCode = addressDetail.postalCode;
            acc.BillingStreet = addressDetail.streetNumber;
            update acc;
        }
    }
    
    public class Address {
        public String Id {get; set;}
        public String city {get; set;}
        public String country {get; set;}
        public String state {get; set;}
        public String postalCode {get; set;}
        public String subLocal2 {get; set;}
        public String subLocal1 {get; set;}
        public String streetNumber {get; set;}
        public String route {get; set;}
    }
}