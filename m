Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EE8C77B75
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 May 2023 03:58:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1JAS-0008NI-Og;
	Tue, 23 May 2023 03:58:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q1JAR-0008NC-FZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 03:58:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+PeB0fZtgMUFKwd+bkgMEghuenyDcKRskW1uQFDmO40=; b=kqIkUo5Vx7vJWpE3E7png5Z+ZC
 mwcmlto0BlVshH6/+Z7xnIOftVU5HbHYLwTnrZiSRXVHkNhjIWu4kIFqg/+Tr9J7D5A/yY1c00Lnu
 ZULb8dO7ruZhKqz8U4hQWcWGU7/q2ZdKe/wHTK3ppC0GrHYd4LTf7gtH7fzWhg8biG9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+PeB0fZtgMUFKwd+bkgMEghuenyDcKRskW1uQFDmO40=; b=W
 UMHJoQNLaXWSlW7+fEWBY+IxZ3DrS4XSEGUib/0Uedj6vO2v2wbetZU/zXo6AP4aODjwu+i2j0tFB
 vMdLCiXQPbpCtVilbvK6vI4Zo492I4kpGurhUDqKSBRYauNQVKMzwYMJAsgS/uZs904aBefpB3M/8
 +TnnhtDaOmZ913Hg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1JAR-0007sM-2J for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 03:58:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AAB6F62414;
 Tue, 23 May 2023 03:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA9FC433D2;
 Tue, 23 May 2023 03:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684814309;
 bh=FniiWmm9rXXh4clLmDfg99004+nvesmQImAp7CGl4fs=;
 h=From:To:Cc:Subject:Date:From;
 b=mS8d4fDz0lmWfjIN8n86vCloGS4zt1Z7Wi+oX4BuPwhUxkw4bckWr8fieU7fPHnDL
 YheukgIxVrsA02N7vw4DScURHobA/cGDMMEQ9sTIdCAmyvT52kE6zxmnujG6vFMLVI
 II2qfFR8mU2yYSOzCEY4vaik90jjmpYmv8b+Lt1IHzNqVlLJCKUKjNrtnOIqSZEq1G
 ZT7J8RK9KIjPE+RpJ72RotUjTJppcBOFuyMbgYGLTagXr+tZeL7ICrCok0VOHiDWp3
 wJqTX+BsX8oTATY1/fCCcB3E0Mjln4o2LXh9EVTfVQN9rshbfa0mDfW138w0yYrKGx
 H6wUMZ00IaDWg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 23 May 2023 11:58:22 +0800
Message-Id: <20230523035822.578123-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1q1JAR-0007sM-2J
Subject: [f2fs-dev] [PATCH] f2fs: don't reset unchangable mount option in
 f2fs_remount()
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
Cc: syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports a bug as below:

general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] PREEMPT SMP KASAN
RIP: 0010:__lock_acquire+0x69/0x2000 kernel/locking/lockdep.c:4942
Call Trace:
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
 __raw_write_lock include/linux/rwlock_api_smp.h:209 [inline]
 _raw_write_lock+0x2e/0x40 kernel/locking/spinlock.c:300
 __drop_extent_tree+0x3ac/0x660 fs/f2fs/extent_cache.c:1100
 f2fs_drop_extent_tree+0x17/0x30 fs/f2fs/extent_cache.c:1116
 f2fs_insert_range+0x2d5/0x3c0 fs/f2fs/file.c:1664
 f2fs_fallocate+0x4e4/0x6d0 fs/f2fs/file.c:1838
 vfs_fallocate+0x54b/0x6b0 fs/open.c:324
 ksys_fallocate fs/open.c:347 [inline]
 __do_sys_fallocate fs/open.c:355 [inline]
 __se_sys_fallocate fs/open.c:353 [inline]
 __x64_sys_fallocate+0xbd/0x100 fs/open.c:353
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The root cause is race condition as below:
- since it tries to remount rw filesystem, so that do_remount won't
call sb_prepare_remount_readonly to block fallocate, there may be race
condition in between remount and fallocate.
- in f2fs_remount(), default_options() will reset mount option to default
one, and then update it based on result of parse_options(), so there is
a hole which race condition can happen.

Thread A			Thread B
- f2fs_fill_super
 - parse_options
  - clear_opt(READ_EXTENT_CACHE)

- f2fs_remount
 - default_options
  - set_opt(READ_EXTENT_CACHE)
				- f2fs_fallocate
				 - f2fs_insert_range
				  - f2fs_drop_extent_tree
				   - __drop_extent_tree
				    - __may_extent_tree
				     - test_opt(READ_EXTENT_CACHE) return true
				    - write_lock(&et->lock) access NULL pointer
 - parse_options
  - clear_opt(READ_EXTENT_CACHE)

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+d015b6c2fbb5c383bf08@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/20230522124203.3838360-1-chao@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index aeed413cf5cd..96bf7e727175 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2097,9 +2097,22 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
-static void default_options(struct f2fs_sb_info *sbi)
+static void default_options(struct f2fs_sb_info *sbi, bool remount)
 {
 	/* init some FS parameters */
+	if (!remount) {
+		set_opt(sbi, READ_EXTENT_CACHE);
+		clear_opt(sbi, DISABLE_CHECKPOINT);
+
+		if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
+			set_opt(sbi, DISCARD);
+
+		if (f2fs_sb_has_blkzoned(sbi))
+			F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
+		else
+			F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_BLOCK;
+	}
+
 	if (f2fs_sb_has_readonly(sbi))
 		F2FS_OPTION(sbi).active_logs = NR_CURSEG_RO_TYPE;
 	else
@@ -2129,23 +2142,16 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_XATTR);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, INLINE_DENTRY);
-	set_opt(sbi, READ_EXTENT_CACHE);
 	set_opt(sbi, NOHEAP);
-	clear_opt(sbi, DISABLE_CHECKPOINT);
 	set_opt(sbi, MERGE_CHECKPOINT);
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	if (!f2fs_is_readonly(sbi))
 		set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
-		set_opt(sbi, DISCARD);
-	if (f2fs_sb_has_blkzoned(sbi)) {
+	if (f2fs_sb_has_blkzoned(sbi))
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
-		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
-	} else {
+	else
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
-		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_BLOCK;
-	}
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
@@ -2317,7 +2323,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 	}
 
-	default_options(sbi);
+	default_options(sbi, true);
 
 	/* parse mount options */
 	err = parse_options(sb, data, true);
@@ -4377,7 +4383,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_chksum_seed = f2fs_chksum(sbi, ~0, raw_super->uuid,
 						sizeof(raw_super->uuid));
 
-	default_options(sbi);
+	default_options(sbi, false);
 	/* parse mount options */
 	options = kstrdup((const char *)data, GFP_KERNEL);
 	if (data && !options) {
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
