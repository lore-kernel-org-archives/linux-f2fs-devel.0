From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Copy summary entries in bulk
Date: Tue, 17 Apr 2018 16:12:03 +0800
Message-ID: <61a94754-f84e-9927-79d6-324bf7b67de7@huawei.com>
References: <CGME20180416111043epcas5p3ea799775cd4117bd80a4207982f98548@epcas5p3.samsung.com>
 <000801d3d573$856747d0$9035d770$@samsung.com>
 <000901d3d575$fdbba760$f932f620$@samsung.com>
 <000a01d3d578$fc23c1f0$f46b45d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1f8Ljn-0004FJ-TN
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 08:13:15 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f8Lip-008nCs-GK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Apr 2018 08:13:15 +0000
In-Reply-To: <000a01d3d578$fc23c1f0$f46b45d0$@samsung.com>
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
To: LiFan <fanofcode.li@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/4/16 19:48, LiFan wrote:
> Copy summary entries in bulk in write_compacted_summaries().
> And zero the blank part of page after writing the summaries
> to the page.
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/segment.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 3bc77c2..a08b2a8 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3103,14 +3103,12 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {
>  	struct page *page;
>  	unsigned char *kaddr;
> -	struct f2fs_summary *summary;
>  	struct curseg_info *seg_i;
>  	int written_size = 0;
> -	int i, j;
> +	int i;
>  
>  	page = grab_meta_page(sbi, blkaddr++);
>  	kaddr = (unsigned char *)page_address(page);
> -	memset(kaddr, 0, PAGE_SIZE);
>  
>  	/* Step 1: write nat cache */
>  	seg_i = CURSEG_I(sbi, CURSEG_HOT_DATA);
> @@ -3124,34 +3122,42 @@ static void write_compacted_summaries(struct f2fs_sb_info *sbi, block_t blkaddr)
>  
>  	/* Step 3: write summary entries */
>  	for (i = CURSEG_HOT_DATA; i <= CURSEG_COLD_DATA; i++) {
> -		unsigned short blkoff;
> +		unsigned short blkoff, page_cap, summary_cnt;

blkoff = 0;

> +
>  		seg_i = CURSEG_I(sbi, i);
>  		if (sbi->ckpt->alloc_type[i] == SSR)
>  			blkoff = sbi->blocks_per_seg;

max = sbi->blocks_per_seg;

>  		else
>  			blkoff = curseg_blkoff(sbi, i);

max = curseg_blkoff(sbi, i);

>  
> -		for (j = 0; j < blkoff; j++) {
> +		while (blkoff) {

while (blkoff < max)

>  			if (!page) {
>  				page = grab_meta_page(sbi, blkaddr++);
>  				kaddr = (unsigned char *)page_address(page);
> -				memset(kaddr, 0, PAGE_SIZE);
>  				written_size = 0;
>  			}
> -			summary = (struct f2fs_summary *)(kaddr + written_size);
> -			*summary = seg_i->sum_blk->entries[j];
> -			written_size += SUMMARY_SIZE;
>  
> -			if (written_size + SUMMARY_SIZE <= PAGE_SIZE -
> -							SUM_FOOTER_SIZE)
> -				continue;
> -
> -			set_page_dirty(page);
> -			f2fs_put_page(page, 1);
> -			page = NULL;
> +			page_cap = (PAGE_SIZE - SUM_FOOTER_SIZE - written_size)
> +						/ SUMMARY_SIZE;
> +			summary_cnt = min(page_cap, blkoff);

summary_cnt = min(page_cap, max - blkoff);

> +			memcpy(kaddr + written_size, seg_i->sum_blk->entries,

memcpy(kaddr + written_size, seg_i->sum_blk->entries + blkoff

> +						summary_cnt * SUMMARY_SIZE);

blkoff += summary_cnt;

> +			written_size += summary_cnt * SUMMARY_SIZE;
> +			blkoff -= summary_cnt;

removed.

Thanks,

> +
> +			if (page_cap == summary_cnt) {
> +				memset(kaddr + written_size, 0,
> +						PAGE_SIZE - written_size);
> +				set_page_dirty(page);
> +				f2fs_put_page(page, 1);
> +				page = NULL;
> +			}
>  		}
>  	}
> +
>  	if (page) {
> +		memset(kaddr + written_size, 0,
> +				PAGE_SIZE - written_size);
>  		set_page_dirty(page);
>  		f2fs_put_page(page, 1);
>  	}
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
