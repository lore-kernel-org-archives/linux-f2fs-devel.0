Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F12C5DF86
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ep1gtk9BQdBNWibD0QLBb1rHZiyxDTZlTt6BLGkwUos=; b=K3IX3p4riKMtc6dsi2I5ZagCVq
	2BQGzlM/wUd93WRIjlVAejuS/ie2cDVazSuMW9eXOsxknxeUI13j0f8haS8wj6oNtW91GExdq7VR8
	PFk/rtXOqIe5Eo4vbByxrW4JSloJr3tLfgP45fvVG7mcw62xl0THXg4F6OIkrX8k+wBk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwg7u-0000eq-KI;
	Wed, 19 Aug 2026 13:14:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wwg7t-0000ek-O6
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:14:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YkturzlV37zRTwxFEsUoMia3rueHM20fJQJwHe6NoXw=; b=XYWvbPtD0AZh8O9toCPgZ3EOsQ
 Z4tWv/BVu15y5l43oSRjDJ/lQg70E/+OEN03MScyRZjjVmuqX/ahMJvEhX5+lT3/dDXXpa6WNsR+m
 d0QaJ60GBnHnZpO7E1HbglQ17lS88i0ew5fyc/KZ0RNiMlrArluFsA3qgXTC00eWPKqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YkturzlV37zRTwxFEsUoMia3rueHM20fJQJwHe6NoXw=; b=e
 2YLcA1Fp063kHiSN8VQyxsUpEGe6BSPbVzcH2TZs3bC/rcG21SXS00RZcogFb+e8ddRmo5fd8yOSX
 LGLHFgpHWmiDrJuPhfdfA7WpBKLqzDuFoZ8Iwy5yc+5CTT+mAKUYfO6uVsWtoAdOynUCg5T+J8D5p
 6mFgL5fzCeCT7/r0=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwg7r-0008HW-07 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:14:41 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so899520a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787145273; x=1787750073; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YkturzlV37zRTwxFEsUoMia3rueHM20fJQJwHe6NoXw=;
 b=rwm0a6yIOWeqaYugdtfPBmLndaUZO392Pya5ihe4W/XDLcJJIbsA09uDEowuy8fhi1
 Nvog5lo+WnTCA5a+HdHpeF1ZIwPZQ9SPRSpvNkgUGJYM/oByNtgHkuWNyQ7ltZjpmGD8
 li76J4De45VTAJmMyk8kibnM6Dduh1/j+jArgZVxXipkVlD4LivGWonCYSoo3+cr2XSk
 j6oAgDLw6WPRSjIgV2VoFrVkQLuG1h1tMl8tWjIVKJGd/CTyZLI1xKP6+RC6wwP8iQ1T
 3/twhinM8D9QWq7bN60+8oopA0vRTwG0gBU6WR7mFXH8kOXY2ttQmI/lPqB3RkpPyr/g
 FA3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145273; x=1787750073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YkturzlV37zRTwxFEsUoMia3rueHM20fJQJwHe6NoXw=;
 b=QKDNIvnruQJpZIFeJ+PjKVc1gpJJNOaRNkMT2GloN0w8q7UMnmX+BZnt8XbPLOhU2j
 SFBbk3LMhqWhvpxJ5pCvAxvmJroklkwx8e9cI7+kPKzVTuZQzzXCzf9ZT/MSfVM1Dy1I
 qqvMwJRP159jR84RH17AtdCGOiGymaIril1JIrp2CyJBO/Gm3d4m27/HuIkU76RU9eG8
 m3Y4VaFF6UCCOH6F16jVgrczwV8tLKI2AkUy2d0bhSghoHNcTiXESTgKtC2Caf6q/Fat
 8s7LmHD57xgH9+IcZVLqJB2gbWqERtz58vq3K7QMb5PF3uuvV46ZgTdgV9fs+xK4ya84
 iXwg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqE2cgHu44c6rPyN0hvdfLERkZ37KHy9uW93go04Szm1uJng62WAnKb4VpI4xhhdsZkgRzV/0qyqsLFyf4/Gpoc@lists.sourceforge.net
X-Gm-Message-State: AFuF++n1vbsbzawG1SHOWD4KVRbJa7XJTV6aVC6K1PYSVgyKT6AIN1xY
 Br4u0Z1ETbxHNdZW4SEQo8s9R6wMRtRR5ly8XommYVDVp/F9A3tmj9s6
X-Gm-Gg: AR+sD13dg9G6wPH6tEblgDWSHslQjhVBi6GLjhCEiv/P9P20exZPeYYlOLbfNBPNxKU
 DiluDOhgJb76s6+099hGZ/LW7x2zW9pRhzrO7rNjGwzCa7JP9/HfCYCHr2NBebK5bruAakmerAh
 UdCld61Ie7bYLyDILQdYJjCm2Pv6XRCrSXHbzfhZLJNGoVGXwyeQfuaRMDcfsLAwiH/oGfGp3id
 yEuTNt/rNqa2mqeCM9S/sAiACOuBed/PGnY1AeqPIfX6wS+ojUruIybMREMoWcvDuH7TPmcmEGg
 mU+oUTqmc8cdjZ0Ro5i8ZNxxvLHAKaggbJyNzWl9XPWNPXFEUmWQ5RJnV7xj0s6IqxyvsqiCIYX
 E94DUxppTjAsDItCVL9GOC5Hj1HX6R1FBA2s36Xms/qoZA76m4qShXcY6RDFEGkqmqi6AopMidq
 nxwA5oKPjsRFuqRcRCGvgE+00n5/eMYRNDPQsYMVRauKQXffDIycsFLKzM3PxfTGhyitB1+FOh5
 p0vGbu95paogictJ36ZJDVIxFDwknU8bqQ=
