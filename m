From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: support checkpoint error injection
Date: Fri, 23 Sep 2016 16:53:45 -0700
Message-ID: <20160923235345.GA23989@jaegeuk>
References: <20160923052458.83849-1-yuchao0@huawei.com>
 <20160923052458.83849-2-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160923052458.83849-2-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

The basic rule is to stop every operations once CP_ERROR_FLAG is set.
But, this patch simply breaks the rule.
For example, f2fs_write_data_page() currently exits with mapping_set_error().
So this patch incurs missing dentry blocks in a valid checkpoint.

Thanks,

On Fri, Sep 23, 2016 at 01:24:57PM +0800, Chao Yu wrote:
> This patch adds to support checkpoint error injection in f2fs for testing
> fatal error tolerance.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h  | 7 +++++++
>  fs/f2fs/super.c | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e216bc0..3c513fe 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -47,6 +47,7 @@ enum {
>  	FAULT_DIR_DEPTH,
>  	FAULT_EVICT_INODE,
>  	FAULT_IO,
> +	FAULT_CHECKPOINT,
>  	FAULT_MAX,
>  };
>  
> @@ -80,6 +81,8 @@ static inline bool time_to_inject(int type)
>  		return false;
>  	else if (type == FAULT_IO && !IS_FAULT_SET(type))
>  		return false;
> +	else if (type == FAULT_CHECKPOINT && !IS_FAULT_SET(type))
> +		return false;
>  
>  	atomic_inc(&f2fs_fault.inject_ops);
>  	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
> @@ -1873,6 +1876,10 @@ static inline int f2fs_readonly(struct super_block *sb)
>  
>  static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
>  {
> +#ifdef CONFIG_F2FS_FAULT_INJECTION
> +	if (time_to_inject(FAULT_CHECKPOINT))
> +		return true;
> +#endif
>  	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
>  }
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6426855..3c49419 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -51,6 +51,7 @@ char *fault_name[FAULT_MAX] = {
>  	[FAULT_DIR_DEPTH]	= "too big dir depth",
>  	[FAULT_EVICT_INODE]	= "evict_inode fail",
>  	[FAULT_IO]		= "IO error",
> +	[FAULT_CHECKPOINT]	= "checkpoint error",
>  };
>  
>  static void f2fs_build_fault_attr(unsigned int rate)
> -- 
> 2.8.2.311.gee88674
