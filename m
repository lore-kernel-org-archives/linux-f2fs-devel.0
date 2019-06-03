From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 3/4] f2fs: Fix accounting for unusable blocks
Date: Mon, 3 Jun 2019 18:39:29 +0800
Message-ID: <c99079bd-99e1-e100-08f6-1e8adae5e722@huawei.com>
References: <20190530004906.261170-1-drosen@google.com>
 <20190530004906.261170-4-drosen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190530004906.261170-4-drosen@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/5/30 8:49, Daniel Rosenberg wrote:
> Fixes possible underflows when dealing with unusable blocks.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/f2fs.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9b3d9977cd1ef..a39cc4ffeb4b1 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1769,8 +1769,12 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
>  
>  	if (!__allow_reserved_blocks(sbi, inode, true))
>  		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> -	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -		avail_user_block_count -= sbi->unusable_block_count;
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +		if (avail_user_block_count > sbi->unusable_block_count)
> +			avail_user_block_count = 0;

avail_user_block_count -= sbi->unusable_block_count;

> +		else
> +			avail_user_block_count -= sbi->unusable_block_count;

avail_user_block_count = 0;

Thanks,

> +	}
>  	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
>  		diff = sbi->total_valid_block_count - avail_user_block_count;
>  		if (diff > *count)
> @@ -1970,7 +1974,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  					struct inode *inode, bool is_inode)
>  {
>  	block_t	valid_block_count;
> -	unsigned int valid_node_count;
> +	unsigned int valid_node_count, user_block_count;
>  	int err;
>  
>  	if (is_inode) {
> @@ -1997,10 +2001,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
>  
>  	if (!__allow_reserved_blocks(sbi, inode, false))
>  		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> +	user_block_count = sbi->user_block_count;
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> -		valid_block_count += sbi->unusable_block_count;
> +		user_block_count -= sbi->unusable_block_count;
>  
> -	if (unlikely(valid_block_count > sbi->user_block_count)) {
> +	if (unlikely(valid_block_count > user_block_count)) {
>  		spin_unlock(&sbi->stat_lock);
>  		goto enospc;
>  	}
> 
