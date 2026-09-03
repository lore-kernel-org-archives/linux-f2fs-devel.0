Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8F2C79F81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P0G6D9g25q5FQ5uunanXP2N5qc3t/9yKZmB2mLEuue4=; b=KEHDSEr3+GyZVEUCSiLeuLZ+/o
	GhmzhFje9rUSCeBvu7BmCKf8CGq44vMRkChuysPed1tzwkwp9EEpvMOo4Cy48WH55LIB4Jt1FE/66
	OJhbSSzxS9SpelpVhppsZMewH6xuJ6vLhZV9u4RFfPfE7TyRkXNf+Y4dAPFXQIivkpUU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2HIr-0003o2-3E;
	Thu, 03 Sep 2026 23:57:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x2HIV-0003mZ-VV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1Bbiltid36UiyV1NzlSYq5njw/VDZh2cdDNub5CVBFk=; b=C0OOdZL/Dpkd5nXc0ZgVOUv0OD
 B20SPnJyAVFHPh8Wa4hEXKL6COet7q+c+lPLcNcwKU+IZtd1pMWu4FLFS3Rh/B84d1onLKoOwDBcg
 ROSlCIZMhU7OqcGvsAIAYYWFN49XZEliiuUD/ldS6w+cPy3ClTGutC1VSU4eaVcSGjbw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1Bbiltid36UiyV1NzlSYq5njw/VDZh2cdDNub5CVBFk=; b=lJfNQZwgrcmCWbQNBgw3xxO7Bx
 QCpq3OOkbtBrbgi3whowYVv+rixrLYGbkDTMjGwHB7KpvDC0iVQvZxhLMS/QFIfRoVsuSZOox7GqC
 j4jGte/QTR6m8e/pvKG5QJnI6wJ/7UeNE7z0CCwnUn7VAvN6MPE2qoypcDdTXJ1lOxkE=;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2HIU-0002WE-By for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:56:47 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-398b3d66515so495436a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788479801; x=1789084601; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1Bbiltid36UiyV1NzlSYq5njw/VDZh2cdDNub5CVBFk=;
 b=jZJtiX3ymLz4bS+ZzmhQrqnUZqzkxzx5KoNE+/FVyV5y0+NqiEpUia3L7tigyzptfj
 ZPDyIgfmu8VTQgBt1f+5BfP7vZMtP6YuifiJScB/s6IUalu3b4PDNU99ehNKcDWo4lvI
 DlNB/UG0KnaSc2KababKKtDcCM3ssUVET06O2b0jUzs6q+4tsVfMQC1i4xxPNbg1yX8k
 +euEB5dcMYreCxQwbw5r9qNnvuTJPYakrRJBL7X1LEDYdTTDPH4ksk0KrDfk7MkfyN8y
 GgX9mNvz4/lWzCEthNGiY4OyfTbbeEXmk1M+W9HjeJyFhTNSjz485gHfxqXBsd0x8XEi
 1o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788479801; x=1789084601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1Bbiltid36UiyV1NzlSYq5njw/VDZh2cdDNub5CVBFk=;
 b=IevboOU8sMZXKne9d8SLlgG2d/A9TdqFM9JqmN4/Uc4fc43nfifp3k/VVhD0Bkahp+
 ozYpi5sEs7v6j0YHZ6evEVoQ2dFHHiqEHLY9oEj7Ai73I0W9ATSHTFASA2tY6P29uiCr
 hdakafkeqIho7mfo01dTdX0RYalrQaoMDMUQWDTKeubKaIYh6pl69xdGQim/5rRs0XlG
 5o8cdu6xEMl9+nkQECY368n4nV/d/DnSH0a1ymEB08+H+pVWSt4ihPNiAiGyN8uW/Wgo
 ALcvloWVZKVuizvAwk74Sn9Py5vq0eIq6KgiecOuzBtQUi/VmWQ/O3yQN1FDvbjNlxS6
 A6eA==
X-Gm-Message-State: AFuF++mYB4Z/d7wlHGZKq2LNoYNqWi1k5MoICR5FnxFbWslV/eqsiO5R
 4zI0NUHrwJQXBkiEap8SbHNKfvinYozYXKOsdELCbDC7aM7Xc2IyhG7P43537t4R
