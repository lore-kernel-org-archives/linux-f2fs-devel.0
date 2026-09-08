Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FB8C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6MmkqNjcfPCrlcYUasPDLYq91AxdNgI3+FbJcW0yb0w=; b=Fs7V6VfzBM4Ubw4v9RVXbuZ3Ww
	oodAJ+HnGsU8WKMZJuFvszNpxbH5M8SmbvZ07WRl6+i8FqwkLaAA3KNTCoHfWDevHlzK0O0sgO7PA
	+tz3+215/TsCHo8YgfUeG0Er2UrDrgXAXc5y7BsoVZZmUXWSTR/khVGG2Hzch1UrGFOg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3mom-00066r-S5;
	Tue, 08 Sep 2026 03:48:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jnhuang95@gmail.com>) id 1x3mom-00066i-9E
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:48:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8AgWnHN03bHYfDkr5aQ12DPzDcM0xtDPZaSW4EywM+Y=; b=TD6A3Y2LKGGKFGplRG650WGktW
 o1QWuAMIh5FEZQDSXyfIuaABArBG+5I9FGJAErG7iqbd12AkFAvvgy0w5+QYOlv9J3+J+WBFVi9rr
 vpYfcXPO0hmO13/ys2H0hhJ/SF9WfNOEfQ2lEZH28NE4Jsn1jRrKDikiwiSXEPV0vxR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8AgWnHN03bHYfDkr5aQ12DPzDcM0xtDPZaSW4EywM+Y=; b=Q
 QTXxqtcYWVeCiKrlGVwGSyGpL/awu7lRA0/vfRT7EpO0u8FfUasZ9Cng2dIgLWP2wxBlfAyOxYPv1
 wp66n9wOwANLcYL3iqnB6djA5cdAEIIvGOJTnhLQFHFeX6FxBQT01J2NCsc9dopG5IAit65QuRXjB
 wCEkP8h2heCXarxY=;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3mom-0007Kv-BI for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:48:21 +0000
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so3950840a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788839295; x=1789444095; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8AgWnHN03bHYfDkr5aQ12DPzDcM0xtDPZaSW4EywM+Y=;
 b=qLsHzFlp/sQL/R5F5zSQnIdjme7d408Mkar0hRBTMyY/VELUJJUgdqC33+3in0Iou5
 oWX6C5dkdCSNi0u1F3o5kigk2REwbFbKj20XRfe9QRxkpCrqpaVCLn+pdjZTmmNzTwJB
 ClLT1VdZ7U3olBUIdHJDKuRZhSlNsIjnEZDYOp6ai5jpxyit+LcZncDU4T+Y3NRrJA4A
 D4oBDj4SUodpiYHY2Uz8ZSqND9rb3Jgu+qadO+0+ZXiNIKfY5d1ItZVLUXe+RAJ+rxMS
 C+4AWQHooJftoaM6TdNkp5lqSfKlEmm+rW7bsp7/UqZ8RHq2XnpX2B+ivjbiYy6EUh+q
 ts3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788839295; x=1789444095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8AgWnHN03bHYfDkr5aQ12DPzDcM0xtDPZaSW4EywM+Y=;
 b=CvwQTpq8dwlqQGMYV3BZ+xnpzitqXXIvCcQUD4Hyypd/Z+wYHk26b9y7lt5iG5Mv+R
 AxhSrRjddO1bomQIX/Fc2Kocej9VtsVKbGP4TuQ3dn4jJRVnBqDVzEMU6rjl/US/bw31
 RlyjKFt8vKlheTcunJpW5VlVaZG0c1+Blhm6o1rQjGD/NvuocjkcrDRTBiWAcKf+giUN
 qO3T/mPkE90YIklSOm6XJUhBk4hi+u3JCofnRzWtxBsnTCfqgye19A35ETzGguLIfDMc
 TQhP2drcLwBlRvs3xPF8vlCVfo8kk3a8yt8IXIqlR7dwOfdPCHhYj7Ocp5AuYm/0hi1A
 K26w==
X-Gm-Message-State: AFuF++moWt6qWpIVcx2DlKlmI3SeNSjfbgNqt/WOueOgdjA4HeEZwGko
 qQLfXIgC1lvake9KEi+1EPwzbcsh/gxXGFGBhP31+eHkO8fTt2PlMObDUZLvtz3//sM=
