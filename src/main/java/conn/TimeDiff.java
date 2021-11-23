package conn;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

//오늘(현재)날짜와 DB의 날짜와의 시간차이를 계산하여 돌려주는 클래스
public class TimeDiff {
	// 1.오늘날짜를 문자로 변경 (날짜형식 기호에 맞도록)
	// 2. 날짜연산을 위해 날짜형식으로 변경
	// 3. 날짜차이를 시간으로 계산하기 위해 숫자로 변경
	
	
	// 외부로부터 날짜를 입력받아 연산처리후 정수값을 돌려준다.
	public int timeDiff(String wCdate) {
		// 1-1 날짜형식을 문자(202111231253)형식으로 맞추기 위한 준비작업
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm"); //HH:24, hh:1~12
		String strToday = sdf.format(cal.getTime());
		
		// 2-1날짜 연산을 위한 문자형식의 날짜를 날짜형식으로 변경한다.
		Date today = null;
		try {
			today = sdf.parse(strToday);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//                   012345678901234567890
		// 1-2. DB에 저장된 날짜(2021-11-23 13:04:52.5)를 앞과 같은 방법으로 처리한다.
		String strWCdate = wCdate.substring(0, 4) + wCdate.substring(5, 7)
			+ wCdate.substring(8, 10) + wCdate.substring(11, 13)+wCdate.substring(14, 16);
		
		
		// 2-2. 날짜연산을 위해 DB에서 가져온 문자변환형식자료를 날짜형식으로 변환
		Date dateWdate = null;
		try {
			dateWdate = sdf.parse(strWCdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		// 3.날짜형식으로 변경된 두 자료(today,dateWdate)를 숫자형식으로 변경(시간으로 연산처리)- 결과값이 ms(0.0001s)형식
		long diffTime = (today.getTime() - dateWdate.getTime()) / (60*60*1000) + 1;//(1시간이 차이나서 +1을 함)
		
		return (int)diffTime; //연산된 결과를 (1~24)로 (시간의 차이)
	}
	
	
	
	
	
}
