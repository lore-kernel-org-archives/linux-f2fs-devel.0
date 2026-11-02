Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07162606D803
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FYh2GFqA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LVDqu7NR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jI27qCZy;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QR8y6Gex
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ByJzogeJwln6NgvhD7QLHmgXQNkLhxYs9XGYroi+Ltc=; b=FYh2GFqAF2ADKQHBdzAZh6BLmk
	BieYoNWGd/iu/Gb/C2rAoElxI3HVTc+OvV6h84l/J6622oA3oMfl8rRmLSmbB4s7tanGC2ZQvDkCh
	sKvOR+vPEw8TSUV8PN9CbPERn3uriSt1vmLOg5OScF97k9z9ixeVcazId5gT4kISvr4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxt6-000000003KU-3Ay2;
	Mon, 02 Nov 2026 19:40:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxt5-000000003KG-3Hpa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6N5uNP4gur0oD/TAybxvvmXj9LSwUE0mVrMCxvkY1h8=; b=LVDqu7NR2rQGYvkZwrKzXAM8Co
 7zdd5Q2awwOkTsQcRT1sNxyffPCM/yPjaVACp4VN5RmzzQfC+cZdiHsV6LRUJ5InGdC1TQNIokSp6
 jIWOfcj5H1a9URsPeNW1onK0ALkUs3IYFLsalIcuDkb5RLB+H/9puYIdZiRFZ9ULcLEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6N5uNP4gur0oD/TAybxvvmXj9LSwUE0mVrMCxvkY1h8=; b=jI27qCZyEIMC3yTFebd0nXOaQE
 4+/NpWl+5TxurLSO8vlj1imRZhh7W3KN2RbzESV3Idn02kMjBiAEPkprm4MqXurFnOYb29GW1iLji
 l9ILdqrAFRf7di+lpesf0k7TlzvzEcKCkFCG5/Ds4BvnoPNxAZVJNBn2FKcUp/SgA4x0=;
Received: from mail-pf1-f174.google.com ([209.85.210.174])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxt4-000000002Cn-1jhc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:11 +0000
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-89ff475a152so1138503b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648405; x=1794253205; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6N5uNP4gur0oD/TAybxvvmXj9LSwUE0mVrMCxvkY1h8=;
 b=QR8y6Gex2owTe2piSLDr7jsmxPtu3stuSIja9qBrGCVdGKzF7B9S5cGZcPfcdesSw8
 jZ6gUDXUJZMjWpdqeNdxRSL2aacAvkfRl8KyCWIwOiAhp95A6SapMYetWiQ2/8nssqbY
 RTt+cUZkR7TtStmp+u4mqYWc5YYCIn83m6Ixm97btUzDWuYdSZMRYlCp1fTLWwSoGoWw
 Um1DsuOfo4Oj76AocMEs9Hlpw13qjRHqsywzfU+MZjA3aYyMjolSMS715CSF4wrA8TCr
 v+4qOXtbp5HoIQDB6hjJKSdYdIQGmDvyNsVUA/jntcIQ72m2doTDItFqRhHxDcS9w5Yd
 OSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648405; x=1794253205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6N5uNP4gur0oD/TAybxvvmXj9LSwUE0mVrMCxvkY1h8=;
 b=K63mZY1+1Cw2rDwgF4eTp28iZgfwX1rcz8bBBbUxtji/YuA0v53viuQwb6aok7R5Bm
 4stDY0Qplfi3y31bIJ9kjQy+CZDjizL0Zqw/T5damGk53dQ1l4SQro2buy+68vZ5CUGD
 Q85LnywSfq9aunZcpBCBcYxkO2TQ38LgKsb5RuYhQDCL3P24Qd+WX2rjWyGh01Qgi98z
 w3W8tc4k5idgbadU7UNYum8UBKOnjHSmia2WwJ/DGsdMl1Cfq1BMzw2eOHJQuuhSL1IJ
 AiEyJxz0A74/Nq7OLQyLyIY39TmVeoXIcgb9umgXZfjrbwq2Rs45id5GT7rZrF28GhbK
 Q0Xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZxx4Y9qFh3tFwfEXxHOoUqT464a+ZpFE5RhIlAW0RYRmFGxBMkKg/MJn0Z1ToHwVFoUvrSuCsNYpiYsgftRiR@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJHvUCdtmmQrsaC4khnYtx/buVnsIN9YMcLEljurWHRmgFMd9zR
 ohdeOwnHb41lBB5NMGZe5oylANu+8WQjeSZG1Y8e9goQ5CAjEKMMTsS5
