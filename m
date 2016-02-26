From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [RFC PATCH] f2fs: recovery missing dot dentries in
	root	directory
Date: Fri, 26 Feb 2016 19:37:36 +0800
Message-ID: <000701d1708a$2eee4520$8ccacf60$@samsung.com>
References: <1456468763-21662-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aZGj5-00010J-Gm
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 11:38:27 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aZGj2-0004bw-Vj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 11:38:27 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3500L5YKBFLZC0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 20:38:16 +0900 (KST)
In-reply-to: <1456468763-21662-1-git-send-email-liuxueliu.liu@huawei.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Liu Xue' <liuxueliu.liu@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org

> -----Original Message-----
> From: Liu Xue [mailto:liuxueliu.liu@huawei.com]
> Sent: Friday, February 26, 2016 2:39 PM
> To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org
> Subject: [f2fs-dev] [RFC PATCH] f2fs: recovery missing dot dentries in root directory
> 
> If f2fs was corrupted with missing dot dentries in root dirctory,
> it needs to recover them after fsck.f2fs set F2FS_INLINE_DOTS flag
> in directory inode when fsck.f2fs detects missing dot dentries.
> 
> Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
> Signed-off-by: Yong Sheng <shengyong1@huawei.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
