Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBE606A31D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nczy3PTU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YNZ89v1j;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h1IckzQY;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QCbJxAQ6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=KnmDDw6NC3ihnfUmeJ86OJ24VYhH5Z88NNGz1iM61vg=; b=Nczy3PTUXSoveZ0uRScYP0AS65
	7IswL1XtoLj9zD4/y2oDPxjfPoKpUlDj6rlpzvNFmHy654nzXf1DLxZOA3DnYDSeSUtWRIt6foIMk
	FKTm30Qmg4HWA/OJy7sBD1pimJFY+klZl4qwit/dGn3XT7GnedlwIWLBqobDQJJWM3PE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndJ-000000006yv-0dLU;
	Thu, 22 Oct 2026 07:54:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndG-000000006xn-0UJF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m4Jec9Gqs5xcdLMkt6OJpNGlxGKaIun9cx3Aj5+yLsw=; b=YNZ89v1jhSS8+5as3HdkCImhZb
 4D4UMXQcG3bwlyAV3U1X8t0DVqr/C98nQRLzpNTRJH4midYZHywsgUnTQSq9WMFjPcv9ihy16BaVV
 xr3pq18yxfhTmW2rHJxjsDDv9FBTVxSVNw8Avg7HWZ13lHE3XrS9aGAn0NEu4Tc2wuQQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m4Jec9Gqs5xcdLMkt6OJpNGlxGKaIun9cx3Aj5+yLsw=; b=h1IckzQYxbWJ1m/0cHqIDw43Lr
 0g4qEXdCCpcRI2intH7FP9sRy2RSBE7jPezlYiudBLss/ctNa8fQgiyaB9xGo6IVICVsH2xG2MTmE
 HOfR9WH1/lNzW/vSd08RlDxOaPjlowgrr8vsL8Pqc3HOZ3c/eGPSnlQsHb5Q6X+j3g3Q=;
Received: from mail-pj2-f4.google.com ([74.125.227.132])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJncy-000000007oU-3vDB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:21 +0000
Received: by mail-pj2-f4.google.com with SMTP id
 98e67ed59e1d1-3a84a12aa97so457330a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655655; x=1793260455; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m4Jec9Gqs5xcdLMkt6OJpNGlxGKaIun9cx3Aj5+yLsw=;
 b=QCbJxAQ6THx8hdVCINzImCEmGhfuW+GjlkeICtmMxw5WiR2nwRKlnUL+1WvJnsaS9y
 k5tSHKoRcJl7GKpZXTjSq75M+lS+ympBiGzGvWaex9I8pwCnNGWNZpPXE2NOrjM+GRZ4
 4gvNDlbPgFgYvZeH34SAvWle00IDyCh4ZkUtL2VDNQcPeivsIWyG9xEegacW8pg/asqv
 /c8PkweP1ciO9KbQVIubrwUy2yO+yWIoSEVgVAhnvZF8pRELlMhsNYsMf/xtjvXjlY/p
 1wc6ct54+spuVb6vcn4U0+b1a1DZX5ZFHWwCfKLeNWvfgL2o9PyZj8XSmMPpNZQscuYo
 t/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655655; x=1793260455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m4Jec9Gqs5xcdLMkt6OJpNGlxGKaIun9cx3Aj5+yLsw=;
 b=Qrwvgr95zgyjFH1ydLdX/y8Uokp1kK4Jh62WSThOhrcvtE0kG59sO6hWycr31x7iq+
 k4s4YD3UD0iayU5kqPcg1X+tqDoyKVjZutZxe2TDz4dFLmr6+HKNQWWPqHHhbVc0amr0
 RzPaZ2rDbcYgmWnnzqVeaxQTeRsaF9EOvwg5c685AmWMi+JLuyrowQCHiFPLjSoI9Za7
 sEq0CZtYYvsJen/NZxgmkuw+5ejFR26pwAzb5E7eC66DiFYDDobYeoGYE/rwhuU0OqV8
 2kIgvSEQM0TPLhU2mlpurSNMBRf4QRsLcAyIxADuz4wa3CW4ErHJYueJWP2GGitVWPaT
 Ovcg==