X-Gm-Gg: AYBFou2+6/jiZS57B6+tdqk1RUBO3AE3Sd4pfjkECyoIulEXddbsCwo6ausH7HxYxkE
 6giNOxb6F9oqTohag1x8ywGmsggLKJUUTsLJWzvUekq4LOWlK6oSZHsZUiscUzELnASJKxnatZE
 iT8Hpc2cknnDc+fCz/eJixeZpzw94zSMG+nfiOUpFLALQBvmD8bvb6zE7AYUZAWz6Y5u9rVWIzr
 Ne9n2/e/uiMOK5oWAYQLpEfFPYwd/EjvbO+Q96G8XOf+uxG6YbcReJvAOuTsBOPTbDh6oa7zJWk
 qQBiZZEBwD/GeDqnBmefyE8wlhF4QgAII7KMJDpbr6g9qRkRgILn8fe+RKmW/DIiSBg3Ejcb0y3
 nHnN8WdsrskhkO8y5Ri+SNAwloxFJDmw99SDEiO5iIJei7XiNn/3sjFzvPcGoccyWtQs8iveASZ
 G6MzGTESi+0DgOO9glsZgbJLzN5h2iQY7v2z+2qPCtCl067KX9NkidyJmOoFWKO6p2eA==
X-Received: by 2002:a17:90a:d44b:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39b26203f11mr3316256a91.16.1788479800472; 
 Thu, 03 Sep 2026 16:56:40 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:29c4:4984:db20:3bb4])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1432424d27asm3711961c88.2.2026.09.03.16.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 16:56:39 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  3 Sep 2026 16:56:23 -0700
Message-ID: <a8360fd9da798b19b33ef577b7af0ba594db3eae.1788479509.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788479509.git.zhangxp1998@gmail.com>
References: <cover.1788479509.git.zhangxp1998@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x2HIU-0002WE-By
Subject: [f2fs-dev] [PATCH v9 11/11] f2fs: parameterize block size and mask
 macros
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Block size constants, shift counts, masks, and page-to-block ratios were
globally defined assuming a fixed 4KB block size.

Parameterize F2FS_BLKSIZE, F2FS_BLKSIZE_BITS, F2FS_BLKSIZE_MASK,
F2FS_BLKS_PER_PAGE, and CP_CHKSUM_OFFSET with struct f2fs_sb_info *sbi
to reference sbi->blocksize, sbi->log_blocksize, and runtime masks.

Update call sites across metadata operations, data I/O, file operations,
garbage collection, inline data, and sysfs information.

Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
 fs/f2fs/checkpoint.c    | 23 ++++++++++++-----------
 fs/f2fs/data.c          | 25 ++++++++++++++-----------
 fs/f2fs/extent_cache.c  |  9 +++++----
 fs/f2fs/f2fs.h          |  8 +++++---
 fs/f2fs/file.c          | 30 +++++++++++++++++-------------
 fs/f2fs/gc.c            | 11 ++++++-----
 fs/f2fs/inline.c        |  6 +++---
 fs/f2fs/inode.c         |  2 +-
 fs/f2fs/node.c          |  7 ++++---
 fs/f2fs/node.h          |  2 +-
 fs/f2fs/segment.c       | 18 +++++++++++-------
 fs/f2fs/segment.h       |  2 +-
 fs/f2fs/super.c         |  6 +++---
 fs/f2fs/sysfs.c         | 10 +++++-----
 fs/f2fs/xattr.c         |  2 +-
 include/linux/f2fs_fs.h | 16 ++++++++--------
 16 files changed, 97 insertions(+), 80 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4d1a0544bbf0..712c4508f38c 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -288,7 +288,7 @@ static struct folio *__get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index,
 		return ERR_PTR(err);
 	}
 
-	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE(sbi));
 
 	folio_lock(folio);
 	if (unlikely(!is_meta_folio(folio))) {
@@ -513,7 +513,7 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
 
 		if (!err)
 			f2fs_update_iostat(sbi, NULL, FS_META_READ_IO,
-							F2FS_BLKSIZE);
+							F2FS_BLKSIZE(sbi));
 	}
 out:
 	blk_finish_plug(&plug);
@@ -1133,16 +1133,17 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	}
 }
 
-static __u32 f2fs_checkpoint_chksum(struct f2fs_checkpoint *ckpt)
+static __u32 f2fs_checkpoint_chksum(struct f2fs_sb_info *sbi,
+				     struct f2fs_checkpoint *ckpt)
 {
 	unsigned int chksum_ofs = le32_to_cpu(ckpt->checksum_offset);
 	__u32 chksum;
 
 	chksum = f2fs_crc32(ckpt, chksum_ofs);
-	if (chksum_ofs < CP_CHKSUM_OFFSET) {
+	if (chksum_ofs < CP_CHKSUM_OFFSET(sbi)) {
 		chksum_ofs += sizeof(chksum);
 		chksum = f2fs_chksum(chksum, (__u8 *)ckpt + chksum_ofs,
-				     F2FS_BLKSIZE - chksum_ofs);
+					F2FS_BLKSIZE(sbi) - chksum_ofs);
 	}
 	return chksum;
 }