X-Gm-Gg: AYBFou2SbAc2MUAtDPzrRbkLyLb4d80zXVIQLidd3/KbawMSspDY2800c4QSHhj34W4
 SWJfOB7ywhh0KP36gn3Pg8GJyEMQLQkIqt9Fk8qeEnljwYHFChGJzt5Wi6nhGk3k08egWxh1fqq
 6/0yapGaUEB98ntNx6I+jXBKJVUkLCQnTtRWUXtFlP2INLHpY9lm7Pvykf7WT+oG+ub3Vsos71h
 shb3WpH8pcbGBdJYqeem2PbjtiE0zuAI7+Cd55PjY1/avNTi0T8yL2g07gOCPqliM6ZHI8xoTda
 TXdzSWxsiOD8jGd4zBUDoTGCdtKgMLNE3/6bAggNNDjSfs5jum7x+11wV8lvNWLtjFKIrWSTTH6
 7UeIG2yk9aEbcaV53PIKfjPSyHIrhguDCiCCjwhmdEWvLOzICFDpJbeZaCa5yuILguBcV942Cn2
 3Vv+tKUWMWufcI3/h2ZGx3dRt9QekXVDeEd2YSLoOOjIOEB3XSJjPF4jOtN64bOfbM2LZbPDsiO
 0LiKraQD8zP+oEaNbg1MSswVI4F50jmKfJnmTqyX4M4QNtbSUpE3gk6xZ7KsUBHXrDSGYdxBTOi
 TWpz0HGLHAhBz/BwF0iYg9D9vxoLsrhR/tg4x0P6PNwFau/wUbJ3RH2cu0yZ2IdSuOvrK0Hp56S
 ygObWFBuO8hCfLYEcxejiiYd8OUR2MkhDFG71ILPfD0Xltg==
X-Received: by 2002:a05:6a20:b603:b0:3e2:7030:9080 with SMTP id
 adf61e73a8af0-3e9289d8cbemr8684267637.47.1793648404515; 
 Mon, 02 Nov 2026 11:40:04 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:03 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:33 -0800
Message-ID: <20261102193952.3002018-2-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxt4-000000002Cn-1jhc
Subject: [f2fs-dev] [PATCH 01/20] f2fs: use block-based index and size
 calculations in remaining paths
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Several paths still convert between file offsets and block indices with
PAGE_SHIFT or PAGE_SIZE, assuming that a page holds exactly one
filesystem block. Use the F2FS_BLK_* helpers there so that they stay
correct when the block size is smaller than PAGE_SIZE.

No functional change when the block size equals PAGE_SIZE, except that
__complete_revoke_list() now computes the truncation offset in 64 bits
and no longer overflows beyond 4GB on 32-bit architectures.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c    |  5 +++--
 fs/f2fs/dir.c     |  4 ++--
 fs/f2fs/file.c    | 48 +++++++++++++++++++++++------------------------
 fs/f2fs/segment.c |  5 +++--
 4 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4ae61138a003..aacc92839f61 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1897,8 +1897,9 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	}
 got_it:
 	if (new_i_size && i_size_read(inode) <
-				((loff_t)(index + 1) << PAGE_SHIFT))
-		f2fs_i_size_write(inode, ((loff_t)(index + 1) << PAGE_SHIFT));
+				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), index + 1))
+		f2fs_i_size_write(inode,
+				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode), index + 1));
 	return folio;
 }
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 70847313ca6a..3eb0b7255951 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -39,8 +39,8 @@ extern struct kmem_cache *f2fs_cf_name_slab;
 
 static unsigned long dir_blocks(struct inode *inode)
 {
-	return ((unsigned long long) (i_size_read(inode) + PAGE_SIZE - 1))
-							>> PAGE_SHIFT;
+	return F2FS_BYTES_TO_BLK(F2FS_I_SB(inode),
+			i_size_read(inode) + F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)));
 }
 
 static unsigned int dir_buckets(unsigned int level, int dir_level)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 05061254c3b2..93d3088c96f0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1576,7 +1576,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				}
 				dn.ofs_in_node++;
 				i++;
-				new_size = (loff_t)(dst + i) << PAGE_SHIFT;
+				new_size = F2FS_BLK_TO_BYTES(sbi, dst + i);
 				if (dst_inode->i_size < new_size)
 					f2fs_i_size_write(dst_inode, new_size);
 			} while (--ilen && (do_replace[i] || blkaddr[i] == NULL_ADDR));
