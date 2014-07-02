From: Changman Lee <cm224.lee@samsung.com>
Subject: Re: [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le in,
 find_in_block
Date: Wed, 02 Jul 2014 16:49:03 +0900
Message-ID: <20140702074903.GA7854@cm224.lee>
References: <53A950F9.907@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <53A950F9.907@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, f2fs <linux-f2fs-devel@lists.sourceforge.net>, fsdevel <linux-fsdevel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi, Gu

Unfortunately, find_next_bit isn't always better than test_bit.
Refer to commit 5d0c667121bfc8be76d1580f485bddbe73465d1a

I remember that
Perviously, Jaegeuk had changed find_next_bit to test_bit because
find_next_bit spent much cpu time in the case of there is lot of dentries like a postmark.
Sorry, I should have reported this quickly.

On Tue, Jun 24, 2014 at 06:20:41PM +0800, Gu Zheng wrote:
> Use find_next_bit_le rather than test_bit_le to improve search speed
> lightly.
> 
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/dir.c |   43 +++++++++++++++++++++----------------------
>  1 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 3edd561..ba510fb 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -93,42 +93,41 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
>  			const char *name, size_t namelen, int *max_slots,
>  			f2fs_hash_t namehash, struct page **res_page)
>  {
> -	struct f2fs_dir_entry *de;
> -	unsigned long bit_pos = 0;
> +	unsigned long bit_pos = 0, bit_start = 0;
>  	struct f2fs_dentry_block *dentry_blk = kmap(dentry_page);
>  	const void *dentry_bits = &dentry_blk->dentry_bitmap;
> -	int max_len = 0;
>  
> -	while (bit_pos < NR_DENTRY_IN_BLOCK) {
> -		if (!test_bit_le(bit_pos, dentry_bits)) {
> -			if (bit_pos == 0)
> -				max_len = 1;
> -			else if (!test_bit_le(bit_pos - 1, dentry_bits))
> -				max_len++;
> -			bit_pos++;
> -			continue;
> +	while (bit_start < NR_DENTRY_IN_BLOCK) {
> +		struct f2fs_dir_entry *de;
> +		int max_len = 0;
> +
> +		bit_pos = find_next_bit_le(dentry_bits,
> +					NR_DENTRY_IN_BLOCK, bit_start);
> +
> +		max_len = bit_pos - bit_start;
> +		if (max_len > *max_slots) {
> +			*max_slots = max_len;
> +			max_len = 0;
>  		}
> +
> +		if (bit_pos >= NR_DENTRY_IN_BLOCK)
> +			break;
> +
>  		de = &dentry_blk->dentry[bit_pos];
>  		if (early_match_name(name, namelen, namehash, de)) {
>  			if (!memcmp(dentry_blk->filename[bit_pos],
>  							name, namelen)) {
>  				*res_page = dentry_page;
> -				goto found;
> +				return de;
>  			}
>  		}
> -		if (max_len > *max_slots) {
> -			*max_slots = max_len;
> -			max_len = 0;
> -		}
> -		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
> +
> +		bit_start = bit_pos
> +				+ GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
>  	}
>  
> -	de = NULL;
>  	kunmap(dentry_page);
> -found:
> -	if (max_len > *max_slots)
> -		*max_slots = max_len;
> -	return de;
> +	return NULL;
>  }
>  
>  static struct f2fs_dir_entry *find_in_level(struct inode *dir,
> -- 
> 1.7.7