@@ -1162,13 +1163,13 @@ static int get_checkpoint_version(struct f2fs_sb_info *sbi, block_t cp_addr,
 
 	crc_offset = le32_to_cpu((*cp_block)->checksum_offset);
 	if (crc_offset < CP_MIN_CHKSUM_OFFSET ||
-			crc_offset > CP_CHKSUM_OFFSET) {
+			crc_offset > CP_CHKSUM_OFFSET(sbi)) {
 		f2fs_folio_put(*cp_folio, true);
 		f2fs_warn(sbi, "invalid crc_offset: %zu", crc_offset);
 		return -EINVAL;
 	}
 
-	crc = f2fs_checkpoint_chksum(*cp_block);
+	crc = f2fs_checkpoint_chksum(sbi, *cp_block);
 	if (crc != cur_cp_crc(*cp_block)) {
 		f2fs_folio_put(*cp_folio, true);
 		f2fs_warn(sbi, "invalid crc value");
@@ -1705,7 +1706,7 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	 */
 	struct folio *folio = f2fs_grab_meta_folio(sbi, blk_addr);
 
-	memcpy(folio_address(folio), src, PAGE_SIZE);
+	memcpy(folio_address(folio), src, F2FS_BLKSIZE(sbi));
 
 	folio_mark_dirty(folio);
 	if (unlikely(!folio_clear_dirty_for_io(folio)))
@@ -1840,7 +1841,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	get_sit_bitmap(sbi, __bitmap_ptr(sbi, SIT_BITMAP));
 	get_nat_bitmap(sbi, __bitmap_ptr(sbi, NAT_BITMAP));
 
-	crc32 = f2fs_checkpoint_chksum(ckpt);
+	crc32 = f2fs_checkpoint_chksum(sbi, ckpt);
 	*((__le32 *)((unsigned char *)ckpt +
 				le32_to_cpu(ckpt->checksum_offset)))
 				= cpu_to_le32(crc32);
@@ -1865,8 +1866,8 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	f2fs_update_meta_page(sbi, ckpt, start_blk++);
 
 	for (i = 1; i < 1 + cp_payload_blks; i++)
-		f2fs_update_meta_page(sbi, (char *)ckpt + i * F2FS_BLKSIZE,
-							start_blk++);
+		f2fs_update_meta_page(sbi, (char *)ckpt +
+				i * F2FS_BLKSIZE(sbi), start_blk++);
 
 	if (orphan_num) {
 		write_orphan_inodes(sbi, start_blk);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a4006b92da55..ebb0275aa8ff 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1192,7 +1192,7 @@ static void f2fs_submit_page_read(struct inode *inode, struct fsverity_info *vi,
 		f2fs_bug_on(sbi, 1);
 
 	inc_page_count(sbi, F2FS_RD_DATA);
-	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_DATA_READ_IO, F2FS_BLKSIZE(sbi));
 	f2fs_submit_read_bio(sbi, bio, DATA);
 }
 
@@ -2175,7 +2175,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			count_in_cluster += map.m_len;
 			if (count_in_cluster == cluster_size) {
 				compr_cluster = false;
-				size += F2FS_BLKSIZE;
+				size += F2FS_BLKSIZE(sbi);
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
 			flags = FIEMAP_EXTENT_UNWRITTEN;
@@ -2220,7 +2220,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 				 struct readahead_control *rac)
 {
 	struct bio *bio = *bio_ret;
-	const unsigned int blocksize = F2FS_BLKSIZE;
+	const unsigned int blocksize = F2FS_BLKSIZE(F2FS_I_SB(inode));
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -2309,7 +2309,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 	f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-							F2FS_BLKSIZE);
+					F2FS_BLKSIZE(F2FS_I_SB(inode)));
 	*last_block_in_bio = block_nr;
 out:
 	*bio_ret = bio;
@@ -2327,7 +2327,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
 	sector_t last_block_in_file;
-	const unsigned int blocksize = F2FS_BLKSIZE;
+	const unsigned int blocksize = F2FS_BLKSIZE(sbi);
 	struct decompress_io_ctx *dic = NULL;
 	struct extent_info ei = {};
 	bool from_dnode = true;
@@ -2460,7 +2460,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		refcount_inc(&dic->refcnt);
 
 		inc_page_count(sbi, F2FS_RD_DATA);
-		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO,
+				   F2FS_BLKSIZE(sbi));
 		*last_block_in_bio = blkaddr;
 	}
 
