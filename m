From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/3] f2fs: use i_size_read to get i_size
Date: Tue, 29 Dec 2015 17:18:19 +0800
Message-ID: <00cd01d14219$f6d317e0$e47947a0$@samsung.com>
References: <1451345497-65784-1-git-send-email-jaegeuk@kernel.org>
 <1451345497-65784-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1451345497-65784-2-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Tuesday, December 29, 2015 7:32 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 2/3] f2fs: use i_size_read to get i_size
> 
> We need to use i_size_read() to get inode->i_size.

All callers of f2fs_write_failed should be protected by i_mutex, so no
one can change i_size, do we really need to use i_size_read here?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f34f42a..8a89810 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1386,10 +1386,11 @@ skip_write:
>  static void f2fs_write_failed(struct address_space *mapping, loff_t to)
>  {
>  	struct inode *inode = mapping->host;
> +	loff_t i_size = i_size_read(inode);
> 
> -	if (to > inode->i_size) {
> -		truncate_pagecache(inode, inode->i_size);
> -		truncate_blocks(inode, inode->i_size, true);
> +	if (to > i_size) {
> +		truncate_pagecache(inode, i_size);
> +		truncate_blocks(inode, i_size, true);
>  	}
>  }
> 
> --
> 2.5.4 (Apple Git-61)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
