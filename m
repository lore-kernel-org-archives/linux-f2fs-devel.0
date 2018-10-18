From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix to account IO correctly
Date: Thu, 18 Oct 2018 12:06:12 -0700
Message-ID: <20181018190612.GD50556@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181017094954.67547-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181017094954.67547-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net


On 10/17, Chao Yu wrote:
> Below race can cause reversed reference on F2FS_RD_DATA, there is
> the same issue in f2fs_submit_page_bio(), fix them by relocate
> __submit_bio() and inc_page_count.
> 
> Thread A			Thread B
> - f2fs_write_begin
>  - f2fs_submit_page_read
>  - __submit_bio
> 				- f2fs_read_end_io
> 				 - __read_end_io
> 				 - dec_page_count(, F2FS_RD_DATA)
>  - inc_page_count(, F2FS_RD_DATA)

Let me integrate the change into the original patch and test a bit.

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index c03bd0c2ed22..8b9240762156 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -480,10 +480,10 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	}
>  	bio_set_op_attrs(bio, fio->op, fio->op_flags);
>  
> -	__submit_bio(fio->sbi, bio, fio->type);
> -
>  	inc_page_count(fio->sbi, is_read_io(fio->op) ?
>  			__read_io_type(page): WB_DATA_TYPE(fio->page));
> +
> +	__submit_bio(fio->sbi, bio, fio->type);
>  	return 0;
>  }
>  
> @@ -612,8 +612,8 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>  		return -EFAULT;
>  	}
>  	ClearPageError(page);
> -	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>  	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
> +	__submit_bio(F2FS_I_SB(inode), bio, DATA);
>  	return 0;
>  }
>  
> -- 
> 2.18.0.rc1