@@ -2634,14 +2635,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 */
 		f2fs_wait_on_block_writeback(inode, block_nr);
 
-		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE,
-					offset << PAGE_SHIFT))
+		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(F2FS_I_SB(inode)),
+				offset << PAGE_SHIFT))
 			goto submit_and_realloc;
 
 		folio_in_bio = true;
 		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-				F2FS_BLKSIZE);
+				F2FS_BLKSIZE(F2FS_I_SB(inode)));
 		last_block_in_bio = block_nr;
 	}
 	trace_f2fs_read_folio(folio, DATA);
@@ -4155,6 +4156,7 @@ static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	sector_t blknr = 0;
 
 	if (f2fs_has_inline_data(inode))
@@ -4165,7 +4167,7 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 		filemap_write_and_wait(mapping);
 
 	/* Block number less than F2FS MAX BLOCKS */
-	if (unlikely(block >= max_file_blocks(F2FS_I_SB(inode), inode)))
+	if (unlikely(block >= max_file_blocks(sbi, inode)))
 		goto out;
 
 	if (f2fs_compressed_file(inode)) {
@@ -4367,7 +4369,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 out:
 	if (not_aligned)
 		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(%lu * N)",
-			  not_aligned, blks_per_sec * F2FS_BLKSIZE);
+			  not_aligned,
+			  (unsigned long)blks_per_sec * F2FS_BLKSIZE(sbi));
 	return ret;
 }
 
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 37cf9fa8d537..57217dc5b310 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -904,11 +904,12 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
 	struct extent_info tei = *ei;	/* only fofs and len are valid */
 
 	/*
-	 * When I/O is not aligned to a PAGE_SIZE, update will happen to the last
-	 * file block even in seq write. So don't record age for newly last file
-	 * block here.
+	 * When I/O is not aligned to the filesystem block size, update will
+	 * happen to the last file block even in seq write. Do not record the age
+	 * of the new last file block here.
 	 */
-	if ((f_size >> PAGE_SHIFT) == ei->fofs && f_size & (PAGE_SIZE - 1) &&
+	if ((f_size >> sbi->log_blocksize) == ei->fofs &&
+	    f_size & F2FS_BLKSIZE_MASK(sbi) &&
 			blkaddr == NEW_ADDR)
 		return -EINVAL;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index df8d1bfef34c..cf0759262207 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2257,6 +2257,7 @@ static inline struct f2fs_sb_info *F2FS_F_SB(const struct folio *folio)
 #define F2FS_ORPHANS_PER_BLOCK(sbi)	((sbi)->orphans_per_block)
 #define GET_ORPHAN_BLOCKS(sbi, n)	DIV_ROUND_UP((n), \
 					F2FS_ORPHANS_PER_BLOCK(sbi))
+#define CP_CHKSUM_OFFSET(sbi)		(F2FS_BLKSIZE(sbi) - sizeof(__le32))
 
 #define NODE_DIR1_BLOCK(sbi)		(DEF_ADDRS_PER_INODE(sbi) + 1)
 #define NODE_DIR2_BLOCK(sbi)		(DEF_ADDRS_PER_INODE(sbi) + 2)
@@ -2311,7 +2312,7 @@ static inline struct f2fs_checkpoint *F2FS_CKPT(struct f2fs_sb_info *sbi)
 
 static inline struct node_footer *F2FS_NODE_FOOTER(const struct folio *folio)
 {
-	return folio_address(folio) + F2FS_BLKSIZE -
+	return folio_address(folio) + F2FS_BLKSIZE(F2FS_F_SB(folio)) -
 		sizeof(struct node_footer);
 }
 
@@ -2327,7 +2328,8 @@ static inline struct f2fs_inode *F2FS_INODE(const struct folio *folio)
 
 static inline __le32 *F2FS_INODE_NIDS(const struct folio *folio)
 {
-	return folio_address(folio) + F2FS_BLKSIZE - sizeof(struct node_footer) -
+	return folio_address(folio) + F2FS_BLKSIZE(F2FS_F_SB(folio)) -
+		sizeof(struct node_footer) -
 		SIZE_OF_I_NID;
 }
 
@@ -2976,7 +2978,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 		if (flag == NAT_BITMAP)
 			return tmp_ptr;
 		else
-			return (unsigned char *)ckpt + F2FS_BLKSIZE;
+			return (unsigned char *)ckpt + F2FS_BLKSIZE(sbi);
 	} else {
 		offset = (flag == NAT_BITMAP) ?
 			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5892247b3622..753ea45e9497 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -110,7 +110,8 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 	ret = filemap_fault(vmf);
 	if (ret & VM_FAULT_LOCKED)
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
-					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
+					APP_MAPPED_READ_IO,
+					F2FS_BLKSIZE(F2FS_I_SB(inode)));
 
 	trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);
 
