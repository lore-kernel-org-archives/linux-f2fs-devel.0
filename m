From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH RFC] f2fs: clean up build_sit_entries
Date: Tue, 19 Dec 2017 15:40:46 -0800
Message-ID: <20171219234046.GF23445@jaegeuk-macbookpro.roam.corp.google.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCB4020@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eRRVG-0004SH-Do
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Dec 2017 23:40:54 +0000
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eRRVF-0002IN-Cz
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Dec 2017 23:40:54 +0000
Content-Disposition: inline
In-Reply-To: <9047C53C18267742AB12E43B65C7F9F70BCB4020@dggemi505-mbs.china.huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "gaoxiang (P)" <gaoxiang25@huawei.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Duwei (Device OS)" <weidu.du@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

On 12/17, gaoxiang (P) wrote:
> clean up some redundant repeat code in build_sit_entries
> and seperate some logic into new functions:
>  - build_discard_entries
>  - build_sec_entries

This patch makes another big loop redundantly?

> 
> Note that "if (f2fs_discard_en(sbi))" and "if (sbi->segs_per_sec > 1)"
> are all taken out of the loops they are unchangable.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
>  fs/f2fs/segment.c | 80 +++++++++++++++++++++++++------------------------------
>  1 file changed, 37 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 40e1d20..bcd8a40 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3476,12 +3476,39 @@ static int build_curseg(struct f2fs_sb_info *sbi)
>  	return restore_curseg_summaries(sbi);
>  }
>  
> +static void build_discard_entries(struct f2fs_sb_info *sbi)
> +{
> +	unsigned segno;
> +
> +	for (segno = 0; segno < MAIN_SEGS(sbi); ++segno) {
> +		struct seg_entry *se = get_seg_entry(sbi, segno);
> +
> +		if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG))
> +			memset(se->discard_map, 0xff, SIT_VBLOCK_MAP_SIZE);
> +		else {
> +			memcpy(se->discard_map, se->cur_valid_map,
> +				SIT_VBLOCK_MAP_SIZE);
> +
> +			sbi->discard_blks += sbi->blocks_per_seg -
> +				se->valid_blocks;
> +		}
> +	}
> +}
> +
> +static void build_sec_entries(struct f2fs_sb_info *sbi)
> +{
> +	unsigned segno;
> +
> +	for (segno = 0; segno < MAIN_SEGS(sbi); ++segno)
> +		get_sec_entry(sbi, segno)->valid_blocks +=
> +			get_seg_entry(sbi, segno)->valid_blocks;
> +}
> +
>  static void build_sit_entries(struct f2fs_sb_info *sbi)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_COLD_DATA);
>  	struct f2fs_journal *journal = curseg->journal;
> -	struct seg_entry *se;
>  	struct f2fs_sit_entry sit;
>  	int sit_blk_cnt = SIT_BLK_CNT(sbi);
>  	unsigned int i, start, end;
> @@ -3498,67 +3525,34 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
>  			struct f2fs_sit_block *sit_blk;
>  			struct page *page;
>  
> -			se = &sit_i->sentries[start];
>  			page = get_current_sit_page(sbi, start);
>  			sit_blk = (struct f2fs_sit_block *)page_address(page);
>  			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
>  			f2fs_put_page(page, 1);
>  
>  			check_block_count(sbi, start, &sit);
> -			seg_info_from_raw_sit(se, &sit);
> -
> -			/* build discard map only one time */
> -			if (f2fs_discard_en(sbi)) {
> -				if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
> -					memset(se->discard_map, 0xff,
> -						SIT_VBLOCK_MAP_SIZE);
> -				} else {
> -					memcpy(se->discard_map,
> -						se->cur_valid_map,
> -						SIT_VBLOCK_MAP_SIZE);
> -					sbi->discard_blks +=
> -						sbi->blocks_per_seg -
> -						se->valid_blocks;
> -				}
> -			}
>  
> -			if (sbi->segs_per_sec > 1)
> -				get_sec_entry(sbi, start)->valid_blocks +=
> -							se->valid_blocks;
> +			seg_info_from_raw_sit(&sit_i->sentries[start], &sit);
>  		}
>  		start_blk += readed;
>  	} while (start_blk < sit_blk_cnt);
>  
>  	down_read(&curseg->journal_rwsem);
>  	for (i = 0; i < sits_in_cursum(journal); i++) {
> -		unsigned int old_valid_blocks;
> -
>  		start = le32_to_cpu(segno_in_journal(journal, i));
> -		se = &sit_i->sentries[start];
>  		sit = sit_in_journal(journal, i);
>  
> -		old_valid_blocks = se->valid_blocks;
> -
>  		check_block_count(sbi, start, &sit);
> -		seg_info_from_raw_sit(se, &sit);
> -
> -		if (f2fs_discard_en(sbi)) {
> -			if (is_set_ckpt_flags(sbi, CP_TRIMMED_FLAG)) {
> -				memset(se->discard_map, 0xff,
> -							SIT_VBLOCK_MAP_SIZE);
> -			} else {
> -				memcpy(se->discard_map, se->cur_valid_map,
> -							SIT_VBLOCK_MAP_SIZE);
> -				sbi->discard_blks += old_valid_blocks -
> -							se->valid_blocks;
> -			}
> -		}
> -
> -		if (sbi->segs_per_sec > 1)
> -			get_sec_entry(sbi, start)->valid_blocks +=
> -				se->valid_blocks - old_valid_blocks;
> +		seg_info_from_raw_sit(&sit_i->sentries[start], &sit);
>  	}
>  	up_read(&curseg->journal_rwsem);
> +
> +	/* build discard map only one time */
> +	if (f2fs_discard_en(sbi))
> +		build_discard_entries(sbi);
> +
> +	if (sbi->segs_per_sec > 1)
> +		build_sec_entries(sbi);
>  }
>  
>  static void init_free_segmap(struct f2fs_sb_info *sbi)
> -- 
> 2.1.4

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
