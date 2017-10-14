From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: update dirty status for CURSEG as
 well
Date: Sat, 14 Oct 2017 08:14:35 +0800
Message-ID: <72f5511f-dcd4-939b-661f-f333738ee691@kernel.org>
References: <1507728318-113117-1-git-send-email-yunlong.song@huawei.com>
 <1507900897-156286-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e3A6P-0008CS-HP
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Oct 2017 00:14:53 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e3A6O-0008Ft-KT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Oct 2017 00:14:53 +0000
In-Reply-To: <1507900897-156286-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/13 21:21, Yunlong Song wrote:
> Without this patch, it will cause all the free segments using up in some
> corner case. For example, there are 100 segments, and 20 of them are
> reserved for ovp. If 79 segments are full of data, segment 80 becomes
> CURSEG segment, write 512 blocks and then delete 511 blocks. Since it is
> CURSEG segment, the __locate_dirty_segment will not update its dirty
> status. Then the dirty_segments(sbi) is 0, f2fs_gc will fail to
> get_victim, and f2fs_balance_fs will fail to trigger gc action. After
> f2fs_balance_fs returns, f2fs can continue to write data to segment 81.
> Again, segment 81 becomes CURSEG segment, write 512 blocks and delete
> 511 blocks, the dirty_segments(sbi) is 0 and f2fs_gc fail again. This
> can finally use up all the free segments and cause panic.

Look into this patch again, I found refresh_sit_entry is called after
->allocate_segment, so if all 512 blocks were allocated, log header should
have been moved to another segment, so locate_dirty_segment in
refresh_sit_entry should update dirty status of previous segment correctly,
anything I'm missing?

Thanks,

> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/segment.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index bfbcff8..0fce076 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -687,7 +687,7 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  
>  	/* need not be added */
> -	if (IS_CURSEG(sbi, segno))
> +	if (IS_CURSEG(sbi, segno) && dirty_type == PRE)
>  		return;
>  
>  	if (!test_and_set_bit(segno, dirty_i->dirty_segmap[dirty_type]))
> @@ -737,7 +737,7 @@ static void locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno)
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	unsigned short valid_blocks;
>  
> -	if (segno == NULL_SEGNO || IS_CURSEG(sbi, segno))
> +	if (segno == NULL_SEGNO)
>  		return;
>  
>  	mutex_lock(&dirty_i->seglist_lock);
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
