From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 08/12] f2fs: introduce a shrinker for mounted
	fs
Date: Tue, 30 Jun 2015 11:43:29 +0800
Message-ID: <00e901d0b2e7$0fa893c0$2ef9bb40$@samsung.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-8-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Z9mTM-0007Hs-1j
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 03:44:36 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z9mTK-0003wh-3m
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 03:44:36 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NQQ00LNYNQ26R30@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 12:44:26 +0900 (KST)
In-reply-to: <1435603176-63219-8-git-send-email-jaegeuk@kernel.org>
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

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 30, 2015 2:40 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 08/12] f2fs: introduce a shrinker for mounted fs
> 
> This patch introduces a shrinker targeting to reduce memory footprint consumed
> by a number of in-memory f2fs data structures.
> 
> In addition, it newly adds:
>  - sbi->umount_mutex to avoid data races on shrinker and put_super
>  - sbi->shruinker_run_no to not revisit objects
> 
> Noteh that the basic implementation was copied from fs/btrfs/shrinker.c

Great! Good to see it's being implemented in f2fs.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

[snip]

> @@ -1406,6 +1425,9 @@ static int __init init_f2fs_fs(void)
>  	err = f2fs_init_crypto();
>  	if (err)
>  		goto free_kset;
> +
> +	register_shrinker(&f2fs_shrinker_info);

This function can fail due to no memory, please check the return value here.

Thanks,


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
