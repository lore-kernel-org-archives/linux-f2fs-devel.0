Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44036C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 20:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQM6pkz+xuHqgafe463oBVrPrjReUz7kD1xVIl6TlTE=; b=WtB3p9CJfU2/5NqyToBGuhoBrr
	WoOwgobKxGtIQVTM7igRmRatQqMeVgP8/HqUJndpuKzGtO+FVMfEerSw2gbO83psA1+CfGCYRZoJs
	ofq1tAr561sSX2BRSWJ0ASFgnFY1KOqOmM6CVlZaQtMsT/wvs41CEe62pHGJWSxhUXV4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyb24-0004nz-7q;
	Mon, 24 Aug 2026 20:12:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wyb22-0004ns-QW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 20:12:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ky29sd1tU4Mo8f3IGiS1LJyTCNhCh8FTNFqRlfXhQjA=; b=Q4fo9pgDQDL8r1EBZc9zcHviA4
 YRTAcAQPgcqGQoU0mjFzA0g04TV9Hrf+0kYGGSbBIGI15P+zud4uV04zDtONvnXUQN/Jwm6C9yjC/
 Wb8qQg6lbprYnBUNffW7B+sGT3Zi+CcitUBMgCI0bg/F5N/hR+zzAZN+A7rAdtyl1Uu8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ky29sd1tU4Mo8f3IGiS1LJyTCNhCh8FTNFqRlfXhQjA=; b=VgOszrOsPay0Or1XiP4x8rhhou
 cdfXWXh1wvOI7i0sYqbYcosuNt0t/gHelv07whgYcukfP5WM+K3I6sJkcXVrnZrNTtlCSJ3p5te7J
 j07S8VaidbPE8E/MD++SpQbHX/XqWaytuc7GDB5kuMqsUk65/CvtUsvelRptKEJ0fwWI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyb1z-0002ny-I4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 20:12:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4E046011F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 20:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8599C1F000E9;
 Mon, 24 Aug 2026 20:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787602345;
 bh=ky29sd1tU4Mo8f3IGiS1LJyTCNhCh8FTNFqRlfXhQjA=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=YQi6huas4tPrAl6xuVJEAb5hxcTNdQxX0SeoizeFulgjp4v0QMmX/lU65xerDmLWk
 nl6ErWWJ6YFNN0iXTi4W1dDrVExSHE1T9/n4BwRSoJwhnhnMV+9l30onhvFqB9VdU4
 ZmsvKbspjX0zXR0dZPk7A8DLvvW+fub6h/4TDpYRlLQoWnNGz3HAOnmY5N6Xv3lllL
 JCsdquVanBpzj8/bjqpTP1zC8TZTGbPJC6JpNf8IpPB/IVQplapNmzEqQS4Cw3i1Dg
 GsmdlLtpPhdwfZ3p3I0y4G9vYF750WHKDNVoBrrInwg5Ew+Jb7Wgvq1fGNt+0M2oJX
 naBmc8Ss7bAcA==
Date: Mon, 24 Aug 2026 20:12:23 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <aoylp9llX9zlKm-g@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aohtWfHNbUwxoQg2@google.com>
X-Headers-End: 1wyb1z-0002ny-I4
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_symlink()
1. f2fs_new_inode
2. f2fs_add_link
3. write_being|end to fill the symlink path
4. flush dirty pages and or checkpoint

Step 4 is nice to succeed, which doesn't become a reason to roll back
the created symlink. OTOH, if we get an error till step 3, don't leave
its dentry and its inode.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
  - Change log from v2:
    : handle the returning errors
  - Change log from v1:
    : fix bugs

 fs/f2fs/f2fs.h  |   3 +-
 fs/f2fs/inode.c |   6 ++-
 fs/f2fs/namei.c | 118 +++++++++++++++++++++++++-----------------------
 3 files changed, 69 insertions(+), 58 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a1f5f375045a..b0a9c14de595 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3878,7 +3878,8 @@ void f2fs_update_inode_page(struct inode *inode);
 int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc);
 void f2fs_remove_donate_inode(struct inode *inode);
 void f2fs_evict_inode(struct inode *inode);
-void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc);
+void f2fs_handle_failed_inode(struct inode *inode,
+		struct f2fs_lock_context *lc, bool add_orphan);
 int f2fs_init_evict_inode_work(void);
 void f2fs_destroy_evict_inode_work(void);
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index bac1e360d966..96cc0e777567 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1107,7 +1107,8 @@ void f2fs_evict_inode(struct inode *inode)
 }
 
 /* caller should call f2fs_lock_op() */
-void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc)
+void f2fs_handle_failed_inode(struct inode *inode,
+		struct f2fs_lock_context *lc, bool orphan_free)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct node_info ni;
@@ -1129,6 +1130,9 @@ void f2fs_handle_failed_inode(struct inode *inode, struct f2fs_lock_context *lc)
 	/* don't make bad inode, since it becomes a regular file. */
 	unlock_new_inode(inode);
 
