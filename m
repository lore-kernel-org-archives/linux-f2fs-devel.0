Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BC8C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 11:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yELADYv63zgl3M6jfTZJNzsZKuzcoHQgzO7lMc21zZk=; b=GsrXRyQ0ybpcPURVmPWqgRBO1w
	wfB/rpeO2JWkd7YEm9WpwG8IaCzat8QGlWFt2V4NxWMowKYLpkZQpyZleRzOudZcDh+lEIVp0OsDa
	2H4adJG3jDaEYTyRThwHpnw/JsSAqUc22FcphmRUb1BxyjRb+pY4RsoPLxSl2KWeaf8g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Mld-0005B7-Dc;
	Tue, 01 Sep 2026 11:35:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1Mlb-0005Az-Jc
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 11:35:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XSzlaEbCf5TZb583dCKIeDAaq0/Cs9e2FUUlpk0ufU0=; b=lOedziuB/4cRTHb/9VmYBwER+x
 OSuih2vcbNl3YA7Tkbg6ubzeFnY9tSWb/bsYsv6HbCnkpUjwtHRNg+hr6d1xAR8NvAF3L5xIMfB/Z
 UZvKi/IrU7wyXN3Vk/6zJ/WCgGlkJbJRZVGJ0rhqxpTJdWmjKn3d16Tf8WC2Q/oF2my0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XSzlaEbCf5TZb583dCKIeDAaq0/Cs9e2FUUlpk0ufU0=; b=iTSwKYG5mk6UMAbGBOTm+dOvMw
 9VT7IIbA/WwPP1yGQgGDnhtaRMCneG7KxTKp0GYrSfSg77W8LU+2bg1zLkOuh2GP4eVIXzxopU8mK
 RP3xs7SBqhrAzvrKPERMmcMoo9BmuqosT4uvoCG8KEDxeyfK9t58P/gtAvXjrnHJ75aA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Mlb-0006Ks-D3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 11:35:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B737D6020B;
 Tue,  1 Sep 2026 11:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53891F000E9;
 Tue,  1 Sep 2026 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788262497;
 bh=XSzlaEbCf5TZb583dCKIeDAaq0/Cs9e2FUUlpk0ufU0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=AAtYmkiEtFoPcBJIr6Fs4drQrAN7sp3Z/KzEG0n6IAYV3vRXghuXmCrAloE9YJFvi
 7cHwHUUpaL+dnmYtJg1kPKbljrOP3OnvY2kg4w+N7ZxxdARjo+Ub0JvbhfAQ0QF5rZ
 +o5UzCnEF7gge8s9XiyXlD6oe43ggzMyn7eHek+qMJxSibofpaHl2HW7RwW7rz28kU
 nU48FsWt36Q+5d5tnzZGROa2qPApHBoTMRCT+jcoudGimyRAAStMuseVCiznN6Wg1v
 Pe3+lyQ1HsxaePyxnkFMpFK9W0c2YYD5lc4+dq8MIe/aOCIKC8OwjVyVmZ4sw/t6vF
 TzbS0ajPPvjwQ==
Message-ID: <47f696a1-1efc-4e8e-90fe-22e1ea2feaea@kernel.org>
Date: Tue, 1 Sep 2026 19:34:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788213716.git.zhangxp1998@gmail.com>
 <f05b57691fdc4c186b08010314f8085aeb868e04.1788213716.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <f05b57691fdc4c186b08010314f8085aeb868e04.1788213716.git.zhangxp1998@gmail.com>
