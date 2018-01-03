From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: use flexible array for
 f2fs_checkpoint::sit_nat_version_bitmap
Date: Wed, 3 Jan 2018 12:12:37 -0800
Message-ID: <20180103201237.GD30014@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180103093251.13597-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eWpP5-0005fM-Tm
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 20:12:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWpP2-0001B9-6c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 03 Jan 2018 20:12:47 +0000
Content-Disposition: inline
In-Reply-To: <20180103093251.13597-1-yuchao0@huawei.com>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 01/03, Chao Yu wrote:
> If we need an array with variable size in the end of structure, we
> can utilize flexible array feature which is supported in C99, so
> let's change sit_nat_version_bitmap[] to flexible array in struct
> f2fs_checkpoint for readability.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/f2fs.h          | 4 ++--
>  include/linux/f2fs_fs.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 83d1f697388b..ad19d29688ae 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1719,13 +1719,13 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
>  
>  	if (__cp_payload(sbi) > 0) {
>  		if (flag == NAT_BITMAP)
> -			return &ckpt->sit_nat_version_bitmap;
> +			return ckpt->sit_nat_version_bitmap;
>  		else
>  			return (unsigned char *)ckpt + F2FS_BLKSIZE;
>  	} else {
>  		offset = (flag == NAT_BITMAP) ?
>  			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
> -		return &ckpt->sit_nat_version_bitmap + offset;
> +		return ckpt->sit_nat_version_bitmap + offset;
>  	}
>  }
>  
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 43e98d30d2df..564f65fc192f 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -157,7 +157,7 @@ struct f2fs_checkpoint {
>  	unsigned char alloc_type[MAX_ACTIVE_LOGS];
>  
>  	/* SIT and NAT version bitmap */
> -	unsigned char sit_nat_version_bitmap[1];
> +	unsigned char sit_nat_version_bitmap[];

I cannot find any benefit to do this. Moreover, it just makes the header
structure be different from the one in f2fs-tools.

>  } __packed;
>  
>  /*
> -- 
> 2.15.0.55.gc2ece9dc4de6

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
