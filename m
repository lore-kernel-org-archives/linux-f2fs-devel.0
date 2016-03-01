From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: Use crypto crc32 functions
Date: Tue, 01 Mar 2016 17:19:37 +0800
Message-ID: <00d201d1739b$96fca580$c4f5f080$@samsung.com>
References: <1456787577-59946-1-git-send-email-kmok@cyngn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aagTt-0006MZ-EI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 09:20:37 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aagTp-0007H0-Sb
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 09:20:37 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3C02QLKSM24WB0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Mar 2016 18:20:26 +0900 (KST)
In-reply-to: <1456787577-59946-1-git-send-email-kmok@cyngn.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Keith Mok' <ek9852@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, 'Keith Mok' <kmok@cyngn.com>

Hi,

> -----Original Message-----
> From: Keith Mok [mailto:ek9852@gmail.com]
> Sent: Tuesday, March 01, 2016 7:13 AM
> To: linux-f2fs-devel@lists.sourceforge.net
> Cc: chao2.yu@samsung.com; cm224.lee@samsung.com; jaegeuk@kernel.org; Keith Mok; Keith Mok
> Subject: [PATCH] f2fs: Use crypto crc32 functions
> 
> The crc function is done bit by bit and
> painfully slow, switch to use crypto
> crc32 function which is backed by h/w/ acceleration.

f2fs_crc32/f2fs_crc_valid won't been invoked very often, so I don't think
that would cause much overhead in calculation and make things slow.

Moreover, we could suffer crash if any error occurrs in crypto_shash_update,
that would be a regression.

Thanks,

