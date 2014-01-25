From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: Re: A lot of data written by cleaner for specific
	workload
Date: Sat, 25 Jan 2014 22:40:36 +0100
Message-ID: <CAFvQSYQFhkvtBgGvfW6+L=efoqwbuktWVoGcYV+LQO+sDeE6PA@mail.gmail.com>
References: <CAFvQSYSRv-SVs+n3rC6tugw1KSOgViEzkBVhbqzum0zjo+gP7Q@mail.gmail.com>
	<1390520510.25542.34.camel@kjgkr>
	<CAFvQSYS88P3P-BiqzWE_QjLmuUQ_xScEGKrUdsnymi6jrVPK3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linuxhippy@gmail.com>) id 1W7Ay2-0004V6-Kc
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Jan 2014 21:40:42 +0000
Received: from mail-vc0-f175.google.com ([209.85.220.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W7Ay1-0001Ju-Un
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 25 Jan 2014 21:40:42 +0000
Received: by mail-vc0-f175.google.com with SMTP id ij19so2588374vcb.20
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 25 Jan 2014 13:40:36 -0800 (PST)
In-Reply-To: <CAFvQSYS88P3P-BiqzWE_QjLmuUQ_xScEGKrUdsnymi6jrVPK3A@mail.gmail.com>
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

Hi again and sorry for the traffic,

I tried to mount with background_gc=off, but in this case f2fs complains:
> [  145.052343] F2FS-fs (mmcblk0p3): Unrecognized mount option "background_gc=off" or missing value

Also, there is no f2fs entry in /sys/fs :/

I guess my kernel (3.10.24+) is too old...

Regards, Clemens

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
