import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.solidextend.core.util.JsonUtil;
import com.solidextend.core.web.JsonData;


public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		JsonData  or = new JsonData();
		or.setMsg("aa");
		or.setSuccess(true);
		or.setTotal(1000);
		List list = new ArrayList();
		Map row = new HashMap();
		row.put("id", "aaaa");
		row.put("deptName", "ssss");
		list.add(row);
		or.setRows(list);
		Map extData = new HashMap();
		extData.put("name", "song");
		or.setExtData(extData);
		String s = JsonUtil.writeValueAsString(or);
		System.out.println(s);
	}

}