X-Gm-Message-State: AFq9FYJL+5IeA0JUp6Ui3tDDrzYq6E6IaJW8bmFV3s9WcMp8yhafzYEB
 qQwuC9eVWemfMPa/qkvRW7Thr13w/y1bl3+R4MEansVYV8ekXWMz0/sfS7elSoYOWHU=
X-Gm-Gg: AYBFou3RKhcMvOka7j1dd3IbPhy0HHxgBzkkw/t8UUu+EWQEAAyPViXMTh/bLAPNm//
 lLWinIBafiHyWgSGNSXt52xD8gnvkEq6Bka84U2B7DxaImqJgd0SvfhmOuji6dAVlHq+R/jt6cY
 6TZ+VeEvlkkxaatGKP18HyMaS3Jmt/LJG9JVMfXkC7BASnA2ocktolGrlvkonNmlKW+AYX1a41y
 KuCDg0UAC8le1L5tUr+iwz2O0aoej1q5utLSiMali+FXgDoF0MPbb9KBBb1NfV6PmDiO8aFNK3t
 FrgiNmtd9E5KoTuBEP9iQp1rTovo0zuJWSpQhMR3GRpKuoe0Dhb0VXhgwciwZP0+fA4qG6rBrcX
 29spHsTY3bbk9YZM1lBI9F+qp7e8OACbR0xfGPWFErXdJpmvOTcDAT3pPEhLiaMTT3yxIJfTWJU
 WFL8jVeTV+CrG37A/ODoZHEeaPin28zJuAnoHvh2pMrHmn3wemUTZuc6moIVU+REvEAZAEoVh26
 9/QzfpumIHSGVysaMAb6tvRinGVZWItJyylHLseoDIMPRatoVuWIvGXPxj4lyEyelDtKsJdMv4U
 hB0yUlIdRDjYo+KLU8UKMhz/mcjREn530d/Ve/I=
X-Received: by 2002:a17:90b:5244:b0:3ab:e588:c295 with SMTP id
 98e67ed59e1d1-3ad86d9e1c7mr3651982a91.42.1792655655118; 
 Thu, 22 Oct 2026 00:54:15 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:14 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:33 +0800
Message-ID: <20261022075343.3043003-7-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJncy-000000007oU-3vDB
Subject: [f2fs-dev] [PATCH v6 06/15] f2fs: account large folio dirty data at
 block granularity
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Originally inode->dirty_pages was accounted once per folio, but f2fs
needs the counter to be accounted in blocks.

This introduces batch dirty page add/sub accounting; for a large folio
the changed dirty page count is computed from the dirty bitmap bit
changes.

Found by f2fs/006 (lfs + checkpoint=disable) and generic/363.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/checkpoint.c | 38 ++++++++++++++++++++++----
 fs/f2fs/compress.c   |  4 +--
 fs/f2fs/data.c       | 50 +++++++++++++++++++++++-----------
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 65 ++++++++++++++++++++++++++++++++++----------
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/inline.c     |  2 +-
 fs/f2fs/node.c       |  2 +-
 8 files changed, 123 insertions(+), 42 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3ad709f69893..1ed38c668fc5 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1324,20 +1324,46 @@ static void __remove_dirty_inode(struct inode *inode, enum inode_type type)
 	stat_dec_dirty_inode(F2FS_I_SB(inode), type);
 }
 
-void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
+/*
+ * Account @nr dirty pages (negative when dirtiness is cleared) for @inode.
+ */
+void f2fs_account_dirty_blocks(struct inode *inode, int nr)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	enum inode_type type = S_ISDIR(inode->i_mode) ? DIR_INODE : FILE_INODE;
 
-	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
-			!S_ISLNK(inode->i_mode))
+	if (!nr)
 		return;
 
 	spin_lock(&sbi->inode_lock[type]);
