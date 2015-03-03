From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] fs/f2fs: add cond_resched() to
	sync_dirty_dir_inodes()
Date: Tue, 03 Mar 2015 09:22:37 +0100
Message-ID: <54F56F4D.7000202@linutronix.de>
References: <20150220201035.GA6005@linutronix.de>
	<20150223233353.GA35245@jaegeuk-mac02>
	<20150227121314.GA21939@linutronix.de>
	<20150303011303.GC6541@lcm-devel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bigeasy@linutronix.de>) id 1YSi6J-00062B-Mj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 08:22:47 +0000
Received: from www.linutronix.de ([62.245.132.108] helo=Galois.linutronix.de)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps
	(TLSv1:AES128-SHA:128) (Exim 4.76) id 1YSi6H-0006Lq-RE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 Mar 2015 08:22:47 +0000
In-Reply-To: <20150303011303.GC6541@lcm-devel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Changman Lee <cm224.lee@samsung.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 03/03/2015 02:13 AM, Changman Lee wrote:

> Hi Sebastian,
Hi Jaegeuk,

> After this patch, your test is all done without any CPU stall, Right?

correct.

> IMHO, context should be switched without cond_resched() after consumed
> own time quota. So, it just reduces system latency due to yielding.
Correct but without preemption enabled there is no time quota. I still
have the >5sec printk but since the task schedules away I don't have a
"problem" anymore.

> I thought another way to discard pages of inode to be evicted in merged bio
> instead of submit. If so, evict() doesn't need to wait for writeback.
You are lucky that the workqueue code is aware of "that". That means it
will schedule another worker if the current task schedules away because
it waits for something. Otherwise you would stall other worker.

If you could solve it in another way, that would be better than just
polling for it.

> Just my curiousity out of this problem.
> 
> Thanks,

Sebastian

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
