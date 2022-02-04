Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Feb 2022 07:20:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nFst1-00069t-MJ; Fri, 04 Feb 2022 07:20:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nFst0-00069Z-5v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Feb 2022 07:20:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+Vao5qxHOM9qKLdAxflvNjGUH+uB9XQ1hdlsZalVsY=; b=H+FwQGIv9o/Qp3D5Jb5KdWixKQ
 egzAlHV9yPY2ntHY99XlP+q5keFbx6TC4xcJhY1QrMpYea+FemjRroO6C2i3nds4j6ALpEgTN+odF
 7Sef9/5vvu2t5jRqBh/Vl+i/2jswA+TMtSeTl3hjy3er4deCdqhxQgLibpkfi2tLTxaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I+Vao5qxHOM9qKLdAxflvNjGUH+uB9XQ1hdlsZalVsY=; b=Z
 1+C9oC25LDcnYUfK//i0McJL0kKeLoT5DnUbZq8gLBe+KmWEWF7J0hD2T81IHmKA0PhsUZqxlH8qS
 l53XKJ6tbnI1WMg3e7+OnqS098NcsMhWNxKGQCYi6fBQvIz0bTb6WjDPOBeuYxsogKawcDGcc9Fir
 Fo7ut8Ncbul+jfG8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nFssx-00Ga6w-4K
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Feb 2022 07:20:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 37057617D6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  4 Feb 2022 07:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0E9C004E1;
 Fri,  4 Feb 2022 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643959190;
 bh=W/618XX1lnhHob8jqldDEkXFfNtNSHeDYB4h2i9bZrA=;
 h=From:To:Cc:Subject:Date:From;
 b=KPJa4BR705l3M94zF5zXeBo5j737VdILZBUdbpbJy8Hvj0T33uFX762QNhfY8sALq
 cZGn4Rg1nhjQVvFHFipqulfP5c6A/rfTHVjrzPdgEjPI7erVhDcM3Di/Xu4nRapLIx
 YXwxK6Vg/o+PZhM/clHqJkhnnFY8t00JY1h+SPKBaDGybs0DqphK/cbUpxkJUNLAzc
 g0E4sTiCEVAcxSvKiTlNnt8NTRVGy0QWBgWMW+pYt6toW7fJ+o6eL0t0Wi3pM8vIX0
 NX6Eq2K2LaZ5WOkH0cI5/YlREN8QxflYDbjuOEdm37ARIEJqyVOqI7sQcUC/+aBRA/
 xSI9LllwsX4rA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri,  4 Feb 2022 15:19:46 +0800
Message-Id: <20220204071946.47435-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1nFssx-00Ga6w-4K
Subject: [f2fs-dev] [PATCH v3] f2fs: introduce F2FS_IPU_HONOR_OPU_WRITE ipu
 policy
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Once F2FS_IPU_FORCE policy is enabled in some cases:
a) f2fs forces to use F2FS_IPU_FORCE in a small-sized volume
b) user sets F2FS_IPU_FORCE policy via sysfs

Then we may fail to defragment file due to IPU policy check, it doesn't
make sense, let's introduce a new IPU policy to allow OPU during file
defragmentation.

In small-sized volume, let's enable F2FS_IPU_HONOR_OPU_WRITE policy
by default.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- code cleanup.
- enables both F2FS_IPU_HONOR_OPU_WRITE and F2FS_IPU_FORCE in small-sized
volume.
 Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
 fs/f2fs/data.c                          | 18 +++++++++++++-----
 fs/f2fs/f2fs.h                          |  3 ++-
 fs/f2fs/file.c                          | 18 +++++++++++-------
 fs/f2fs/segment.h                       |  6 ++++--
 fs/f2fs/super.c                         |  3 ++-
 6 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index ce8103f522cb..58bf0dc83712 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -55,8 +55,9 @@ Description:	Controls the in-place-update policy.
 		0x04  F2FS_IPU_UTIL
 		0x08  F2FS_IPU_SSR_UTIL
 		0x10  F2FS_IPU_FSYNC
-		0x20  F2FS_IPU_ASYNC,
+		0x20  F2FS_IPU_ASYNC
 		0x40  F2FS_IPU_NOCACHE
+		0x80  F2FS_IPU_HONOR_OPU_WRITE
 		====  =================
 
 		Refer segment.h for details.
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b3c152de4bba..b09f401f8960 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2460,6 +2460,9 @@ static inline bool check_inplace_update_policy(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int policy = SM_I(sbi)->ipu_policy;
 
+	if (policy & (0x1 << F2FS_IPU_HONOR_OPU_WRITE) &&
+			is_inode_flag_set(inode, FI_OPU_WRITE))
+		return false;
 	if (policy & (0x1 << F2FS_IPU_FORCE))
 		return true;
 	if (policy & (0x1 << F2FS_IPU_SSR) && f2fs_need_SSR(sbi))
@@ -2530,6 +2533,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
 		return true;
 
+	if (is_inode_flag_set(inode, FI_OPU_WRITE))
+		return true;
+
 	if (fio) {
 		if (page_private_gcing(fio->page))
 			return true;
@@ -3154,8 +3160,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 			f2fs_available_free_memory(sbi, DIRTY_DENTS))
 		goto skip_write;
 
-	/* skip writing during file defragment */
-	if (is_inode_flag_set(inode, FI_DO_DEFRAG))
+	/* skip writing in file defragment preparing stage */
+	if (is_inode_flag_set(inode, FI_SKIP_WRITES))
 		goto skip_write;
 
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
@@ -3729,6 +3735,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	filemap_invalidate_lock(inode->i_mapping);
 
 	set_inode_flag(inode, FI_ALIGNED_WRITE);
+	set_inode_flag(inode, FI_OPU_WRITE);
 
 	for (; secidx < end_sec; secidx++) {
 		f2fs_down_write(&sbi->pin_sem);
@@ -3737,7 +3744,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
 		f2fs_unlock_op(sbi);
 
-		set_inode_flag(inode, FI_DO_DEFRAG);
+		set_inode_flag(inode, FI_SKIP_WRITES);
 
 		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
 			struct page *page;
@@ -3754,7 +3761,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 			f2fs_put_page(page, 1);
 		}
 
-		clear_inode_flag(inode, FI_DO_DEFRAG);
+		clear_inode_flag(inode, FI_SKIP_WRITES);
 
 		ret = filemap_fdatawrite(inode->i_mapping);
 
@@ -3765,7 +3772,8 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 	}
 
 done:
