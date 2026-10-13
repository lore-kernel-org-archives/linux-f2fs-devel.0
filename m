Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FAFCA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkUNc/bGES6/jSFjXGh0YfHOp1dv7p6faT8L3tGO5A8=; b=F//sfabsir7xunVtmtwIJKaR1m
	nXOgzpl0pYxyTS0wJlIfdcGRgKFJyCQNwqOTKKyOUUDL0nWgXsXlVHNoEmM6fpuVkzDUodeveS0Aj
	aomlqvV5ISVzwWqyHV7vB6wRmpPtn0E7YSExdnmritloOFOWpf9ZxA2NspFhXmGEkZe4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8j-00040U-14;
	Tue, 13 Oct 2026 11:57:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8h-00040K-Tp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WBaTPspCN3/uMYPsCb7NttxnkmVn8zwdNqmUI3MSBIM=; b=EalkbMFCjnhTqoXM3Iqxl06vXw
 mas0JRhfGyQv3HZN3/mF5FUz0sc9ddskjuy8oZ40Apeq2shwwR7ck8E6CD7SSHcXUZ0SOJpOvkCaE
 12qSuCgIN88GGl+z1XXJmLnd3XoNcwfIBtTUCN+zVD20uBrpx2mSbxbbWPTk1uWqXJPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WBaTPspCN3/uMYPsCb7NttxnkmVn8zwdNqmUI3MSBIM=; b=hXPHQZ/1bZobq1IqidslZmT8gn
 YMdWBflLL8eKfc2ub7PWcY5mnCMawyVco021WrfvmYI7XITXr461dH+VmErdPE7kOn8M0B8vZl5ya
 uL/cz0I/kA9ijD1XW4hx/TTnSq+XWf8gVtjDQlTpLz0bLJMmH0pq5jNRfAjDAz2k4O1k=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8e-0005Sf-CG for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:52 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-3a0aa5e2b20so802830a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892663; x=1792497463; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WBaTPspCN3/uMYPsCb7NttxnkmVn8zwdNqmUI3MSBIM=;
 b=iAA7pgSxl9IoXgtxcTKu7YmAX8OtPk6EwRUzBuUovEOEzH9BAymDl7E+kKm2JCtzlP
 S8vmteJkwJKm6rGHmtFXVA5F68DRDMahodTqOTmO/pO2zaKnh1v7qnswFcduJ/SkAZh9
 UpTmz7XuMENiX5l4ad0DjQrlEe2SyUWVkyaSI9CH6xrJCaH1IqK5aBipHQ1vAU5YnI8T
 QOobenxwUcWe2P9yribpLa3bS+QJcP98qV/DV+/soAdXAjjlESia/a21iY49ack5E+Jj
 YYcYixaaaLNokaf2VK7wWhpZra/E7r7AnpFgncwP3yANyHMLQMr09ShW/K/IfZnjDI4K
 HV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892663; x=1792497463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WBaTPspCN3/uMYPsCb7NttxnkmVn8zwdNqmUI3MSBIM=;
 b=De+Pr/+bpXvOCVn3s4Q5/HCb2xF+DO65aG9TfX1o1lCfrt4YdWuxmc+ZgrqfHZMzr9
 BqyH6ZXqr0ELLRJMq2CNpb2kBMcmUmBq+Vrh7wVS3OC/pdYwyWgfW+teAOxbVJE3mmpN
 PajmHrcC07kWNg+FueEIX8mL9WiZO4QMyVgB/vknzeskElxfUz+XMnd5H1AM6ZCEvSW5
 j5shPfm8JNE8lrAIi1Q0pVzJrrWZYf9124Etl4uFuvGj3A0NRIpLghvTmyAcv8wS9bcl
 hvAP4bMxbVeGmf2lZgqF2lgYa0zI6XBug5YcIqGMp4ujhdqtn7qXFVWx372iB1bHYCTf
 zcRg==
X-Gm-Message-State: AFq9FYJr0o697/Y6kO+2D2uR76Cqw+NIy2uSjew/+x8xMH/yisuytDJw
 veaQBFYCh3Q6p8dOWS2KZTRr/dCC5vio0QqThfh2BHB/9GUiBVAb7bbXhfhEzCRV
X-Gm-Gg: AYBFou0XV48ZnGGklAYVlj/2wynorGEOW0QSAgtG1UeqzM9ID1H5csnyMYqfJepmVzL
 ZkZsyCe2kUgTSyh3+6KeoOnryTslB4xdnu1pCtho47LuxwIVdutYLCuwZ6lL12oPf2UrQaHFmMP
 kak9vTQUvAXrF8ZIAf5AKEqTzc+m0ReCbEon5jcWdbo7Q6hRixNNc94y1lW3UaEsgIqM1coIVcs
 igPi2G+XQrYhAT4gmBhBWKGfTsgSI7zknU+wralYs4NbV7nviVuQyL5NsASSssuBkW6PPb3pyvU
 jWpJa5eT6ill8zxW6BvFR8rpzpcPZHk+eLp10iiCYjtVQEzOxtgYmJfa9An79w0T8Uo70rYMcIJ
 3TtQom1XDtQigLDjLJ253EvybqY48GeX0QSR4uKmswQZiS+6e/o1llPNy9PbLDdxLyibdY4k0kq
 nn/FigdxhGYHmNPGNdyDJHluJwUVrM+s4Dh3XzDU52+9p+UMnrXu9yB9aZGDSr+KczBG8ZrKtlS
 Ny8OPxS3waygNP6Sj99jk7sh+hAao4Grcwf
