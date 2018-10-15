From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clear cold data flag if IO is not
 counted
Date: Mon, 15 Oct 2018 20:38:01 +0800
Message-ID: <3f08031e-d195-5bc1-67e1-f3b6eab3506b@huawei.com>
References: <20181010212217.52289-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010212217.52289-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/10/11 5:22, Jaegeuk Kim wrote:
> If we clear the cold data flag out of the writeback flow, we can miscount
> -1 by end_io.

I didn't get it, which count do you mean?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 29a9d3b8f709..4102799b5558 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2636,10 +2636,6 @@ static int f2fs_set_data_page_dirty(struct page *page)
>  	if (!PageUptodate(page))
>  		SetPageUptodate(page);
>  
> -	/* don't remain PG_checked flag which was set during GC */
> -	if (is_cold_data(page))
> -		clear_cold_data(page);
> -
>  	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
>  		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
>  			f2fs_register_inmem_page(inode, page);
> 
