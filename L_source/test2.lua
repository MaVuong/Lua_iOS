
_arr3={};

_arr3[1]="ssss";
_arr3[2]=3;
_arr3[3]="waeasad";
_arr3[4]={"ss","222","444"};

for count=1,#_arr3 do
	if "table"==type(_arr3[count]) then
		for cx=1,#_arr3[count] do
			print("--".._arr3[count][cx]);
		end
	end
	print(_arr3[count]);
end
