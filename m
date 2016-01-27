From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] Introduce lifetime write IO statistics
Date: Wed, 27 Jan 2016 21:03:14 +0800
Message-ID: <56A8C012.7030904@kernel.org>
References: <1453794038-189520-1-git-send-email-liushuoran@huawei.com>
	<00a101d1581b$6a7ad090$3f7071b0$@samsung.com>
	<56A7468A.5050600@huawei.com>
	<00c801d158d3$4507ae10$cf170a30$@samsung.com>
	<56A87462.7010502@huawei.com>
	<00da01d158e9$f170a290$d451e7b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1aOPkw-00058z-Cw
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 13:03:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aOPkv-00013y-FG for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 27 Jan 2016 13:03:30 +0000
In-Reply-To: <00da01d158e9$f170a290$d451e7b0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Shuoran' <liushuoran@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 1/27/16 6:02 PM, Chao Yu wrote:
> IMO, maybe it's better to use journal log in data segments to store

data -> node

> checkpoint related data, maybe more nats/sits entries.
> 
> And another thing is I'm in doubt that whether it is enough to use cp +
> data journal to update stat, since abnormal pow-cut after a normal cp would

ditto.

> make us losing all stats saved before.

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
