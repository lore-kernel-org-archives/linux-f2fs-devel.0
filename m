From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] fsck.f2fs: add sanity check nat_bits
Date: Tue, 19 Jun 2018 21:15:22 +0800
Message-ID: <2b6dfb1b-8882-a20b-aa1b-813768b6c23f@huawei.com>
References: <20180618003948.16479-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fVGUW-0006Zg-Lc
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 13:16:12 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fVGUU-002UcD-4n
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 19 Jun 2018 13:16:12 +0000
In-Reply-To: <20180618003948.16479-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2018/6/18 8:39, Jaegeuk Kim wrote:
> This patch adds to check nat_bits is valid or not. If not, it writes correct
> nat_bits.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fsck/mount.c | 95 ++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 21 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index a481a1e..f830e9b 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1044,6 +1044,78 @@ void write_nat_bits(struct f2fs_sb_info *sbi,
>  	free(nat_bits);
>  }
>  
> +static int check_nat_bits(struct f2fs_sb_info *sbi,
> +	struct f2fs_super_block *sb, struct f2fs_checkpoint *cp)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	u_int32_t nat_blocks = get_sb(segment_count_nat) <<
> +				(get_sb(log_blocks_per_seg) - 1);
> +	u_int32_t nat_bits_bytes = nat_blocks >> 3;
> +	u_int32_t nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) +
> +					8 + F2FS_BLKSIZE - 1);
> +	unsigned char *nat_bits, *full_nat_bits, *empty_nat_bits;
> +	u_int32_t i, j;
> +	block_t blkaddr;
> +	int err = 0;
> +
> +	nat_bits = calloc(F2FS_BLKSIZE, nat_bits_blocks);
> +	ASSERT(nat_bits);
> +
> +	full_nat_bits = nat_bits + 8;
> +	empty_nat_bits = full_nat_bits + nat_bits_bytes;
> +
> +	blkaddr = get_sb(segment0_blkaddr) + (sbi->cur_cp <<
> +				get_sb(log_blocks_per_seg)) - nat_bits_blocks;
> +
> +	for (i = 0; i < nat_bits_blocks; i++) {
> +		if (dev_read_block(nat_bits + i * F2FS_BLKSIZE, blkaddr + i))
> +			ASSERT_MSG("\tError: read NAT bits to disk!!!\n");
> +	}
> +
> +	if (*(__le64 *)nat_bits != get_cp_crc(cp)) {
> +		err = -1;
> +		goto out;
> +	}
> +
> +	for (i = 0; i < nat_blocks; i++) {
> +		u_int32_t start_nid = i * NAT_ENTRY_PER_BLOCK;
> +		u_int32_t valid = 0;
> +
> +		for (j = 0; j < NAT_ENTRY_PER_BLOCK; j++) {
> +			if (f2fs_test_bit(start_nid + j, nm_i->nid_bitmap))
> +				valid++;
> +		}
> +		if (valid == 0) {
> +			if (!test_bit_le(i, empty_nat_bits) ||
> +					test_bit_le(i, full_nat_bits)) {
> +				err = -1;
> +				goto out;
> +			}
> +		} else if (valid == NAT_ENTRY_PER_BLOCK) {
> +			if (test_bit_le(i, empty_nat_bits) ||
> +					!test_bit_le(i, full_nat_bits)) {
> +				err = -1;
> +				goto out;
> +			}
> +		} else {
> +			if (test_bit_le(i, empty_nat_bits) ||
> +					test_bit_le(i, full_nat_bits)) {
> +				err = -1;
> +				goto out;
> +			}
> +		}

Can clean up by replacing test_bit_le(i, ...) with added empty/full variables?

empty = test_bit_le(i, empty_nat_bits);
full = test_bit_le(i, full_nat_bits);

Anyway, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> +	}
> +out:
> +	free(nat_bits);
> +	if (!err) {
> +		MSG(0, "Info: Checked valid nat_bits in checkpoint\n");
> +	} else {
> +		c.bug_on = 1;
> +		MSG(0, "Info: Corrupted valid nat_bits in checkpoint\n");
> +	}
> +	return err;
> +}
> +
>  int init_node_manager(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> @@ -2394,28 +2466,9 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>  	}
>  
>  	/* Check nat_bits */
> -	if (c.func != DUMP && is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
> -		u_int32_t nat_bits_bytes, nat_bits_blocks;
> -		__le64 *kaddr;
> -		u_int32_t blk;
> -
> -		blk = get_sb(cp_blkaddr) + (1 << get_sb(log_blocks_per_seg));
> -		if (sbi->cur_cp == 2)
> -			blk += 1 << get_sb(log_blocks_per_seg);
> -
> -		nat_bits_bytes = get_sb(segment_count_nat) << 5;
> -		nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
> -				F2FS_BLKSIZE - 1);
> -		blk -= nat_bits_blocks;
> -
> -		kaddr = malloc(PAGE_SIZE);
> -		ret = dev_read_block(kaddr, blk);
> -		ASSERT(ret >= 0);
> -		if (*kaddr != get_cp_crc(cp))
> +	if (c.func == FSCK && is_set_ckpt_flags(cp, CP_NAT_BITS_FLAG)) {
> +		if (check_nat_bits(sbi, sb, cp) && c.fix_on)
>  			write_nat_bits(sbi, sb, cp, sbi->cur_cp);
> -		else
> -			MSG(0, "Info: Found valid nat_bits in checkpoint\n");
> -		free(kaddr);
>  	}
>  	return 0;
>  }
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
