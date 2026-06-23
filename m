Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DDDCDB47A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 05:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=55xBvIr5KGp0SRqFlZAEb0b14hbdP7XzvS2EAu05/yY=; b=dYZaWQRFFSB2lNCpGG6QsbFuum
	7v7OQp7ucMnnQ1QCYRremwY3hA5BTYh39S4oPOggj2hNw1hH36uJDSr9CisqzNX41eL8h/9lmH6hA
	V2hH+UQap3KQM9KG+fLGb+HnabZ0MXTRnLwrEaUJB+N/bvtN5WQKeQC/dWP7DrYuUmPw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbtQS-0007ok-I3;
	Tue, 23 Jun 2026 05:11:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3D_05agsKAEov0mzzqotuqzs00sxq.o0y@flex--joannechien.bounces.google.com>)
 id 1wbtQR-0007oV-HR for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 05:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IVbGMEHq6fOsFJEOohLfitPVsUIbpddyCfsWs6SQcgs=; b=JNw77KvShu2RUiwxnPpw0eYDkb
 A/3TSDtiDlevdvOd7ZoJcPWfZJ4loeXyb5Owu6kph+0+eoIzW19YCgQ15ieWY1e8IjW+GkQy9nEkC
 lp2vxL0WmI0jEhZadvxP+gtq0ERrknrJ+YHmfF9Ih5NwADbuKKguQ4BKE0ckEHaKMyQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IVbGMEHq6fOsFJEOohLfitPVsUIbpddyCfsWs6SQcgs=; b=V
 NEUPWFMQb3FyCgDEICzJtzkY3fYGvs4NpknqkNIucLqomuF45NiRG7Sx869qHlllNVF08Bg719bji
 IyzOxhofxn0DTs5tspoi6juBPisRaBEp2Nixlj5rapTaSb9OU0on3dXQy44MhyAbqps7Jvw/jHhFs
 n2teK/bcWn1wxJr0=;
