From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] defrag.f2fs: enhance allocation speed
Date: Sat, 19 Dec 2015 17:44:45 +0800
Message-ID: <5675270D.6040806@kernel.org>
References: <1450476805-98536-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1aAE4P-0005II-Uo
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Dec 2015 09:44:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aAE4P-00085v-2i for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 19 Dec 2015 09:44:57 +0000
In-Reply-To: <1450476805-98536-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 12/19/15 6:13 AM, Jaegeuk Kim wrote:
> This patch improves the allocation speed.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fsck/f2fs.h  |  2 +-
>  fsck/mount.c | 10 ++++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index af5cc40..f990527 100644
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -295,7 +295,7 @@ static inline block_t __end_block_addr(struct f2fs_sb_info *sbi)
>  #define GET_R2L_SEGNO(sbi, segno)	(segno + FREE_I_START_SEGNO(sbi))
>  
>  #define START_BLOCK(sbi, segno)	(SM_I(sbi)->main_blkaddr +		\
> -	(segno << sbi->log_blocks_per_seg))
> +	((segno) << sbi->log_blocks_per_seg))
>  
>  static inline struct curseg_info *CURSEG_I(struct f2fs_sb_info *sbi, int type)
>  {
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 4b38df8..82af895 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1401,9 +1401,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
>  		se = get_seg_entry(sbi, segno);
>  
>  		if (se->valid_blocks == sbi->blocks_per_seg ||
> -				IS_CUR_SEGNO(sbi, segno, type))
> -			goto next;
> -
> +				IS_CUR_SEGNO(sbi, segno, type)) {
> +			*to = left ? START_BLOCK(sbi, segno - 1) :

When traversing leftward, shouldn't next position be

*to = left ? START_BLOCK(sbi, segno) - 1 : ?

Thanks,

> +						START_BLOCK(sbi, segno + 1);
> +			continue;
> +		}
>  		if (se->valid_blocks == 0 && !(segno % sbi->segs_per_sec)) {
>  			struct seg_entry *se2;
>  			int i;
> @@ -1420,7 +1422,7 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
>  		if (se->type == type &&
>  			!f2fs_test_bit(offset, (const char *)se->cur_valid_map))
>  			return 0;
> -next:
> +
>  		*to = left ? *to - 1: *to + 1;
>  	}
>  	return -1;
> 

------------------------------------------------------------------------------
