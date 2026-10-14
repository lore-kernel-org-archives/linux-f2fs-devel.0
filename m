Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD6CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ieJsgBucxhAPr43dY1S4gIyPsxTncCAPxJLvuvpSw4=; b=mcpLJRC/h/+g0SwlPBhxXA/c3n
	zwkXnJadVAvMkwWbT+9LN0BuA0G45moy2rAObD1cr7f7UB8/3nWydXHD6Ly8y/EGv1Ay+bhf3c0HI
	3HIwj5Rq63OedmvkYCmctw+3n3oewsGHte4dm8LLlOhaKmXmI3YSSo1yN4tmjgSzEg5I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskQ-0002mq-Mf;
	Wed, 14 Oct 2026 06:45:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskJ-0002gz-8o
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mEKIlPH2igusDvI9TwS0fA4c3tyUSHkbTzcqfoClEHY=; b=gttL2xiOEcG1mf+l8LJSx9hjaQ
 jW9rANAc0KLYFEKU2IuELwlJMTOSuA8SmurwmfPrDLoIyX4kyf6yCx7HeUhReuf5Y3yIH77LJvcHT
 CDlYmYo8H0DaaS/lWl70NALZbOqzb1da8MtJIWfG+38A/ClaFQ5T9sVcWY+E5QgeuK7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mEKIlPH2igusDvI9TwS0fA4c3tyUSHkbTzcqfoClEHY=; b=nFqkNwk4JDYA2ttKVBozJqoQ51
 FWyUtE1esOd3i4+JWGYtS7XddwlAPtlm0KPrUKipkwTzkR0DHZOyRTF57MpmuzVL14m5NooTvGj9V
 jsrdvEpcJVbIB9DP46Hw7REN3KKvs939WtbAQaA7reScTSdfWjwvwREPJR4c3O4edGOc=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskE-0004KF-EY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:45:47 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3ac69691963so97175a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960341; x=1792565141; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mEKIlPH2igusDvI9TwS0fA4c3tyUSHkbTzcqfoClEHY=;
 b=aLdEUdWqnFAxFK81zNf1X6aS4Gr+/SURuMTEGNu6ChYL6ypwhxWNoEw3MYaxIOt7Q6
 ES4VuLRiLd0UxcJyt0J71Cp0V0NmmRJT3KfpSCQiOfAdc6UljyGac/1P4tcqwhc9VRCt
 rMfYkfad5I+UpxtFWdeQhRc2oc/R75H17YaH86k7sSDKhzJh4BrP5ZWGptOqpHEm/O7+
 OSiwRAqJPwhEZKgEvivyTzA3yu6bqzLpcvOYea8HHV8lwKr+rqdm7rgD2BDFuvEj5mAK
 Wh3BKdj0QZ3mghJ0Dfdk5rYZfglA845E24996Kza5G2HwXTYPV00Q+qeA3vkVO5281ID
 gzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960341; x=1792565141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mEKIlPH2igusDvI9TwS0fA4c3tyUSHkbTzcqfoClEHY=;
 b=mvLH6WgLsXvZ9y9kFgWToDVTz/RQe7pmLLneyfq80JdYaQ6T+PehmCn4v2JHny4YDq
 ALGApihsuKXnh/62vD9daHeP6r71X6xP1BKWm/rcqs1paO22OeCRhg4cUGS/UPlL40l/
 wQbo5zgNErqHI4kAfXvRj54RYFd6ynOQhqX1huy8z3L4Vl7Ibmesxjc8NIhq9Ik+cXeL
 y6BY7NRme0JWe8WZKkuWgYkMuYZpL8c8iU9KpKw/evqOryM0UeEq9ItBkq9/RkYXmPnS
 uhVPVR9B5SqlN9TL3PFdNTzhJY8gP6dB16AYKNnZ6yQo2V3tbLwTaxDxflAj6j8ZeOHy
 gxjA==
X-Gm-Message-State: AFq9FYLFSTXCtDhhAUeeY8eZoOBolJT7vjeZNtNH1R7wdReBaO3bix8g
 F8O9+M0MJYDDDHfk9WZrozj/J+c6QQDJj7tPfpgBqojqXea5JJ6bpcaDwjFpd0XinQA=