-	clear_inode_flag(inode, FI_DO_DEFRAG);
+	clear_inode_flag(inode, FI_SKIP_WRITES);
+	clear_inode_flag(inode, FI_OPU_WRITE);
 	clear_inode_flag(inode, FI_ALIGNED_WRITE);
 
 	filemap_invalidate_unlock(inode->i_mapping);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6ddb98ff0b7c..01a9033723fc 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -737,7 +737,8 @@ enum {
 	FI_DROP_CACHE,		/* drop dirty page cache */
 	FI_DATA_EXIST,		/* indicate data exists */
 	FI_INLINE_DOTS,		/* indicate inline dot dentries */
-	FI_DO_DEFRAG,		/* indicate defragment is running */
+	FI_SKIP_WRITES,		/* should skip data page writeback */
+	FI_OPU_WRITE,		/* used for opu per file */
 	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
 	FI_PREALLOCATED_ALL,	/* all blocks for write were preallocated */
 	FI_HOT_DATA,		/* indicate file is hot */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 6ccdd6e347e2..42fbdcf0ccc9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2559,10 +2559,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	bool fragmented = false;
 	int err;
 
-	/* if in-place-update policy is enabled, don't waste time here */
-	if (f2fs_should_update_inplace(inode, NULL))
-		return -EINVAL;
-
 	pg_start = range->start >> PAGE_SHIFT;
 	pg_end = (range->start + range->len) >> PAGE_SHIFT;
 
@@ -2570,6 +2566,13 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	inode_lock(inode);
 
+	/* if in-place-update policy is enabled, don't waste time here */
+	set_inode_flag(inode, FI_OPU_WRITE);
+	if (f2fs_should_update_inplace(inode, NULL)) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
 						range->start + range->len - 1);
@@ -2651,7 +2654,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 			goto check;
 		}
 
-		set_inode_flag(inode, FI_DO_DEFRAG);
+		set_inode_flag(inode, FI_SKIP_WRITES);
 
 		idx = map.m_lblk;
 		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
@@ -2676,15 +2679,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 		if (map.m_lblk < pg_end && cnt < blk_per_seg)
 			goto do_map;
 
-		clear_inode_flag(inode, FI_DO_DEFRAG);
+		clear_inode_flag(inode, FI_SKIP_WRITES);
 
 		err = filemap_fdatawrite(inode->i_mapping);
 		if (err)
 			goto out;
 	}
 clear_out:
-	clear_inode_flag(inode, FI_DO_DEFRAG);
+	clear_inode_flag(inode, FI_SKIP_WRITES);
 out:
+	clear_inode_flag(inode, FI_OPU_WRITE);
 	inode_unlock(inode);
 	if (!err)
 		range->len = (u64)total << PAGE_SHIFT;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 0291cd55cf09..7be59e3c4e00 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -651,7 +651,9 @@ static inline int utilization(struct f2fs_sb_info *sbi)
  *                     pages over min_fsync_blocks. (=default option)
  * F2FS_IPU_ASYNC - do IPU given by asynchronous write requests.
  * F2FS_IPU_NOCACHE - disable IPU bio cache.
- * F2FS_IPUT_DISABLE - disable IPU. (=default option in LFS mode)
+ * F2FS_IPU_HONOR_OPU_WRITE - use OPU write prior to IPU write if inode has
+ *                            FI_OPU_WRITE flag.
+ * F2FS_IPU_DISABLE - disable IPU. (=default option in LFS mode)
  */
 #define DEF_MIN_IPU_UTIL	70
 #define DEF_MIN_FSYNC_BLOCKS	8
@@ -667,6 +669,7 @@ enum {
 	F2FS_IPU_FSYNC,
 	F2FS_IPU_ASYNC,
 	F2FS_IPU_NOCACHE,
+	F2FS_IPU_HONOR_OPU_WRITE,
 };
 
 static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
@@ -675,7 +678,6 @@ static inline unsigned int curseg_segno(struct f2fs_sb_info *sbi,
 	struct curseg_info *curseg = CURSEG_I(sbi, type);
 	return curseg->segno;
 }
-
 static inline unsigned char curseg_alloc_type(struct f2fs_sb_info *sbi,
 		int type)
 {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9af6c20532ec..806836184ebc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3957,7 +3957,8 @@ static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 		F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_REUSE;
 		if (f2fs_block_unit_discard(sbi))
 			sm_i->dcc_info->discard_granularity = 1;
-		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE;
+		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
+					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
 
 	sbi->readdir_ra = 1;
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
