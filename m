From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix to determine start_cp_addr by sbi->cur_cp_pack
Date: Sat, 10 Dec 2016 15:40:02 +0800
Message-ID: <6ded2a84-51fb-ec54-2bcc-2b82c1f28b8f@huawei.com>
References: <20161125023236.80473-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161125023236.80473-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

Let me try to understand this, in some cases, we can write a checkpoint pack
which has wrong cp_ver, like in 1st cp pack which has even version number or 2nd
cp pack which has odd version number, so if we load that kind of cp pack during
fill_super, we may load wrong summary data from another older cp pack which cp
version pointed to, is that right?

Thanks,

On 2016/11/25 10:32, Jaegeuk Kim wrote:
> We don't guarantee cp_addr is fixed by cp_version.
> This is to sync with f2fs-tools.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  5 +++++
>  fs/f2fs/f2fs.h       | 14 +++-----------
>  2 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 54cc6a9..bf2f44c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -789,6 +789,11 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  		f2fs_put_page(cur_page, 1);
>  	}
>  done:
> +	if (cur_page == cp1)
> +		sbi->cur_cp_pack = 1;
> +	else
> +		sbi->cur_cp_pack = 2;
> +
>  	f2fs_put_page(cp1, 1);
>  	f2fs_put_page(cp2, 1);
>  	return 0;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 62383d2..e22e7e1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -792,6 +792,7 @@ struct f2fs_sb_info {
>  
>  	/* for checkpoint */
>  	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
> +	int cur_cp_pack;			/* remain current cp pack */
>  	spinlock_t cp_lock;			/* for flag in ckpt */
>  	struct inode *meta_inode;		/* cache meta blocks */
>  	struct mutex cp_mutex;			/* checkpoint procedure lock */
> @@ -1352,19 +1353,10 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>  
>  static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
>  {
> -	block_t start_addr;
> -	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> -	unsigned long long ckpt_version = cur_cp_version(ckpt);
> -
> -	start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
> +	block_t start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
>  
> -	/*
> -	 * odd numbered checkpoint should at cp segment 0
> -	 * and even segment must be at cp segment 1
> -	 */
> -	if (!(ckpt_version & 1))
> +	if (sbi->cur_cp_pack == 2)
>  		start_addr += sbi->blocks_per_seg;
> -
>  	return start_addr;
>  }
>  
> 
