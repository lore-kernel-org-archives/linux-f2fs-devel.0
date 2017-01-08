From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/5] f2fs: check in-memory block bitmap
Date: Sat, 7 Jan 2017 21:02:08 -0800
Message-ID: <20170108050208.GA16864@jaegeuk.local>
References: <83098918-d882-8743-51bc-1e96038d6ad2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cQ5ca-0008TJ-Ri
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 08 Jan 2017 05:02:20 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cQ5cY-0001Pq-FT
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 08 Jan 2017 05:02:20 +0000
Content-Disposition: inline
In-Reply-To: <83098918-d882-8743-51bc-1e96038d6ad2@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On 01/07, Chao Yu wrote:
> This patch adds a mirror for valid block bitmap, and use it to detect
> in-memory bitmap corruption which may be caused by bit-transition of
> cache or memory overflow.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/segment.c | 30 ++++++++++++++++++++++++++++--
>  fs/f2fs/segment.h |  6 ++++++
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index fa8c0ae87d47..ec21ee1c61cd 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1026,14 +1026,32 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
> 
>  	/* Update valid block bitmap */
>  	if (del > 0) {
> -		if (f2fs_test_and_set_bit(offset, se->cur_valid_map))
> +		if (f2fs_test_and_set_bit(offset, se->cur_valid_map)) {
> +#ifdef CONFIG_F2FS_CHECK_FS
> +			if (f2fs_test_and_set_bit(offset,
> +						se->cur_valid_map_mir))
> +				f2fs_bug_on(sbi, 1);
> +			else
> +				WARN_ON(1);
> +#else
>  			f2fs_bug_on(sbi, 1);
> +#endif
> +		}
>  		if (f2fs_discard_en(sbi) &&
>  			!f2fs_test_and_set_bit(offset, se->discard_map))
>  			sbi->discard_blks--;
>  	} else {
> -		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
> +		if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map)) {
> +#ifdef CONFIG_F2FS_CHECK_FS
> +			if (!f2fs_test_and_clear_bit(offset,
> +						se->cur_valid_map_mir))
> +				f2fs_bug_on(sbi, 1);
> +			else
> +				WARN_ON(1);
> +#else
>  			f2fs_bug_on(sbi, 1);
> +#endif
> +		}
>  		if (f2fs_discard_en(sbi) &&
>  			f2fs_test_and_clear_bit(offset, se->discard_map))
>  			sbi->discard_blks++;
> @@ -2357,6 +2375,13 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  				!sit_i->sentries[start].ckpt_valid_map)
>  			return -ENOMEM;
> 
> +#ifdef CONFIG_F2FS_CHECK_FS
> +		sit_i->sentries[start].cur_valid_map_mir
> +			= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> +		if (!sit_i->sentries[start].cur_valid_map_mir)
> +			return -ENOMEM;
> +#endif
> +
>  		if (f2fs_discard_en(sbi)) {
>  			sit_i->sentries[start].discard_map
>  				= kzalloc(SIT_VBLOCK_MAP_SIZE, GFP_KERNEL);
> @@ -2786,6 +2811,7 @@ static void destroy_sit_info(struct f2fs_sb_info *sbi)
>  	if (sit_i->sentries) {
>  		for (start = 0; start < MAIN_SEGS(sbi); start++) {
>  			kfree(sit_i->sentries[start].cur_valid_map);

I added:

#ifdef CONFIG_F2FS_CHECK_FS

> +			kfree(sit_i->sentries[start].cur_valid_map_mir);

#endif

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