X-Gm-Gg: AYBFou1Y7dUyMGZWuvZgVdS0VRtjj/OBopiAHwoc7BVu72hykJ2zpFBLpv206jIq6ZR
 qQw7uqL9z0d5kclN3AXjfBrro3ha+CRoprr9udEUeUXNKC4RA2aXZJrYTf/X2IVr7EDk391WYyQ
 Jrx1BwlBcNRwOCNZfTC1gnEdqT8sWIy+bVtj0ypYfbnNBVogCKe1ab1s5rUOKUAjmu7+8RyQkWB
 JZLx9QkYp19IRUEldV2zOzMZLWsZWJYhcNlHl1Xl/HXHD5RCRdUhNU5K9bErjnnZcocPqoYXQbj
 +86n35QMG58q5xWJBIlIH+4bUzOtOu7cHb72/CHT8BRQeCKBDoHsf/fV64o7d27O+HbyfSEySKi
 +T6t2LBnQLU+Gb8amqwyFjDT01ELx6ZCvv4yHZRKlBCJIa5TD8Vg/dhHr08S/D41yllvwJToqgK
 Auv0f7vztktNr1boJmIQHBG2RIvYiopq1Y/xje2bS7trZ4qorSnVsjZpdf21XRVPgyve5YG8bHG
 nHP2n0lbWwNXp8uBlHvkfn4IJFZ/tv9JJA+Ng==
X-Received: by 2002:a05:6a20:9630:b0:3cc:ebeb:3efe with SMTP id
 adf61e73a8af0-3da39ee18ecmr41062832637.9.1788839294513; 
 Mon, 07 Sep 2026 20:48:14 -0700 (PDT)
Received: from 4ce604c9y2.bytedance.net ([61.213.176.58])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc45a6abaa2sm4424812a12.23.2026.09.07.20.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 20:48:14 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org, jaegeuk@kernel.org
Date: Tue,  8 Sep 2026 11:48:09 +0800
Message-ID: <20260908034809.616919-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x3mom-0007Kv-BI
Subject: [f2fs-dev] [PATCH] f2fs: quota: fix quota flush failure during
 filesystem freeze
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
Cc: Jianan Huang <jnhuang95@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Quota flush retries can be exhausted during filesystem freeze.

freeze_super() and the quota checkpoint may race as below.

freeze_super()                       f2fs_ckpt
- down_write(&sb->s_umount)
- sb->s_writers.frozen = SB_FREEZE_PAGEFAULT
- sync_filesystem()
 - f2fs_sync_fs()
  - f2fs_issue_checkpoint()
   - queue CP_SYNC -----------------> - block_operations()
                                      - down_read_trylock(s_umount)
                                        : fails; freeze holds write lock
                                      - quota flush retries exhausted
                                      - set CP_QUOTA_NEED_FSCK_FLAG

During the PAGEFAULT sync pass, freeze_super() holds s_umount for
write, but umount_lock_holder is not set until f2fs_freeze().  Thus
quota writeback tries to acquire s_umount again and can exhaust retries.

With checkpoint merge enabled, f2fs_issue_checkpoint() may dispatch
CP_SYNC to f2fs_ckpt.  That thread also cannot acquire the freeze lock.

Split the F2FS-internal sync implementation from the super-operation
callback.  For the VFS PAGEFAULT freeze sync, record current as holder
around the internal sync.  This lets quota writeback use the existing
lock and makes CP_SYNC run directly in the freeze caller.

Convert F2FS-internal callers to the internal helper so they cannot be
mistaken for the freeze owner while the filesystem is frozen.

Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  8 ++++----
 fs/f2fs/namei.c   | 16 ++++++++--------
 fs/f2fs/segment.c |  4 ++--
 fs/f2fs/super.c   | 25 ++++++++++++++++++++++---
 5 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9940a6cecf1a..169792a08a82 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3977,7 +3977,7 @@ void f2fs_quota_off_umount(struct super_block *sb);
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
-int f2fs_sync_fs(struct super_block *sb, int sync);
+int __f2fs_sync_fs(struct super_block *sb, int sync);
 int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi);
 
 /*
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index edc352569e87..83546a053656 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -408,7 +408,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
-		ret = f2fs_sync_fs(inode->i_sb, 1);
+		ret = __f2fs_sync_fs(inode->i_sb, 1);
 
 		/*
 		 * We've secured consistency through sync_fs. Following pino
@@ -2548,7 +2548,7 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		break;
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
-		ret = f2fs_sync_fs(sb, 1);
+		ret = __f2fs_sync_fs(sb, 1);
 		if (ret) {
 			if (ret == -EIO)
 				ret = 0;
@@ -2568,7 +2568,7 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		set_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		/* do checkpoint only */
-		ret = f2fs_sync_fs(sb, 1);
+		ret = __f2fs_sync_fs(sb, 1);
 		if (ret == -EIO)
 			ret = 0;
 		goto out;
