public class Employeer {
    public static void test(){
        PariNumbers p1 = new PariNumbers(1,2);
        PariNumbers p2 = new PariNumbers(4,2);
        PariNumbers p3 = new PariNumbers(1,2);
        System.debug(p1 == p3);
        System.debug(p1.equals(p2));
        System.debug(p1.equals(p3));
        Map<PariNumbers,String> mapP = new Map<PariNumbers,String>();
        mapP.put(p1,'first');
        mapP.put(p2,'2nd');
        mapP.put(p3,'3rd');
        System.debug(mapP.keySet());
        System.debug(mapP.size());
    }
                 
    public class PariNumbers{
        public Integer x;
        public Integer y;
        public PariNumbers(Integer x, Integer y){
            this.x = x;
            this.y =y;
        }
        public Boolean equals(Object obj){
            if(obj InstanceOf PariNumbers){
                PariNumbers p = (PariNumbers)obj;
                return p.x==x && p.y == y;
            }
            return false;
        }
        public Integer hashCode(){
            System.debug(x^y);
            return x^Y;
		}
    }

}