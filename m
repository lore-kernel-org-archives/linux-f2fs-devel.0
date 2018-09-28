From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: clear PageError on the read path
Date: Fri, 28 Sep 2018 19:58:46 +0800
Message-ID: <04bbaf3a-e1ec-a5ae-a664-68d1299aaeb6@kernel.org>
References: <20180926014617.12369-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926014617.12369-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018-9-26 9:46, Jaegeuk Kim wrote:
> When running fault injection test, I hit somewhat wrong behavior in f2fs_gc ->
> gc_data_segment():
> 
> 0. fault injection generated some PageError'ed pages
> 
> 1. gc_data_segment
>  -> f2fs_get_read_data_page(REQ_RAHEAD)
> 
> 2. move_data_page
>  -> f2fs_get_lock_data_page()
>   -> f2f_get_read_data_page()
>    -> f2fs_submit_page_read()
>     -> submit_bio(READ)
>   -> return EIO due to PageError
>   -> fail to move data
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 41102c227eee..cb3ebcae0398 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -77,7 +77,8 @@ static void __read_end_io(struct bio *bio)
>  		/* PG_error was set if any post_read step failed */
>  		if (bio->bi_status || PageError(page)) {
>  			ClearPageUptodate(page);
> -			SetPageError(page);
> +			/* will re-read again later */
> +			ClearPageError(page);
>  		} else {
>  			SetPageUptodate(page);

How about:

if (PaegeError(page))
	ClearPageError(page);

if (bio->bi_status) {
	ClearPageUptodate(page);
	SetPageError(page);
} else {
	SetPageUptodate(page);
	ClearPageError(page);
}

So that below codes are not needed.

Thanks,

>  		}
> @@ -591,6 +592,7 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>  		bio_put(bio);
>  		return -EFAULT;
>  	}
> +	ClearPageError(page);
>  	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>  	return 0;
>  }
> @@ -1571,6 +1573,7 @@ static int f2fs_mpage_readpages(struct address_space *mapping,
>  		if (bio_add_page(bio, page, blocksize, 0) < blocksize)
>  			goto submit_and_realloc;
>  
> +		ClearPageError(page);
>  		last_block_in_bio = block_nr;
>  		goto next_page;
>  set_error_page:
> 
