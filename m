Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C0606A32D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M/Jn5vxT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WEn++w5X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZK+zqBhf;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgikbGlL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P4LLvthbcG3n3pGQMExUUSFk3beuBm/Dqmelku+uI6g=; b=M/Jn5vxTZoRsjn
	sFUVEvNLUVKcy1sXH5LxYYvndShAdsxbniiHReLVN2x5xIJ8c8Da+sf4RWHtBoj+diN2NQM5L4yCX
	XDvgBcJdGkybXcB/V9eAKVVJ72748qy3Mf3tv3oaWCsLkFtOouNQWeA3rbL7lZ2jN6+00sR08zc9M
	n3A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOAmT-000000004MR-1Joo;
	Tue, 03 Nov 2026 09:26:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xOAmR-000000004MB-2cm7
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v029MmB/+Kg/3AvfJCngSTrZpw2MdCxPVZPycItk8Ak=; b=WEn++w5XP4QEdObPQPcNwetYft
 TQLaC39kKGvnQv+mzsTnzowCdXZKxaGpx9PBirCU3ZKkRJ25Dv3s8CkvfrVSP8XSPAeEfzI5we5DA
 UOOOLVUoq1CetGFWGSrXuzClyzM5VY5Gr/qSuQD4UGj3BekV6Zh5sJGtsIgfdPY5k75M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v029MmB/+Kg/3AvfJCngSTrZpw2MdCxPVZPycItk8Ak=; b=ZK+zqBhfnXEupu/PKrTRnqHp2m
 8kwvKrs1NEiiEwaUxr5b1OjvJURfzqX9kDZMGyboVRgJSMNGenoZVHEry5ZSAMinzzqIjdxgtkVgd
 PPuKgcnsWb5ZnLSh/CrwL+cTwkEluqrV1D9qmqrKEDGhojMO727cyN/ehuBXWIVoFlWw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOAmO-000000007oV-3693
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:26:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F3514601EF;
 Tue,  3 Nov 2026 09:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA151F000C1;
 Tue,  3 Nov 2026 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793697962;
 bh=v029MmB/+Kg/3AvfJCngSTrZpw2MdCxPVZPycItk8Ak=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JgikbGlLywr2vC4l7vQs7IvGnFhpsf4QP301/Qzidll+exoyRF/dTdgSG8aUfIIBa
 zLyn7gjjy0FpP4H3sJ+C0jdweK8P2IvYVPBwVfl8zJFd1IEl/pdTwk8MlLzsJsrLzO
 /Tfyu/czycVG9WggXKAMtivVzrmKAVdn40mvJ71Yq0xqVOxDMl1Lg5ghHjwDAttz9K
 yenTXdvh3NmaqTSHaDUVRnKh468d8q+qKMVdxltgbrRT3MQr4pvf5qI0C4kmqRBDX7
 nUxSkWSCk45EPaRHhaQGObZ4BAjJ3LGGYQ/kYles2plzDCCYBavA+nn9BK+5j6R6Lk
 VWbpOPBmNKXcw==
Message-ID: <0ac04f29-982c-423c-b65d-ebed996c4a52@kernel.org>
Date: Tue, 3 Nov 2026 17:26:00 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-3-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-3-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOAmO-000000007oV-3693
Subject: Re: [f2fs-dev] [PATCH 02/20] f2fs: support subpage block size
 superblock and mount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add the infrastructure to mount F2FS with a block size smaller than
