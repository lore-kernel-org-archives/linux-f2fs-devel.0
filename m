From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: introduce a new direct_IO write path
Date: Fri, 20 Dec 2013 10:14:58 +0800
Message-ID: <000b01cefd29$6c1e61e0$445b25a0$@samsung.com>
References: <1387244992-7038-1-git-send-email-jaegeuk.kim@samsung.com>
	<1387325521.2101.212.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VtpdI-0004pM-Dq
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 02:16:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VtpdG-0008Cd-Dk
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 02:16:08 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MY300MVI2AMTWD0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 20 Dec 2013 11:15:58 +0900 (KST)
In-reply-to: <1387325521.2101.212.camel@kjgkr>
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
To: jaegeuk.kim@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Kim,

One comment as following:

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Wednesday, December 18, 2013 8:12 AM
> To: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce a new direct_IO write path
> 
> Change log from v1:
>  o fix NOSPC error handling
> 
> >From b8511a74fe98b67247a9feeed58441e8f5ffd705 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> Date: Mon, 16 Dec 2013 19:04:05 +0900
> Subject: [PATCH] f2fs: introduce a new direct_IO write path
> Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
> linux-f2fs-devel@lists.sourceforge.net
> 
> Previously, f2fs doesn't support direct IOs with high performance, which
> throws
> every write requests via the buffered write path, resulting in highly
> performance degradation due to memory opeations like copy_from_user.
> 
> This patch introduces a new direct IO path in which every write requests
> are
> processed by generic blockdev_direct_IO() with enhanced get_block
> function.
> 
> The get_data_block() in f2fs handles:
> 1. if original data blocks are allocates, then give them to blockdev.
> 2. otherwise,
>   a. preallocate requested block addresses
>   b. do not use extent cache for better performance
>   c. give the block addresses to blockdev
> 
> This policy induces that:
> - new allocated data are sequentially written to the disk
> - updated data are randomly written to the disk.
> - f2fs gives consistency on its file meta, not file data.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
> ---
>  fs/f2fs/data.c    | 152
> ++++++++++++++++++++++++++++++++++++++++--------------
>  fs/f2fs/f2fs.h    |   2 +
>  fs/f2fs/segment.c |  23 ++++++---
>  3 files changed, 129 insertions(+), 48 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 15956fa..a0950bc 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -570,74 +570,151 @@ repeat:
>  	return page;
>  }
> 
> +static int __allocate_data_block(struct dnode_of_data *dn)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_SB(dn->inode->i_sb);
> +	struct f2fs_summary sum;
> +	block_t new_blkaddr;
> +	struct node_info ni;
> +	int type;
> +
> +	if (unlikely(is_inode_flag_set(F2FS_I(dn->inode), FI_NO_ALLOC)))
> +		return -EPERM;
> +	if (unlikely(!inc_valid_block_count(sbi, dn->inode, 1)))
> +		return -ENOSPC;
> +
> +	__set_data_blkaddr(dn, NEW_ADDR);
> +	dn->data_blkaddr = NEW_ADDR;
> +
> +	get_node_info(sbi, dn->nid, &ni);
> +	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
> +
> +	type = CURSEG_WARM_DATA;

If so, our cold data will be written to WARM_DATA segment.
How about check segment type here?

> +
> +	allocate_data_block(sbi, NULL, NULL_ADDR, &new_blkaddr, &sum, type);
> +
> +	/* direct IO doesn't use extent cache to maximize the performance */
> +	set_inode_flag(F2FS_I(dn->inode), FI_NO_EXTENT);
> +	update_extent_cache(new_blkaddr, dn);
> +	clear_inode_flag(F2FS_I(dn->inode), FI_NO_EXTENT);
> +
> +	dn->data_blkaddr = new_blkaddr;
> +	return 0;
> +}
> +

[snip]


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
