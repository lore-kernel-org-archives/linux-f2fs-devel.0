From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] f2fs: do more integrity verification for
	superblock
Date: Mon, 14 Dec 2015 16:55:38 -0800
Message-ID: <20151215005538.GA57132@jaegeuk.local>
References: <03bb01d133eb$5628a350$0279e9f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1a8du8-0005M7-UI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 00:55:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1a8du6-0006Ux-AH for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Dec 2015 00:55:48 +0000
Content-Disposition: inline
In-Reply-To: <03bb01d133eb$5628a350$0279e9f0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

I also got superblock failure.
It seems that your patch doesn't handle correctly if segment0_blkaddr is not
zero.
Please see below.

On Fri, Dec 11, 2015 at 04:09:23PM +0800, Chao Yu wrote:
> Do more sanity check for superblock during ->mount.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/super.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 5434186..624fc2c 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -926,6 +926,79 @@ static loff_t max_file_size(unsigned bits)
>  	return result;
>  }
>  
> +static inline bool sanity_check_area_boundary(struct super_block *sb,
> +					struct f2fs_super_block *raw_super)
> +{
> +	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
> +	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
> +	u32 sit_blkaddr = le32_to_cpu(raw_super->sit_blkaddr);
> +	u32 nat_blkaddr = le32_to_cpu(raw_super->nat_blkaddr);
> +	u32 ssa_blkaddr = le32_to_cpu(raw_super->ssa_blkaddr);
> +	u32 main_blkaddr = le32_to_cpu(raw_super->main_blkaddr);
> +	u32 segment_count_ckpt = le32_to_cpu(raw_super->segment_count_ckpt);
> +	u32 segment_count_sit = le32_to_cpu(raw_super->segment_count_sit);
> +	u32 segment_count_nat = le32_to_cpu(raw_super->segment_count_nat);
> +	u32 segment_count_ssa = le32_to_cpu(raw_super->segment_count_ssa);
> +	u32 segment_count_main = le32_to_cpu(raw_super->segment_count_main);
> +	u32 segment_count = le32_to_cpu(raw_super->segment_count);
> +	u32 log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
> +
> +	if (segment0_blkaddr != cp_blkaddr) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Mismatch start address, segment0(%u) cp_blkaddr(%u)",
> +			segment0_blkaddr, cp_blkaddr);
> +		return true;
> +	}
> +
> +	if (cp_blkaddr + (segment_count_ckpt << log_blocks_per_seg) !=
> +							sit_blkaddr) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong CP boundary, start(%u) end(%u) blocks(%u)",
> +			cp_blkaddr, sit_blkaddr,
> +			segment_count_ckpt << log_blocks_per_seg);
> +		return true;
> +	}
> +
> +	if (sit_blkaddr + (segment_count_sit << log_blocks_per_seg) !=
> +							nat_blkaddr) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong SIT boundary, start(%u) end(%u) blocks(%u)",
> +			sit_blkaddr, nat_blkaddr,
> +			segment_count_sit << log_blocks_per_seg);
> +		return true;
> +	}
> +
> +	if (nat_blkaddr + (segment_count_nat << log_blocks_per_seg) !=
> +							ssa_blkaddr) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong NAT boundary, start(%u) end(%u) blocks(%u)",
> +			nat_blkaddr, ssa_blkaddr,
> +			segment_count_nat << log_blocks_per_seg);
> +		return true;
> +	}
> +
> +	if (ssa_blkaddr + (segment_count_ssa << log_blocks_per_seg) !=
> +							main_blkaddr) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong SSA boundary, start(%u) end(%u) blocks(%u)",
> +			ssa_blkaddr, main_blkaddr,
> +			segment_count_ssa << log_blocks_per_seg);
> +		return true;
> +	}
> +
> +	if (main_blkaddr + (segment_count_main << log_blocks_per_seg) !=
> +				(segment_count + 1) << log_blocks_per_seg) {

This should be
		segment_count << log_blocks_per_seg + segment0_blkaddr) {


=========================================================================
                           '- main_blkaddr
    `- segment0_blkaddr
                           |-------------- segment_count_main ----------|

    |-------------------------- segment_count --------------------------|


Thanks,

> +		f2fs_msg(sb, KERN_INFO,
> +			"Wrong MAIN_AREA boundary, start(%u) end(%u) blocks(%u)",
> +			main_blkaddr,
> +			(segment_count + 1) << log_blocks_per_seg,
> +			segment_count_main << log_blocks_per_seg);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static int sanity_check_raw_super(struct super_block *sb,
>  			struct f2fs_super_block *raw_super)
>  {
> @@ -955,6 +1028,14 @@ static int sanity_check_raw_super(struct super_block *sb,
>  		return 1;
>  	}
>  
> +	/* check log blocks per segment */
> +	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Invalid log blocks per segment (%u)\n",
> +			le32_to_cpu(raw_super->log_blocks_per_seg));
> +		return 1;
> +	}
> +
>  	/* Currently, support 512/1024/2048/4096 bytes sector size */
>  	if (le32_to_cpu(raw_super->log_sectorsize) >
>  				F2FS_MAX_LOG_SECTOR_SIZE ||
> @@ -973,6 +1054,23 @@ static int sanity_check_raw_super(struct super_block *sb,
>  			le32_to_cpu(raw_super->log_sectorsize));
>  		return 1;
>  	}
> +
> +	/* check reserved ino info */
> +	if (le32_to_cpu(raw_super->node_ino) != 1 ||
> +		le32_to_cpu(raw_super->meta_ino) != 2 ||
> +		le32_to_cpu(raw_super->root_ino) != 3) {
> +		f2fs_msg(sb, KERN_INFO,
> +			"Invalid Fs Meta Ino: node(%u) meta(%u) root(%u)",
> +			le32_to_cpu(raw_super->node_ino),
> +			le32_to_cpu(raw_super->meta_ino),
> +			le32_to_cpu(raw_super->root_ino));
> +		return 1;
> +	}
> +
> +	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
> +	if (sanity_check_area_boundary(sb, raw_super))
> +		return 1;
> +
>  	return 0;
>  }
>  
> -- 
> 2.6.3
> 

------------------------------------------------------------------------------