X-Received: by 2002:a17:90a:e7cb:b0:3aa:ee81:a62d with SMTP id
 98e67ed59e1d1-3ab3a7480f9mr11231808a91.35.1791892662564; 
 Tue, 13 Oct 2026 04:57:42 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:41 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:18 +0800
Message-ID: <20261013115621.968742-16-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8e-0005Sf-CG
Subject: [f2fs-dev] [PATCH v4 15/18] f2fs: fix zeroing paths for large folios
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Several f2fs zeroing paths still use PAGE_SIZE based offsets after
a file mapping can contain large folios.  This is fine for order-0
folios, but it zeros the wrong range once the target block is not at
offset 0 in a large folio.

Use offset_in_folio() to translate the file block index to the folio
offset before zeroing data in truncate_partial_data_page(), fill_zero(),
and f2fs_get_new_data_folio().

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 18 +++++++++++++-----
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 29 ++++++++++++++++++++++++-----
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 433d8f2b0..48376cbcc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1799,6 +1799,12 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	if (folio_test_large(folio) && !f2fs_ffs_find_or_alloc(folio)) {
+		f2fs_folio_put(folio, true);
+		f2fs_put_cache(ientry, true);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	set_new_dnode(&dn, inode, ientry, NULL, 0);
 	err = f2fs_reserve_block(&dn, index);
 	if (err) {
@@ -1808,13 +1814,15 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 	if (!ientry)
 		f2fs_put_dnode(&dn);
 
-	if (folio_test_uptodate(folio))
+	if (f2fs_ffs_test_blk_uptodate(folio, index))
 		goto got_it;
 
 	if (dn.data_blkaddr == NEW_ADDR) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		if (!folio_test_uptodate(folio))
-			folio_mark_uptodate(folio);
+		size_t off = offset_in_folio(folio,
+					(loff_t)index << PAGE_SHIFT);
+
+		folio_zero_segment(folio, off, off + PAGE_SIZE);
+		f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
 	} else {
 		f2fs_folio_put(folio, true);
 
@@ -2922,7 +2930,7 @@ bool f2fs_ffs_test_blk_uptodate(const struct folio *folio, pgoff_t index)
 	return test_bit(idx, ffs->state);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c98607017..a925d1a59 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4455,6 +4455,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 37d41f593..69d1344a5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -842,12 +842,13 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
-	loff_t offset = from & (PAGE_SIZE - 1);
 	pgoff_t index = from >> PAGE_SHIFT;
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
+	size_t folio_off;
+	size_t blk_end;
 
-	if (!offset && !cache_only)
+	if (!(from & (PAGE_SIZE - 1)) && !cache_only)
 		return 0;
 
 	if (cache_only) {
@@ -865,12 +866,22 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
 truncate_out:
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_zero_segment(folio, offset, folio_size(folio));
+	folio_off = offset_in_folio(folio, from);
+	blk_end = min_t(size_t, round_up(folio_off, PAGE_SIZE),
+					folio_size(folio));
+	folio_zero_segment(folio, folio_off, blk_end);
 
 	/* An encrypted inode should have a key and truncate the last page. */
 	f2fs_bug_on(F2FS_I_SB(inode), cache_only && IS_ENCRYPTED(inode));
-	if (!cache_only)
+	if (!cache_only) {
+		/*
+		 * The folio was read back above, so the subpage is
+		 * already uptodate and dirty data stays valid.
+		 */
+		f2fs_ffs_mark_subrange_dirty(folio, folio_off,
+				blk_end - folio_off);
 		folio_mark_dirty(folio);
+	}
 	f2fs_folio_put(folio, true);
 	return 0;
 }
@@ -1335,6 +1346,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1349,7 +1361,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 		return PTR_ERR(folio);
 
 	f2fs_folio_wait_writeback(folio, true, true);
-	folio_zero_range(folio, start, len);
+	folio_off = offset_in_folio(folio,
+				   (loff_t)index << PAGE_SHIFT) + start;
+	folio_zero_range(folio, folio_off, len);
+	/*
+	 * This subpage must be uptodate here, which is guaranteed by
+	 * f2fs_get_new_data_folio() above.
+	 */
+	f2fs_ffs_mark_subrange_dirty(folio, folio_off, len);
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 	return 0;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