> PAGE_SIZE, e.g. 4KB blocks on a 16KB page kernel.
> 
> - Add helpers to convert between block indices, folio indices and
>   offsets within a folio.
> - Take the block size from the 1st superblock, which is at the same
>   offset for every block size. If it is invalid, probe the 2nd
>   superblock with each supported block size.
> - Allow log_blocksize up to PAGE_SHIFT, and write back only the target
>   superblock block instead of the whole folio.
> - Keep rejecting subpage block sizes, and return -EOPNOTSUPP for the
>   features that do not support them yet. Later patches add the support
>   and lift these restrictions.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/compress.c      |   2 +
>  fs/f2fs/f2fs.h          |  61 ++++++++++++---
>  fs/f2fs/file.c          |  42 +++++++++++
>  fs/f2fs/super.c         | 160 ++++++++++++++++++++++++++++------------
>  fs/f2fs/verity.c        |   3 +
>  include/linux/f2fs_fs.h |   1 +
>  6 files changed, 212 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index c7910688c318..0b0f31af6626 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -550,6 +550,8 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
>  {
>  	if (!f2fs_compressed_file(inode))
>  		return true;
> +	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
> +		return false;
>  	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
>  }
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 50a5f845176d..11de12a3e804 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1372,11 +1372,11 @@ struct f2fs_io_info {
>  };
>  
>  #define F2FS_FIO_LBLK(fio)						\
> -	(((fio)->folio)->index + (fio)->folio_offset)
> +	(f2fs_folio_lblk((fio)->sbi, (fio)->folio) + (fio)->folio_offset)
>  #define F2FS_FIO_BLKCNT(fio)						\
>  	((fio)->folio_blkcnt)
>  #define F2FS_FIO_BIO_OFFSET(fio)					\
> -	((fio)->folio_offset << PAGE_SHIFT)
> +	F2FS_BLK_TO_BYTES((fio)->sbi, (fio)->folio_offset)
>  #define F2FS_FIO_BIO_SIZE(fio)					\
>  	F2FS_BLK_TO_BYTES((fio)->sbi, F2FS_FIO_BLKCNT(fio))
>  
> @@ -2326,19 +2326,59 @@ static inline void make_dentry_ptr_block(struct inode *inode,
>  					SIZE_OF_DIR_ENTRY * entries;
>  }
>  
> +static inline unsigned int f2fs_blocks_per_folio(struct f2fs_sb_info *sbi,
> +						 const struct folio *folio)
> +{
> +	return folio_size(folio) >> sbi->log_blocksize;
> +}
> +
> +static inline bool f2fs_has_subpage_blocks(struct f2fs_sb_info *sbi)
> +{
> +	return F2FS_BLKSIZE(sbi) < PAGE_SIZE;
> +}
> +
> +static inline pgoff_t f2fs_folio_lblk(struct f2fs_sb_info *sbi,
> +				      const struct folio *folio)
> +{
> +	return ((loff_t)folio->index << PAGE_SHIFT) >> sbi->log_blocksize;
> +}
> +
> +static inline pgoff_t f2fs_lblk_to_folio_index(struct f2fs_sb_info *sbi,
> +					       pgoff_t index)
> +{
> +	return F2FS_BLK_TO_BYTES(sbi, index) >> PAGE_SHIFT;
> +}
> +
> +static inline pgoff_t f2fs_folio_blk_offset(struct f2fs_sb_info *sbi,
> +					     const struct folio *folio,
> +					     pgoff_t index)
> +{
> +	return index - f2fs_folio_lblk(sbi, folio);
> +}
> +
> +static inline size_t f2fs_folio_byte_offset(struct f2fs_sb_info *sbi,
> +					     const struct folio *folio,
> +					     pgoff_t index)
> +{
> +	return F2FS_BLK_TO_BYTES(sbi, f2fs_folio_blk_offset(sbi, folio, index));
> +}
> +
> +static inline void *f2fs_folio_lblk_address(struct f2fs_sb_info *sbi,
> +					    struct folio *folio, pgoff_t index)
> +{
> +	return folio_address(folio) + f2fs_folio_byte_offset(sbi, folio, index);
> +}
> +
>  static inline struct f2fs_super_block *F2FS_RAW_SUPER(struct f2fs_sb_info *sbi)
>  {
>  	return (struct f2fs_super_block *)(sbi->raw_super);
>  }
>  
> -static inline struct f2fs_super_block *F2FS_SUPER_BLOCK(struct folio *folio,
> -								pgoff_t index)
> +static inline struct f2fs_super_block *
> +F2FS_SUPER_BLOCK(struct f2fs_sb_info *sbi, struct folio *folio, pgoff_t index)
>  {
> -	pgoff_t idx_in_folio = index % folio_nr_pages(folio);
> -
>  	return (struct f2fs_super_block *)
> -		(page_address(folio_page(folio, idx_in_folio)) +
> -						F2FS_SUPER_OFFSET);
> +		(f2fs_folio_lblk_address(sbi, folio, index) + F2FS_SUPER_OFFSET);
>  }
>  
>  static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
> @@ -3905,11 +3945,10 @@ static inline bool f2fs_is_time_consistent(struct inode *inode)
>  
>  static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
>  {
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	bool ret;
>  
>  	if (dsync) {
> -		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -
>  		spin_lock(&sbi->inode_lock[DIRTY_META]);
>  		ret = list_empty(&F2FS_I(inode)->gdirty_list);
>  		spin_unlock(&sbi->inode_lock[DIRTY_META]);
> @@ -3917,7 +3956,7 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
>  	}
>  	if (!is_inode_flag_set(inode, FI_AUTO_RECOVER) ||
>  			file_keep_isize(inode) ||
> -			i_size_read(inode) & ~PAGE_MASK)
> +			i_size_read(inode) & (F2FS_BLKSIZE(sbi) - 1))

