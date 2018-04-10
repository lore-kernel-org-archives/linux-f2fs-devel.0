From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fsck.f2fs: recover nat bits feature default
 by fsck
Date: Mon, 9 Apr 2018 21:00:47 -0700
Message-ID: <20180410040047.GD47598@jaegeuk-macbookpro.roam.corp.google.com>
References: <1523244881-13125-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1f5kT3-0000v0-Gi
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 04:01:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1f5kSj-006Tii-AW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Apr 2018 04:01:13 +0000
Content-Disposition: inline
In-Reply-To: <1523244881-13125-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: zhangdianfang@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 04/09, Yunlei He wrote:
> Now, nat bits feature is enabled by default, we will
> meet with the following scenarios:
> 
> i.   disabled, without CP_NAT_BITS_FLAG, if fsck find some
>      fs errors, fix or write new checkpoint will then enable it.
> ii.  enabled, with CP_NAT_BITS_FLAG, in the case of sudden
>      power off, bitmap will get lost but CP_NAT_BITS_FLAG
>      still exist, fsck will recover bitmap in f2fs_do_mount.
> iii. enabled, with CP_NAT_BITS_FLAG, both of bitmap and
>      CP_NAT_BITS_FLAG will get lost if not enough space for
>      nat bits or nat bits check failed during mounting.
>      SBI_NEED_FSCK is set, fsck will recover flag and bitmap
>      before next mount.
> 
> SBI_NEED_FSCK means fs is corrupted, is not suitable for
> nat bits disabled. This patch try to recover nat bits all
> by fsck, no need set SBI_NEED_FSCK flag in kernel.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fsck/mount.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index e5574c5..2361ee0 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -2389,7 +2389,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>  	}
>  
>  	/* Check nat_bits */
> -	if (c.func != DUMP && is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
> +	if (c.func != DUMP) {
>  		u_int32_t nat_bits_bytes, nat_bits_blocks;
>  		__le64 *kaddr;
>  		u_int32_t blk;
> @@ -2406,10 +2406,15 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>  		kaddr = malloc(PAGE_SIZE);
>  		ret = dev_read_block(kaddr, blk);
>  		ASSERT(ret >= 0);
> -		if (*kaddr != get_cp_crc(cp))
> -			write_nat_bits(sbi, sb, cp, sbi->cur_cp);
> -		else
> -			MSG(0, "Info: Found valid nat_bits in checkpoint\n");
> +		if(is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
> +			if (*kaddr != get_cp_crc(cp))
> +				write_nat_bits(sbi, sb, cp, sbi->cur_cp);
> +			else
> +				MSG(0, "Info: Found valid nat_bits in checkpoint\n");
> +		} else if (c.func == FSCK){
> +			ASSERT_MSG("Need to recover nat_bits.");
> +			c.fix_on = 1;

What if kernel doesn't support this?

> +		}
>  		free(kaddr);
>  	}
>  	return 0;
> -- 
> 1.9.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
