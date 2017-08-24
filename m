From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: write back last cp block in the
 end
Date: Thu, 24 Aug 2017 22:23:49 +0800
Message-ID: <dcdbcb79-2258-2430-f96a-9b7c3de82ce9@kernel.org>
References: <1503461584-4449-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1dkt3I-0006wy-13
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Aug 2017 14:24:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dkt3G-0003tK-2W
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 24 Aug 2017 14:24:07 +0000
In-Reply-To: <1503461584-4449-1-git-send-email-heyunlei@huawei.com>
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
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Cc: morgan.wang@huawei.com

On 2017/8/23 12:13, Yunlei He wrote:
> Write back last cp block in the end in case of sudden power off
> during fsck process
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fsck/mount.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index a0b0bea..700a4ff 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1918,13 +1918,16 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  		ASSERT(ret >= 0);
>  	}
>  
> -	/* write the last cp */
> -	ret = dev_write_block(cp, cp_blk_no++);
> -	ASSERT(ret >= 0);
> -
>  	/* Write nat bits */
>  	if (flags & CP_NAT_BITS_FLAG)
>  		write_nat_bits(sbi, sb, cp, sbi->cur_cp);
> +
> +	/* in case of sudden power off */
> +	f2fs_finalize_device();
> +
> +	/* write the last cp */
> +	ret = dev_write_block(cp, cp_blk_no++);
> +	ASSERT(ret >= 0);
>  }
>  
>  void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
