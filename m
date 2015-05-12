From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: add default mount options to remount
Date: Tue, 12 May 2015 17:52:51 +0800
Message-ID: <009a01d08c99$86819ab0$9384d010$@samsung.com>
References: <1430993497-3894-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Ys6t3-0001Gz-5w
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 09:54:05 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Ys6su-00033j-Pg
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 09:54:05 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NO8002FKE5HC940@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 18:53:41 +0900 (KST)
In-reply-to: <1430993497-3894-1-git-send-email-heyunlei@huawei.com>
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
To: 'Yunlei He' <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, cm224.lee@samsung.com

Hi Yunlei,

> -----Original Message-----
> From: Yunlei He [mailto:heyunlei@huawei.com]
> Sent: Thursday, May 07, 2015 6:12 PM
> To: linux-f2fs-devel@lists.sourceforge.net; jaegeuk@kernel.org; cm224.lee@samsung.com
> Cc: chao2.yu@samsung.com; Yunlei He
> Subject: [PATCH] f2fs: add default mount options to remount
> 
> I use f2fs filesystem with /data partition on my Android phone
> by the default mount options. When I remount /data in order to
> adding discard option to run some benchmarks, I find the default
> options such as background_gc, user_xattr and acl turned off.
> 
> So I introduce a function named default_options in super.c. It do
> some default setting, and both mount and remount operations will
> call this function to complete default setting.

Looks good to me.

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
