Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC73C5B56A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5STvemAPx9VbSlHmeDrnikKnXdwD6fRAMHxTgbmWkjM=; b=evRXYXpL+r94xh1ykMkITIrrs0
	3M+pRUE/UiEaW78lWVXF5BU+KC/Tdi7nKLo9D+xuWvTcNg7TnN7Y7FZ6nI7bccUkyBINDzPrT6Pab
	EHJC/bZ+V+bZ/nL5f5bNzouNZrzdmvsm0dgu4gYo2AcXbZbHy5BvBDRDM1EuWtgQclM8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wu7x0-0003wD-CX;
	Wed, 12 Aug 2026 12:20:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wu7wz-0003w7-Co
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kZg03mGGOq81u4B61Lg/APAIsg+87Ay12C/WV1nBv3o=; b=SNU4alMGDwtSBMthefjuCK9z+h
 qBDly90MKghCYKnhrIudVjmFOMlEzAS12nDwUZretLe2LbQB2PqyimNPKHEsNWnCw70cNGpyGzxPv
 G2kASotiNqDKsNuQCwvBJyy4gydRMG6UXe5/rHJwQmXgPkCAisuO/ibqNvwEHZRAO25A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kZg03mGGOq81u4B61Lg/APAIsg+87Ay12C/WV1nBv3o=; b=Z
 JL1wBroHr/OSHR5XEYcLueF4X1keOlKm2JQ+5AhLrdnjqYxMuNx2WUWAl5/WP6IKKTeJ4D9HTgsOg
 D1JKgV/cHnG7ltlnUNq8LO9lRr0o06R4ZDgqcpyQrOwbyWHTMfn/vgmCzQZg1OXyOVZFtOiMbu5pt
 p2ZbzQPjFaKb+Cyw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu7wy-0004gu-NW for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 12:20:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 711B943865
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 12:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799EE1F000E9;
 Wed, 12 Aug 2026 12:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786537247;
 bh=kZg03mGGOq81u4B61Lg/APAIsg+87Ay12C/WV1nBv3o=;
 h=From:To:Cc:Subject:Date;
 b=nq70MJ2QRHC6tQhybaj0SVjKCObIv6jr0Iydr3bCWznrFVark8dUMKpN/2J2LkOhY
 70u/uDh3/IqzdOao0eeJgHKZNa6+IaORH9CkC22StBVSqsmCm8iK1a83pLKHyMbzB3
 v27VWU6HG/LE3hEjwzrn55rkPx8JmS4kX75yT8C3zchnsuHG4GRiEG3fTmtA9Kx7DU
 alE7DuUfDkc379IkGrtzJ9reBBIgJv2CFkkgTsu94F8V15zu9mATWZMg2Ycyy3KeuY
 Af60ZhqAFxWFU/80obAsMkAGXqNTdYOeTGh0Ws5R8ZeWzv9l1nYj5/0We3u8m8YANf
 CWWpgmkkTYClA==
To: jaegeuk@kernel.org
Date: Wed, 12 Aug 2026 12:20:43 +0000
Message-ID: <20260812122043.282195-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
MIME-Version: 1.0
X-Headers-End: 1wu7wy-0004gu-NW
Subject: [f2fs-dev] [PATCH] f2fs: fix to propagate error from f2fs_sync_fs()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

So that caller can detect any failure from f2fs_sync_fs().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 51 ++++++++++++++++++++++++++++++++++---------------
 fs/f2fs/super.c |  4 +++-
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index f67864417455..37897f4321c0 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -402,8 +402,11 @@ static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			return err;
+	}
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -455,8 +458,11 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 	d_instantiate(dentry, inode);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			return err;
+	}
 	return 0;
 out:
 	clear_inode_flag(inode, FI_INC_LINK);
@@ -624,8 +630,11 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			goto out;
+	}
 
 	goto out;
 corrupted:
@@ -717,7 +726,7 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 						   disk_link.len - 1);
 
 		if (!err && IS_DIRSYNC(dir))
-			f2fs_sync_fs(sbi->sb, 1);
+			err = f2fs_sync_fs(sbi->sb, 1);
 	}
 
 	if (err)
@@ -769,8 +778,11 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	f2fs_balance_fs(sbi, true);
 	return NULL;
@@ -824,8 +836,11 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			return err;
+	}
 
 	f2fs_balance_fs(sbi, true);
 	return 0;
@@ -1122,8 +1137,11 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 
 	f2fs_unlock_op(sbi, &lc);
 
-	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			return err;
+	}
 
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
@@ -1289,8 +1307,11 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	f2fs_unlock_op(sbi, &lc);
 
-	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
+		err = f2fs_sync_fs(sbi->sb, 1);
+		if (err)
+			return err;
+	}
 
 	f2fs_update_time(sbi, REQ_TIME);
 	return 0;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 0c8f60b7242f..3bdb0f891c35 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2960,7 +2960,9 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		set_sbi_flag(sbi, SBI_IS_CLOSE);
-		f2fs_sync_fs(sb, 1);
+		err = f2fs_sync_fs(sb, 1);
+		if (err)
+			goto restore_gc;
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
 	}
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
