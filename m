From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: fix to update variable correctly when
 skip a unmapped block
Date: Mon, 14 Dec 2015 18:05:13 +0800
Message-ID: <005f01d13657$043d5cc0$0cb81640$@samsung.com>
References: <004f01d13640$ceab8890$6c0299b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1a8Q16-000219-37
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 10:06:04 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a8Q13-0003Qz-8M
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 10:06:04 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZC026G2EPO75B0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 14 Dec 2015 19:05:53 +0900 (KST)
In-reply-to: <004f01d13640$ceab8890$6c0299b0$@samsung.com>
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
To: 'Fan Li' <fanofcode.li@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Monday, December 14, 2015 3:26 PM
> To: 'Jaegeuk Kim'
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: fix to update variable correctly when skip a unmapped block
> 
> map.m_len should be reduced after skip a block
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>



------------------------------------------------------------------------------