-	if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
-		__add_dirty_inode(inode, type);
-	inode_inc_dirty_pages(inode);
+	if (nr > 0) {
+		if (type != FILE_INODE || test_opt(sbi, DATA_FLUSH))
+			__add_dirty_inode(inode, type);
+		inode_add_dirty_blocks(inode, nr);
+	} else {
+		inode_sub_dirty_blocks(inode, -nr);
+		__remove_dirty_inode(inode, type);
+	}
 	spin_unlock(&sbi->inode_lock[type]);
+}
+
+void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio)
+{
+	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
+			!S_ISLNK(inode->i_mode))
+		return;
+
+	/*
+	 * Large folios have a subpage dirty bitmap, so defer their dirty accounting
+	 * to the f2fs_ffs_*subrange_dirty*() helpers.  This avoids nesting
+	 * ffs->state_lock with the inode dirty list lock.
+	 */
+	if (f2fs_folio_has_ffs(folio)) {
+		folio_set_f2fs_reference(folio);
+		return;
+	}
+
+	f2fs_account_dirty_blocks(inode, 1);
 
 	folio_set_f2fs_reference(folio);
 }
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c0e39f580993..162bd8ef822a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1065,7 +1065,7 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 	/* Cancel writeback and stay locked. */
 	for (i = 0; i < cc->cluster_size; i++) {
 		if (i < submitted) {
-			inode_inc_dirty_pages(cc->inode);
+			inode_inc_dirty_block(cc->inode);
 			lock_page(cc->rpages[i]);
 		}
 		clear_page_private_gcing(cc->rpages[i]);
@@ -1409,7 +1409,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		}
 		(*submitted)++;
 unlock_continue:
-		inode_dec_dirty_pages(cc->inode);
+		inode_dec_dirty_block(cc->inode);
 		folio_unlock(fio.folio);
 	}
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 74583f0f1833..f415c3eb4e78 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2967,10 +2967,18 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
 	return bitmap_weight(ffs->state, 2 * nr_subpages) - before;
 }
 
+/*
+ * Mark the given range dirty for writeback.
+ *
+ * Callers must guarantee that the corresponding subpages are already
+ * uptodate: a dirty subpage always holds the latest data, whose
+ * on-disk copy may be stale.
+ */
 void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 				    size_t offset, size_t len)
 {
 	struct f2fs_folio_state *ffs;
+	unsigned int set;
 	unsigned long flags;
 
 	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
@@ -2981,21 +2989,27 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
 	ffs = (struct f2fs_folio_state *)folio->private;
 
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	__ffs_mark_subrange_dirty(folio, ffs, offset, len);
+	set = __ffs_mark_subrange_dirty(folio, ffs, offset, len);
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	if (set)
+		f2fs_account_dirty_blocks(folio->mapping->host, set);
 }
 
 static bool __ffs_clear_subrange_dirty(struct folio *folio,
-			struct f2fs_folio_state *ffs, size_t offset, size_t len)
+			struct f2fs_folio_state *ffs, size_t offset, size_t len,
+			unsigned int *cleared)
 {
 	unsigned int nr_subpages = folio_nr_pages(folio);
-	unsigned int start, end;
+	unsigned int start, end, before;
 
 	start = offset >> PAGE_SHIFT;
 	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	end = min(end, nr_subpages);
 
+	before = bitmap_weight(ffs->state, 2 * nr_subpages);
 	bitmap_clear(ffs->state, nr_subpages + start, end - start);
+	*cleared = before - bitmap_weight(ffs->state, 2 * nr_subpages);
 	return find_next_bit(ffs->state, 2 * nr_subpages, nr_subpages) <
 			2 * nr_subpages;
 }
@@ -3007,13 +3021,15 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
  * @len: byte length of the subrange
  *
  * Clear the dirty bits of the 4K subpages covered by [offset, offset + len),
