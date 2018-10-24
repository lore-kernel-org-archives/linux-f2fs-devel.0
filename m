From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: only flush the single temp bio cache which owns the
 target page
Date: Wed, 24 Oct 2018 17:55:08 +0800
Message-ID: <5a92fd67-5a36-b14e-0c4d-820bcaa86568@huawei.com>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yunlong,

On 2018/10/24 16:10, Yunlong Song wrote:
> Previously, when f2fs finds which temp bio cache owns the target page,
> it will flush all the three temp bio caches, but we only need to flush
> one single bio cache indeed, which can help to keep bio merged.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/data.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 106f116..04ebbad 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -374,7 +374,7 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
>  
>  static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  						struct page *page, nid_t ino,
> -						enum page_type type)
> +						enum page_type type, enum temp_type *owner)
>  {
>  	enum page_type btype = PAGE_TYPE_OF_BIO(type);
>  	enum temp_type temp;
> @@ -392,6 +392,10 @@ static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
>  		if (ret || btype == META)
>  			break;
>  	}
> +	if (!ret || (!inode && !page && !ino))
> +		*owner = NR_TEMP_TYPE;
> +	else
> +		*owner = temp;
>  	return ret;
>  }
>  
> @@ -421,9 +425,14 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>  {
>  	enum temp_type temp;
>  
> -	if (!force && !has_merged_page(sbi, inode, page, ino, type))
> +	if (!force && !has_merged_page(sbi, inode, page, ino, type, &temp))
>  		return;
>  
> +	if (!force && temp != NR_TEMP_TYPE) {
> +		__f2fs_submit_merged_write(sbi, type, temp);

I think we need to add has_merged_page into __f2fs_submit_merged_write to
check whether we should submit bio from different log, otherwise we will
missed to submit bio in below condition:

- f2fs_write_cache_pages
 - add page into bio cache of cold log
 - add page into bio cache of warm log
 - f2fs_submit_merged_write_cond(inode)
   - __f2fs_submit_merged_write(warm) -- missed to submit bio of cold log

Thanks,

> +		return;
> +	}
> +
>  	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
>  
>  		__f2fs_submit_merged_write(sbi, type, temp);
> 
