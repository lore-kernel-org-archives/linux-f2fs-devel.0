From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH RESEND 5/5] fsck.f2fs: try to recover
 cp_payload from valid cp pack
Date: Thu, 6 Sep 2018 11:12:02 +0800
Message-ID: <3e87d5ba-f5b3-a0e5-8c1d-74f91c0d8f65@huawei.com>
References: <20180830033733.236460-1-zhengjunling@huawei.com>
 <20180830033733.236460-5-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fxkiS-0004wt-NE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 03:12:20 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxkiQ-00BBgQ-Cy
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 03:12:20 +0000
In-Reply-To: <20180830033733.236460-5-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On 2018/8/30 11:37, Junling Zheng wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> If sb checksum is not enabled, and cp pack is valid due to no
> crc inconsistence, let's try to recover cp_payload based on
> cp_pack_start_sum in cp pack.

Please help to add below info into commit message additionally:



This problem is reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=200635

As Stathis Maneas said:

2018-08-24 18:55:40 UTC

I have reopened the bug, because indeed, the fix included in the
aforementioned commit prevents the file system from being mounted after
reading an invalid value from the superblock.

Nonetheless, after invoking fsck to fix the partition, the file system
still cannot be mounted. Would the patch that introduces the checksum
mechanism for the superblock completely resolve the error?

2018-08-26 23:22:45 UTC

For the case where the checksum mechanism is not enabled for the
superblock, it would be nice to fix the error and make the file system able
to be mounted once again, provided that there is a safe way to restore the
values stored in the superblock using any of the underlying checkpoints.

2018-09-05 16:44:46 UTC

I can verify that the latter patch is able to resolved the error and thus,
I am marking the issue as resolved.

Tested-by: Stathis Maneas <smaneas@cs.toronto.edu>

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fsck/f2fs.h  |  5 +++++
>  fsck/mount.c | 10 +++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index d216444..0d0d5e2 100644
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
> index 71af6b2..8a7d6e4 100644
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
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
