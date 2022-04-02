public class CompareClass {
    public static void test(){
        Emp e1  = new Emp(15, 'A123');
        Emp e2  = new Emp(12,'B124567');
        List<Emp> eList = new List<Emp>();
        eList.add(e1);
        eList.add(e2);
        eList.sort();
        System.debug(eList);
        
    }
    public class Emp implements Comparable{
        public Integer Id;
        public String name;
        Public Emp(Integer i,String n){
            Id = i;
            name =n;
        }
        public Integer compareTo(Object obj){
            Emp Ins = (Emp)obj;
            System.debug('Ins'+Ins);
             System.debug('Ins'+Id);
            if(name.length() == Ins.name.length()) return 0;
            if(name.length() < Ins.name.length()) return 1;
            return -1;
        }
        
    }
    public static void queryTest(){
        List<account> accList = new List<Account>();
        for(Integer i=0;i<10000;i++){
            accList.add(new account(name=String.valueOf(i)));
        }
        insert accList;
        List<account> accList2 = new List<Account>();
        for(Integer i=0;i<10000;i++){
            accList2.add(new account(name=String.valueOf((i+1000))));
        }
        insert accList2;
    }
    
}