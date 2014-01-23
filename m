From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: A lot of data written by cleaner for specific workload
Date: Thu, 23 Jan 2014 13:42:23 +0100
Message-ID: <CAFvQSYSRv-SVs+n3rC6tugw1KSOgViEzkBVhbqzum0zjo+gP7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linuxhippy@gmail.com>) id 1W6Jc5-0007Ut-RH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 12:42:29 +0000
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W6Jc5-0007O1-3q
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Jan 2014 12:42:29 +0000
Received: by mail-vc0-f176.google.com with SMTP id la4so1010409vcb.35
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 23 Jan 2014 04:42:23 -0800 (PST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Hi,

I hope it is ok to write this question to the developer mailing list,
I didn't find any user-related one.

I am using f2fs on my raspberry pi (linux-3.10.23) to store sensor
values every 10s in a postgresql database (a workload that killed a
32gb microSD card formatted with ext4 within 4 days, it developed bad
blocks where the journal was located).
With f2fs I noticed the cleaner is writing a lot, often as much as
80-90% of the total data written:

Iotop accumulated results for a few minutes are:

                              READ:       WRITE
01313 be/4 root         35.19 M     70.12 M  0.00 %  0.09 % [f2fs_gc-8:0]
01863 be/4 root          0.00 B   1240.00 K  0.00 %  0.02 % [kworker/u2:1]
02290 be/4 root          0.00 B   1100.00 K  0.00 %  0.42 % java
-Djava.util.logging.config.file=/root/apache~7/temp
org.apache.catalina.startup.Bootstrap start
02289 be/4 root          0.00 B   1092.00 K  0.00 %  0.41 % java -jar
/root/WPO.jar
12346 be/4 root          0.00 B   1052.00 K  0.00 %  0.02 % [kworker/u2:0]
02147 be/4 postgres   0.00 B    768.00 K  0.00 %  0.00 % postgres: wal
writer process
02529 be/4 root          0.00 B    532.00 K  0.00 %  0.08 % [kworker/u2:2]
02146 be/4 postgres   8.00 K    464.00 K  0.00 %  0.00 % postgres:
writer process
02447 be/4 root          8.00 K    384.00 K  0.00 %  0.01 % java
-Djava.util.logging.config.file=/root/apache~7/temp
org.apache.catalina.startup.Bootstrap start
rest < 100 KB

Is this to be expected for this kind of workload?

Thank you in advance, Clemens

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
