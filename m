From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [RFC PATCH] fsck.f2fs: check valid values for
	dot	dentries
Date: Fri, 26 Feb 2016 19:38:40 +0800
Message-ID: <000801d1708a$543285d0$fc979170$@samsung.com>
References: <1456468933-21881-1-git-send-email-liuxueliu.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aZGk4-0000qU-3B
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 11:39:28 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aZGk2-000085-MH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 11:39:28 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3501G8YKDI4ZB0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 26 Feb 2016 20:39:19 +0900 (KST)
In-reply-to: <1456468933-21881-1-git-send-email-liuxueliu.liu@huawei.com>
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
> Sent: Friday, February 26, 2016 2:42 PM
> To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org
> Subject: [f2fs-dev] [RFC PATCH] fsck.f2fs: check valid values for dot dentries
> 
> Check valid values for '.' and '..', such as ino, hash_code, and the
> number of dot or dotdot in the directory.
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