- * and return whether the folio still has any dirty subpage left.
+ * account the cleared subpages against the inode dirty counters, and return
+ * whether the folio still has any dirty subpage left.
  */
 bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 					    size_t len)
 {
 	struct f2fs_folio_state *ffs;
 	unsigned long flags;
+	unsigned int cleared = 0;
 	bool dirty;
 
 	if (!f2fs_folio_has_ffs(folio))
@@ -3021,9 +3037,12 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
 	ffs = (struct f2fs_folio_state *)folio->private;
 	spin_lock_irqsave(&ffs->state_lock, flags);
-	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len);
+	dirty = __ffs_clear_subrange_dirty(folio, ffs, offset, len, &cleared);
 	spin_unlock_irqrestore(&ffs->state_lock, flags);
 
+	if (cleared)
+		f2fs_account_dirty_blocks(folio->mapping->host, -cleared);
+
 	return dirty;
 }
 
@@ -3933,7 +3952,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		goto redirty_out;
 
 out:
-	inode_dec_dirty_pages(inode);
+	inode_dec_dirty_block(inode);
 	if (err) {
 		folio_clear_uptodate(folio);
 		folio_clear_f2fs_gcing(folio);
@@ -4312,14 +4331,13 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 */
 		if (unlikely(f2fs_cp_error(sbi))) {
 			mapping_set_error(folio->mapping, -EIO);
-			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY) {
+			if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
 				folio_redirty_for_writepage(wbc, folio);
-			} else {
-				if (f2fs_folio_has_ffs(folio))
-					f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-									folio_size(folio));
-				inode_dec_dirty_pages(inode);
-			}
+			else if (f2fs_folio_has_ffs(folio))
+				f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+								folio_size(folio));
+			else
+				f2fs_account_dirty_blocks(inode, -1);
 			goto retry_out;
 		}
 
@@ -4436,8 +4454,8 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
 					(err ? pos : end_pos) - folio_pos(folio)) || err)
 			folio_redirty_for_writepage(wbc, folio);
-		else
-			inode_dec_dirty_pages(inode);
+		else if (!f2fs_folio_has_ffs(folio))
+			inode_dec_dirty_block(inode);
 
 		/*
 		 * Release the bias taken above and we end writeback here if
@@ -5279,7 +5297,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		return;
 
 	if (folio_test_dirty(folio)) {
-		inode_dec_dirty_pages(inode);
+		inode_dec_dirty_block(inode);
 		f2fs_remove_dirty_inode(inode);
 	}
 
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 97f7fef6b068..70847313ca6a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -937,7 +937,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, void *dentry_block,
 		folio_clear_uptodate(folio);
 		folio_detach_private(folio);
 
-		inode_dec_dirty_pages(dir);
+		inode_dec_dirty_block(dir);
 		f2fs_remove_dirty_inode(dir);
 	}
 	f2fs_folio_put(folio, true);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index df0091591ff5..b89664e28a92 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2919,9 +2919,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 	f2fs_i_blocks_write(inode, count, false, true);
 }
 
-static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
+static inline void add_cache_counts(struct f2fs_sb_info *sbi,
+					int count_type, int nr)
 {
-	atomic_inc(&sbi->nr_caches[count_type]);
+	atomic_add(nr, &sbi->nr_caches[count_type]);
 
 	if (count_type == F2FS_DIRTY_DENTS ||
 			count_type == F2FS_DIRTY_NODES ||
@@ -2931,31 +2932,66 @@ static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 }
 
-static inline void inode_inc_dirty_pages(struct inode *inode)
+static inline void sub_cache_counts(struct f2fs_sb_info *sbi,
+					int count_type, int nr)
 {
-	atomic_inc(&F2FS_I(inode)->dirty_pages);
-	inc_cache_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
-				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
-	if (IS_NOQUOTA(inode))
-		inc_cache_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
+	atomic_sub(nr, &sbi->nr_caches[count_type]);
+}
+
+static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
+{
+	add_cache_counts(sbi, count_type, 1);
 }
 
 static inline void dec_cache_count(struct f2fs_sb_info *sbi, int count_type)
 {
-	atomic_dec(&sbi->nr_caches[count_type]);
+	sub_cache_counts(sbi, count_type, 1);
+}
+
+/*
+ * Account @nr dirty pages for @inode; one page is
+ * (PAGE_SIZE >> log_blocksize) filesystem blocks.
+ */
+static inline void inode_add_dirty_blocks(struct inode *inode, int nr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int blocks = nr * (PAGE_SIZE >> sbi->log_blocksize);
+
+	atomic_add(blocks, &F2FS_I(inode)->dirty_pages);
+	if (S_ISDIR(inode->i_mode))
+		add_cache_counts(sbi, F2FS_DIRTY_DENTS, blocks);
+	else
+		add_cache_counts(sbi, F2FS_DIRTY_DATA, blocks);
+	if (IS_NOQUOTA(inode))
+		add_cache_counts(sbi, F2FS_DIRTY_QDATA, blocks);
 }
 