Use F2FS_BLKSIZE_MASK(sbi) for cleanup

>  		return false;
>  
>  	if (!f2fs_is_time_consistent(inode))
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 93d3088c96f0..82eb62301c48 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2207,6 +2207,15 @@ static long f2fs_fallocate(struct file *file, int mode,
>  		goto out;
>  	}
>  
> +	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
> +		if ((mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)) ||
> +		    f2fs_is_pinned_file(inode) || f2fs_is_atomic_file(inode) ||
> +		    f2fs_compressed_file(inode)) {
> +			ret = -EOPNOTSUPP;
> +			goto out;
> +		}
> +	}
> +
>  	ret = file_modified(file);
>  	if (ret)
>  		goto out;
> @@ -2455,6 +2464,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>  	loff_t isize;
>  	int ret;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!(filp->f_mode & FMODE_WRITE))
>  		return -EBADF;
>  
> @@ -3262,6 +3274,9 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>  	struct f2fs_defragment range;
>  	int err;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> @@ -3484,6 +3499,9 @@ static int f2fs_ioc_move_range(struct file *filp, unsigned long arg)
>  {
>  	struct f2fs_move_range range;
>  
> +	if (f2fs_has_subpage_blocks(F2FS_I_SB(file_inode(filp))))
> +		return -EOPNOTSUPP;
> +
>  	if (copy_from_user(&range, (struct f2fs_move_range __user *)arg,
>  							sizeof(range)))
>  		return -EFAULT;
> @@ -3734,6 +3752,9 @@ static int f2fs_ioc_set_pin_file(struct file *filp, unsigned long arg)
>  	__u32 pin;
>  	int ret = 0;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (get_user(pin, (__u32 __user *)arg))
>  		return -EFAULT;
>  
> @@ -4114,6 +4135,9 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
>  	__u64 block_count;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> @@ -4131,6 +4155,9 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
>  
> +	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
> +		return -EOPNOTSUPP;
> +
>  	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>  
>  	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
> @@ -4311,6 +4338,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>  	int ret;
>  	int writecount;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!f2fs_sb_has_compression(sbi))
>  		return -EOPNOTSUPP;
>  
> @@ -4506,6 +4536,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
>  	unsigned int reserved_blocks = 0;
>  	int ret;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!f2fs_sb_has_compression(sbi))
>  		return -EOPNOTSUPP;
>  
> @@ -4827,6 +4860,9 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
>  	struct f2fs_comp_option option;
>  	int ret = 0;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!f2fs_sb_has_compression(sbi))
>  		return -EOPNOTSUPP;
>  
> @@ -4965,6 +5001,9 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>  	pgoff_t page_idx = 0, last_idx, cluster_idx;
>  	int ret;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!f2fs_sb_has_compression(sbi) ||
>  			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
>  		return -EOPNOTSUPP;
> @@ -5046,6 +5085,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
>  	pgoff_t page_idx = 0, last_idx, cluster_idx;
>  	int ret;
>  
> +	if (f2fs_has_subpage_blocks(sbi))
> +		return -EOPNOTSUPP;
> +
>  	if (!f2fs_sb_has_compression(sbi) ||
>  			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
>  		return -EOPNOTSUPP;
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 78dbf1e92285..f34558b661eb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4000,7 +4000,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
>  	folio_lock(folio);
>  	folio_wait_writeback(folio);
>  	if (update)
> -		memcpy(F2FS_SUPER_BLOCK(folio, index), F2FS_RAW_SUPER(sbi),
> +		memcpy(F2FS_SUPER_BLOCK(sbi, folio, index), F2FS_RAW_SUPER(sbi),
>  					sizeof(struct f2fs_super_block));
>  	folio_mark_dirty(folio);
>  	folio_clear_dirty_for_io(folio);
> @@ -4010,9 +4010,10 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
>  	bio = bio_alloc(sbi->sb->s_bdev, 1, opf, GFP_NOFS);
>  
>  	/* it doesn't need to set crypto context for superblock update */
> -	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, folio->index);
> +	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(sbi, index);
>  
> -	if (!bio_add_folio(bio, folio, folio_size(folio), 0))
> +	if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(sbi),
> +			   f2fs_folio_byte_offset(sbi, folio, index)))
>  		f2fs_bug_on(sbi, 1);
>  
>  	ret = submit_bio_wait(bio);
> @@ -4025,7 +4026,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
>  static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
>  					struct folio *folio, pgoff_t index)
>  {
> -	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(folio, index);
> +	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(sbi, folio, index);
>  	struct super_block *sb = sbi->sb;
>  	u32 segment0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
>  	u32 cp_blkaddr = le32_to_cpu(raw_super->cp_blkaddr);
> @@ -4107,11 +4108,13 @@ static inline bool sanity_check_area_boundary(struct f2fs_sb_info *sbi,
>  			res = "internally";
>  		} else {
>  			/*
> -			 * __f2fs_commit_super() will access log_blocksize
> -			 * in SECTOR_FROM_BLOCK(), init it in advance.
> +			 * __f2fs_commit_super() will access log_blocksize and
> +			 * blocksize to locate the superblock, init them in
> +			 * advance.
>  			 */
>  			sbi->log_blocksize =
>  				le32_to_cpu(raw_super->log_blocksize);
> +			sbi->blocksize = BIT(sbi->log_blocksize);
>  			err = __f2fs_commit_super(sbi, folio, index, false);
>  			res = err ? "failed" : "done";
>  		}
> @@ -4129,7 +4132,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  {
>  	block_t segment_count, segs_per_sec, secs_per_zone, segment_count_main;
>  	block_t total_sections, blocks_per_seg;
> -	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(folio, index);
> +	struct f2fs_super_block *raw_super = F2FS_SUPER_BLOCK(sbi, folio, index);
>  	size_t crc_offset = 0;
>  	__u32 crc = 0;
>  
> @@ -4155,14 +4158,23 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  		}
>  	}
>  
> -	/* only support block_size equals to PAGE_SIZE */
> -	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
> -		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
> +	/* Keep one or more filesystem blocks in each base-page folio. */
> +	if (le32_to_cpu(raw_super->log_blocksize) <
> +			F2FS_MIN_LOG_BLOCKSIZE ||
> +			le32_to_cpu(raw_super->log_blocksize) > F2FS_MAX_LOG_BLOCKSIZE) {
> +		f2fs_info(sbi, "Invalid log_blocksize (%u), supports %u..%u",
>  			  le32_to_cpu(raw_super->log_blocksize),
> -			  PAGE_SHIFT);
> +			  F2FS_MIN_LOG_BLOCKSIZE, F2FS_MAX_LOG_BLOCKSIZE);
>  		return -EFSCORRUPTED;
>  	}
>  
> +	/* Subpage block size is enabled after all paths support it. */
> +	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
> +		f2fs_info(sbi, "Subpage block size (%u) is not supported yet",
> +			  le32_to_cpu(raw_super->log_blocksize));
> +		return -EOPNOTSUPP;
> +	}
> +
>  	/* check log blocks per segment */
>  	if (le32_to_cpu(raw_super->log_blocks_per_seg) != 9) {
>  		f2fs_info(sbi, "Invalid log blocks per segment (%u)",
> @@ -4181,7 +4193,7 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
>  	}
>  	if (le32_to_cpu(raw_super->log_sectors_per_block) +
>  		le32_to_cpu(raw_super->log_sectorsize) !=
> -			F2FS_MAX_LOG_SECTOR_SIZE) {
> +			le32_to_cpu(raw_super->log_blocksize)) {
>  		f2fs_info(sbi, "Invalid log sectors per block(%u) log sectorsize(%u)",
>  			  le32_to_cpu(raw_super->log_sectors_per_block),
>  			  le32_to_cpu(raw_super->log_sectorsize));
> @@ -4703,56 +4715,103 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>   * to get the first valid one. If any one of them is broken, we pass
>   * them recovery flag back to the caller.
>   */
> +static int check_super_block(struct f2fs_sb_info *sbi,
> +			     struct f2fs_super_block *super,
> +			     int block, int *valid_super_block,
> +			     struct f2fs_super_block **raw_super)
> +{
> +	struct folio *folio;
> +	int err;
> +
> +	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
> +				   f2fs_lblk_to_folio_index(sbi, block), NULL);
> +	if (IS_ERR(folio))
> +		return PTR_ERR(folio);
> +
> +	/* Skip unmatched magic during probing to avoid noisy logs */
> +	if (block != 0 && !*raw_super &&
> +	    le32_to_cpu(F2FS_SUPER_BLOCK(sbi, folio, block)->magic) !=
> +			F2FS_SUPER_MAGIC) {
> +		folio_put(folio);
> +		return -EINVAL;

err = -EINVAL;
goto out_put;

> +	}
> +
> +	/*
> +	 * The 2nd superblock was located with sbi->log_blocksize. Check it
> +	 * before sanity_check_raw_super(), which may write the superblock
> +	 * back with its own log_blocksize.
> +	 */
> +	err = 0;
> +	if (block) {

Can we combine above "if (block != 0)" and "if (block)":

if (block) {
	/* ... */
	if (!*raw_super &&
		le32_to_cpu(F2FS_SUPER_BLOCK(sbi, folio, block)->magic) !=
		F2FS_SUPER_MAGIC) {
		...
	}

	/* ... */
	if (log_bs != sbi->log_blocksize) {
		...
	}
	
}

> +		u32 log_bs = le32_to_cpu(F2FS_SUPER_BLOCK(sbi, folio,
> +						block)->log_blocksize);
> +
> +		if (log_bs != sbi->log_blocksize) {
> +			f2fs_info(sbi, "Mismatched log_blocksize (%u) in 2nd superblock, expected %u",
> +				  log_bs, sbi->log_blocksize);
> +			err = -EFSCORRUPTED;

goto out_put;

Then we can clean up below !err check.

> +		}
> +	}
> +	if (!err)
> +		err = sanity_check_raw_super(sbi, folio, block);

err = sanity_check_raw_super(sbi, folio, block);

> +	if (!err && !*raw_super) {
> +		memcpy(super, F2FS_SUPER_BLOCK(sbi, folio, block),
> +		       sizeof(*super));
> +		*valid_super_block = block;
> +		*raw_super = super;
> +		sbi->log_blocksize = le32_to_cpu(super->log_blocksize);
> +		sbi->blocksize = BIT(sbi->log_blocksize);
> +	}

out_put:

> +	folio_put(folio);
> +	return err;
> +}
> +
>  static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  			struct f2fs_super_block **raw_super,
>  			int *valid_super_block, int *recovery)
>  {
> -	struct super_block *sb = sbi->sb;
> -	int block;
> -	struct folio *folio;
>  	struct f2fs_super_block *super;
> -	int err = 0;
> +	int log_bs, err;
>  
>  	super = kzalloc_obj(struct f2fs_super_block);
>  	if (!super)
>  		return -ENOMEM;
>  
> -	for (block = 0; block < 2; block++) {
> -		folio = read_mapping_folio(sb->s_bdev->bd_mapping, block, NULL);
> -		if (IS_ERR(folio)) {
> -			f2fs_err(sbi, "Unable to read %dth superblock",
> -				 block + 1);
> -			err = PTR_ERR(folio);
> -			*recovery = 1;
> -			continue;
> -		}
> +	/* 1. Read 1st superblock (block 0) */
> +	err = check_super_block(sbi, super, 0, valid_super_block, raw_super);
> +	if (err) {
> +		f2fs_err(sbi, "Can't find valid F2FS filesystem in 1st superblock");
> +		*recovery = 1;
> +	}
>  
> -		/* sanity checking of raw super */
> -		err = sanity_check_raw_super(sbi, folio, block);
> -		if (err) {
> -			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
> -				 block + 1);
> -			folio_put(folio);
> +	/* 2. Read 2nd superblock (block 1) */
> +	if (*raw_super) {
> +		if (check_super_block(sbi, super, 1, valid_super_block, raw_super)) {
> +			f2fs_err(sbi, "Can't find valid F2FS filesystem in 2nd superblock");
>  			*recovery = 1;
> -			continue;
>  		}
> -
> +	} else {
> +		for (log_bs = F2FS_MIN_LOG_BLOCKSIZE;
> +		     log_bs <= F2FS_MAX_LOG_BLOCKSIZE; log_bs++) {
> +			sbi->log_blocksize = log_bs;
> +			sbi->blocksize = BIT(log_bs);
> +			err = check_super_block(sbi, super, 1, valid_super_block,
> +						raw_super);
> +			if (!err)
> +				break;

Later err = -EINVAL due to sb magic mismatch (not exist) will overwrite previous
err = -EFSCORRUPTED due to sb corruption, how about not overwriting it for such case?
to get correct error number.

> +		}
>  		if (!*raw_super) {
> -			memcpy(super, F2FS_SUPER_BLOCK(folio, block),
> -							sizeof(*super));
> -			*valid_super_block = block;
> -			*raw_super = super;
> +			f2fs_err(sbi, "Can't find valid F2FS filesystem in 2nd superblock");
> +			*recovery = 1;

Not needed to set *recovery, because both superblocks are corrupted.

Thanks,

>  		}
> -		folio_put(folio);
>  	}
>  
> -	/* No valid superblock */
> -	if (!*raw_super)
> +	/* No valid superblock: return the error of the last probe. */
> +	if (!*raw_super) {
>  		kfree(super);
> -	else
> -		err = 0;
> -
> -	return err;
> +		return err;
> +	}
> +	return 0;
>  }
>  
>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
> @@ -4777,7 +4836,8 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>  
>  	/* write back-up superblock first */
>  	index = sbi->valid_super_block ? 0 : 1;
> -	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping, index, NULL);
> +	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
> +				f2fs_lblk_to_folio_index(sbi, index), NULL);
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  	err = __f2fs_commit_super(sbi, folio, index, true);
> @@ -4789,7 +4849,8 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>  
>  	/* write current valid superblock */
>  	index = sbi->valid_super_block;
> -	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping, index, NULL);
> +	folio = read_mapping_folio(sbi->sb->s_bdev->bd_mapping,
> +				f2fs_lblk_to_folio_index(sbi, index), NULL);
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
>  	err = __f2fs_commit_super(sbi, folio, index, true);
> @@ -5263,6 +5324,13 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	}
>  	mutex_init(&sbi->flush_lock);
>  
> +	/*
> +	 * The 1st superblock is at F2FS_SUPER_OFFSET of block 0 for every
> +	 * block size, so locate it with the minimum supported block size.
> +	 */
> +	sbi->log_blocksize = F2FS_MIN_LOG_BLOCKSIZE;
> +	sbi->blocksize = F2FS_MIN_BLKSIZE;
> +
>  	err = read_raw_super_block(sbi, &raw_super, &valid_super_block,
>  								&recovery);
>  	if (err)
> diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> index 4a2cea4288f9..af1b7f21c1d8 100644
> --- a/fs/f2fs/verity.c
> +++ b/fs/f2fs/verity.c
> @@ -94,6 +94,9 @@ static int f2fs_begin_enable_verity(struct file *filp)
>  	struct inode *inode = file_inode(filp);
>  	int err;
>  
> +	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
> +		return -EOPNOTSUPP;
> +
>  	if (f2fs_verity_in_progress(inode))
>  		return -EBUSY;
>  
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 3081702b1ddb..1b3276d57bce 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -15,6 +15,7 @@
>  #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
>  #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
>  #define F2FS_MIN_LOG_BLOCKSIZE		12
> +#define F2FS_MAX_LOG_BLOCKSIZE		PAGE_SHIFT
>  #define F2FS_MIN_BLKSIZE		4096UL
>  #define F2FS_MAX_BLKSIZE		PAGE_SIZE
>  #define F2FS_MAX_EXTENSION		64	/* # of extension entries */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
