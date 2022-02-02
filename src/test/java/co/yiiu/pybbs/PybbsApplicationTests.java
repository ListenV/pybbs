package co.yiiu.pybbs;

import co.yiiu.pybbs.exception.ApiAssert;
import org.junit.Test;
import org.springframework.boot.test.context.SpringBootTest;

//@RunWith(SpringRunner.class)
@SpringBootTest
public class PybbsApplicationTests {

    @Test
    public void contextLoads() {
    }

    // Test custom ApiAssert
    @Test
    public void testApiAssert(){
        Integer a = null;
        Integer b = 1;
        ApiAssert.isNull(b, "不是null");
    }

}