> 
> Signed-off-by: Keith Mok <ek9852@gmail.com>
> ---
>  fs/f2fs/Kconfig      |  2 ++
>  fs/f2fs/checkpoint.c |  6 +++---
>  fs/f2fs/f2fs.h       | 52 +++++++++++++++++++++++++++++++---------------------
>  fs/f2fs/super.c      | 13 +++++++++++++
>  4 files changed, 49 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
> index b0a9dc9..f8b0e6f 100644
> --- a/fs/f2fs/Kconfig
> +++ b/fs/f2fs/Kconfig
> @@ -1,6 +1,8 @@
>  config F2FS_FS
>  	tristate "F2FS filesystem support"
>  	depends on BLOCK
> +	select CRYPTO
> +	select CRYPTO_CRC32
>  	help
>  	  F2FS is based on Log-structured File System (LFS), which supports
>  	  versatile "flash-friendly" features. The design has been focused on
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 3842af9..1dfaf47 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -621,7 +621,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  		goto invalid_cp1;
> 
>  	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
> -	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
> +	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
>  		goto invalid_cp1;
> 
>  	pre_version = cur_cp_version(cp_block);
> @@ -636,7 +636,7 @@ static struct page *validate_checkpoint(struct f2fs_sb_info *sbi,
>  		goto invalid_cp2;
> 
>  	crc = le32_to_cpu(*((__le32 *)((unsigned char *)cp_block + crc_offset)));
> -	if (!f2fs_crc_valid(crc, cp_block, crc_offset))
> +	if (!f2fs_crc_valid(sbi, crc, cp_block, crc_offset))
>  		goto invalid_cp2;
> 
>  	cur_version = cur_cp_version(cp_block);
> @@ -1008,7 +1008,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
>  	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
> 
> -	crc32 = f2fs_crc32(ckpt, le32_to_cpu(ckpt->checksum_offset));
> +	crc32 = f2fs_crc32(sbi, ckpt, le32_to_cpu(ckpt->checksum_offset));
>  	*((__le32 *)((unsigned char *)ckpt +
>  				le32_to_cpu(ckpt->checksum_offset)))
>  				= cpu_to_le32(crc32);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ff79054..e753654 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -22,6 +22,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
> +#include <crypto/hash.h>
> 
>  #ifdef CONFIG_F2FS_CHECK_FS
>  #define f2fs_bug_on(sbi, condition)	BUG_ON(condition)
> @@ -84,27 +85,6 @@ struct f2fs_mount_info {
>  #define F2FS_CLEAR_FEATURE(sb, mask)					\
>  	F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask)
> 
> -#define CRCPOLY_LE 0xedb88320
> -
> -static inline __u32 f2fs_crc32(void *buf, size_t len)
> -{
> -	unsigned char *p = (unsigned char *)buf;
> -	__u32 crc = F2FS_SUPER_MAGIC;
> -	int i;
> -
> -	while (len--) {
> -		crc ^= *p++;
> -		for (i = 0; i < 8; i++)
> -			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
> -	}
> -	return crc;
> -}
> -
> -static inline bool f2fs_crc_valid(__u32 blk_crc, void *buf, size_t buf_size)
> -{
> -	return f2fs_crc32(buf, buf_size) == blk_crc;
> -}
> -
>  /*
>   * For checkpoint manager
>   */
> @@ -844,6 +824,9 @@ struct f2fs_sb_info {
>  	struct list_head s_list;
>  	struct mutex umount_mutex;
>  	unsigned int shrinker_run_no;
> +
> +	/* Reference to checksum algorithm driver via cryptoapi */
> +	struct crypto_shash *s_chksum_driver;
>  };
> 
>  static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
> @@ -874,6 +857,33 @@ static inline bool is_idle(struct f2fs_sb_info *sbi)
>  /*
>   * Inline functions
>   */
> +static inline __u32 f2fs_crc32(struct f2fs_sb_info *sbi, const void *address,
> +			   unsigned int length)
> +{
> +	struct {
> +		struct shash_desc shash;
> +		char ctx[4];
> +	} desc;
> +	int err;
> +
> +	BUG_ON(crypto_shash_descsize(sbi->s_chksum_driver) != sizeof(desc.ctx));
> +
> +	desc.shash.tfm = sbi->s_chksum_driver;
> +	desc.shash.flags = 0;
> +	*(u32 *)desc.ctx = F2FS_SUPER_MAGIC;
> +
> +	err = crypto_shash_update(&desc.shash, address, length);
> +	BUG_ON(err);
> +
> +	return *(__u32 *)desc.ctx;
> +}
> +
> +static inline bool f2fs_crc_valid(struct f2fs_sb_info *sbi, __u32 blk_crc,
> +				  void *buf, size_t buf_size)
> +{
> +	return f2fs_crc32(sbi, buf, buf_size) == blk_crc;
> +}
> +
>  static inline struct f2fs_inode_info *F2FS_I(struct inode *inode)
>  {
>  	return container_of(inode, struct f2fs_inode_info, vfs_inode);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 6134832..9630865 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -574,6 +574,8 @@ static void f2fs_put_super(struct super_block *sb)
>  	wait_for_completion(&sbi->s_kobj_unregister);
> 
>  	sb->s_fs_info = NULL;
> +	if (sbi->s_chksum_driver)
> +		crypto_free_shash(sbi->s_chksum_driver);
>  	kfree(sbi->raw_super);
>  	kfree(sbi);
>  }
> @@ -1254,6 +1256,15 @@ try_onemore:
>  	if (!sbi)
>  		return -ENOMEM;
> 
> +	/* Load the checksum driver */
> +	sbi->s_chksum_driver = crypto_alloc_shash("crc32", 0, 0);
> +	if (IS_ERR(sbi->s_chksum_driver)) {
> +		f2fs_msg(sb, KERN_ERR, "Cannot load crc32 driver.");
> +		err = PTR_ERR(sbi->s_chksum_driver);
> +		sbi->s_chksum_driver = NULL;
> +		goto free_sbi;
> +	}
> +
>  	/* set a block size */
>  	if (unlikely(!sb_set_blocksize(sb, F2FS_BLKSIZE))) {
>  		f2fs_msg(sb, KERN_ERR, "unable to set blocksize");
> @@ -1506,6 +1517,8 @@ free_options:
>  free_sb_buf:
>  	kfree(raw_super);
>  free_sbi:
> +	if (sbi->s_chksum_driver)
> +		crypto_free_shash(sbi->s_chksum_driver);
>  	kfree(sbi);
> 
>  	/* give only one another chance */
> --
> 2.5.1



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