-static inline void inode_dec_dirty_pages(struct inode *inode)
+static inline void inode_sub_dirty_blocks(struct inode *inode, int nr)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	int blocks = nr * (PAGE_SIZE >> sbi->log_blocksize);
+
 	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
 			!S_ISLNK(inode->i_mode))
 		return;
 
-	atomic_dec(&F2FS_I(inode)->dirty_pages);
-	dec_cache_count(F2FS_I_SB(inode), S_ISDIR(inode->i_mode) ?
-				F2FS_DIRTY_DENTS : F2FS_DIRTY_DATA);
+	atomic_sub(blocks, &F2FS_I(inode)->dirty_pages);
+	if (S_ISDIR(inode->i_mode))
+		sub_cache_counts(sbi, F2FS_DIRTY_DENTS, blocks);
+	else
+		sub_cache_counts(sbi, F2FS_DIRTY_DATA, blocks);
 	if (IS_NOQUOTA(inode))
-		dec_cache_count(F2FS_I_SB(inode), F2FS_DIRTY_QDATA);
+		sub_cache_counts(sbi, F2FS_DIRTY_QDATA, blocks);
+}
+
+static inline void inode_inc_dirty_block(struct inode *inode)
+{
+	inode_add_dirty_blocks(inode, 1);
+}
+
+static inline void inode_dec_dirty_block(struct inode *inode)
+{
+	inode_sub_dirty_blocks(inode, 1);
 }
 
 static inline void inc_atomic_write_cnt(struct inode *inode)
@@ -4384,6 +4420,7 @@ void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
 int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
 void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio);
+void f2fs_account_dirty_blocks(struct inode *inode, int nr);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 								bool from_cp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 485c01b6756b..67a4224a5d75 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1564,7 +1564,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 
 		folio_mark_dirty(folio);
 		if (folio_clear_dirty_for_io(folio)) {
-			inode_dec_dirty_pages(inode);
+			inode_dec_dirty_block(inode);
 			f2fs_remove_dirty_inode(inode);
 		}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ab7537ff7ebd..49905aa08418 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -199,7 +199,7 @@ int f2fs_convert_inline_folio(struct dnode_of_data *dn, struct folio *folio)
 	f2fs_outplace_write_data(dn, &fio);
 	f2fs_folio_wait_writeback(folio, true, true);
 	if (dirty) {
-		inode_dec_dirty_pages(dn->inode);
+		inode_dec_dirty_block(dn->inode);
 		f2fs_remove_dirty_inode(dn->inode);
 	}
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 424e95ca5878..1fdef678dcef 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1699,7 +1699,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 		goto folio_out;
 
 	ret = f2fs_write_inline_data(inode, folio);
-	inode_dec_dirty_pages(inode);
+	inode_dec_dirty_block(inode);
 	f2fs_remove_dirty_inode(inode);
 	if (ret)
 		folio_mark_dirty(folio);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
