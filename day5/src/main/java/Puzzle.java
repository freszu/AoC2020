import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;

public class Puzzle {

    public static void main(String[] args) throws IOException {
        final var ids = Files.lines(Paths.get("input.txt"))
                .map(line -> line
                        .replaceAll("[FL]", "0")
                        .replaceAll("[BR]", "1")
                )
                .mapToInt(bin -> Integer.valueOf(bin, 2))
                .sorted()
                .toArray();

        final var max = ids[ids.length - 1];
        System.out.println(max);

        var mySeat = ((ids[0] + ids[ids.length - 1]) * (ids.length + 1) / 2 - Arrays.stream(ids).sum());

        System.out.println(mySeat);
    }
}
