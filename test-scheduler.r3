REBOL []

do %scheduler.r3

;------------------
;--- Unit tests ---
;------------------
sys-now: :now
now: 02-Jan-2009/01:00:01
c: 0
tests: [
;	-RULE-												-1st Event-				-2nd Event-
	[at 18:30]											02-Jan-2009/18:30			-
	[at 03-03-2009/18:30]								03-Mar-2009/18:30			-
	[every day]											03-Jan-2009/01:00:01	04-Jan-2009/01:00:01
	[every day at 18:30]								03-Jan-2009/18:30		04-Jan-2009/18:30
	[every day at 01:00:01]								03-Jan-2009/01:00:01	04-Jan-2009/01:00:01
	[every 3 days]										05-Jan-2009/01:00:01	08-Jan-2009/01:00:01
	[every monday]										05-Jan-2009/01:00:01	12-Jan-2009/01:00:01
	[every monday at 18:30]								05-Jan-2009/18:30		12-Jan-2009/18:30
	[every #2]											02-Feb-2009/01:00:01	02-Mar-2009/01:00:01
	[every #2 at 00:00]									02-Feb-2009/00:00		02-Mar-2009/00:00
	[every [#3 #4]]										03-Jan-2009/01:00:01	04-Jan-2009/01:00:01
	[every [#3 #4] not sat]								04-Jan-2009/01:00:01	03-Feb-2009/01:00:01
	[every [#3 #4] not [sat sun]]						03-Feb-2009/01:00:01	04-Feb-2009/01:00:01
	[every [#3 - #15] not [sat sun]]					05-Jan-2009/01:00:01	06-Jan-2009/01:00:01
	[every [sat sun]]									03-Jan-2009/01:00:01	04-Jan-2009/01:00:01
	[every [wed]]										07-Jan-2009/01:00:01	14-Jan-2009/01:00:01
	[every wed]											07-Jan-2009/01:00:01	14-Jan-2009/01:00:01
	[every monday not #5]								12-Jan-2009/01:00:01	19-Jan-2009/01:00:01
	[every monday not [#5]]								12-Jan-2009/01:00:01	19-Jan-2009/01:00:01
	[every [monday] not #5]								12-Jan-2009/01:00:01	19-Jan-2009/01:00:01
	[every [sat sun] not #3]							04-Jan-2009/01:00:01	10-Jan-2009/01:00:01
	[every [sat sun] not [#3 #4]]						10-Jan-2009/01:00:01	11-Jan-2009/01:00:01
	[every [sat sun] not [#1 - #5]]						10-Jan-2009/01:00:01	11-Jan-2009/01:00:01
	[every [sat sun] not [#3 - #4 #5 - #8 #10]] 		11-Jan-2009/01:00:01	17-Jan-2009/01:00:01
	[every #3 not saturday]								03-Feb-2009/01:00:01	03-Mar-2009/01:00:01
	[every #4 not [sat sun]]							04-Feb-2009/01:00:01	04-Mar-2009/01:00:01
	[every 12 hours]									02-Jan-2009/13:00:01	03-Jan-2009/01:00:01
	[every 15 mn]										02-Jan-2009/01:15:01	02-Jan-2009/01:30:01
	[every 30 sec]										02-Jan-2009/01:00:31	02-Jan-2009/01:01:01
	[every week]										09-Jan-2009/01:00:01	16-Jan-2009/01:00:01
	[every week not #9]									16-Jan-2009/01:00:01	23-Jan-2009/01:00:01
	[every month]										01-Feb-2009/01:00:01	01-Mar-2009/01:00:01
	[every month on #17]								17-Jan-2009/01:00:01	17-Feb-2009/01:00:01
	[every 3 month]										01-Apr-2009/01:00:01	01-Jul-2009/01:00:01
	[every 3 month on #17]								17-Jan-2009/01:00:01	17-Apr-2009/01:00:01
	[every march]										01-Mar-2009/01:00:01	01-Mar-2010/01:00:01
	[every march on #15]								15-Mar-2009/01:00:01	15-Mar-2010/01:00:01
	[every [march may] on #15]							15-Mar-2009/01:00:01	15-May-2009/01:00:01
	[every january]										01-Jan-2010/01:00:01	01-Jan-2011/01:00:01
	[every january on #2]								02-Jan-2010/01:00:01	02-Jan-2011/01:00:01
	[every january on #3]								03-Jan-2009/01:00:01	03-Jan-2010/01:00:01
	[every january at 00:00:00]							01-Jan-2010/00:00:00	01-Jan-2011/00:00:00
	[every month not [jan feb]]							01-Mar-2009/01:00:01	01-Apr-2009/01:00:01
	[every month on #15 not [jan feb]]					15-Mar-2009/01:00:01	15-Apr-2009/01:00:01
	[every 2 months not [jan feb]]						01-Mar-2009/01:00:01	01-May-2009/01:00:01
	[every hour [8:00 - 12:00]]							02-Jan-2009/08:00:01	02-Jan-2009/09:00:01
	[every hour not [00:00 - 5:00]]						02-Jan-2009/05:00:01	02-Jan-2009/06:00:01
	[every 15 mn [8:00 - 8:20 12:00 - 20:00]] 			02-Jan-2009/08:00:01	02-Jan-2009/08:15:01
	[every 15 mn [8:00 - 8:20 12:00 - 20:00] from 00:03] 02-Jan-2009/08:03		02-Jan-2009/08:18
	[every 15 mn [8:00 - 8:20 12:00 - 20:00] from 00:10] 02-Jan-2009/08:10		02-Jan-2009/12:10
	[every hour not [2:0 3:0] from 1:0]					02-Jan-2009/04:00		02-Jan-2009/05:00
	{every month on 1st}								01-Feb-2009/01:00:01	01-Mar-2009/01:00:01
	{every month not [1st 2nd 3rd 5th]}					04-Jan-2009/01:00:01	06-Jan-2009/01:00:01
	{every 12h}											02-Jan-2009/13:00:01	03-Jan-2009/01:00:01
	{every 15mn not [00:00 - 05:00]}					02-Jan-2009/05:00:01	02-Jan-2009/05:15:01

]

foreach [rule evt1 evt2] tests [
	rule: append rule either string? rule [{ do %test.r}][[do %test.r]]
	scheduler/plan/new copy/deep rule
	either any [
		err1: evt1 <> scheduler/jobs/1
		all [
			evt2 <> '-
			scheduler/jobs/2/last: scheduler/jobs/1
			err2: evt2 <> scheduler/next-event? scheduler/jobs/2
		]
	][
		print [
			"^/##Error" c: c + 1 ", rule" mold rule "failed =>^/"
			"result:" mold scheduler/jobs/1 newline
			"expected:" mold any [all [err1 evt1] all [err2 evt2]]
		]
	][
		print ["OK test:" mold rule]
	]
]
print "^/-- unit tests done --"
print [c "error(s)"]

print "^/---- Ticking tests ---"

now: :sys-now
scheduler/reset

out: make string! 64
expecting: "11211215121121912511201121512112112511211215"
emit: func [v][prin v append out v]

scheduler/plan compose [
	at (now + 00:00:12) do [emit "0"]
	in 9 sec 			 do [emit "9"]
	every 1 sec 25 times do [emit "1"]
	every 2 sec 12 times do [emit "2"]
	every 5 sec  5 times do [emit "5"]
]

scheduler/wait

print ""
print expecting		; result can differ a little due to events fired in the same second
print either out = expecting ["OK tick tests"]["^/##not matching!!"]

