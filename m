From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 4/4] f2fs: call f2fs_balance_fs only
	when	node	was changed
Date: Fri, 25 Dec 2015 09:38:34 +0800
Message-ID: <017701d13eb5$13422640$39c672c0$@samsung.com>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
	<1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
	<010b01d13d66$f85f2ac0$e91d8040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aCHLx-0006sF-PK
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 01:39:33 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aCHLv-0005Cg-TD
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 01:39:33 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NZW00QBJ4LN4320@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 25 Dec 2015 10:39:23 +0900 (KST)
In-reply-to: <010b01d13d66$f85f2ac0$e91d8040$@samsung.com>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Wednesday, December 23, 2015 5:47 PM
> To: 'Jaegeuk Kim'
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: call f2fs_balance_fs only when node was changed
> 
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, December 23, 2015 9:00 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 4/4] f2fs: call f2fs_balance_fs only when node was changed
> >
> > If user tries to update or read data, we don't need to call f2fs_balance_fs
> > which triggers f2fs_gc, which increases unnecessary long latency.
> 
> One missing case is get_data_block_dio, how about also covering it based on
> following patch?
> 
> 
> >From 7175efac7473e7a04285055c69edfb7432f8ca4e Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao2.yu@samsung.com>
> Date: Wed, 23 Dec 2015 17:11:43 +0800
> Subject: [PATCH] f2fs: reduce covered region of sbi->cp_rwsem in
>  f2fs_map_blocks

Title of this commit log was not merged into dev-test branch correctly,
could you please reedit it? :)

Thanks,



------------------------------------------------------------------------------
