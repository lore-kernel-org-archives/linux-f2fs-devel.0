From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: rebuild sit page from sit info in
 mem
Date: Thu, 25 Jan 2018 15:27:16 +0800
Message-ID: <d3cafa85-f5e3-e6cb-a5d4-3225dff2ae18@huawei.com>
References: <1516852429-27641-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eebwd-0007J6-4u
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 07:27:35 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eebwb-00073y-Pb
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Jan 2018 07:27:35 +0000
In-Reply-To: <1516852429-27641-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: ning.jia@huawei.com

On 2018/1/25 11:53, Yunlei He wrote:
> This patch rebuild sit page from sit info in mem instead
> of issue a read io.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/segment.c | 19 +++++--------------
>  fs/f2fs/segment.h | 24 ++++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e5739ce..e448b75 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3113,28 +3113,19 @@ static struct page *get_next_sit_page(struct f2fs_sb_info *sbi,
>  					unsigned int start)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
> -	struct page *src_page, *dst_page;
> +	struct page *page;
>  	pgoff_t src_off, dst_off;
> -	void *src_addr, *dst_addr;
>  
>  	src_off = current_sit_addr(sbi, start);
>  	dst_off = next_sit_addr(sbi, src_off);
>  
> -	/* get current sit block page without lock */
> -	src_page = get_meta_page(sbi, src_off);
> -	dst_page = grab_meta_page(sbi, dst_off);
> -	f2fs_bug_on(sbi, PageDirty(src_page));
> -
> -	src_addr = page_address(src_page);
> -	dst_addr = page_address(dst_page);
> -	memcpy(dst_addr, src_addr, PAGE_SIZE);
> -
> -	set_page_dirty(dst_page);
> -	f2fs_put_page(src_page, 1);
> +	page = grab_meta_page(sbi, dst_off);
> +	seg_info_to_sit_page(sbi, page, start);
>  
> +	set_page_dirty(page);
>  	set_to_next_sit(sit_i, start);
>  
> -	return dst_page;
> +	return page;
>  }
>  
>  static struct sit_entry_set *grab_sit_entry_set(void)
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 1a807e6..ee39fd6 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -348,6 +348,30 @@ static inline void seg_info_from_raw_sit(struct seg_entry *se,
>  	se->mtime = le64_to_cpu(rs->mtime);
>  }
>  
> +static inline void seg_info_to_sit_page(struct f2fs_sb_info *sbi,
> +				struct page *page, unsigned int start)
> +{
> +	struct f2fs_sit_block *raw_sit;
> +	unsigned short raw_vblocks;
> +	struct seg_entry *se;
> +	struct f2fs_sit_entry *rs;
> +	unsigned int end = min(start + SIT_ENTRY_PER_BLOCK,
> +					(unsigned long)MAIN_SEGS(sbi));
> +	int i;
> +
> +	raw_sit = (struct f2fs_sit_block *)page_address(page);
> +	for (i = 0; i < end - start; i++) {
> +		rs = &raw_sit->entries[i];
> +		se = get_seg_entry(sbi, start + i);
> +		raw_vblocks = (se->type << SIT_VBLOCKS_SHIFT) |
> +						se->valid_blocks;
> +		rs->vblocks = cpu_to_le16(raw_vblocks);
> +		memcpy(rs->valid_map, se->cur_valid_map,
> +						SIT_VBLOCK_MAP_SIZE);
> +		rs->mtime = cpu_to_le64(se->mtime);
> +	}
> +}

Looks more clean than previous one, but still there are reduplicated codes
there.

How about splitting seg_info_to_raw_sit as below, and reuse
__seg_info_to_raw_sit in seg_info_to_sit_page?

static inline void __seg_info_to_raw_sit(struct seg_entry *se,
					struct f2fs_sit_entry *rs)
{
	unsigned short raw_vblocks = (se->type << SIT_VBLOCKS_SHIFT) |
					se->valid_blocks;
	rs->vblocks = cpu_to_le16(raw_vblocks);
	memcpy(rs->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
	rs->mtime = cpu_to_le64(se->mtime);
}
static inline void seg_info_to_raw_sit(struct seg_entry *se,
					struct f2fs_sit_entry *rs)
{
	__seg_info_to_raw_sit(se, rs);

	memcpy(se->ckpt_valid_map, rs->valid_map, SIT_VBLOCK_MAP_SIZE);
	se->ckpt_valid_blocks = se->valid_blocks;
}

Thanks,

> +
>  static inline void seg_info_to_raw_sit(struct seg_entry *se,
>  					struct f2fs_sit_entry *rs)
>  {
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
