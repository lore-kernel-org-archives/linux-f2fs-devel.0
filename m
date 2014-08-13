From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 05/13] f2fs: should clear the inline_xattr flag
Date: Wed, 13 Aug 2014 18:19:28 +0800
Message-ID: <009d01cfb6e0$3489cf50$9d9d6df0$@samsung.com>
References: <1407872967-26423-1-git-send-email-jaegeuk@kernel.org>
 <1407872967-26423-5-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1407872967-26423-5-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, August 13, 2014 3:49 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 05/13] f2fs: should clear the inline_xattr flag
> 
> During the recovery, we should clear the inline_xattr flag if its xattr node
> block is recovered.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/node.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 093d799..151045f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1557,26 +1557,25 @@ void recover_inline_xattr(struct inode *inode, struct page *page)
>  	struct page *ipage;
>  	struct f2fs_inode *ri;
> 
> -	if (!f2fs_has_inline_xattr(inode))
> -		return;
> -
>  	if (!IS_INODE(page))
>  		return;
> 
> -	ri = F2FS_INODE(page);
> -	if (!(ri->i_inline & F2FS_INLINE_XATTR))
> -		return;
> -
>  	ipage = get_node_page(sbi, inode->i_ino);
>  	f2fs_bug_on(IS_ERR(ipage));
> 
> +	ri = F2FS_INODE(page);
> +	if (!(ri->i_inline & F2FS_INLINE_XATTR)) {
> +		clear_inode_flag(F2FS_I(inode), FI_INLINE_XATTR);
> +		goto update_inode;
> +	}
> +
>  	dst_addr = inline_xattr_addr(ipage);
>  	src_addr = inline_xattr_addr(page);
>  	inline_size = inline_xattr_size(inode);
> 
>  	f2fs_wait_on_page_writeback(ipage, NODE);
>  	memcpy(dst_addr, src_addr, inline_size);
> -
> +update_inode:
>  	update_inode(inode, ipage);
>  	f2fs_put_page(ipage, 1);
>  }
> --
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