@@ -233,7 +234,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	}
 	folio_mark_dirty(folio);
 
-	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, inode, APP_MAPPED_IO, F2FS_BLKSIZE(sbi));
 	f2fs_update_time(sbi, REQ_TIME);
 
 out_sem:
@@ -974,7 +975,7 @@ int f2fs_truncate(struct inode *inode)
 
 	trace_f2fs_truncate(inode);
 
-	if (time_to_inject(sbi, FAULT_TRUNCATE))
+	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE))
 		return -EIO;
 
 	err = f2fs_dquot_initialize(inode);
@@ -1671,7 +1672,8 @@ static int f2fs_collapse_range(struct inode *inode, loff_t offset, loff_t len)
 		return -EINVAL;
 
 	/* collapse range should be aligned to block size of f2fs. */
-	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
+	if (offset & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)) ||
+	    len & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)))
 		return -EINVAL;
 
 	ret = f2fs_convert_inline_inode(inode);
@@ -1886,7 +1888,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 		return -EINVAL;
 
 	/* insert range should be aligned to block size of f2fs. */
-	if (offset & (F2FS_BLKSIZE - 1) || len & (F2FS_BLKSIZE - 1))
+	if (offset & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)) ||
+	    len & F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)))
 		return -EINVAL;
 
 	ret = f2fs_convert_inline_inode(inode);
@@ -3189,7 +3192,8 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 		return -EFAULT;
 
 	/* verify alignment of offset & size */
-	if (range.start & (F2FS_BLKSIZE - 1) || range.len & (F2FS_BLKSIZE - 1))
+	if (range.start & F2FS_BLKSIZE_MASK(sbi) ||
+	    range.len & F2FS_BLKSIZE_MASK(sbi))
 		return -EINVAL;
 
 	if (unlikely(F2FS_BYTES_TO_BLK(sbi, range.start + range.len) >
@@ -3275,7 +3279,7 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (src == dst && pos_out > pos_in && pos_out < pos_in + len)
 		goto out_unlock;
 	if (pos_in + len == src->i_size)
-		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
+		len = ALIGN(src->i_size, F2FS_BLKSIZE(sbi)) - pos_in;
 	if (len == 0) {
 		ret = 0;
 		goto out_unlock;
@@ -3293,9 +3297,9 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	}
 
 	/* verify the end result is block aligned */
-	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE) ||
-			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE) ||
-			!IS_ALIGNED(pos_out, F2FS_BLKSIZE))
+	if (!IS_ALIGNED(pos_in, F2FS_BLKSIZE(sbi)) ||
+			!IS_ALIGNED(pos_in + len, F2FS_BLKSIZE(sbi)) ||
+			!IS_ALIGNED(pos_out, F2FS_BLKSIZE(sbi)))
 		goto out_unlock;
 
 	ret = f2fs_convert_inline_inode(src);
@@ -4589,14 +4593,14 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
 		to_end = true;
 	}
 
-	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
-			(!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE))) {
+	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE(sbi)) ||
+	    (!to_end && !IS_ALIGNED(end_addr, F2FS_BLKSIZE(sbi)))) {
 		ret = -EINVAL;
 		goto err;
 	}
 
 	index = F2FS_BYTES_TO_BLK(sbi, range.start);
-	pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);
+	pg_end = F2FS_BLK_ALIGN(sbi, end_addr);
 
 	ret = f2fs_convert_inline_inode(inode);
 	if (ret)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 39fa4776404e..bc22dde1cb30 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1305,8 +1305,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	f2fs_put_page(fio.encrypted_page, false);
 	f2fs_folio_put(folio, true);
 
-	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
-	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE(sbi));
+	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE(sbi));
 
 	if (atomic_inode)
 		iput(atomic_inode);
