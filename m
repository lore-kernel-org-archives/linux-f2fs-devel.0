Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94602606C072
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WVQAxltD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HmC4SiF6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HNWsp4MH;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4SsGYQk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=SD8/xdRWcLRiKR2PSpvGpDnljQ0FJ+hzOCli3wiS+Ow=; b=WVQAxltDboC8XmT2jWc30C6iQL
	D6zxQVJyb27Yk+G9c/Oxb03NZ4CN2A17TcUNgCj0pOzPqy+t2Z67cAa7imb/pPBazcTX40vft95t5
	gbR8LrQw+WaX6DsyXPtGz3kGj7cTn1jxncC/ThX8cFPXqvfbUqLrzOy9kJpKr0XN9Bns=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5pg-000000000u3-1Koe;
	Wed, 28 Oct 2026 15:44:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5pe-000000000tw-2GjS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3FCFT0uaxJxLqwTeRxMuCffzvNFzo6uOEkKMUhBywkQ=; b=HmC4SiF6XGN5R5eoN6b8Jd43IF
 rI7KLZj3ydE7kmZbnVw9tjO5XbWtTI4IVzGg9vODhvNffsChr9A3ZBWh7spkDtqrksoVY+0itxT5J
 Ta6gu+qiYtJn4mH1W3gDoRUdHxdYaeXSLWYQ5BHx9Nxhc9g6qmNYjtX8+wmXPer6+Aro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3FCFT0uaxJxLqwTeRxMuCffzvNFzo6uOEkKMUhBywkQ=; b=HNWsp4MHlCwdkcDrp9u7/DHB3O
 M58GidbWIshAIroV5M0bMywiffq8lRnX/roUbSWTjceWvo/OcycaE+AZD+GDXtPNdQ/ZOxlVDYabB
 pdTBuSEDduwlGup/zM4gZ2OIWgwohmiN7g/Oe8HqIwWn79zGLDZ0iGqtQ5otiu3mIf8M=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5pc-000000003ZS-45oB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:44:54 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2e85fb35300so1810145ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202287; x=1793807087; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3FCFT0uaxJxLqwTeRxMuCffzvNFzo6uOEkKMUhBywkQ=;
 b=Y4SsGYQkN6Zs6S2vaH5l6lp7eM4LBGO4yLtuoJdX/kZJEPsFnrKYGkDWq4LFe1c99a
 oMxoL86HwgNqcEmnfhZpOXGl+lqS7lEAT7ZTqapZD3v7e9s1EE6VU5IZQnmrxILFqIV+
 kbTWpW73mutQ+ej+CDPIPeSHH4CQNTpaOygQjBcxiULkolfsAb68JQT0VteVkR8hQ7Eo
 5yu4+yft/3qezxdYeo07IpQvz+1Z7xR1wxvk/SM3DCr2KRJY5MUjCZ5RTU1Wt+V4sJM0
 Yu5aHKmRm9TixbIbu5Zrob1E7yaCg2WrBK0HgmVZIiCdxpWNGMZukBZs5ZLwAfViKjib
 TalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202287; x=1793807087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3FCFT0uaxJxLqwTeRxMuCffzvNFzo6uOEkKMUhBywkQ=;
 b=GYs8Fa9rqNbP+CfmG02QqIXGo9qtRFj7PrKYGRuUJM3QXj79TqiF9uPXeJrM8uNOdG
 KzKNv5K7ahNzJ2qTiTw0jBQKcEDszZ99B5O4poKACDiGk59pYeXLozAw5CJ9SW/VB5us
 q4tdQVuiGmnRhzK3SPcI+CKX3/8oATZokaqVkBA7hJgItROpW3t5nZFq9FUd9JLd7I5n
 mTD866TSZAlBvysh+ETCBuULWBtyQ0PKv1nmJMHIlJCggffsPW6+XEmlmVfL1OppfQPO
 0l/PAwkgeOkFiJl3TGexNV0FnjBza0h6qu+j6u9eTTUBrs+GDuzyvMxpYsyU1Vx/ewTA
 ujgQ==
X-Gm-Message-State: AFq9FYKnKCnSEmWrkSVOA6YTMc0GFNl/TCYDVC23uhgC0tmtIhCGbtFJ
 Jn1r0oUYtseT5s15+bKCFl357OWi7IzDrJNhbFaEiH2DiL/LgLKRGYvHCVFetw4zcfo=