X-Headers-End: 1x1Mlb-0006Ks-D3
Subject: Re: [f2fs-dev] [PATCH v7 04/11] f2fs: describe orphan block layout
 dynamically
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/1/26 06:08, Kelvin Zhang wrote:
> An on-disk orphan block contains a variable-length array of 32-bit
> inode numbers followed by a fixed footer at the end of the block. A
> compile-time whole-block structure cannot represent the footer position
> when the block size varies at runtime.
> 
> Remove struct f2fs_orphan_block, introduce
> struct f2fs_orphan_block_footer, and compute sbi->orphans_per_block
> dynamically in init_sb_info(). Add helpers to access the inode entry array
> and footer from a block buffer.
> 
> Update orphan inode recovery, checkpointing, and mount paths to use the
> parameterized helpers. This preserves the on-disk format while decoupling
> orphan handling from compile-time constants.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
> ---
>  fs/f2fs/checkpoint.c    | 44 ++++++++++++++++++++++-------------------
>  fs/f2fs/f2fs.h          | 12 +++++++++++
>  fs/f2fs/super.c         |  2 ++
>  include/linux/f2fs_fs.h | 18 ++++++++++-------
>  4 files changed, 49 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 3ecced9b4d57..37a72b693545 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1041,7 +1041,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  
>  	for (i = 0; i < orphan_blocks; i++) {
>  		struct folio *folio;
> -		struct f2fs_orphan_block *orphan_blk;
> +		__le32 *orphan_inos;
> +		struct f2fs_orphan_footer *footer;
>  		unsigned int entry_count;
>  
>  		folio = f2fs_get_meta_folio(sbi, start_blk + i);
> @@ -1050,9 +1051,10 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  			goto out;
>  		}
>  
> -		orphan_blk = folio_address(folio);
> -		entry_count = le32_to_cpu(orphan_blk->entry_count);
> -		if (entry_count > F2FS_ORPHANS_PER_BLOCK) {
> +		orphan_inos = folio_address(folio);
> +		footer = f2fs_orphan_footer(orphan_inos, sbi);
> +		entry_count = le32_to_cpu(footer->entry_count);
> +		if (entry_count > F2FS_ORPHANS_PER_BLOCK(sbi)) {
>  			f2fs_err(sbi, "invalid orphan inode entry count %u",
>  				 entry_count);
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
> @@ -1063,7 +1065,7 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  		}
>  
>  		for (j = 0; j < entry_count; j++) {
> -			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
> +			nid_t ino = le32_to_cpu(orphan_inos[j]);
>  
>  			err = recover_orphan_inode(sbi, ino);
>  			if (err) {
> @@ -1084,7 +1086,8 @@ int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>  {
>  	struct list_head *head;
> -	struct f2fs_orphan_block *orphan_blk = NULL;
> +	__le32 *orphan_inos = NULL;
> +	struct f2fs_orphan_footer *footer = NULL;
>  	unsigned int nentries = 0;
>  	unsigned short index = 1;
>  	unsigned short orphan_blocks;
> @@ -1092,7 +1095,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>  	struct ino_entry *orphan = NULL;
>  	struct inode_management *im = &sbi->im[ORPHAN_INO];
>  
> -	orphan_blocks = GET_ORPHAN_BLOCKS(im->ino_num);
> +	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, im->ino_num);
>  
>  	/*
>  	 * we don't need to do spin_lock(&im->ino_lock) here, since all the
> @@ -1105,21 +1108,22 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>  	list_for_each_entry(orphan, head, list) {
>  		if (!folio) {
>  			folio = f2fs_grab_meta_folio(sbi, start_blk++);
> -			orphan_blk = folio_address(folio);
> -			memset(orphan_blk, 0, sizeof(*orphan_blk));
> +			orphan_inos = folio_address(folio);
> +			footer = f2fs_orphan_footer(orphan_inos, sbi);
> +			memset(orphan_inos, 0, sbi->blocksize);
>  		}
>  
> -		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
> +		orphan_inos[nentries++] = cpu_to_le32(orphan->ino);
>  
> -		if (nentries == F2FS_ORPHANS_PER_BLOCK) {
> +		if (nentries == F2FS_ORPHANS_PER_BLOCK(sbi)) {
>  			/*
> -			 * an orphan block is full of 1020 entries,
> +			 * an orphan block is full,
>  			 * then we need to flush current orphan blocks
>  			 * and bring another one in memory
>  			 */
> -			orphan_blk->blk_addr = cpu_to_le16(index);
> -			orphan_blk->blk_count = cpu_to_le16(orphan_blocks);
> -			orphan_blk->entry_count = cpu_to_le32(nentries);
> +			footer->blk_addr = cpu_to_le16(index);
> +			footer->blk_count = cpu_to_le16(orphan_blocks);
> +			footer->entry_count = cpu_to_le32(nentries);
>  			folio_mark_dirty(folio);
>  			f2fs_folio_put(folio, true);
>  			index++;
> @@ -1129,9 +1133,9 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
>  	}
>  
>  	if (folio) {
> -		orphan_blk->blk_addr = cpu_to_le16(index);
> -		orphan_blk->blk_count = cpu_to_le16(orphan_blocks);
> -		orphan_blk->entry_count = cpu_to_le32(nentries);
> +		footer->blk_addr = cpu_to_le16(index);
> +		footer->blk_count = cpu_to_le16(orphan_blocks);
> +		footer->entry_count = cpu_to_le32(nentries);
>  		folio_mark_dirty(folio);
>  		f2fs_folio_put(folio, true);
>  	}
> @@ -1824,7 +1828,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  		__clear_ckpt_flags(ckpt, CP_COMPACT_SUM_FLAG);
>  	spin_unlock_irqrestore(&sbi->cp_lock, flags);
>  
> -	orphan_blocks = GET_ORPHAN_BLOCKS(orphan_num);
> +	orphan_blocks = GET_ORPHAN_BLOCKS(sbi, orphan_num);
>  	ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
>  			orphan_blocks);
>  
> @@ -2080,7 +2084,7 @@ void f2fs_init_ino_entry_info(struct f2fs_sb_info *sbi)
>  
>  	sbi->max_orphans = (BLKS_PER_SEG(sbi) - F2FS_CP_PACKS -
>  			NR_CURSEG_PERSIST_TYPE - __cp_payload(sbi)) *
> -			F2FS_ORPHANS_PER_BLOCK;
> +			F2FS_ORPHANS_PER_BLOCK(sbi);
>  }
>  
>  int __init f2fs_create_checkpoint_caches(void)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8e6000e7d766..2a4ba7d4ec0e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1865,6 +1865,7 @@ struct f2fs_sb_info {
>  	unsigned int blocksize;			/* block size */
>  	unsigned int nat_entries_per_block;	/* NAT entries in a block */
>  	unsigned int sit_entries_per_block;	/* SIT entries in a block */
> +	unsigned int orphans_per_block;	/* orphan inodes in a block */
>  	unsigned int root_ino_num;		/* root inode number*/
>  	unsigned int node_ino_num;		/* node inode number*/
>  	unsigned int meta_ino_num;		/* meta inode number*/
> @@ -2255,6 +2256,17 @@ static inline struct f2fs_sb_info *F2FS_F_SB(const struct folio *folio)
>  
>  #define SIT_ENTRY_PER_BLOCK(sbi)	((sbi)->sit_entries_per_block)
>  #define NAT_ENTRY_PER_BLOCK(sbi)	((sbi)->nat_entries_per_block)
> +#define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
> +#define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
> +					F2FS_ORPHANS_PER_BLOCK(sbi))
> +
> +static inline struct f2fs_orphan_footer *
> +f2fs_orphan_footer(void *orphan_block, struct f2fs_sb_info *sbi)
> +{
> +	return (struct f2fs_orphan_footer *)
> +		((char *)orphan_block + sbi->blocksize -
> +		 sizeof(struct f2fs_orphan_footer));
> +}
>  
>  static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
>  {
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index fdc2b0c51c06..f9811d571ae5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4386,6 +4386,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  		sizeof(struct f2fs_nat_entry);
>  	sbi->sit_entries_per_block = sbi->blocksize /
>  		sizeof(struct f2fs_sit_entry);
> +	sbi->orphans_per_block = (sbi->blocksize -
> +		sizeof(struct f2fs_orphan_footer)) / sizeof(__le32);
>  	sbi->log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
>  	sbi->blocks_per_seg = BIT(sbi->log_blocks_per_seg);
>  	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 061f906a7b94..7d2cbceb42d5 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -220,14 +220,18 @@ struct f2fs_checkpoint {
>  
>  /*
>   * For orphan inode management
> + *
> + * An orphan block has no fixed-size C structure because the number of inode
> + * entries depends on the filesystem block size.  Its exact on-disk layout is:
> + *
> + * 0                           blocksize - 16             blocksize
> + * +--------------------------+--------------------------+
> + * | ino[0] ... ino[n - 1]    | struct f2fs_orphan_footer |
> + * +--------------------------+--------------------------+
> + *
> + * n = (blocksize - sizeof(struct f2fs_orphan_footer)) / sizeof(__le32)
>   */
> -#define F2FS_ORPHANS_PER_BLOCK	((F2FS_BLKSIZE - 4 * sizeof(__le32)) / sizeof(__le32))
> -
> -#define GET_ORPHAN_BLOCKS(n)	(((n) + F2FS_ORPHANS_PER_BLOCK - 1) / \
> -					F2FS_ORPHANS_PER_BLOCK)
> -
> -struct f2fs_orphan_block {
> -	__le32 ino[F2FS_ORPHANS_PER_BLOCK];	/* inode numbers */

Oh, maybe we can leave this structure like we did for f2fs_{nat,sit}_block ?

 struct f2fs_sit_block {
-	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+	DECLARE_FLEX_ARRAY(struct f2fs_sit_entry, entries);
 } __packed;

Something like this:

struct f2fs_orphan_block {
	DECLARE_FLEX_ARRAY(__le32, ino);
} __packed;

> +struct f2fs_orphan_footer {
>  	__le32 reserved;	/* reserved */
>  	__le16 blk_addr;	/* block index in current CP */
>  	__le16 blk_count;	/* Number of orphan inode blocks in CP */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
