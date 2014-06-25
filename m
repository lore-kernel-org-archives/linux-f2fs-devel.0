From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/4] f2fs: use find_next_bit_le rather than
 test_bit_le in, find_in_block
Date: Wed, 25 Jun 2014 10:30:00 +0800
Message-ID: <002f01cf901d$78041ae0$680c50a0$@samsung.com>
References: <53A950F9.907@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <53A950F9.907@cn.fujitsu.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'fsdevel' <linux-fsdevel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Gu,

Just one nitpick.

> -----Original Message-----
> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
> Sent: Tuesday, June 24, 2014 6:21 PM
> To: Jaegeuk Kim
> Cc: fsdevel; f2fs
> Subject: [f2fs-dev] [PATCH 3/4] f2fs: use find_next_bit_le rather than test_bit_le in,
> find_in_block
> 
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

It could be removed here, and also do not need to initialize above.

Thanks.
Yu

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
> 
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

