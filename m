From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: set dirty state for filesystem only when updating
 meta data
Date: Thu, 18 Aug 2016 17:45:12 +0800
Message-ID: <88352fee-4f32-1600-60e3-3bd30a98f96f@huawei.com>
References: <20160818090523.57556-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818090523.57556-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/8/18 17:05, Chao Yu wrote:
> We don't guarantee integrity of user data after checkpoint, since we only
> guarantee meta data integrity for data consistency of filesystem.
> 
> Due to above reason, we only need to set fs as dirty when meta data is
> updated, so that we can skip writing checkpoint in some case of non-meta
> data is updated.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5a10bce..1659d10 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1220,7 +1220,9 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
>  static inline void inc_page_count(struct f2fs_sb_info *sbi, int count_type)
>  {
>  	percpu_counter_inc(&sbi->nr_pages[count_type]);
> -	set_sbi_flag(sbi, SBI_IS_DIRTY);
> +	if (count_type == F2FS_DIRTY_DENTS || count_type == F2FS_DIRTY_NODES ||
> +			count_type == F2FS_DIRTY_META)

Sorry, I miss one condition here, please ignore this patch.

Thanks,

> +		set_sbi_flag(sbi, SBI_IS_DIRTY);
>  }
>  
>  static inline void inode_inc_dirty_pages(struct inode *inode)
> 
