From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: try to recover cp_payload from
 valid cp pack
Date: Wed, 29 Aug 2018 19:10:17 -0700
Message-ID: <20180830021017.GC91444@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180828135926.109119-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fvCPi-0001vV-BG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 02:10:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fvCPg-002lJX-NG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Aug 2018 02:10:26 +0000
Content-Disposition: inline
In-Reply-To: <20180828135926.109119-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

Could you please add this into Junling's patch series?
A little bit confusing between patches and reviews on them.

Thanks,

On 08/28, Chao Yu wrote:
> If sb checksum is not enabled, and cp pack is valid due to no
> crc inconsistence, let's try to recover cp_payload based on
> cp_pack_start_sum in cp pack.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fsck/f2fs.h  |  5 +++++
>  fsck/mount.c | 10 +++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index d2164449db15..0d0d5e2cc399 100644
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -259,6 +259,11 @@ static inline unsigned long __bitmap_size(struct f2fs_sb_info *sbi, int flag)
>  	return 0;
>  }
>  
> +static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
> +{
> +	return le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
> +}
> +
>  static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>  {
>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 4f0c3fc0db50..9421f5953cd8 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -945,12 +945,16 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  	}
>  
>  	cp_pack_start_sum = __start_sum_addr(sbi);
> -	cp_payload = get_sb(cp_payload);
> +	cp_payload = __cp_payload(sbi);
>  	if (cp_pack_start_sum < cp_payload + 1 ||
>  		cp_pack_start_sum > blocks_per_seg - 1 -
>  			NR_CURSEG_TYPE) {
> -		MSG(0, "\tWrong cp_pack_start_sum(%u)\n", cp_pack_start_sum);
> -		return 1;
> +		MSG(0, "\tWrong cp_pack_start_sum(%u) or cp_payload(%u)\n",
> +			cp_pack_start_sum, cp_payload);
> +		if ((get_sb(feature) & F2FS_FEATURE_SB_CHKSUM))
> +			return 1;
> +		set_sb(cp_payload, cp_pack_start_sum - 1);
> +		update_superblock(sb, SB_ALL);
>  	}
>  
>  	return 0;
> -- 
> 2.18.0.rc1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