X-Gm-Gg: AYBFou0s20JegPu1ReBZ8VuT6FCros/4IYax0J+98eMNkBXmR8Oz21voRExlYuJ7gnE
 E1we8xlY3D92q8nAMYBT6UJQ6HlyTji+K6tG7JmKyQP7yJDOlS95kcgNt9kf42TJD5+09+HjqrQ
 uxoAWOQpQXNXHPILwEVWqcAwJRDD7mWIyPT6dSQ9TmX1qJ/EmcuY0U7eZ0xWzVSqJ72HY3Mp7ib
 K3mfSTtXW4JODqy1lzhcfezrQFi6FXGTkmdVeasaimcNIimBhxX6j34QsOQWKBoWvKb16ppfQkG
 NZrNXHxotlnnBPwwfeKAzhROYPw3vXkrZAaZxhDOSqVgHkNeVyQKpcxtZ9nN0erAWLYcTkWu4fK
 JXBHk+VCdhl9H5cy5fcOlsz/5nxD78OEA5HJnFtr72tOKoej1u9pF72o+L5C1Rq7tlpTPwChX57
 YVz9owWxzvXI2HJCOYcPWehzmK49roGF7BwWTuzQbtrMZPYgaGW72JDv8yoioke1x9TOr0oogWR
 RJIgrf1BWFiKMK9rPCiU8QWEBz9X6EK77prVJF0/S/aWz4=
X-Received: by 2002:a17:90b:4b92:b0:3a8:6b84:234d with SMTP id
 98e67ed59e1d1-3ab3a366814mr12040482a91.6.1791960340616; 
 Tue, 13 Oct 2026 23:45:40 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:40 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:35 +0800
Message-ID: <20261014064445.2835813-7-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskE-0004KF-EY
Subject: [f2fs-dev] [PATCH v5 06/16] f2fs: account large folio dirty data at
 block granularity
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

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
 fs/f2fs/data.c       | 44 +++++++++++++++++++++++-------
 fs/f2fs/dir.c        |  2 +-
 fs/f2fs/f2fs.h       | 65 ++++++++++++++++++++++++++++++++++----------
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/inline.c     |  2 +-
 fs/f2fs/node.c       |  2 +-
 8 files changed, 123 insertions(+), 36 deletions(-)

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
index 9701d2d2da89..b5c048134e00 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2921,10 +2921,18 @@ static unsigned int __ffs_mark_subrange_dirty(struct folio *folio,
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
@@ -2935,21 +2943,27 @@ void f2fs_ffs_mark_subrange_dirty(struct folio *folio,
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
@@ -2961,13 +2975,15 @@ static bool __ffs_clear_subrange_dirty(struct folio *folio,
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
@@ -2975,9 +2991,12 @@ bool f2fs_ffs_clear_subrange_dirty_and_test(struct folio *folio, size_t offset,
 
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
 
@@ -3880,7 +3899,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 		goto redirty_out;
 
 out:
-	inode_dec_dirty_pages(inode);
+	inode_dec_dirty_block(inode);
 	if (err) {
 		folio_clear_uptodate(folio);
 		folio_clear_f2fs_gcing(folio);
@@ -4376,11 +4395,16 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 * partially written back), the folio must stay dirty so that
 		 * the remaining subranges are written back later.
 		 */
+		/*
+		 * Redirty the folio if dirty subranges remain in a large
+		 * folio, or if order-0 writeback fails due to an error.
+		 */
 		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-					(err ? pos : end_pos) - folio_pos(folio)))
+					(err ? pos : end_pos) - folio_pos(folio)) ||
+					err)
 			folio_redirty_for_writepage(wbc, folio);
-		else
-			inode_dec_dirty_pages(inode);
+		else if (!f2fs_folio_has_ffs(folio))
+			inode_dec_dirty_block(inode);
 
 		/*
 		 * Release the bias taken above and we end writeback here if
@@ -5219,7 +5243,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
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
index 6db23a3c25a9..9edff1e79f2c 100644
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
index 89e50f871b75..d7fae1890835 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1555,7 +1555,7 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
 
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
index e7522e7eedf8..d96ccf1c90ff 100644
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
