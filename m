Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767DBC369B0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 20:13:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzLWB-00062U-Ke;
	Mon, 31 Mar 2025 20:13:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1tzLVo-0005jN-RX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYwYgJq2Ldd/K4BwCxlUMr4oZflmWP+sKMyT6nmCAjY=; b=i6P/gOSZ3d+N8sVPvJmbgmUkoj
 53YJhQw12vUbTUjOqh/6gKV2svjeHcj4qTG8VhoU9PPVjN0iqvlG5QoZxoDxu91yfEJvEuPrxmlDN
 QO5UvZhPuf8YSAbxWdYHFjT6lLcJGfSelfmi18YjH5xAJgJLitM3n9CluLcvxk1VP81U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rYwYgJq2Ldd/K4BwCxlUMr4oZflmWP+sKMyT6nmCAjY=; b=TO+bXhkWI6ShlEqpRLfKtYO6qC
 gsfXNtLHzmbqSSmpYT7l7c0BeiY5I7mAkHP3TyRdBJE4GFiwxRND00XcOiSk32J1cV7Sn6SMab/b8
 rLtNSV20ON12dWiiVZt9t0eBlK2msNh5uQHz9w0xjsKRhTxuLA0ROtXg7p+qJM0gqcXA=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzLVn-0003hb-HE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 20:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=rYwYgJq2Ldd/K4BwCxlUMr4oZflmWP+sKMyT6nmCAjY=; b=QeOfIP3wuCtXT44qASqLmpmcil
 TPCY6We1zDadVhWfYUyGVPWX+5ljWiCQ6gGEzoAudfsbtv9KpqYubYAvR5ZOlCYiqyDYDx0gyEtcC
 K6903XHfKztOWWvfU3YUpte3+p371Jv3971MIGlR3YpcmQAp8BQwQIJX1i/id5G98CEVgQKgKecxo
 WnIQXEXVmOwbS814MFGTOTYXF7xqhIfUbULpnAXu5CvLcoVj+ZSU/xR1VMEBQI0rHKCefnWukvCVw
 jTW3SkWY5hAmE6mwqkEoGoUfUuft5Mxfsd43qSI5/KehT7B1ns+N+eIC08kGaihjfznCk6pJIaSLT
 gajmZPAg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red
 Hat Linux)) id 1tzLVc-00000004SZe-0RZz;
 Mon, 31 Mar 2025 20:13:24 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 31 Mar 2025 21:12:35 +0100
Message-ID: <20250331201256.1057782-136-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331201256.1057782-1-willy@infradead.org>
References: <20250331201256.1057782-1-willy@infradead.org>
MIME-Version: 1.0
X-Headers-End: 1tzLVn-0003hb-HE
Subject: [f2fs-dev] [PATCH 135/153] f2fs: Pass a folio to f2fs_set_link()
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
Cc: "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

All callers now have a folio, pass it in.  Removes four calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/dir.c   | 10 +++++-----
 fs/f2fs/f2fs.h  |  2 +-
 fs/f2fs/namei.c | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c52609b6ba3a..4eafdb1d1bc0 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -426,19 +426,19 @@ ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
 }
 
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
-		struct page *page, struct inode *inode)
+		struct folio *folio, struct inode *inode)
 {
 	enum page_type type = f2fs_has_inline_dentry(dir) ? NODE : DATA;
 
-	lock_page(page);
-	f2fs_wait_on_page_writeback(page, type, true, true);
+	folio_lock(folio);
+	f2fs_folio_wait_writeback(folio, type, true, true);
 	de->ino = cpu_to_le32(inode->i_ino);
 	de->file_type = fs_umode_to_ftype(inode->i_mode);
-	set_page_dirty(page);
+	folio_mark_dirty(folio);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	f2fs_mark_inode_dirty_sync(dir, false);
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 }
 
 static void init_dent_inode(struct inode *dir, struct inode *inode,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b8ddc2df0571..014ef580c0e4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3652,7 +3652,7 @@ struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct folio **f);
 ino_t f2fs_inode_by_name(struct inode *dir, const struct qstr *qstr,
 			struct folio **folio);
 void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
-			struct page *page, struct inode *inode);
+			struct folio *folio, struct inode *inode);
 bool f2fs_has_enough_room(struct inode *dir, struct folio *ifolio,
 			  const struct f2fs_filename *fname);
 void f2fs_update_dentry(nid_t ino, umode_t mode, struct f2fs_dentry_ptr *d,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d8175140e626..c2da97da6b36 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -998,7 +998,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		if (err)
 			goto put_out_dir;
 
-		f2fs_set_link(new_dir, new_entry, &new_folio->page, old_inode);
+		f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
 		new_folio = NULL;
 
 		inode_set_ctime_current(new_inode);
@@ -1055,7 +1055,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	}
 
 	if (old_dir_entry)
-		f2fs_set_link(old_inode, old_dir_entry, &old_dir_folio->page, new_dir);
+		f2fs_set_link(old_inode, old_dir_entry, old_dir_folio, new_dir);
 	if (old_is_dir)
 		f2fs_i_links_write(old_dir, false);
 
@@ -1180,14 +1180,14 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	/* update ".." directory entry info of old dentry */
 	if (old_dir_entry)
-		f2fs_set_link(old_inode, old_dir_entry, &old_dir_folio->page, new_dir);
+		f2fs_set_link(old_inode, old_dir_entry, old_dir_folio, new_dir);
 
 	/* update ".." directory entry info of new dentry */
 	if (new_dir_entry)
-		f2fs_set_link(new_inode, new_dir_entry, &new_dir_folio->page, old_dir);
+		f2fs_set_link(new_inode, new_dir_entry, new_dir_folio, old_dir);
 
 	/* update directory entry info of old dir inode */
-	f2fs_set_link(old_dir, old_entry, &old_folio->page, new_inode);
+	f2fs_set_link(old_dir, old_entry, old_folio, new_inode);
 
 	f2fs_down_write(&F2FS_I(old_inode)->i_sem);
 	if (!old_dir_entry)
@@ -1206,7 +1206,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_mark_inode_dirty_sync(old_dir, false);
 
 	/* update directory entry info of new dir inode */
-	f2fs_set_link(new_dir, new_entry, &new_folio->page, old_inode);
+	f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
 
 	f2fs_down_write(&F2FS_I(new_inode)->i_sem);
 	if (!new_dir_entry)
-- 
2.47.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
