From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH 07/11] f2fs: enable in-place-update for
	fdatasync
Date: Tue, 29 Jul 2014 09:41:11 +0900
Message-ID: <20140729004111.GA442@lcm>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
	<1406328445-63707-7-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cm224.lee@samsung.com>) id 1XBvVC-0001f4-FR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 00:42:50 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XBvVA-0004OM-Bm
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 00:42:50 +0000
Received: from epcpsbgr2.samsung.com
	(u142.gpu120.samsung.co.kr [203.254.230.142])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N9G000V87B4AY60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Jul 2014 09:42:40 +0900 (KST)
Content-disposition: inline
In-reply-to: <1406328445-63707-7-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On Fri, Jul 25, 2014 at 03:47:21PM -0700, Jaegeuk Kim wrote:
> This patch enforces in-place-updates only when fdatasync is requested.
> If we adopt this in-place-updates for the fdatasync, we can skip to write the
> recovery information.

But, as you know, random write occurs when changing into in-place-updates.
It will degrade write performance. Is there any case in-place-updates is
better, except recovery or high utilization?

Thanks

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h    | 1 +
>  fs/f2fs/file.c    | 7 +++++++
>  fs/f2fs/segment.h | 4 ++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ab36025..8f8685e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -998,6 +998,7 @@ enum {
>  	FI_INLINE_DATA,		/* used for inline data*/
>  	FI_APPEND_WRITE,	/* inode has appended data */
>  	FI_UPDATE_WRITE,	/* inode has in-place-update data */
> +	FI_NEED_IPU,		/* used fo ipu for fdatasync */
>  };
>  
>  static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 121689a..e339856 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -127,11 +127,18 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>  		return 0;
>  
>  	trace_f2fs_sync_file_enter(inode);
> +
> +	/* if fdatasync is triggered, let's do in-place-update */
> +	if (datasync)
> +		set_inode_flag(fi, FI_NEED_IPU);
> +
>  	ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
>  	if (ret) {
>  		trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
>  		return ret;
>  	}
> +	if (datasync)
> +		clear_inode_flag(fi, FI_NEED_IPU);
>  
>  	/*
>  	 * if there is no written data, don't waste time to write recovery info.
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index ee5c75e..55973f7 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -486,6 +486,10 @@ static inline bool need_inplace_update(struct inode *inode)
>  	if (S_ISDIR(inode->i_mode))
>  		return false;
>  
> +	/* this is only set during fdatasync */
> +	if (is_inode_flag_set(F2FS_I(inode), FI_NEED_IPU))
> +		return true;
> +
>  	switch (SM_I(sbi)->ipu_policy) {
>  	case F2FS_IPU_FORCE:
>  		return true;
> -- 
> 1.8.5.2 (Apple Git-48)
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
