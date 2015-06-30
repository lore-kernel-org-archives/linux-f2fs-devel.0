From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 04/12] f2fs: remove wrong f2fs_bug_on
	when	merging extents
Date: Tue, 30 Jun 2015 11:00:13 +0800
Message-ID: <00e501d0b2e0$fd65f3c0$f831db40$@samsung.com>
References: <1435603176-63219-1-git-send-email-jaegeuk@kernel.org>
	<1435603176-63219-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1Z9lnI-0006ta-Es
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 03:01:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z9lnG-0002zP-Hy
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 03:01:08 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NQQ0359DLPNJS70@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 30 Jun 2015 12:00:59 +0900 (KST)
In-reply-to: <1435603176-63219-4-git-send-email-jaegeuk@kernel.org>
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
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, June 30, 2015 2:39 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 04/12] f2fs: remove wrong f2fs_bug_on when merging extents
> 
> In f2fs_update_extent_tree, if there is existing extent, f2fs tries to split
> it with two parts.
> In each trial, __insert_extent_tree checks __is_front/back_mergeable, and then
> if it hits to go, there is f2fs_bug_on(!den), which triggers a kernel panic.
> 
> Actually, we don't need to check this. Instead, we can do __try_back_merge only
> when there exists a den pointer.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9bedfa8..7817167 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -519,19 +519,19 @@ static struct extent_node *__insert_extent_tree(struct f2fs_sb_info *sbi,
> 
>  		if (ei->fofs < en->ei.fofs) {
>  			if (__is_front_mergeable(ei, &en->ei)) {
> -				f2fs_bug_on(sbi, !den);

I add a BUG_ON here because we assume that in extent cache there is no such 
two extents whose mapping address is continuous but without being merged,
since whenever we add a new extent(not splitted one) into cache, we tries to
merge it frontward/backward, then all extent with continuous mapping should be
merged. So when we split one extent to two parts, each part should not be able
to merge with others. Otherwise it should be a bug.

Is there some special case to trigger this BUG_ON?

Thanks,

>  				en->ei.fofs = ei->fofs;
>  				en->ei.blk = ei->blk;
>  				en->ei.len += ei->len;
> -				*den = __try_back_merge(sbi, et, en);
> +				if (den)
> +					*den = __try_back_merge(sbi, et, en);
>  				return en;
>  			}
>  			p = &(*p)->rb_left;
>  		} else if (ei->fofs >= en->ei.fofs + en->ei.len) {
>  			if (__is_back_mergeable(ei, &en->ei)) {
> -				f2fs_bug_on(sbi, !den);
>  				en->ei.len += ei->len;
> -				*den = __try_front_merge(sbi, et, en);
> +				if (den)
> +					*den = __try_front_merge(sbi, et, en);
>  				return en;
>  			}
>  			p = &(*p)->rb_right;
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
