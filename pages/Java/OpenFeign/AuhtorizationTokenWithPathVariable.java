import feign.Headers;
import feign.Param;
import feign.RequestLine;

public interface HttpClient {

    @RequestLine("POST /api/{version}/yourRestEndpoint")
    @Headers({
            "Content-Type: application/json",
            "Authorization: {apiToken}"
    })
    String executeQuery(String request, @Param("version") String version, @Param("apiToken") String apiToken);

}

// <dependency>
//     <groupId>io.github.openfeign</groupId>
//     <artifactId>feign-okhttp</artifactId>
//     <version>11.6</version>
// </dependency>
