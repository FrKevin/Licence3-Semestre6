import java.util.stream.*;

public class Somme {
    public static void main(String args[]) {
        System.out.println(IntStream.range(1,10).sum());
        System.out.println(IntStream.range(1,10).map(i -> i * i).sum());
    }
}
