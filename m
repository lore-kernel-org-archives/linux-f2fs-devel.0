From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: introduce get_checkpoint_version for cleanup
Date: Thu, 29 Sep 2016 19:37:32 +0800
Message-ID: <d61454bb-59f8-580f-cb4a-3eb490eae12d@huawei.com>
References: <4d39a005.249.1576cebd52c.Coremail.kernelpatch@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4d39a005.249.1576cebd52c.Coremail.kernelpatch@126.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tiezhu Yang <kernelpatch@126.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/9/28 2:32, Tiezhu Yang wrote:
> There exists almost same codes when get the value of pre_version
> and cur_version in function validate_checkpoint, this patch adds
> get_checkpoint_version to clean up redundant codes.
> 
> Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
> ---
>  fs/f2fs/checkpoint.c | 68 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index de8693c..06992a7 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -663,45 +663,57 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>  	}
>  }
>  
> -static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
> -				block_t cp_addr, unsigned long long *version)
> +static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
> +		struct f2fs_checkpoint **cp_block, struct page **cp_page,
> +		unsigned long long *version)
>  {
> -	struct page *cp_page_1, *cp_page_2 = NULL;
>  	unsigned long blk_size = sbi->blocksize;
> -	struct f2fs_checkpoint *cp_block;
> -	unsigned long long cur_version = 0, pre_version = 0;
> -	size_t crc_offset;
> +	size_t crc_offset = 0;
>  	__u32 crc = 0;
>  
> -	/* Read the 1st cp block in this CP pack */
> -	cp_page_1 = get_meta_page(sbi, cp_addr);
> +	*cp_page = get_meta_page(sbi, cp_addr);
> +	*cp_block = (struct f2fs_checkpoint *)page_address(*cp_page);
>  
> -	/* get the version number */
> -	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_1);
> -	crc_offset = le32_to_cpu(cp_block->checksum_offset);
> -	if (crc_offset >= blk_size)
> -		goto invalid_cp1;
> +	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
> +	if (crc_offset >= blk_size) {
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"%s: crc_offset is greater than or equal to blk_size.",
> +			__func__);

Trivial thing:

f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc_offset:%ld", crc_offset);

> +		return -EINVAL;
> +	}
>  
> -	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
> -	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
> -		goto invalid_cp1;
> +	crc = le32_to_cpu(*((__le32 *)((unsigned char *)*cp_block
> +							+ crc_offset)));
> +	if (!f2fs_crc_valid(sbi, crc, *cp_block, crc_offset)) {
> +		f2fs_msg(sbi->sb, KERN_WARNING,
> +			"%s: f2fs_crc_valid returns false.", __func__);

f2fs_msg(sbi->sb, KERN_WARNING, "invalid crc value");

Rather than that, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> +		return -EINVAL;
> +	}
>  
> -	pre_version = cur_cp_version(cp_block);
> +	*version = cur_cp_version(*cp_block);
> +	return 0;
> +}
>  
> -	/* Read the 2nd cp block in this CP pack */
> -	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
> -	cp_page_2 = get_meta_page(sbi, cp_addr);
> +static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
> +				block_t cp_addr, unsigned long long *version)
> +{
> +	struct page *cp_page_1 = NULL, *cp_page_2 = NULL;
> +	struct f2fs_checkpoint *cp_block = NULL;
> +	unsigned long long cur_version = 0, pre_version = 0;
> +	int err;
>  
> -	cp_block = (struct f2fs_checkpoint *)page_address(cp_page_2);
> -	crc_offset = le32_to_cpu(cp_block->checksum_offset);
> -	if (crc_offset >= blk_size)
> -		goto invalid_cp2;
> +	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
> +					&cp_page_1, version);
> +	if (err)
> +		goto invalid_cp1;
> +	pre_version = *version;
>  
> -	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
> -	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
> +	cp_addr += le32_to_cpu(cp_block->cp_pack_total_block_count) - 1;
> +	err = get_checkpoint_version(sbi, cp_addr, &cp_block,
> +					&cp_page_2, version);
> +	if (err)
>  		goto invalid_cp2;
> -
> -	cur_version = cur_cp_version(cp_block);
> +	cur_version = *version;
>  
>  	if (cur_version == pre_version) {
>  		*version = cur_version;
> 