+	if (!orphan_free)
+		goto out;
+
 	/*
 	 * Note: we should add inode to orphan list before f2fs_unlock_op()
 	 * so we can prevent losing this orphan when encoutering checkpoint
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 7d9f8e92de06..afaab7739283 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -411,7 +411,7 @@ static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
 	f2fs_balance_fs(sbi, true);
 	return 0;
 out:
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return err;
 }
 
@@ -566,40 +566,31 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(err);
 }
 
-static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
+static int __do_unlink(struct inode *dir, struct inode *inode,
+			const struct qstr *name)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
-	struct inode *inode = d_inode(dentry);
 	struct f2fs_dir_entry *de;
 	struct f2fs_lock_context lc;
 	struct folio *folio;
 	int err;
 
-	trace_f2fs_unlink_enter(dir, dentry);
-
-	if (IS_DEVICE_ALIASING(inode)) {
-		err = -EPERM;
-		goto out;
-	}
+	if (IS_DEVICE_ALIASING(inode))
+		return -EPERM;
 
-	if (unlikely(f2fs_cp_error(sbi))) {
-		err = -EIO;
-		goto out;
-	}
+	if (unlikely(f2fs_cp_error(sbi)))
+		return -EIO;
 
 	err = f2fs_dquot_initialize(dir);
 	if (err)
-		goto out;
+		return err;
 	err = f2fs_dquot_initialize(inode);
 	if (err)
-		goto out;
+		return err;
 
-	de = f2fs_find_entry(dir, &dentry->d_name, &folio);
-	if (!de) {
-		if (IS_ERR(folio))
-			err = PTR_ERR(folio);
-		goto out;
-	}
+	de = f2fs_find_entry(dir, name, &folio);
+	if (!de)
+		return IS_ERR(folio) ? PTR_ERR(folio) : 0;
 
 	if (unlikely(inode->i_nlink == 0)) {
 		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
@@ -617,11 +608,28 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	err = f2fs_acquire_orphan_inode(sbi);
 	if (err) {
 		f2fs_unlock_op(sbi, &lc);
-		f2fs_folio_put(folio, false);
-		goto out;
+		goto err_out;
 	}
 	f2fs_delete_entry(de, folio, dir, inode);
 	f2fs_unlock_op(sbi, &lc);
+	return 0;
+
+corrupted:
+	err = -EFSCORRUPTED;
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+err_out:
+	f2fs_folio_put(folio, false);
+	return err;
+}
+
+static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	int err;
+
+	trace_f2fs_unlink_enter(dir, dentry);
+	err = __do_unlink(dir, d_inode(dentry), &dentry->d_name);
+	if (err)
+		goto out;
 
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -632,19 +640,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 
-	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
-		if (err)
-			goto out;
-	}
-
-	goto out;
-corrupted:
-	err = -EFSCORRUPTED;
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
-	f2fs_folio_put(folio, false);
+	if (IS_DIRSYNC(dir))
+		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
 out:
-	trace_f2fs_unlink_exit(inode, err);
+	trace_f2fs_unlink_exit(d_inode(dentry), err);
 	return err;
 }
 
@@ -671,6 +670,8 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	size_t len = strlen(symname);
 	struct fscrypt_str disk_link;
+	bool orphan_free = true;
+	int ret = -EAGAIN;
 	int err;
 
 	if (unlikely(f2fs_cp_error(sbi)))
@@ -701,17 +702,19 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	f2fs_lock_op(sbi, &lc);
 	err = f2fs_add_link(dentry, inode);
 	if (err)
-		goto out_f2fs_handle_failed_inode;
+		goto free_inode;
 	f2fs_unlock_op(sbi, &lc);
 	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
+	/* Write the symlink path to the new inode. */
 	err = fscrypt_encrypt_symlink(inode, symname, len, &disk_link);
 	if (err)
-		goto err_out;
+		goto unlink_free_inode;
 
 	err = page_symlink(inode, disk_link.name, disk_link.len);
+	if (err)
+		goto unlink_free_inode;
 
-err_out:
 	d_instantiate_new(dentry, inode);
 
 	/*
@@ -723,26 +726,29 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 * If the symlink path is stored into inline_data, there is no
 	 * performance regression.
 	 */
-	if (!err) {
-		err = filemap_write_and_wait_range(inode->i_mapping, 0,
-						   disk_link.len - 1);
-
-		if (!err && IS_DIRSYNC(dir))
-			err = f2fs_sync_fs(sbi->sb, 1);
-	}
-
-	if (err)
-		f2fs_unlink(dir, dentry);
+	ret = filemap_write_and_wait_range(inode->i_mapping, 0,
+					   disk_link.len - 1);
+	if (!ret && IS_DIRSYNC(dir))
+		err = f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
-	goto out_free_encrypted_link;
-
-out_f2fs_handle_failed_inode:
-	f2fs_handle_failed_inode(inode, &lc);
-out_free_encrypted_link:
+out:
 	if (disk_link.name != (unsigned char *)symname)
 		kfree(disk_link.name);
 	return err;
+
+unlink_free_inode:
+	ret = __do_unlink(dir, inode, &dentry->d_name);
+	if (ret) {
+		/* Give up and leave a broken symlink. */
+		d_instantiate_new(dentry, inode);
+		goto out;
+	}
+	orphan_free = false;
+	f2fs_lock_op(sbi, &lc);
+free_inode:
+	f2fs_handle_failed_inode(inode, &lc, orphan_free);
+	goto out;
 }
 
 static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
@@ -791,7 +797,7 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 out_fail:
 	clear_inode_flag(inode, FI_INC_LINK);
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return ERR_PTR(err);
 }
 
@@ -847,7 +853,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	f2fs_balance_fs(sbi, true);
 	return 0;
 out:
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return err;
 }
 
@@ -918,7 +924,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 release_out:
 	f2fs_release_orphan_inode(sbi);
 out:
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return err;
 }
 
-- 
2.55.0.860.g4b6b3295ed-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
