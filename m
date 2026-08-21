Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E9CC5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=blclBJ+nBvxlRM49yscaqnbjwXtZ/7Zsb22/huBoa4M=; b=nBEJnjxm912I4N0/gQkxqqxlsO
	SDbOHPgON52KF92eApD0LQLOmwuf/0HMORKEvX2qFUk7MZil2WVSlVzyLfZUDXA+Ua+Dj9eKbwDzm
	59JMTY8SUvDEpiFicJ/bQrgtn/2RbnheHBYyNnCT8Fdk0HqzbRr2+0XJz8dMjEWr+AKs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxR5P-0001tE-C4;
	Fri, 21 Aug 2026 15:23:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wxR5O-0001t7-6O
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:23:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eK1CpkIxcpDPrCVxw2kVnToKkhT+4Ub9pbOerS3cEPU=; b=Lsx3TPrNulNWPOYeVgNKWyj4bC
 5yzyGyCjWpVwQ68SKN4Q8hGifd7bGrptMzvau0vjVXj/TGj2qE/pez5Q2OLspItQOHxcY4Vt+mAXF
 h5g5HOwdcq6duq13Usc+fVfZs6j8laZm8jqvvZXJS+qxYzZ8KLTw2eVut9nMcbeJeEh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eK1CpkIxcpDPrCVxw2kVnToKkhT+4Ub9pbOerS3cEPU=; b=aQeZnd1/0sCPTvpOMy1jS1kc3r
 HpZSyA/ySJWkP/2XnxJJyDk6Qd6ePI3QW9hLAt0iFbMt4nywLY17hWnCcY+Wfr65wbmflF40jQgFH
 NFZcklQNCGa72b1+0dYSZwmiRCLZ+TF5J+WukYxiIclBsjDe4OP3ropWd85YbSco23V8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxR5N-0004Ab-92 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:23:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9152D61879
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 15:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 331B41F000E9;
 Fri, 21 Aug 2026 15:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325787;
 bh=eK1CpkIxcpDPrCVxw2kVnToKkhT+4Ub9pbOerS3cEPU=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=hm3Tl0X5srDxh0fdLb5o5DO3WVXb7Aj7jQRz3Xvt4BQKcAtEyY+Cya4kh7AAAIfp9
 5T417m3ypkh63uqd9RxYDGUygd0v+bh9XtdAgbj1xWuofmmrA3Z3mBp16TFh5CWCBP
 gfpjmm1Tl14fkFQcXLRaduT+Avz/dVc1Mw6Cyp34viE7oWrrPZX2tWb0gTBQl4VOuv
 hvouYU4mVDxTe18DnBTtFf5z1WA/LnvWPkqtk3NUtrS1Dk6hXGHIVBapb/oPne1Jn8
 OAyTvXamovgP3BPi2GGjwnexn4fU1hJHXKAGAVbZEdFh9gOQN0cpSIkJ5BDQ4j2/3K
 Nue4sYo5sQ7iA==
Date: Fri, 21 Aug 2026 15:23:05 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <aohtWfHNbUwxoQg2@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260818200121.2684318-1-jaegeuk@kernel.org>
X-Headers-End: 1wxR5N-0004Ab-92
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't leave the hashed inode while
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

 Change log from v1:
  - fix bugs

 fs/f2fs/f2fs.h  |   3 +-
 fs/f2fs/inode.c |   6 ++-
 fs/f2fs/namei.c | 101 +++++++++++++++++++++++++-----------------------
 3 files changed, 60 insertions(+), 50 deletions(-)

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
index 37897f4321c0..4971872edc5f 100644
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
 
@@ -566,38 +566,31 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
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
 	if (IS_DEVICE_ALIASING(inode))
 		return -EPERM;
 
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
@@ -615,11 +608,28 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
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
@@ -630,19 +640,10 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
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
 
@@ -669,7 +670,8 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	size_t len = strlen(symname);
 	struct fscrypt_str disk_link;
-	int err;
+	bool orphan_free = true;
+	int err, ret;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -703,13 +705,16 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	f2fs_unlock_op(sbi, &lc);
 	f2fs_alloc_nid_done(sbi, inode->i_ino);
 
+	/* Write the symlink path to the new inode. */
 	err = fscrypt_encrypt_symlink(inode, symname, len, &disk_link);
 	if (err)
-		goto err_out;
+		goto unlink_out_f2fs_handle_failed_inode;
 
 	err = page_symlink(inode, disk_link.name, disk_link.len);
+	if (err)
+		goto unlink_out_f2fs_handle_failed_inode;
 
-err_out:
+give_up:
 	d_instantiate_new(dentry, inode);
 
 	/*
@@ -721,22 +726,22 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
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
 	goto out_free_encrypted_link;
 
+unlink_out_f2fs_handle_failed_inode:
+	err = __do_unlink(dir, inode, &dentry->d_name);
+	if (err)
+		goto give_up;
+	orphan_free = false;
+	f2fs_lock_op(sbi, &lc);
 out_f2fs_handle_failed_inode:
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, orphan_free);
 out_free_encrypted_link:
 	if (disk_link.name != (unsigned char *)symname)
 		kfree(disk_link.name);
@@ -789,7 +794,7 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 
 out_fail:
 	clear_inode_flag(inode, FI_INC_LINK);
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return ERR_PTR(err);
 }
 
@@ -845,7 +850,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	f2fs_balance_fs(sbi, true);
 	return 0;
 out:
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return err;
 }
 
@@ -916,7 +921,7 @@ static int __f2fs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 release_out:
 	f2fs_release_orphan_inode(sbi);
 out:
-	f2fs_handle_failed_inode(inode, &lc);
+	f2fs_handle_failed_inode(inode, &lc, true);
 	return err;
 }
 
-- 
2.55.0.766.g2966f0265a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
