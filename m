From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: add compat_ioctl to f2fs_dir_operations
Date: Tue, 12 May 2015 17:54:53 +0800
Message-ID: <009b01d08c99$cc49fbf0$64ddf3d0$@samsung.com>
References: <5551B465.8000804@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Ys6ux-00035t-OT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 09:56:03 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Ys6ul-00011L-PQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 09:56:03 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NO800JYEE8QNL30@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 May 2015 18:55:38 +0900 (KST)
In-reply-to: <5551B465.8000804@huawei.com>
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
To: 'hujianyang' <hujianyang@huawei.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: namjae.jeon@samsung.com, linux-f2fs-devel@lists.sourceforge.net

Hi Jianyang,

> -----Original Message-----
> From: hujianyang [mailto:hujianyang@huawei.com]
> Sent: Tuesday, May 12, 2015 4:06 PM
> To: Jaegeuk Kim
> Cc: Chao Yu; namjae.jeon@samsung.com; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev][PATCH] f2fs: add compat_ioctl to f2fs_dir_operations
> 
> commit e9750824114ff939d9da299e73651add6aa65456
> 
> f2fs: add compat_ioctl to provide backward compatability
> 
> introduce compat_ioctl to regular files, but doesn't add this
> functionality to f2fs_dir_operations.
> 
> While running a 32-bit busybox, I met an error like this:
> (A is a directory)
> 
> # busybox chattr +i A
> chattr: reading flags on A: Inappropriate ioctl for device
> 
> This patch copies compat_ioctl from f2fs_file_operations and
> fix this problem.

Looks good to me.

> 
> Signed-off-by: hujianyang <hujianyang@huawei.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
