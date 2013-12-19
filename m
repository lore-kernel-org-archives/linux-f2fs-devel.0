From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: introduce a new direct_IO write path
Date: Thu, 19 Dec 2013 09:12:16 +0800
Message-ID: <000901cefc57$775a6450$660f2cf0$@samsung.com>
References: <1387244992-7038-1-git-send-email-jaegeuk.kim@samsung.com>
	<1387325521.2101.212.camel@kjgkr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VtSAv-0001Ru-Hp
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 01:13:17 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VtSAt-0005Nd-LL
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 01:13:17 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MY10081E4PVEJC0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 19 Dec 2013 10:13:07 +0900 (KST)
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

Looks Nice!

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> +
> +	end_offset = IS_INODE(dn.node_page) ?
> +			ADDRS_PER_INODE(F2FS_I(inode)) : ADDRS_PER_BLOCK;
> +	bh_result->b_size = (((size_t)1) << blkbits);
> +	dn.ofs_in_node++;
> +	pgofs++;
> +
> +get_next:
> +	if (dn.ofs_in_node >= end_offset) {
> +		if (allocated)
> +			sync_inode_page(&dn);
> +		allocated = false;

		if (allocated) {
			sync_inode_page(&dn);
			allocated = false;
		}
Certainly, it's really not a big deal. :)

Thanks


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
