From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 5/5] f2fs: check the node block address of
	newly	allocated nid
Date: Thu, 20 Aug 2015 17:12:03 +0800
Message-ID: <01bb01d0db28$61844ea0$248cebe0$@samsung.com>
References: <1439887589-35190-1-git-send-email-jaegeuk@kernel.org>
	<1439887589-35190-5-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZSLu8-00065I-7c
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Aug 2015 09:13:00 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZSLu6-0005Ls-MU
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Aug 2015 09:13:00 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NTD01XBHIXAV0A0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Aug 2015 18:12:51 +0900 (KST)
In-reply-to: <1439887589-35190-5-git-send-email-jaegeuk@kernel.org>
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

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, August 18, 2015 4:46 PM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 5/5] f2fs: check the node block address of newly allocated nid
> 
> This patch adds a routine which checks the block address of newly allocated nid.
> If an nid has already allocated by other thread due to subtle data races, it
> will result in filesystem corruption.
> So, it needs to check whether its block address was already allocated or not
> in prior to nid allocation as the last chance.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 3cc32b8..6bef5a2 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1573,6 +1573,8 @@ retry:
> 
>  	/* We should not use stale free nids created by build_free_nids */
>  	if (nm_i->fcnt && !on_build_free_nids(nm_i)) {
> +		struct node_info ni;
> +
>  		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
>  		list_for_each_entry(i, &nm_i->free_nid_list, list)
>  			if (i->state == NID_NEW)
> @@ -1583,6 +1585,13 @@ retry:
>  		i->state = NID_ALLOC;
>  		nm_i->fcnt--;
>  		spin_unlock(&nm_i->free_nid_list_lock);
> +
> +		/* check nid is allocated already */
> +		get_node_info(sbi, *nid, &ni);
> +		if (ni.blk_addr != NULL_ADDR) {

I didn't get it, why free nid is with non-NULL blkaddr?
Could you please explain more about this?

> +			alloc_nid_done(sbi, *nid);

Will another thread call alloc_nid_done too, making this free nid being
released again?

Thanks,

> +			goto retry;
> +		}
>  		return true;
>  	}
>  	spin_unlock(&nm_i->free_nid_list_lock);
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