@@ -1426,9 +1426,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		}
 
 		f2fs_update_iostat(fio.sbi, inode, FS_DATA_READ_IO,
-							F2FS_BLKSIZE);
+						F2FS_BLKSIZE(fio.sbi));
 		f2fs_update_iostat(fio.sbi, NULL, FS_GDATA_READ_IO,
-							F2FS_BLKSIZE);
+						F2FS_BLKSIZE(fio.sbi));
 
 		folio_lock(mfolio);
 		if (unlikely(!is_meta_folio(mfolio) ||
@@ -1479,7 +1479,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_write(&fio);
 
-	f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO, F2FS_BLKSIZE);
+	f2fs_update_iostat(fio.sbi, NULL, FS_GC_DATA_IO,
+					F2FS_BLKSIZE(fio.sbi));
 
 	f2fs_update_data_blkaddr(&dn, newaddr);
 	set_inode_flag(inode, FI_APPEND_WRITE);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 73cd9b6ddcc5..3e0b9449ffba 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -448,7 +448,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 	 * Start by zeroing the full block, to ensure that all unused space is
 	 * zeroed and no uninitialized memory is leaked to disk.
 	 */
-	memset(dentry_blk, 0, F2FS_BLKSIZE);
+	memset(dentry_blk, 0, F2FS_BLKSIZE(F2FS_I_SB(dir)));
 
 	make_dentry_ptr_inline(dir, &src, inline_dentry);
 	make_dentry_ptr_block(dir, &dst, dentry_blk);
@@ -477,8 +477,8 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 		F2FS_I(dir)->i_inline_xattr_size = 0;
 
 	f2fs_i_depth_write(dir, 1);
-	if (i_size_read(dir) < PAGE_SIZE)
-		f2fs_i_size_write(dir, PAGE_SIZE);
+	if (i_size_read(dir) < F2FS_BLKSIZE(F2FS_I_SB(dir)))
+		f2fs_i_size_write(dir, F2FS_BLKSIZE(F2FS_I_SB(dir)));
 out:
 	f2fs_folio_put(folio, true);
 	return err;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index aa22e457d5b3..82ebcb338b0c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -165,7 +165,7 @@ static __u32 f2fs_inode_chksum(struct f2fs_sb_info *sbi, struct folio *folio)
 	chksum = f2fs_chksum(chksum, (__u8 *)&dummy_cs, cs_size);
 	offset += cs_size;
 	chksum = f2fs_chksum(chksum, (__u8 *)ri + offset,
-			     F2FS_BLKSIZE - offset);
+			     F2FS_BLKSIZE(sbi) - offset);
 	return chksum;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7bb99988833a..68a95d703c4a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -165,7 +165,7 @@ static struct folio *get_next_nat_folio(struct f2fs_sb_info *sbi, nid_t nid)
 
 	src_addr = folio_address(src_folio);
 	dst_addr = folio_address(dst_folio);
-	memcpy(dst_addr, src_addr, PAGE_SIZE);
+	memcpy(dst_addr, src_addr, F2FS_BLKSIZE(sbi));
 	folio_mark_dirty(dst_folio);
 	f2fs_folio_put(src_folio, true);
 
@@ -1500,7 +1500,8 @@ static int read_node_folio(struct folio *folio, blk_opf_t op_flags)
 	err = f2fs_submit_page_bio(&fio);
 
 	if (!err)
-		f2fs_update_iostat(sbi, NULL, FS_NODE_READ_IO, F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, NULL, FS_NODE_READ_IO,
+				   F2FS_BLKSIZE(sbi));
 
 	return err;
 }
@@ -3313,7 +3314,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 			return PTR_ERR(folio);
 
 		memcpy(nm_i->nat_bits + F2FS_BLK_TO_BYTES(sbi, i),
-					folio_address(folio), F2FS_BLKSIZE);
+					folio_address(folio), F2FS_BLKSIZE(sbi));
 		f2fs_folio_put(folio, true);
 	}
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 2766ced7bef7..c265739f2105 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -282,7 +282,7 @@ static inline void fill_node_footer(const struct folio *folio, nid_t nid,
 	unsigned int old_flag = 0;
 
 	if (reset)
-		memset(rn, 0, F2FS_BLKSIZE);
+		memset(rn, 0, F2FS_BLKSIZE(F2FS_F_SB(folio)));
 	else
 		old_flag = le32_to_cpu(footer->flag);
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index eb27b92fbad8..d186ac01d98a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1316,7 +1316,8 @@ static void __submit_zone_reset_cmd(struct f2fs_sb_info *sbi,
 	submit_bio(bio);
 
 	atomic_inc(&dcc->issued_discard);
-	f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO, dc->di.len * F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, FS_ZONE_RESET_IO,
+			   dc->di.len * F2FS_BLKSIZE(sbi));
 }
 #endif
 
@@ -1419,7 +1420,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 
 		atomic_inc(&dcc->issued_discard);
 
-		f2fs_update_iostat(sbi, NULL, FS_DISCARD_IO, len * F2FS_BLKSIZE);
+		f2fs_update_iostat(sbi, NULL, FS_DISCARD_IO,
+			   len * F2FS_BLKSIZE(sbi));
 
 		lstart += len;
 		start += len;