X-Received: by 2002:a17:90b:3cc5:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-39580f3bcdemr9196929a91.10.1787145273058; 
 Wed, 19 Aug 2026 06:14:33 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb8578asm2659651a91.11.2026.08.19.06.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:14:32 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 19 Aug 2026 21:14:25 +0800
Message-ID: <20260819131425.189025-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wwg7r-0008HW-07
Subject: [f2fs-dev] [PATCH] f2fs: avoid instantiating failed symlinks
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com, stable@kernel.org,
 viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_add_link() initializes inode metadata needed by page_symlink(), so
the directory entry is added before the symlink target is set up. If
target setup fails, the current error path instantiates the dentry and
calls f2fs_unlink() directly. This bypasses the dcache update performed
by vfs_unlink() and leaves a hashed positive dentry attached to an
unlinked inode.

Factor the F2FS unlink work into an internal helper which takes the
directory, name and inode, and use it while the creation dentry is still
negative. Always unhash the dentry before releasing the inode so an
entry left behind by a failed rollback remains discoverable.

Return -ENOENT explicitly when f2fs_find_entry() cannot find the
directory entry. Successful quota initialization otherwise leaves err
set to zero and makes the helper report a successful deletion.

Fixes: a6be014e1d28 ("f2fs: fix error path of ->symlink")
Cc: stable@kernel.org
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/linux-f2fs-devel/20260815051820.GA660827@ZenIV/
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/namei.c | 83 ++++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 35 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 784f63624..5438d8ffc 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -560,38 +560,31 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(err);
 }
 
-static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
+static int f2fs_unlink_inode(struct inode *dir, const struct qstr *name,
+			     struct inode *inode)
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
+		return IS_ERR(folio) ? PTR_ERR(folio) : -ENOENT;
 
 	if (unlikely(inode->i_nlink == 0)) {
 		f2fs_warn(sbi, "%s: inode (ino=%llx) has zero i_nlink",
@@ -610,29 +603,40 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 	if (err) {
 		f2fs_unlock_op(sbi, &lc);
 		f2fs_folio_put(folio, false);
-		goto out;
+		return err;
 	}
 	f2fs_delete_entry(de, folio, dir, inode);
 	f2fs_unlock_op(sbi, &lc);
 
+	return 0;
+
+corrupted:
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_folio_put(folio, false);
+	return -EFSCORRUPTED;
+}
+
+static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	int err;
+
+	trace_f2fs_unlink_enter(dir, dentry);
+
+	err = f2fs_unlink_inode(dir, &dentry->d_name, inode);
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at f2fs_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+	if (!err && IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 
-	if (IS_DIRSYNC(dir))
-		f2fs_sync_fs(sbi->sb, 1);
+	if (!err && IS_DIRSYNC(dir))
+		f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
 
-	goto out;
-corrupted:
-	err = -EFSCORRUPTED;
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
-	f2fs_folio_put(folio, false);
-out:
 	trace_f2fs_unlink_exit(inode, err);
 	return err;
 }
@@ -660,7 +664,7 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	size_t len = strlen(symname);
 	struct fscrypt_str disk_link;
-	int err;
+	int err, ret;
 
 	if (unlikely(f2fs_cp_error(sbi)))
 		return -EIO;
@@ -701,6 +705,19 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	err = page_symlink(inode, disk_link.name, disk_link.len);
 
 err_out:
+	if (err) {
+		ret = f2fs_unlink_inode(dir, &dentry->d_name, inode);
+		if (ret)
+			f2fs_warn(sbi, "failed to rollback symlink inode %llu, err: %d",
+				  inode->i_ino, ret);
+		d_drop(dentry);
+		unlock_new_inode(inode);
+		if (!ret && IS_DIRSYNC(dir))
+			f2fs_sync_fs(sbi->sb, 1);
+		iput(inode);
+		goto out_balance;
+	}
+
 	d_instantiate_new(dentry, inode);
 
 	/*
@@ -712,16 +729,12 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	 * If the symlink path is stored into inline_data, there is no
 	 * performance regression.
 	 */
-	if (!err) {
-		filemap_write_and_wait_range(inode->i_mapping, 0,
-							disk_link.len - 1);
+	filemap_write_and_wait_range(inode->i_mapping, 0, disk_link.len - 1);
 
-		if (IS_DIRSYNC(dir))
-			f2fs_sync_fs(sbi->sb, 1);
-	} else {
-		f2fs_unlink(dir, dentry);
-	}
+	if (IS_DIRSYNC(dir))
+		f2fs_sync_fs(sbi->sb, 1);
 
+out_balance:
 	f2fs_balance_fs(sbi, true);
 	goto out_free_encrypted_link;
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
