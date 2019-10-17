package mall.Util;

import java.text.DecimalFormat;

public class Util {
		
		public static String comma(int n) {
			
			DecimalFormat df = new DecimalFormat("#,###");
			String str = df.format(n);
			return str;
		}
}
