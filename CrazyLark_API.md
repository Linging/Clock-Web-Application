#Crazylark's
##Api Document
tags : API
README 
if u wander more [click here](https://github.com/Linging/Crazylark)
<br><br>
##Mobile number Authentication(Sign up)
### Description
> When user input his mobile number. Browser send a json make sure that this mobile has not been signed. 
### Http request
	POST http://localhost:port/users.json
### Query Parameter
	[
	{
	"mobile_number": 15908155675
	}
	]     
 <br>      
##Message Authentication(Sign up)
### Description
> Server has send a massage to current user's mobile phone including a 6-bit authentic number. And user need to input this number correctly.
### Http request
	POST http://localhost:port/users.json
### Query Parameter
	[
	{
	"mobile_number": 15908155675,
	"message": 123456
	}
	]		
<br>
##CD-key Authentication(Sign up)
### Description
> Make sure user has payed.
### Http request
	POST http://localhost:port/users.json
### Query Parameter
	[
	{
	"mobile_number": 15908155675,
	"message": 123456,
	"key": "FT73QBYUEWQ7"
	}
	]	
<br>
##Sign up Authentication(Sign up)
### Description
> User has finished all input box correctly. And click the submit bottom.
### Http request
	POST http://localhost:port/users.json
### Query Parameter
	[
	{
	"mobile_number": 15908155675,
	"message": 123456,
	"key": "FT73QBYUEWQ7",
	"password": "123789",
	"passworde_comfirmation": "123789"
	}
	]	
<br>
##Mobile number Authenticatiion(Log in)
### Description
> User wanna log in and input his mobile number.
### Http request
	POST http://localhost:port/sessions.json
### Query Parameter
	[
	{
	"mobile_number": 15908155675
	}
	]	
<br>
##Log in Authentication(Log in)
### Description
> Server need to affirm if mobile number and password are corresponding.
### Http request
	POST http://localhost:port/sessions.json
### Query Parameter
	[
	{
	"mobile_number": 15908155675,
	"password": "123789"
	}
	]	
<br>
## Get all the staff(Staff Management)
### Description
> User ask for a list of all the staff.  
### Http request
	GET http://localhost:port/employees.json
### Query Parameter
	[
	"corporation_id": 1,
	"department":
	[
	{
	"name":"开发部",
	"member_count": 6
	},
	{
	"name": "流程部",
	"member_count": 16
	}
	],
	"employees":
	[
	{
	"id": 1,
	"mobile_number": 12345678910,
	"name": "唐宇",
	"mac": "98:E0:D9:4E:71:A4",
	"openid": "oB4nYjvY13SVtaWC-AFztM2f3TlU",
	"corporation_id": 1,
	"department": "开发部",
	"image": "tangyu.jpg"
	},
	{
	"id": 2,
	"mobile_number": 78912345610,
	"name": "李嘉迅",
	"mac": "48:E9:K9:A9:71:A8",
	"openid": "oB4nYjvY13SVtaWC-AFztM2f3TlU",
	"corporation_id": 1,
	"department": "流程部",
	"image": "lijiaxun.jpg"
	}
	]
	]
<br>
## Get the special staff(Staff Management)
###Description
> User ask for the special staff infomation.
###Http request
	GET http://localhost:port/employees/id.json
###Query Parameter
	[
	{
	"id": 1,
	"mobile_number": 12345678910,
	"name": "唐宇",
	"mac": "98:E0:D9:4E:71:A4",
	"openid": "oB4nYjvY13SVtaWC-AFztM2f3TlU",
	"corporation_id": 1,
	"department": "开发部",
	"image": "tangyu.jpg"
	"clock_info":
	[
	{
	"date": "/Date(700000+0500)/",
	"clock": "normal", 
	"holiday?": false,
	"id": 1
	},	
	{
	"date": "/Date(710000+0500)/",
	"clock": "late", 
	"holiday?": false,
	"id": 1
	},
	.
	.
	.
	{
	"date": "/Date(770000+0500)/",
	"clock": "absence", 
	"holiday?": false,
	"id": 1
	}
	]
	]
<br>
##Change staff profile(Staff Management)
###Description
> User edit profile of the staff
###Http request
	PATCH http://localhost:port/employees/id.json
###Query request
	[
	{
	"id": 1,
	"mobile_number": 12345678910,
	"name": "唐宇",
	"mac": "98:E0:D9:4E:71:A4",
	"department": "开发部",
	"image": "tangyu.jpg"
	"clock_info":
	[
	{
	"date": "/Date(700000+0500)/",
	"clock": "normal", 
	"holiday?": false,
	"id": 1
	},	
	{
	"date": "/Date(710000+0500)/",
	"clock": "late", 
	"holiday?": false,
	"id": 1
	},
	.
	.
	.
	{
	"date": "/Date(770000+0500)/",
	"clock": "absence", 
	"holiday?": false,
	"id": 1
	}
	]
	]
<br>
##Delete someone leave our firm(Staff Management)
###Description
> User need to delete all information of someone who leave this company.
###Http request
	DELETE http://localhost:port/employees/id.json
###Query Parameter
	[
	{
	"id":1 
	}
	]
<br>
##User profile fill form(User Setting)
###Description
> After user's login action, he will fill his profile form and then server could know more datail infomation about him.
##Http request
	POST http://localhost:port/users/id.json
##Query Parameter
	[
	{
	"mobile_number": 168-0312-8888,
	"password": "123789",
	"passworde_reset": "789123",
	"email": "foxmother@gmail.com",
	"name": "董小姐",
	"gender": "female"
	}
	]	
<br>
##User fill firm infomation(User Setting)
###Description
> User who takes charge of personnel need to input some message about this company, including departments and leaders.
###Http request
	GET http://localhost:port/corporations/id.json
###Query Parameter
	[
	{
	"corporation_name": "聊聊科技",
	"address": "天上",
	"department": 
	[
	{
	"department_name": "开发部"
	},
	{
	"department_name": "流程部"
	}
	]
	}
	]
<br>
##User set clock time(Clock Setting)
###Description
> User input T1 to T6. Ps:therer should be some default values, user could change them if necessary.  
###Http request
	PATCH http://localhost:port/settings/time_clocks.json
###Query Parameter
	[
	{
	"t1": "8:00",
	"t2": "9:00",
	"t3": "10:00",
	"t4": "4:00",
	"t5": "5:00",
	"t6": "6:00" 
	}
	]
<br>
##User set clock mode(Clock Setting)
###Description
> User choose a clock mode in 3. Ps:therer should be a default value, user could change them if necessary.  
###Http request
	PATCH http://localhost:port/settings/clockmodes.json
###Query Parameter
	[
	{
	"mode": "hell"
	}
	]
<br>
##Month Staement(Statements)
###Description
>   All employees with their clock records.
###Http request
	PATCH http://localhost:port/statements/1.json("1" means Jan)
###Query Parameter
	[
	{
	"id":1,
	"name": "唐宇",
	"corporation_id": 1,
	"department": "开发部",
	"overtime": 14,
	"clock_info":
	[
	{
	"date": "/Date(700000+0500)/",
	"clock": "normal", 
	"holiday?": false,
	"id": 1
	},	
	{
	"date": "/Date(710000+0500)/",
	"clock": "late", 
	"holiday?": false,
	"id": 1
	},
	.
	.
	.
	{
	"date": "/Date(770000+0500)/",
	"clock": "absence", 
	"holiday?": false,
	"id": 1
	}
	]
	},
	{
	"id":2,
	"name": "李嘉迅",
	"corporation_id": 1,
	"department": "流程部",
	"overtime": 23,
	"clock_info":
	[
	{
	"date": "/Date(700000+0500)/",
	"clock": "normal", 
	"holiday?": false,
	"id": 2
	},	
	{
	"date": "/Date(710000+0500)/",
	"clock": "late", 
	"holiday?": false,
	"id": 2
	},
	.
	.
	.
	{
	"date": "/Date(770000+0500)/",
	"clock": "absence", 
	"holiday?": false,
	"id": 2
	}
	]
	}
	]
<br>
##Main page(Dash board)
###Description
> Main page dashboard.  
###Http request
	GET http://localhost:port/dashboard.json
###Query Parameter
	[
	{
	"late_count": 1,
	"absence_count": 1,
	"attendance": 1,
	"tardy": 1,
	"vacate" 1,
	"total": 5,
	"departemnts":[
	{
	"name": "开发部"
	},
	{
	"name": "流程部",
	}
	]
	}
	]
<br> 
##Main page with lates list(Dash board)
###Description
> Main page dashboard.  
###Http request
	GET http://localhost:port/late.json
###Query Parameter
	[
	{
	"lates":[
	{
	"name": "李嘉迅",
	"department": "流程部"
	},
	{
	"name": "唐宇",
	"department": "开发部"
	}
	]
	}
	]
<br>
##Main page with absences list(Dash board)
###Description
> Main page dashboard.  
###Http request
	GET http://localhost:port/absences.json
###Query Parameter
	[
	{
	"absences":[
	{
	"name": "李嘉迅",
	"department": "流程部"
	},
	{
	"name": "唐宇",
	"department": "开发部"
	}
	]
	}
	]
<br>
##Main page with vacates list(Dash board)
###Description
> Main page dashboard.  
###Http request
	GET http://localhost:port/vacates.json
###Query Parameter
	[
	{
	"lates":[
	{
	"name": "李嘉迅",
	"department": "流程部"
	},
	{
	"name": "唐宇",
	"department": "开发部"
	}
	]
	}
	]
<br>
##Main page with tardys list(Dash board)
###Description
> Main page dashboard.  
###Http request
	GET http://localhost:port/tardys.json
###Query Parameter
	[
	{
	"lates":[
	{
	"name": "李嘉迅",
	"department": "流程部"
	},
	{
	"name": "唐宇",
	"department": "开发部"
	}
	]
	}
	]
<br>
