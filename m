Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9BCFD874A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sLYkAhiNE79yFUf6466jqpcTlaMqjbYVGYbKdLn+YN4=; b=dcSJFtHuk1FzCt9A1tS6whlmCJ
	cnnnvnwkyJn5cvQhOhWWywRHK99Z7E4drxa/TOQ0HgN/qrouEr0prx3+JtQVhXYy8/x240B4Rm5Kt
	IwVTox9anYCNMcsfSePlhqxvMz6XmewrQO0uZ6da2DQjHeQAGMerR/49t8Wo5nIZOVOY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2T1B-0006sk-SQ;
	Tue, 17 Mar 2026 11:55:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w2T19-0006sc-RG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=71jWwCyfi65X33rV2znyj4dmBOBLd1i1HjeFrQngO5w=; b=I/r3Dl+/ZTCgq0KSj4zTfViHOe
 9fdYQ7rdzUsw+q8kexgqYmVfxIwuHGVU3TJmLe5/C80ZgAQXkIPcUaOJHAWzPyQi8daObelmBY8tr
 m0AhbJJ7VUpC6YRjBcY3kzXeLmhQp18+1bANL+tJnE2HcxONGmrqx6Ua9Ddhoh+DrRG8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=71jWwCyfi65X33rV2znyj4dmBOBLd1i1HjeFrQngO5w=; b=O
 86FhsjQ+17PrO4+TMbsraKTdMk4c6ZFr2bLwz1WkKRyWFLDSOtHX1lzsItIHD9H1yqJn6L8srzc7j
 RN4SKnSdPJYfwMTQifhJlLQKouU5oz6eHX3ZrqGfB+atYlK0MOpwgDp5Fvkq/Zlr0qzu5x86FyCdA
 n4SOlhcdAFt/K6l8=;
Received: from smtp153-162.sina.com.cn ([61.135.153.162])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w2T18-0004Ua-EM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:55:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773748522; bh=71jWwCyfi65X33rV2znyj4dmBOBLd1i1HjeFrQngO5w=;
 h=From:Subject:Date:Message-ID;
 b=u6UC+N1eL1qaOGgp5ed0MWBUSKC67TwL+En//6k3R2m9Dzw+0GIHzMkxFar0BPFAp
 SEwRrR6A0083hmcMAggqjRTJdaZya5gTdZNCbVb3oR659zv2q4Pq/iUvBOrlQtV57F
 ltRxijFa/OSCLAAI5Rrx5OptGbaBjerPNHz+DR80=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.31) with ESMTP
 id 69B9411A000012B1; Tue, 17 Mar 2026 19:55:08 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 4537956816129
X-SMAIL-UIID: 7628ECA68C834CF385F5CE8AC0672F3A-20260317-195508-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 17 Mar 2026 19:54:57 +0800
Message-ID: <20260317115459.208306-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1w2T18-0004Ua-EM
Subject: [f2fs-dev] [PATCH v4 1/4] f2fs: refactor f2fs_move_node_folio
 function
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

This patch refactor the f2fs_move_node_folio() function. No logical
changes.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/node.c | 54 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 660bf88a376f..afb4d10142dd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3950,6 +3950,8 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 17eab01ae8f9..2e74d2882b6f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1845,41 +1845,51 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 	return false;
 }
 
-int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type)
 {
 	int err = 0;
+	struct writeback_control wbc = {
+		.sync_mode = WB_SYNC_ALL,
+		.nr_to_write = 1,
+	};
 
-	if (gc_type == FG_GC) {
-		struct writeback_control wbc = {
-			.sync_mode = WB_SYNC_ALL,
-			.nr_to_write = 1,
-		};
+	if (!sync_mode) {
+		/* set page dirty and write it */
+		if (mark_dirty && !folio_test_writeback(node_folio))
+			folio_mark_dirty(node_folio);
+		goto out_folio;
+	}
 
-		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
+	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
 
+	if (mark_dirty)
 		folio_mark_dirty(node_folio);
+	else if (!folio_test_dirty(node_folio))
+		goto out_folio;
 
-		if (!folio_clear_dirty_for_io(node_folio)) {
-			err = -EAGAIN;
-			goto out_page;
-		}
-
-		if (!__write_node_folio(node_folio, false, NULL,
-					&wbc, false, FS_GC_NODE_IO, NULL))
-			err = -EAGAIN;
-		goto release_page;
-	} else {
-		/* set page dirty and write it */
-		if (!folio_test_writeback(node_folio))
-			folio_mark_dirty(node_folio);
+	if (!folio_clear_dirty_for_io(node_folio)) {
+		err = -EAGAIN;
+		goto out_folio;
 	}
-out_page:
+
+	if (!__write_node_folio(node_folio, false, NULL,
+				&wbc, false, FS_GC_NODE_IO, NULL))
+		err = -EAGAIN;
+	goto release_folio;
+out_folio:
 	folio_unlock(node_folio);
-release_page:
+release_folio:
 	f2fs_folio_put(node_folio, false);
 	return err;
 }
 
+int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+{
+	return f2fs_write_single_node_folio(node_folio, gc_type == FG_GC,
+			true, FS_GC_NODE_IO);
+}
+
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			struct writeback_control *wbc, bool atomic,
 			unsigned int *seq_id)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