X-Gm-Gg: AYBFou0k+KjEJSb8mosidaA0XFYDR4fLRHOZ3/xKZSAYShoHIB/Iw2HX4ZcDK1dOCdE
 wOAQhbwE7zGNV1/FOYHJ5tOBPLLX9B8tOW6xFZlJQ6Yk1uclhCgVncDllOYgkSbCIACcMeqE/h0
 5epaaAeCa7QSRlDm7gdx3fvNseDwoJ1PAiQYd9akfSvL8BV0tJNCCFW9yxPnpCEO+Q2D7POiFYa
 xC4spkYoBXQKCl1Kvc3uVrVtVThfIh0hzYifJzZOgIXYahdl+5nnMjUBVjWrJlCfWYAf1fpphaX
 IIQRH3OaQxa7dg0qKxoEVzQ5SDAqHuw9WkFoP1HU4svfXXjGGK7kEZ5k2dXjmN/CnYStOxsvsH7
 QMc5ShxE9iKV/O13DHsQ7hrfyoOgHbnY47V65iYpqslw9jcCqFgcT5+GbPl8LtgyGtZLnfVMilb
 zoF37yFhiLTs8EhEDKLJ4bySvJP843/ZaqXL6flOY7+vEF/H/75I1rSM9oGo5lPcPb9JHxVvC0g
 /m23aFNcHEaeIDpZ65bo4Aygf+Avlj2zLs41NiRNTyNX1zkv56OmQtAiGxbUMvV4YzjKHXMLYTt
 jFZsF3SjCgfjYjnhHT2kMnBLWwFdM2/Q90OQJH8bcDEe4Mr4PCZmS6Tj2/6FTAXRAkawpLpdiZ8
 yIlhLQuM0N2el
X-Received: by 2002:a17:902:f54d:b0:2e9:528c:b9ea with SMTP id
 d9443c01a7336-2eb073ef1f7mr11115375ad.11.1793202287155; 
 Wed, 28 Oct 2026 08:44:47 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:44:46 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:43:57 +0800
Message-ID: <20261028154407.1601430-7-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5pc-000000003ZS-45oB
Subject: [f2fs-dev] [PATCH v8 06/15] f2fs: account large folio dirty data at
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
 fs/f2fs/data.c       | 37 +++++++++++++++++++------
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 65 ++++++++++++++++++++++++++++++++++----------
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/inline.c     |  2 +-
 fs/f2fs/node.c       |  2 +-
 8 files changed, 117 insertions(+), 35 deletions(-)

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
index 1faff6f4621d..6040bda749b7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2991,10 +2991,18 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
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
@@ -3005,21 +3013,27 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
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
@@ -3031,13 +3045,15 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
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
@@ -3045,9 +3061,12 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
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
 
@@ -3957,7 +3976,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		goto redirty_out;
 
 out:
-	inode_dec_dirty_pages(inode);
+	inode_dec_dirty_block(inode);
 	if (err) {
 		folio_clear_uptodate(folio);
 		folio_clear_f2fs_gcing(folio);
@@ -4471,8 +4490,8 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
 						clear_len) || err) {
 			folio_redirty_for_writepage(wbc, folio);
-		} else {
-			inode_dec_dirty_pages(inode);
+		} else if (!f2fs_folio_has_ffs(folio)) {
+			inode_dec_dirty_block(inode);
 		}
 
 		/*
@@ -5325,7 +5344,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
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
index e33335976a9b..99db13fc9299 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2930,9 +2930,10 @@ static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
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
@@ -2942,31 +2943,66 @@ static inline void inc_cache_count(struct f2fs_sb_info *sbi, int count_type)
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
@@ -4395,6 +4431,7 @@ void f2fs_remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino);
 int f2fs_recover_orphan_inodes(struct f2fs_sb_info *sbi);
 int f2fs_get_valid_checkpoint(struct f2fs_sb_info *sbi);
 void f2fs_update_dirty_folio(struct inode *inode, struct folio *folio);
+void f2fs_account_dirty_blocks(struct inode *inode, int nr);
 void f2fs_remove_dirty_inode(struct inode *inode);
 int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 								bool from_cp);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 72c7f9ceafc2..c66ca03d0d5a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1565,7 +1565,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 
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
