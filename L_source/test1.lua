----Các hàm khởi tạo ở đây bắt buộc phải có

function LKS_DidFinishLoad(_sendAppName)
	---mot thread ngam se duoc chay o day de lay thong tin User
	print ("FINISH LOAD DATA: ".._sendAppName);
	
	_documentDir=_sendAppName;
end

--------------Example FUNCTION----------------
function LKS_LoadDataFromURLviaPOST_TEST(thamso)
	_content_type ="application/x-www-form-urlencoded";---[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"] content_type la tham so mac dinh
	_bodyData="grant_type=client_credentials&client_id=LEKHACSONABC&client_secret=SAJn%2Bytel%2FJG6JFUgATs79qZVJ8oC3KgN8KIdya4UfA%3D&scope=http://api.microsofttranslator.com";--- data nay se duoc post di
	_urlRequest="https://datamarket.accesscontrol.windows.net/v2/OAuth2-13";
	_nextFunC="khonglamgica";--- ten function tiep theo ma user muon nhan de truyen tham so
	print(thamso);
	lks_fnPostHTTP(_urlRequest,_nextFunC,_bodyData,_content_type) ;--->Hàm này dùng để load HTTP từ phương thức POST
end


function LKS_LoadDataFromURLviaGT_TEST(thamsoURL)
	_urlRequest="http://dantri.com.vn";
	_nextFunc="HienThiThongTin"
	print ("vao day"..thamsoURL);
	lks_fnGetHTTP(_urlRequest,_nextFunc); --->Hàm này dùng để load HTTP từ phương thức GET 
end



----Các hàm viết thêm----

function KhoiTaoAlertview()
	 LKS_CreateObj("UIAlertView","alertview");
	 LKS_SetPRM("alertview","setTitle:","Call From Lua");
	 LKS_SetPRM("alertview","setMessage:","xin chao toi la Lua");
	 LKS_SetPRM("alertview","addButtonWithTitle:","Close");
	 LKS_SetPRM("alertview","show");
end


print ("Xin chao:");

