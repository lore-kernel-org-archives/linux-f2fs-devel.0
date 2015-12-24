From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 4/4] f2fs: call f2fs_balance_fs only
 when	node was changed
Date: Thu, 24 Dec 2015 13:48:34 +0800
Message-ID: <015301d13e0e$d3a7aa60$7af6ff20$@samsung.com>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
	<1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
	<20151223191428.GE30505@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aBymD-0007yx-RO
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 05:49:25 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aBymC-0002bj-1T
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 05:49:25 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZU00HI5LI49DD0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 24 Dec 2015 14:49:16 +0900 (KST)
In-reply-to: <20151223191428.GE30505@jaegeuk.local>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Thursday, December 24, 2015 3:14 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: call f2fs_balance_fs only when node was changed
> 
> Change log v2:
>  - add dio case
> 
> >From c2d16a526371954671f9c8cff5f09f9d230f7993 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 22 Dec 2015 13:23:35 -0800
> Subject: [PATCH] f2fs: call f2fs_balance_fs only when node was changed
> 
> If user tries to update or read data, we don't need to call f2fs_balance_fs
> which triggers f2fs_gc, which increases unnecessary long latency.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