@@ -2988,7 +2988,7 @@ static int f2fs_ioc_write_checkpoint(struct file *filp)
 	if (ret)
 		return ret;
 
-	ret = f2fs_sync_fs(sbi->sb, 1);
+	ret = __f2fs_sync_fs(sbi->sb, 1);
 
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index ff86ee07290d..5f6f5db9e849 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -403,7 +403,7 @@ static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (err)
 			return err;
 	}
@@ -459,7 +459,7 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (err)
 			return err;
 	}
@@ -641,7 +641,7 @@ static int f2fs_unlink(struct inode *dir, struct dentry *dentry)
 		d_invalidate(dentry);
 
 	if (IS_DIRSYNC(dir))
-		err = f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
+		err = __f2fs_sync_fs(F2FS_I_SB(dir)->sb, 1);
 out:
 	trace_f2fs_unlink_exit(d_inode(dentry), err);
 	return err;
@@ -729,7 +729,7 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0,
 					   disk_link.len - 1);
 	if (!ret && IS_DIRSYNC(dir))
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 
 	f2fs_balance_fs(sbi, true);
 out:
@@ -787,7 +787,7 @@ static struct dentry *f2fs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (err)
 			return ERR_PTR(err);
 	}
@@ -845,7 +845,7 @@ static int f2fs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate_new(dentry, inode);
 
 	if (IS_DIRSYNC(dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (err)
 			return err;
 	}
@@ -1148,7 +1148,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	f2fs_unlock_op(sbi, &lc);
 
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (err)
 			return err;
 	}
@@ -1318,7 +1318,7 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	f2fs_unlock_op(sbi, &lc);
 
 	if (IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir)) {
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (err)
 			return err;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b712d3d599..9a09f2525b70 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -550,7 +550,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi, bool from_bg)
 		mutex_unlock(&sbi->flush_lock);
 	}
 	stat_inc_cp_call_count(sbi, BACKGROUND);
-	f2fs_sync_fs(sbi->sb, 1);
+	__f2fs_sync_fs(sbi->sb, 1);
 }
 
 static int __submit_flush_wait(struct f2fs_sb_info *sbi,
@@ -3478,7 +3478,7 @@ int f2fs_allocate_pinning_section(struct f2fs_sb_info *sbi)
 				true, ZONED_PIN_SEC_REQUIRED_COUNT, true);
 		if (err)
 			return err;
-		err = f2fs_sync_fs(sbi->sb, 1);
+		err = __f2fs_sync_fs(sbi->sb, 1);
 		if (!err) {
 			gc_required = false;
 			goto retry;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1314b6ccced9..a82065146849 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2131,7 +2131,7 @@ static void f2fs_put_super(struct super_block *sb)
 	}
 }
 
-int f2fs_sync_fs(struct super_block *sb, int sync)
+int __f2fs_sync_fs(struct super_block *sb, int sync)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	int err = 0;
@@ -2154,6 +2154,25 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
 	return err;
 }
 
+static int f2fs_sync_fs(struct super_block *sb, int sync)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	bool freeze_sync = sync &&
+			sb->s_writers.frozen == SB_FREEZE_PAGEFAULT;
+	int err;
+
+	/* freeze_super() holds s_umount for write during this sync pass. */
+	if (freeze_sync)
+		sbi->umount_lock_holder = current;
+
+	err = __f2fs_sync_fs(sb, sync);
+
+	if (freeze_sync)
+		sbi->umount_lock_holder = NULL;
+
+	return err;
+}
+
 static int f2fs_freeze(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -2807,7 +2826,7 @@ static int f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 	f2fs_up_write_trace(&sbi->gc_lock, &lc);
 
-	ret = f2fs_sync_fs(sbi->sb, 1);
+	ret = __f2fs_sync_fs(sbi->sb, 1);
 	if (ret)
 		f2fs_err(sbi, "%s sync_fs failed, ret: %d", __func__, ret);
 
@@ -2993,7 +3012,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		set_sbi_flag(sbi, SBI_IS_CLOSE);
-		err = f2fs_sync_fs(sb, 1);
+		err = __f2fs_sync_fs(sb, 1);
 		if (err)
 			goto restore_gc;
 		clear_sbi_flag(sbi, SBI_IS_CLOSE);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
