From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: Allocate and stat mem used by free nid
 bitmap more accurately
Date: Wed, 27 Jun 2018 14:08:07 +0800
Message-ID: <9fe4e8d0-c472-7710-e13a-66eb4ed8287f@huawei.com>
References: <1530067125-21397-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fY3du-0005Dw-44
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jun 2018 06:09:26 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fY3ds-00AQQP-5V
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jun 2018 06:09:26 +0000
In-Reply-To: <1530067125-21397-1-git-send-email-heyunlei@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: zhangdianfang@huawei.com

On 2018/6/27 10:38, Yunlei He wrote:
> This patch used f2fs_bitmap_size macro to calculate mem used by
> free nid bitmap, and stat used mem including aligned part.

We can remove both NAT_ENTRY_BITMAP_SIZE and NAT_ENTRY_BITMAP_SIZE_ALIGNED, and
then using f2fs_bitmap_size instead.

Thanks,

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/debug.c         | 2 +-
>  include/linux/f2fs_fs.h | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 2d65e77..a1f24c5 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -215,7 +215,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>  	si->base_mem += sizeof(struct f2fs_nm_info);
>  	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
>  	si->base_mem += (NM_I(sbi)->nat_bits_blocks << F2FS_BLKSIZE_BITS);
> -	si->base_mem += NM_I(sbi)->nat_blocks * NAT_ENTRY_BITMAP_SIZE;
> +	si->base_mem += NM_I(sbi)->nat_blocks * NAT_ENTRY_BITMAP_SIZE_ALIGNED;
>  	si->base_mem += NM_I(sbi)->nat_blocks / 8;
>  	si->base_mem += NM_I(sbi)->nat_blocks * sizeof(unsigned short);
>  
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index aa5db8b..4fa7e5e 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -304,10 +304,7 @@ struct f2fs_node {
>   * For NAT entries
>   */
>  #define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
> -#define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 7) / 8)
> -#define NAT_ENTRY_BITMAP_SIZE_ALIGNED				\
> -	((NAT_ENTRY_BITMAP_SIZE + BITS_PER_LONG - 1) /		\
> -	BITS_PER_LONG * BITS_PER_LONG)
> +#define NAT_ENTRY_BITMAP_SIZE_ALIGNED	f2fs_bitmap_size(NAT_ENTRY_PER_BLOCK)
>  
>  
>  struct f2fs_nat_entry {
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
