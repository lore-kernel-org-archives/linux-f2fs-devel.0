From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: flush cp pack except cp pack 2 page
 at first
Date: Thu, 25 Jan 2018 14:06:00 -0800
Message-ID: <20180125220600.GB22514@jaegeuk-macbookpro.roam.corp.google.com>
References: <9047C53C18267742AB12E43B65C7F9F70BCD2F67@dggemi505-mbs.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9047C53C18267742AB12E43B65C7F9F70BCD2F67@dggemi505-mbs.china.huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: "Gaoxiang (OS)" <gaoxiang25@huawei.com>
Cc: Chao Yu <chao@kernel.org>, "Yuchao (T)" <yuchao0@huawei.com>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, heyunlei <heyunlei@huawei.com>, hutj <hutj@huawei.com>, "Duwei (Device OS)" <weidu.du@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 01/25, Gaoxiang (OS) wrote:
> Previously, we attempt to flush the whole cp pack in a single bio,
> however, when suddenly powering off at this time, we could get into
> an extreme scenario that cp pack 1 page and cp pack 2 page are updated
> and latest, but payload or current summaries are still partially
> outdated. (see reliable write in the UFS specification)
> 
> This patch submits the whole cp pack except cp pack 2 page at first,
> and then writes the cp pack 2 page with an extra independent
> bio with pre-io barrier.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> ---
> Change log from v2:
>   - Apply the review comments from Chao
> Change log from v1:
>   - Apply the review comments from Chao
>   - time data from "finish block_ops" to " finish checkpoint" (tested on ARM64 with TOSHIBA 128GB UFS):
>      Before patch: 0.002273  0.001973  0.002789  0.005159  0.002050
>      After patch: 0.002502  0.001624  0.002487  0.003049  0.002696
>  fs/f2fs/checkpoint.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 14d2fed..c1f4b10 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -300,6 +300,33 @@ static int f2fs_write_meta_pages(struct address_space *mapping,
>  	return 0;
>  }
>  
> +static void commit_checkpoint(struct f2fs_sb_info *sbi,
> +	void *src, block_t blk_addr)
> +{
> +	struct writeback_control wbc = {
> +		.for_reclaim = 0,
> +	};
> +	struct page *page = grab_meta_page(sbi, blk_addr);
> +	int err;
> +
> +	memcpy(page_address(page), src, PAGE_SIZE);
> +	set_page_dirty(page);
> +
> +	f2fs_wait_on_page_writeback(page, META, true);
> +	f2fs_bug_on(sbi, PageWriteback(page));
> +	if (unlikely(!clear_page_dirty_for_io(page)))
> +		f2fs_bug_on(sbi, 1);
> +
> +	/* writeout cp pack 2 page */
> +	err = __f2fs_write_meta_page(page, &wbc, FS_CP_META_IO);
> +	f2fs_bug_on(sbi, err);
> +
> +	f2fs_put_page(page, 0);
> +
> +	/* submit checkpoint with barrier */
> +	f2fs_submit_merged_write(sbi, META_FLUSH);
> +}
> +
>  long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
>  				long nr_to_write, enum iostat_type io_type)
>  {
> @@ -1297,9 +1324,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		start_blk += NR_CURSEG_NODE_TYPE;
>  	}
>  
> -	/* writeout checkpoint block */
> -	update_meta_page(sbi, ckpt, start_blk);
> -
>  	/* wait for previous submitted node/meta pages writeback */
>  	wait_on_all_pages_writeback(sbi);

Then, we don't need to wait for this as well as wait_on_all_pages_writeback()
in the early stage in do_checkpoint()?

So, it seems like we can modify like below:

---
1. while (get_pages())
	sync_meta_pages()
2. if (enabled_nat_bits())
	while (get_pages())
		sync_meta_pages()

3. wait_on_all_pages_writeback()
 -> remove

4. f2fs_flush_device_cache()

5. update_meta_page() <- for first cp_block

6. update_meta_page()... <- payload

7. orphan writes

8. node_summary writes

9. update_meta_page() <- for last cp_block
 -> remove

10. wait_on_all_pages_writeback()

----
Add) 11. commit_checkpoint()
  - update_meta_page() <- for last cp_block
  - sync_meta_pages(META_FLUSH)

We don't need to wait for page_writeback any more.

>  
> @@ -1313,10 +1337,15 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>  	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>  
> -	/* Here, we only have one bio having CP pack */
> -	sync_meta_pages(sbi, META_FLUSH, LONG_MAX, FS_CP_META_IO);
> +	/* Here, we have one bio having CP pack except cp pack 2 page */
> +	sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>  
>  	/* wait for previous submitted meta pages writeback */
> +	if (!test_opt(sbi, NOBARRIER))

The above has nothing to do with this patch.

> +		wait_on_all_pages_writeback(sbi);
> +
> +	/* barrier and flush checkpoint cp pack 2 page */
> +	commit_checkpoint(sbi, ckpt, start_blk);
>  	wait_on_all_pages_writeback(sbi);
>  
>  	release_ino_entry(sbi, false);
> -- 
> 2.1.4
