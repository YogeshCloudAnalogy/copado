public class getContactList{

    public String encoding{get;set;}
    
    public feed feed{get;set;}
    
    public String version{get;set;}
    
    public class updated{
    
    public String NNt{get;set;}
    
    }
    
    public class title{
    
    public String type{get;set;}
    
    public String NNt{get;set;}
    
    }
    
    public class openSearchNNtotalResults{
    
    public String NNt{get;set;}
    
    }
    
    public class openSearchNNstartIndex{
    
    public String NNt{get;set;}
    
    }
    
    public class openSearchNNitemsPerPage{
    
    public String NNt{get;set;}
    
    }
    
    public class name{
    
    public String NNt{get;set;}
    
    }
    
    public class link{
    
    public String href{get;set;}
    
    public String rel{get;set;}
    
    public String type{get;set;}
    
    }
    
    public class googleId{
    
    public String NNt{get;set;}
    
    }
    
    public class generator{
    
    public String version{get;set;}
    
    public String uri{get;set;}
    
    public String NNt{get;set;}
    
    }
    
    public class gdNNemail{
    
    public String primary{get;set;}
    
    public String rel{get;set;}
    
    public String address{get;set;}
    
    }
    
        public class GdNNphoneNumber {
    
    public String rel {get;set;} 
    
    public String uri {get;set;} 
    
    public String NNt {get;set;} 
    
        }
    
    public class feed{
    
    public generator generator{get;set;}
    
    public list<author> author{get;set;}
    
    public openSearchNNtotalResults openSearchNNtotalResults{get;set;}
    
    public list<link> link{get;set;}
    
    public openSearchNNstartIndex openSearchNNstartIndex{get;set;}
    
    public title title{get;set;}
    
    public openSearchNNitemsPerPage openSearchNNitemsPerPage{get;set;}
    
    public list<category> category{get;set;}
    
    public String xmlnsNNgContact{get;set;}
    
    public String xmlnsNNgd{get;set;}
    
    public googleId googleId{get;set;}
    
    public String xmlnsNNbatch{get;set;}
    
    public updated updated{get;set;}
    
    public String xmlnsNNopenSearch{get;set;}
    
    public list<entry> entry{get;set;}
    
    public String xmlns{get;set;}
    
    }
    
    public class entry{
    
    public googleId googleId{get;set;}
    
    public title title{get;set;}
    
    public list<link> link{get;set;}
    
    public list<category> category{get;set;}
    
    public list<gdNNemail> gdNNemail{get;set;}
    
    public updated updated{get;set;}
    
            public List<GdNNphoneNumber> gdNNphoneNumber {get;set;} 
    
    }
    
    public class email{
    
    public String NNt{get;set;}
    
    }
    
    public class category{
    
    public String scheme{get;set;}
    
    public String term{get;set;}
    
    }
    
    public class author{
    
    public name name{get;set;}
    
    public email email{get;set;}
    
    }
    
    }