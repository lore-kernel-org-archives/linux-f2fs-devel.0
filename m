From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] fs/f2fs: atomically set inode->i_flags
Date: Mon, 24 Aug 2015 17:34:25 +0800
Message-ID: <001701d0de50$2e09ab80$8a1d0280$@samsung.com>
References: <55DA845C.2020700@huawei.com> <55DA8F64.3060307@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZTo9z-0005tL-J5
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 09:35:23 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZTo9x-0006Ge-HG
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 09:35:23 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTK01I4SYMO3EC0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 18:35:14 +0900 (KST)
In-reply-to: <55DA8F64.3060307@huawei.com>
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
To: 'Zhang Zhen' <zhenzhang.zhang@huawei.com>, jaegeuk@kernel.org, cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Zhang Zhen [mailto:zhenzhang.zhang@huawei.com]
> Sent: Monday, August 24, 2015 11:29 AM
> To: jaegeuk@kernel.org; cm224.lee@samsung.com
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] fs/f2fs: atomically set inode->i_flags
> 
> According to commit 5f16f3225b06 ("ext4: atomically set inode->i_flags in
> ext4_set_inode_flags()").
> 
> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>


------------------------------------------------------------------------------
