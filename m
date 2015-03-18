From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 4/4] f2fs: avoid wrong f2fs_bug_on when
	truncating inline_data
Date: Wed, 18 Mar 2015 09:12:00 +0800
Message-ID: <006d01d06118$a3a23390$eae69ab0$@samsung.com>
References: <1426611461-690-1-git-send-email-jaegeuk@kernel.org>
 <1426611461-690-4-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426611461-690-4-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, March 18, 2015 12:58 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 4/4] f2fs: avoid wrong f2fs_bug_on when truncating inline_data
> 
> This patch removes wrong f2fs_bug_on in truncate_inline_inode.
> 
> When there is no space, it can happen a corner case where i_isze is over
> MAX_INLINE_SIZE while its inode is still inline_data.
> 
> The scenario is
>  1. write small data into file #A.
>  2. fill the whole partition to 100%.
>  3. truncate 4096 on file #A.

If we truncate size over MAX_INLINE_DATA, we will convert inline data in
f2fs_truncate rather than write_begin below. isn't it?

Thanks,

>  4. write data at 8192 offset.
>   --> f2fs_write_begin
>     -> -ENOSPC = f2fs_convert_inline_page
>     -> f2fs_write_failed
>       -> truncate_blocks
>         -> truncate_inline_inode
> 	  BUG_ON, since i_size is 4096.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/inline.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 153c5e7..d3e0599 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -54,13 +54,6 @@ bool truncate_inline_inode(struct page *ipage, u64 from)
>  {
>  	void *addr;
> 
> -	/*
> -	 * we should never truncate inline data past max inline data size,
> -	 * because we always convert inline inode to normal one before
> -	 * truncating real data if new size is past max inline data size.
> -	 */
> -	f2fs_bug_on(F2FS_P_SB(ipage), from > MAX_INLINE_DATA);
> -
>  	if (from >= MAX_INLINE_DATA)
>  		return false;
> 
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