@@ -2797,7 +2799,7 @@ void f2fs_update_meta_page(struct f2fs_sb_info *sbi,
 	if (IS_ERR(folio))
 		return;
 
-	memcpy(folio_address(folio), src, PAGE_SIZE);
+	memcpy(folio_address(folio), src, F2FS_BLKSIZE(sbi));
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 }
@@ -4150,7 +4152,7 @@ void f2fs_do_write_meta_page(struct f2fs_sb_info *sbi, struct folio *folio,
 	f2fs_submit_page_write(&fio);
 
 	stat_inc_meta_count(sbi, folio->index);
-	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, NULL, io_type, F2FS_BLKSIZE(sbi));
 }
 
 void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
@@ -4160,7 +4162,8 @@ void f2fs_do_write_node_page(unsigned int nid, struct f2fs_io_info *fio)
 	set_summary(&sum, nid, 0, 0);
 	do_write_page(&sum, fio);
 
-	f2fs_update_iostat(fio->sbi, NULL, fio->io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(fio->sbi, NULL, fio->io_type,
+					F2FS_BLKSIZE(fio->sbi));
 }
 
 void f2fs_outplace_write_data(struct dnode_of_data *dn,
@@ -4176,7 +4179,8 @@ void f2fs_outplace_write_data(struct dnode_of_data *dn,
 	do_write_page(&sum, fio);
 	f2fs_update_data_blkaddr(dn, fio->new_blkaddr);
 
-	f2fs_update_iostat(sbi, dn->inode, fio->io_type, F2FS_BLKSIZE);
+	f2fs_update_iostat(sbi, dn->inode, fio->io_type,
+					F2FS_BLKSIZE(sbi));
 }
 
 int f2fs_inplace_write_data(struct f2fs_io_info *fio)
@@ -4218,7 +4222,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		f2fs_update_device_state(fio->sbi, fio->ino,
 						fio->new_blkaddr, 1);
 		f2fs_update_iostat(fio->sbi, fio_inode(fio),
-						fio->io_type, F2FS_BLKSIZE);
+						fio->io_type, F2FS_BLKSIZE(fio->sbi));
 	}
 
 	return err;
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 2275404e769c..cc0428b614da 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -432,7 +432,7 @@ static inline void seg_info_to_sit_folio(struct f2fs_sb_info *sbi,
 	int i;
 
 	raw_sit = folio_address(folio);
-	memset(raw_sit, 0, PAGE_SIZE);
+	memset(raw_sit, 0, F2FS_BLKSIZE(sbi));
 	for (i = 0; i < end - start; i++) {
 		rs = &raw_sit->entries[i];
 		se = get_seg_entry(sbi, start + i);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 75713e639b63..f96abecb3c55 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1610,7 +1610,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 			return -EINVAL;
 		}
 		min_size = MIN_INLINE_XATTR_SIZE;
-		max_size = MAX_INLINE_XATTR_SIZE(sbi->blocksize);
+		max_size = MAX_INLINE_XATTR_SIZE(F2FS_BLKSIZE(sbi));
 
 		if (F2FS_OPTION(sbi).inline_xattr_size < min_size ||
 				F2FS_OPTION(sbi).inline_xattr_size > max_size) {
@@ -4079,10 +4079,10 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 	}
 
 	/* only support block_size equals to PAGE_SIZE */
-	if (le32_to_cpu(raw_super->log_blocksize) != F2FS_BLKSIZE_BITS) {
+	if (le32_to_cpu(raw_super->log_blocksize) != PAGE_SHIFT) {
 		f2fs_info(sbi, "Invalid log_blocksize (%u), supports only %u",
 			  le32_to_cpu(raw_super->log_blocksize),
-			  F2FS_BLKSIZE_BITS);
+			  PAGE_SHIFT);
 		return -EFSCORRUPTED;
 	}
 
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 811e350a1430..aaca9ed9b169 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -1871,8 +1871,8 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int i;
 
-	seq_printf(seq, "Address Layout   : %5luB Block address (# of Segments)\n",
-					F2FS_BLKSIZE);
+	seq_printf(seq, "Address Layout   : %5uB Block address (# of Segments)\n",
+		   F2FS_BLKSIZE(sbi));
 	seq_printf(seq, " SB            : %12s\n", "0/1024B");
 	seq_printf(seq, " seg0_blkaddr  : 0x%010x\n", SEG0_BLKADDR(sbi));
 	seq_printf(seq, " Checkpoint    : 0x%010x (%10d)\n",
@@ -1889,13 +1889,13 @@ static int __maybe_unused disk_map_seq_show(struct seq_file *seq,
 	seq_printf(seq, " Main          : 0x%010x (%10d)\n",
 			SM_I(sbi)->main_blkaddr,
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count_main));
-	seq_printf(seq, " Block size    : %12lu KB\n", F2FS_BLKSIZE >> 10);
+	seq_printf(seq, " Block size    : %12u KB\n", F2FS_BLKSIZE(sbi) >> 10);
 	seq_printf(seq, " Segment size  : %12d MB\n",
-			(BLKS_PER_SEG(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
+			(BLKS_PER_SEG(sbi) << (F2FS_BLKSIZE_BITS(sbi) - 10)) >> 10);
 	seq_printf(seq, " Segs/Sections : %12d\n",
 			SEGS_PER_SEC(sbi));
 	seq_printf(seq, " Section size  : %12d MB\n",
-			(BLKS_PER_SEC(sbi) << (F2FS_BLKSIZE_BITS - 10)) >> 10);
+			(BLKS_PER_SEC(sbi) << (F2FS_BLKSIZE_BITS(sbi) - 10)) >> 10);
 	seq_printf(seq, " # of Sections : %12d\n",
 			le32_to_cpu(F2FS_RAW_SUPER(sbi)->section_count));
 
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 99c863513725..98059e583b09 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -850,4 +850,4 @@ int __init f2fs_init_xattr_cache(void)
 void f2fs_destroy_xattr_cache(void)
 {
 	kmem_cache_destroy(inline_xattr_slab);
-}
\ No newline at end of file
+}
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 9036cc6c2a2c..92a11e984d7a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -14,12 +14,9 @@
 #define F2FS_SUPER_OFFSET		1024	/* byte-size offset */
 #define F2FS_MIN_LOG_SECTOR_SIZE	9	/* 9 bits for 512 bytes */
 #define F2FS_MAX_LOG_SECTOR_SIZE	PAGE_SHIFT	/* Max is Block Size */
-#define F2FS_LOG_SECTORS_PER_BLOCK(sbi)	((sbi)->log_blocksize - 9) /* log number for sector/blk */
 #define F2FS_MIN_LOG_BLOCKSIZE		12
 #define F2FS_MIN_BLKSIZE		4096UL
-#define F2FS_BLKSIZE			PAGE_SIZE /* support only block == page */
 #define F2FS_MAX_BLKSIZE		PAGE_SIZE
-#define F2FS_BLKSIZE_BITS		PAGE_SHIFT /* bits for F2FS_BLKSIZE */
 #define F2FS_MAX_EXTENSION		64	/* # of extension entries */
 #define F2FS_EXTENSION_LEN		8	/* max size of extension */
 
@@ -27,16 +24,20 @@
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */
 
-#define F2FS_BLKSIZE_MASK		(F2FS_BLKSIZE - 1)
+#define F2FS_BLKSIZE(sbi)		((sbi)->blocksize)
+#define F2FS_BLKSIZE_BITS(sbi)		((sbi)->log_blocksize)
+#define F2FS_BLKSIZE_MASK(sbi)		(F2FS_BLKSIZE(sbi) - 1)
+#define F2FS_LOG_SECTORS_PER_BLOCK(sbi)	(F2FS_BLKSIZE_BITS(sbi) - 9)
+#define F2FS_BLKS_PER_PAGE(sbi)		(PAGE_SIZE / F2FS_BLKSIZE(sbi))
 #define F2FS_BYTES_TO_BLK(sbi, bytes)					\
-	((unsigned long long)(bytes) >> (sbi)->log_blocksize)
+	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS(sbi))
 #define F2FS_BLK_TO_BYTES(sbi, blk)					\
-	((unsigned long long)(blk) << (sbi)->log_blocksize)
+	((unsigned long long)(blk) << F2FS_BLKSIZE_BITS(sbi))
 #define F2FS_BLK_END_BYTES(sbi, blk)					\
 	(F2FS_BLK_TO_BYTES(sbi, (blk) + 1) - 1)
 #define F2FS_BLK_ALIGN(sbi, bytes)					\
 	F2FS_BYTES_TO_BLK(sbi, (unsigned long long)(bytes) +		\
-				 (sbi)->blocksize - 1)
+				 F2FS_BLKSIZE(sbi) - 1)
 
 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
@@ -222,7 +223,6 @@ struct f2fs_checkpoint {
 	unsigned char sit_nat_version_bitmap[];
 } __packed;
 
-#define CP_CHKSUM_OFFSET	(F2FS_BLKSIZE - sizeof(__le32))	/* default chksum offset in checkpoint */
 #define CP_MIN_CHKSUM_OFFSET						\
 	(offsetof(struct f2fs_checkpoint, sit_nat_version_bitmap))
 
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
