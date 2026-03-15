Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EC5F30271
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aY5dh+JP7pxB6CcGN3ydeJSHRlfGKzPDxQAcZDSJgUw=; b=Ypd31aId/pO+f9vtCCe7EJcyKZ
	7a3RwAQDey/oeQPQA/FqjKwifOX8SbTQ7xQRUf2HvMU2KyQFOOjr3OZzbfvUYcFgrb2EENtRbJIZt
	bsfF0v9dTeFBfa+S8xEAf/57J9MY3CMs6NMR170ut5jmPl9QRyo1eCKm3nTSnO1mbNdM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w1pJc-0005Kl-Ug;
	Sun, 15 Mar 2026 17:31:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w1pJb-0005KW-DG
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Mar 2026 17:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0XbKiLXf4iagE8tlgTU7W0BRuj8z8cPk97/4PREqx5s=; b=mVb6zV1WIKXkIHdBbpqCdCBYlI
 PE87qdr3fR0lq+x+CpAjCepmVdRVhTn8kYKbHE4w+127I4dWiZdM9oeo+XLNyP4X1gAmxxp9ojjTR
 3YVHGAAW7/3ObyXUZRHQIr7OEu/wGHWG4/WEHg0EuBNRnWCVy6clCXy/94dEch9u+x6Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0XbKiLXf4iagE8tlgTU7W0BRuj8z8cPk97/4PREqx5s=; b=k
 E0tyvSFQ/QUqNDtBw3aXCIkgkqsHQ/IxDwqn7YifYfanFFwEbNk0pAcjNCh5L3Oh7cUK56rUMbdBQ
 AlM2Ok56cyxZhlkHaIfwzbYmlmNNudVn13jFUY8XkoNSq9ZzoGt6VNxuLw40CQ0HQn41aWe7MEPbE
 tCoYMCtu6TP08Py0=;
Received: from mail3-165.sinamail.sina.com.cn ([202.108.3.165])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w1pJb-0005YL-8J for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Mar 2026 17:31:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773595907; bh=0XbKiLXf4iagE8tlgTU7W0BRuj8z8cPk97/4PREqx5s=;
 h=From:Subject:Date:Message-ID;
 b=hXLfqLbPClMqyVK0yOGTB+/qt8iUnxYYFCZWaffZ9D5NK4ZKYdA3CmYXNp2rxTx3O
 KrJiPBuZSmCEYdpCmzomB+9nqSDanGi7YOFOD6PBVs7GHJslPLXdaYYjmv5TW/YO/x
 n2VGdkVEdEyu6qv0cvJp/N/gA8FN/nysTa+1i10c=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 69B6ECF90000240D; Sun, 16 Mar 2026 01:31:39 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 5572696685180
X-SMAIL-UIID: 0B4EDBD79B8A4BAEB950FE16E497B3DD-20260316-013139-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 16 Mar 2026 01:31:17 +0800
Message-ID: <20260315173118.4048271-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1w1pJb-0005YL-8J
Subject: [f2fs-dev] [PATCH 1/3] f2fs: refactor f2fs_move_node_folio function
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

This patch refactor the f2fs_move_node_folio() function. The current
implementation may leave the node folio locked, and gc_node_segment()
does not handle such locked state. This patch guarantees that the node
folio's reference count and lock are properly released before returning
from f2fs_move_node_folio().

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/f2fs.h |  2 ++
 fs/f2fs/node.c | 58 +++++++++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8942b2a63cfd..be5132f992e8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3947,6 +3947,8 @@ int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
+int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
+			bool mark_dirty, enum iostat_type io_type);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
 void f2fs_flush_inline_data(struct f2fs_sb_info *sbi);
 int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bbfa677ef46f..bd0039d16568 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1843,38 +1843,48 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
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
+		goto out;
+	}
 
-		f2fs_folio_wait_writeback(node_folio, NODE, true, true);
+	f2fs_folio_wait_writeback(node_folio, NODE, true, true);
 
+	if (mark_dirty)
 		folio_mark_dirty(node_folio);
+	else if (!folio_test_dirty(node_folio))
+		goto out;
 
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
+		goto out;
 	}
-out_page:
-	folio_unlock(node_folio);
-release_page:
-	f2fs_folio_put(node_folio, false);
+
+	if (!__write_node_folio(node_folio, false, NULL,
+				&wbc, false, FS_GC_NODE_IO, NULL))
+		err = -EAGAIN;
+out:
+	return err;
+}
+
+int f2fs_move_node_folio(struct folio *node_folio, int gc_type)
+{
+	int err = 0;
+
+	err = f2fs_write_single_node_folio(node_folio, gc_type == FG_GC,
+			gc_type == FG_GC, FS_GC_NODE_IO);
+	f2fs_folio_put(node_folio, true);
 	return err;
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
