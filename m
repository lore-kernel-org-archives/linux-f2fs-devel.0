From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: Re: A lot of data written by cleaner for specific
	workload
Date: Fri, 24 Jan 2014 23:07:38 +0100
Message-ID: <CAFvQSYS88P3P-BiqzWE_QjLmuUQ_xScEGKrUdsnymi6jrVPK3A@mail.gmail.com>
References: <CAFvQSYSRv-SVs+n3rC6tugw1KSOgViEzkBVhbqzum0zjo+gP7Q@mail.gmail.com>
	<1390520510.25542.34.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linuxhippy@gmail.com>) id 1W6ouf-00057Z-7s
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jan 2014 22:07:45 +0000
Received: from mail-ve0-f176.google.com ([209.85.128.176])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W6oue-0001E3-HN
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 24 Jan 2014 22:07:45 +0000
Received: by mail-ve0-f176.google.com with SMTP id oz11so2281060veb.21
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 24 Jan 2014 14:07:39 -0800 (PST)
In-Reply-To: <1390520510.25542.34.camel@kjgkr>
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

Hi Jaegeuk,

Thanks a lot for your reply.

> The f2fs_gc can be controlled by user through a sysfs entry.
> So, could you look at the amount of written data by varying the gc
> interval?
>
> cat /sys/fs/f2fs/$dev/gc_min_sleep_time
> 30000
> cat /sys/fs/f2fs/$dev/gc_max_sleep_time
> 60000
>
> These values are represented in milliseconds.
> If you don't want to write data as much as possibe and don't need a high
> performance as the partition becomes full, you can just grow the
> interval times.
> The other way is that you can just add a mount option, "-o
> background_gc=off", which turns off the f2fs_gc.

I'll try turning off the background-gc, as I can't find the
sysfs-knobs in my system.

What I still wonder is, how the cleaner can write twice the data it
reads (as in the above example).

Regards, Clemens

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