@@ -1593,7 +1593,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				return PTR_ERR(fsrc);
 
 			src_off = offset_in_folio(fsrc,
-						(loff_t)(src + i) << PAGE_SHIFT);
+						F2FS_BLK_TO_BYTES(sbi, src + i));
 
 			/*
 			 * For same-inode operations (collapse/insert), src and
@@ -1623,10 +1623,10 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 
 			dst_off = offset_in_folio(fdst,
-					(loff_t)(dst + i) << PAGE_SHIFT);
+					F2FS_BLK_TO_BYTES(sbi, dst + i));
 			f2fs_folio_wait_writeback(fdst, true, true);
 			memcpy_folio(fdst, dst_off, fsrc, src_off,
-				    PAGE_SIZE);
+				    F2FS_BLKSIZE(sbi));
 			if (folio_test_large(fdst)) {
 				if (!f2fs_ffs_find_or_alloc(fdst)) {
 					f2fs_folio_put(fdst, true);
@@ -1635,15 +1635,15 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 					return -ENOMEM;
 				}
 				f2fs_ffs_mark_subrange_uptodate(fdst,
-							dst_off, PAGE_SIZE);
+						dst_off, F2FS_BLKSIZE(sbi));
 				f2fs_ffs_mark_subrange_dirty(fdst, dst_off,
-							    PAGE_SIZE);
+						F2FS_BLKSIZE(sbi));
 			}
 			folio_mark_dirty(fdst);
 			if (same_folio && i_size_read(dst_inode) <
-			    ((loff_t)(dst + i + 1) << PAGE_SHIFT))
+			    F2FS_BLK_TO_BYTES(sbi, dst + i + 1))
 				f2fs_i_size_write(dst_inode,
-					((loff_t)(dst + i + 1) << PAGE_SHIFT));
+					F2FS_BLK_TO_BYTES(sbi, dst + i + 1));
 			folio_set_f2fs_gcing(fdst);
 			f2fs_folio_put(fdst, true);
 			if (!same_folio)
@@ -1715,9 +1715,9 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_lock_context lc;
-	pgoff_t nrpages = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
-	pgoff_t start = offset >> PAGE_SHIFT;
-	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	pgoff_t nrpages = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
+	pgoff_t start = F2FS_BYTES_TO_BLK(sbi, offset);
+	pgoff_t end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 	int ret;
 
 	f2fs_balance_fs(sbi, true);
@@ -1988,10 +1988,10 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	pg_start = offset >> PAGE_SHIFT;
-	pg_end = (offset + len) >> PAGE_SHIFT;
+	pg_start = F2FS_BYTES_TO_BLK(sbi, offset);
+	pg_end = F2FS_BYTES_TO_BLK(sbi, offset + len);
 	delta = pg_end - pg_start;
-	idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	/* avoid gc operation during block exchange */
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
@@ -3104,10 +3104,10 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
-	pg_start = range->start >> PAGE_SHIFT;
+	pg_start = F2FS_BYTES_TO_BLK(sbi, range->start);
 	pg_end = min_t(pgoff_t,
-				(range->start + range->len) >> PAGE_SHIFT,
-				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
+				F2FS_BYTES_TO_BLK(sbi, range->start + range->len),
+				F2FS_BLK_ALIGN(sbi, i_size_read(inode)));
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) ||
 		f2fs_is_atomic_file(inode)) {
@@ -3124,8 +3124,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						(loff_t)pg_start << PAGE_SHIFT,
-						((loff_t)pg_end << PAGE_SHIFT) - 1);
+						F2FS_BLK_TO_BYTES(sbi, pg_start),
+						F2FS_BLK_TO_BYTES(sbi, pg_end) - 1);
 	if (err)
 		goto out;
 
@@ -3249,7 +3249,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 unlock_out:
 	inode_unlock(inode);
 	if (!err) {
-		range->len = (u64)total << PAGE_SHIFT;
+		range->len = F2FS_BLK_TO_BYTES(sbi, total);
 		stat_inc_defrag_blk_count(sbi, total);
 	}
 	return err;
@@ -4354,7 +4354,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	while (page_idx < last_idx) {
 		struct dnode_of_data dn;
@@ -4532,7 +4532,7 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 
 	while (page_idx < last_idx) {
 		struct dnode_of_data dn;
@@ -4997,7 +4997,7 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!atomic_read(&fi->i_compr_blocks))
 		goto out;
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	last_idx >>= fi->i_log_cluster_size;
 
 	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
@@ -5084,7 +5084,7 @@ static int f2fs_ioc_compress_file(struct file *filp)
 
 	set_inode_flag(inode, FI_ENABLE_COMPRESS);
 
-	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	last_idx = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	last_idx >>= fi->i_log_cluster_size;
 
 	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 31ac93a93021..2b0821c2c18b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -285,6 +285,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 					bool revoke)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct revoke_entry *cur, *tmp;
 	pgoff_t start_index = 0;
 	bool truncate = is_inode_flag_set(inode, FI_ATOMIC_REPLACE);
@@ -303,7 +304,7 @@ static void __complete_revoke_list(struct inode *inode, struct list_head *head,
 	}
 
 	if (!revoke && truncate)
-		f2fs_do_truncate_blocks(inode, start_index * PAGE_SIZE, false);
+		f2fs_do_truncate_blocks(inode, F2FS_BLK_TO_BYTES(sbi, start_index), false);
 }
 
 static int __f2fs_commit_atomic_write(struct inode *inode)
@@ -315,7 +316,7 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
 	struct list_head revoke_list;
 	block_t blkaddr;
 	struct dnode_of_data dn;
-	pgoff_t len = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	pgoff_t len = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	pgoff_t off = 0, blen, index;
 	int ret = 0, i;
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
