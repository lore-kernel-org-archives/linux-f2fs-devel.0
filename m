From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to redirty page if fail to gc data page
Date: Sun, 29 May 2016 19:37:02 -0700
Message-ID: <20160530023702.GB78763@jaegeuk.hsd1.ca.comcast.net>
References: <1463807951-10472-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1463807951-10472-1-git-send-email-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Sat, May 21, 2016 at 01:19:11PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> If we fail to move data page during foreground GC, we should give another
> chance to writeback that page which was set dirty previously by writer.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/gc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 38d56f6..ee213a8 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -653,12 +653,15 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
>  			.page = page,
>  			.encrypted_page = NULL,
>  		};
> +		bool is_dirty = PageDirty(page);
> +
>  		set_page_dirty(page);
>  		f2fs_wait_on_page_writeback(page, DATA, true);
>  		if (clear_page_dirty_for_io(page))
>  			inode_dec_dirty_pages(inode);
>  		set_cold_data(page);
> -		do_write_data_page(&fio);
> +		if (do_write_data_page(&fio) && is_dirty)
> +			set_page_dirty(page);

If this page is truncated with -ENOENT, we don't need to set it dirty again.
I expect that, if we get an error here, do_garbage_collect() would retry FG_GC
again.

Thanks,

>  		clear_cold_data(page);
>  	}
>  out:
> -- 
> 2.7.2