Received: from mail-oa1-f73.google.com ([209.85.160.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbtQR-0001dF-9g for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 05:11:56 +0000
Received: by mail-oa1-f73.google.com with SMTP id
 586e51a60fabf-43d052ba649so6822149fac.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 22:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782191505; x=1782796305;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IVbGMEHq6fOsFJEOohLfitPVsUIbpddyCfsWs6SQcgs=;
 b=tLct3a5hVXcv3/4XuMsmK8pONMKQ+b+PJ9MrKv+50XA5SWa3r7n/1JIMp4WpblCFcH
 Yu+8rXTEtL3aRqey/Dpq2oj6QofkxPgbJHa6TX2BjTLt3tTt4PCXRRhAInwEQ6eW8/51
 wXZbSIxf2f4BtRNHHi+G1egFBbewYmAvv9H04ob++IxB07B3xnQj2aD6Qsz8z/qf2sTW
 GZbvUA6Fu0xoKTLHzHVj/a4oajDFavLA5yPi0ALgZY9oA227fZZNip8S8ClbYon0xRJ5
 4RpTTU4qpg9KVnTWlO3amM+Bh4GHc8sFuwHaEP1/3vUSTRrKjasDNhvSCQpSgQHrVLDs
 47hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782191505; x=1782796305;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IVbGMEHq6fOsFJEOohLfitPVsUIbpddyCfsWs6SQcgs=;
 b=l2Sm9AWSix9hfskiv6wEadp5JdZkKbT/No6AYrhdIsydhecUnzfd59KARQIl4WURXa
 iEGWabKxN9cZBolL3Ao6mB/OS7JrCLwPPf3JNT6NSSPYPWy0K/ZJGPw4xy6qhjjFt87r
 snsbixL4xhDWbLLflHXK7Ym/6y8AM+ilZe35mMynJ/fkqhIu+XPGFHAxn/ksl3gXl5ZE
 atD37lfZa/wNcJLVxLKdE0N2T4nP7MwtAImlUNAKTvjuGhc9mvRNi+lnhxary8VW3d2E
 vp2lPj/YuMKHknHnH1NCpuWvocuZBlc3VQPbb/9eZpuHrC+HFEyJSVz3LLmOJ4cq/kxL
 YPKA==
X-Gm-Message-State: AOJu0Yw2UnE1M+x9xj/jNMSkpEZOEJwDXQWWXJC9SVj7fu+oeEMEnOMG
 nf+uw0iuclcSXqoqD0u/rS1yqqrUb+KfH/PKZMYsx5gK8XMB1uiAUMnSSE4k02CzrzALNHbLhKJ
 d2QU747Zg31nwuuJV3BV/FTnqDw==
X-Received: from pgo1.prod.google.com ([2002:a63:e41:0:b0:c85:9c9a:ab4a])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:438d:b0:3b7:d8d5:2340 with SMTP id
 adf61e73a8af0-3bb31dfaaeemr19667668637.11.1782185231754; 
 Mon, 22 Jun 2026 20:27:11 -0700 (PDT)
Date: Tue, 23 Jun 2026 03:27:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623032701.173516-1-joannechien@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1wbtQR-0001dF-9g
Subject: [f2fs-dev] [PATCH v1] f2fs: dirty directory inodes on mtime/ctime
 update
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
From: Joanne Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Joanne Chang <joannechien@google.com>
Cc: Joanne Chang <joannechien@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Xfstests generic/547 sometimes fail with mismatched directory metadata
before and after a power failure. This happens because when a directory
entry is added, renamed, or deleted, its mtime and ctime are updated and
the inode is marked dirty via
f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
the dirty inode is not added to the global DIRTY_META list. Therefore,
subsequent checkpoints skip flushing these updated directory blocks,
causing directory timestamps to revert to stale values after a sudden
power failure.

Address this by changing the dirtying parameter to sync=true during
directory entry mutations and renames. This forces F2FS to immediately
queue the updated directory blocks on the global DIRTY_META list,
ensuring timestamps are committed to checkpoints.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 fs/f2fs/dir.c    | 6 +++---
 fs/f2fs/inline.c | 2 +-
 fs/f2fs/namei.c  | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index a9563f7fcd88..e1c42d2b5c15 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -460,7 +460,7 @@ void f2fs_set_link(struct inode *dir, struct f2fs_dir_entry *de,
 	folio_mark_dirty(folio);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 	f2fs_folio_put(folio, true);
 }
 
@@ -615,7 +615,7 @@ void f2fs_update_parent_metadata(struct inode *dir, struct inode *inode,
 		clear_inode_flag(inode, FI_NEW_INODE);
 	}
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (F2FS_I(dir)->i_current_depth != current_depth)
 		f2fs_i_depth_write(dir, current_depth);
@@ -927,7 +927,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct folio *folio,
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e2f7bedf1552..aec06fb4fd76 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -732,7 +732,7 @@ void f2fs_delete_inline_entry(struct f2fs_dir_entry *dentry,
 	f2fs_folio_put(folio, true);
 
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
-	f2fs_mark_inode_dirty_sync(dir, false);
+	f2fs_mark_inode_dirty_sync(dir, true);
 
 	if (inode)
 		f2fs_drop_nlink(dir, inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index cac03b8e91a1..7ffdf23cea5e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1076,7 +1076,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	f2fs_up_write(&F2FS_I(old_inode)->i_sem);
 
 	inode_set_ctime_current(old_inode);
-	f2fs_mark_inode_dirty_sync(old_inode, false);
+	f2fs_mark_inode_dirty_sync(old_inode, true);
 
 	f2fs_delete_entry(old_entry, old_folio, old_dir, NULL);
 	old_folio = NULL;
@@ -1246,7 +1246,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(old_dir, old_nlink > 0);
 		f2fs_up_write(&F2FS_I(old_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(old_dir, false);
+	f2fs_mark_inode_dirty_sync(old_dir, true);
 
 	/* update directory entry info of new dir inode */
 	f2fs_set_link(new_dir, new_entry, new_folio, old_inode);
@@ -1265,7 +1265,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 		f2fs_i_links_write(new_dir, new_nlink > 0);
 		f2fs_up_write(&F2FS_I(new_dir)->i_sem);
 	}
-	f2fs_mark_inode_dirty_sync(new_dir, false);
+	f2fs_mark_inode_dirty_sync(new_dir, true);
 
 	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
 		f2fs_add_ino_entry(sbi, old_dir->i_ino, TRANS_DIR_INO);
-- 
2.54.0.1189.g8c84645362-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
