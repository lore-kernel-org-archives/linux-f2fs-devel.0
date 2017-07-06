From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid migratepage for atomic written
 page
Date: Thu, 6 Jul 2017 21:38:34 +0800
Message-ID: <e95a37f3-5403-20c8-606f-ed1a55fa67b7@kernel.org>
References: <20170703230820.63929-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170703230820.63929-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

On 2017/7/4 7:08, Jaegeuk Kim wrote:
> In order to avoid lock contention for atomic written pages, we'd better give
> EAGAIN in f2fs_migrate_page. We expect it will be released soon as transaction
> commits.

Hmm.. if atomic write is triggered intensively, there is little change to
migrate fragmented page.

How about detecting migrate mode here, for MIGRATE_SYNC case, let it moving
the page; for MIGRATE_ASYNC/MIGRATE_SYNC_LIGHT case, the migration priority
is lower, we can return EAGAIN.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d58b81213a86..1458e3a6d630 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2197,41 +2197,26 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
>  int f2fs_migrate_page(struct address_space *mapping,
>  		struct page *newpage, struct page *page, enum migrate_mode mode)
>  {
> -	int rc, extra_count;
> -	struct f2fs_inode_info *fi = F2FS_I(mapping->host);
> -	bool atomic_written = IS_ATOMIC_WRITTEN_PAGE(page);
> +	int rc;
>  
> -	BUG_ON(PageWriteback(page));
> -
> -	/* migrating an atomic written page is safe with the inmem_lock hold */
> -	if (atomic_written && !mutex_trylock(&fi->inmem_lock))
> +	/*
> +	 * We'd better return EAGAIN for atomic pages, which will be committed
> +	 * sooner or later. Don't botter transactions with inmem_lock.
> +	 */
> +	if (IS_ATOMIC_WRITTEN_PAGE(page))
>  		return -EAGAIN;
>  
> +	BUG_ON(PageWriteback(page));	/* Writeback must be complete */
> +
>  	/*
>  	 * A reference is expected if PagePrivate set when move mapping,
>  	 * however F2FS breaks this for maintaining dirty page counts when
>  	 * truncating pages. So here adjusting the 'extra_count' make it work.
>  	 */
> -	extra_count = (atomic_written ? 1 : 0) - page_has_private(page);
>  	rc = migrate_page_move_mapping(mapping, newpage,
> -				page, NULL, mode, extra_count);
> -	if (rc != MIGRATEPAGE_SUCCESS) {
> -		if (atomic_written)
> -			mutex_unlock(&fi->inmem_lock);
> +			page, NULL, mode, (page_has_private(page) ? -1 : 0));
> +	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
> -	}
> -
> -	if (atomic_written) {
> -		struct inmem_pages *cur;
> -		list_for_each_entry(cur, &fi->inmem_pages, list)
> -			if (cur->page == page) {
> -				cur->page = newpage;
> -				break;
> -			}
> -		mutex_unlock(&fi->inmem_lock);
> -		put_page(page);
> -		get_page(newpage);
> -	}
>  
>  	if (PagePrivate(page))
>  		SetPagePrivate(newpage);
> 
