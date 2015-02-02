From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: don't trigger recovery for normal umount image
Date: Mon, 2 Feb 2015 15:31:38 -0800
Message-ID: <20150202233138.GC34575@jaegeuk-mac02.mot.com>
References: <008b01d03d34$6926d250$3b7476f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <008b01d03d34$6926d250$3b7476f0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Sat, Jan 31, 2015 at 04:59:49PM +0800, Chao Yu wrote:
> Our recovery option is on by default, so we will try to recover data for
> a normally umounted image when mounting it, but no data will be recovered.
> 
> So it'd be better to skip the recovery for above condition.

No.
We should consider the existing UMOUNT flag written by old f2fs.

Thanks,

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/recovery.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index 188a034..c80c286 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -500,6 +500,9 @@ int recover_fsync_data(struct f2fs_sb_info *sbi)
>  	int err;
>  	bool need_writecp = false;
>  
> +	if (is_set_ckpt_flags(sbi->ckpt, CP_UMOUNT_FLAG))
> +		return 0;
> +
>  	fsync_entry_slab = f2fs_kmem_cache_create("f2fs_fsync_inode_entry",
>  			sizeof(struct fsync_inode_entry));
>  	if (!fsync_entry_slab)
> -- 
> 2.2.1
