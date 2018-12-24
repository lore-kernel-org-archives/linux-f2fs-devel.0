From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: rebuild nat_bits during umount
Date: Mon, 24 Dec 2018 14:48:09 +0800
Message-ID: <461b1a02-977a-00a7-cf5b-4869355fa8f0@huawei.com>
References: <20181213085020.49241-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1gbK2L-0002TA-Cs
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Dec 2018 06:48:25 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gbK2H-00Ffze-SO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Dec 2018 06:48:25 +0000
In-Reply-To: <20181213085020.49241-1-yuchao0@huawei.com>
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
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/12/13 16:50, Chao Yu wrote:
> If all free_nat_bitmap are available, we can rebuild nat_bits from
> free_nat_bitmap entirely during umount, let's make another chance
> to reenable nat_bits for image.

Jaegeuk,

Could you please have a try with this patch?

I just did xfstest on it with below method, and there is no data corruption
reported from fsck:

- let fill_super preload all NAT blocks to enable free_nid_bitmap entirely.
- don't add nat_bits during mkfs image.

Thanks,

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix bugs in f2fs_enable_nat_bits()
> - add kmsg to record nat_bits {en,dis}abling operations
> - fix to validate {full,empty}_nat_bits in __get_nat_bitmaps()
> 
>  fs/f2fs/checkpoint.c | 20 +++++++++---
>  fs/f2fs/f2fs.h       | 21 ++-----------
>  fs/f2fs/node.c       | 72 +++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 82 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 623536b8e0c0..fa0eb56f1703 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1225,12 +1225,22 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&sbi->cp_lock, flags);
> +	if (cpc->reason & CP_UMOUNT) {
> +		if (le32_to_cpu(ckpt->cp_pack_total_block_count) >
> +			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks) {
> +			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> +			f2fs_msg(sbi->sb, KERN_NOTICE,
> +				"Disable nat_bits due to no space");
> +		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
> +						f2fs_nat_bitmap_enabled(sbi)) {
> +			f2fs_enable_nat_bits(sbi);
> +			set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> +			f2fs_msg(sbi->sb, KERN_NOTICE,
> +				"Rebuild and enable nat_bits");
> +		}
> +	}
>  
> -	if ((cpc->reason & CP_UMOUNT) &&
> -			le32_to_cpu(ckpt->cp_pack_total_block_count) >
> -			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
> -		disable_nat_bits(sbi, false);
> +	spin_lock_irqsave(&sbi->cp_lock, flags);
>  
>  	if (cpc->reason & CP_TRIMMED)
>  		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7cec897146a3..869a36b6a28f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1618,25 +1618,6 @@ static inline void clear_ckpt_flags(struct f2fs_sb_info *sbi, unsigned int f)
>  	spin_unlock_irqrestore(&sbi->cp_lock, flags);
>  }
>  
> -static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
> -{
> -	unsigned long flags;
> -
> -	/*
> -	 * In order to re-enable nat_bits we need to call fsck.f2fs by
> -	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
> -	 * so let's rely on regular fsck or unclean shutdown.
> -	 */
> -
> -	if (lock)
> -		spin_lock_irqsave(&sbi->cp_lock, flags);
> -	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
> -	kfree(NM_I(sbi)->nat_bits);
> -	NM_I(sbi)->nat_bits = NULL;
> -	if (lock)
> -		spin_unlock_irqrestore(&sbi->cp_lock, flags);
> -}
> -
>  static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
>  					struct cp_control *cpc)
>  {
> @@ -2952,6 +2933,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
>  int f2fs_truncate_xattr_node(struct inode *inode);
>  int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
>  					unsigned int seq_id);
> +bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
>  int f2fs_remove_inode_page(struct inode *inode);
>  struct page *f2fs_new_inode_page(struct inode *inode);
>  struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
> @@ -2975,6 +2957,7 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
>  int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
>  int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
>  			unsigned int segno, struct f2fs_summary_block *sum);
> +void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
>  int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
>  int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
>  void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 30a4427aaa94..9f55f2cb0dff 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2036,6 +2036,24 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
>  	}
>  }
>  
> +bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	unsigned int i;
> +	bool ret = true;
> +
> +	down_read(&nm_i->nat_tree_lock);
> +	for (i = 0; i < nm_i->nat_blocks; i++) {
> +		if (!test_bit_le(i, nm_i->nat_block_bitmap)) {
> +			ret = false;
> +			break;
> +		}
> +	}
> +	up_read(&nm_i->nat_tree_lock);
> +
> +	return ret;
> +}
> +
>  static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
>  							bool set, bool build)
>  {
> @@ -2720,6 +2738,43 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
>  		__clear_bit_le(nat_index, nm_i->full_nat_bits);
>  }
>  
> +void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	int nat_ofs;
> +
> +	down_read(&nm_i->nat_tree_lock);
> +
> +	for (nat_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
> +		int valid = 0, nid_ofs = 0;
> +
> +		if (nat_ofs == 0) {
> +			valid = 1;
> +			nid_ofs = 1;
> +		}
> +
> +		for (; nid_ofs < NAT_ENTRY_PER_BLOCK; nid_ofs++) {
> +			if (!test_bit_le(nid_ofs,
> +					nm_i->free_nid_bitmap[nat_ofs]))
> +				valid++;
> +		}
> +
> +		if (valid == 0) {
> +			__set_bit_le(nat_ofs, nm_i->empty_nat_bits);
> +			__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
> +			continue;
> +		}
> +
> +		__clear_bit_le(nat_ofs, nm_i->empty_nat_bits);
> +		if (valid == NAT_ENTRY_PER_BLOCK)
> +			__set_bit_le(nat_ofs, nm_i->full_nat_bits);
> +		else
> +			__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
> +	}
> +
> +	up_read(&nm_i->nat_tree_lock);
> +}
> +
>  static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
>  		struct nat_entry_set *set, struct cp_control *cpc)
>  {
> @@ -2862,15 +2917,18 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>  	__u64 cp_ver = cur_cp_version(ckpt);
>  	block_t nat_bits_addr;
>  
> -	if (!enabled_nat_bits(sbi, NULL))
> -		return 0;
> -
>  	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
>  	nm_i->nat_bits = f2fs_kzalloc(sbi,
>  			nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS, GFP_KERNEL);
>  	if (!nm_i->nat_bits)
>  		return -ENOMEM;
>  
> +	nm_i->full_nat_bits = nm_i->nat_bits + 8;
> +	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
> +
> +	if (!enabled_nat_bits(sbi, NULL))
> +		return 0;
> +
>  	nat_bits_addr = __start_cp_addr(sbi) + sbi->blocks_per_seg -
>  						nm_i->nat_bits_blocks;
>  	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
> @@ -2887,13 +2945,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
>  
>  	cp_ver |= (cur_cp_crc(ckpt) << 32);
>  	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
> -		disable_nat_bits(sbi, true);
> +		clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> +		f2fs_msg(sbi->sb, KERN_NOTICE,
> +			"Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
> +			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
>  		return 0;
>  	}
>  
> -	nm_i->full_nat_bits = nm_i->nat_bits + 8;
> -	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
> -
>  	f2fs_msg(sbi->sb, KERN_NOTICE, "Found nat_bits in checkpoint");
>  	return 0;
>  }
> 
