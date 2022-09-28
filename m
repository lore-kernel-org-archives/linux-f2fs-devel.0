Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E38FC04A95
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Sep 2022 15:39:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1odZ9m-0007PO-7w;
	Wed, 28 Sep 2022 15:39:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1odZ9c-0007P3-Vc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Sep 2022 15:39:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ZXcHbaJzLwDUX4134uVMXX6b32rn9jzmo8RHQ+xZI8=; b=Ouk0UpNEJJaXTK2yb9fZIciGNa
 IoX+2+e/+BvHz3pVw4TSguc1HM/hdPHXCZP5+tohvqjUff5UlsR8l8CCbPduvTlmcXEEtDmsTSQRy
 nbf7Ke1oQJlF8sUJTqAugUlf4aRBZbiX+ZD++WXjzOmNiONln+tXPlBoYYPtHHsbPKVk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8ZXcHbaJzLwDUX4134uVMXX6b32rn9jzmo8RHQ+xZI8=; b=IseVJf377XHsn9ArkBwZ8bWglq
 N+gzgGG/mByB96uZ31+OP1p2Ir37VUUeWE78on1+0s0EPjAdH6PIz9BCk/xEM15z0uUJ5LB/ghLl+
 nTxoG2o3xB/fLnrwUZ/ZOKIRvqIrO4+Db/qH4NnPheAQ2ldmL/YH1anSCjm2kWFe/gDw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1odZ9c-0003S4-4a for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Sep 2022 15:39:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 028B261F08
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Sep 2022 15:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37B4C433D6;
 Wed, 28 Sep 2022 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664379551;
 bh=MltwnQZqLWKplo4cGRS5ox1jetCSvwOPwiJREoC2IHA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XiWE/rBJ8EZnn0w3unVNoZJGj7STiCDkea+FafqeX/M/VAYp75aJG3ATzV5UzEydv
 cE/llezFJnfFQl3X0bt+rAf85OF7/wed/mZONTqJPHwQw1TRlj4sgFjlANSNTlYwhT
 QLFfR+Gu/YYlwx0oKlI0Oz93KPcGmxja13jutIpKatevVCcNXwzMXm/xM1MiAuJPxH
 4YshiwJHgQXfOJDj9cud8/Kg5m7ao9m1W8IlVPV9kRkvL/BcSbfh/O/aSAzxEkJshe
 2MMthvTfCvgpMqkC4GNsxjUazIfuJIFAT9M56zsN2EsgKCSi6VAJiIfdrNa1pMzbue
 pgx67NcD561Ow==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 28 Sep 2022 23:38:55 +0800
Message-Id: <20220928153855.4634-3-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220928153855.4634-1-chao@kernel.org>
References: <20220928153855.4634-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1odZ9c-0003S4-4a
Subject: [f2fs-dev] [PATCH 3/3] f2fs: support
 errors=remount-ro|continue|panic mountoption
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch supports errors=remount-ro|continue|panic mount option.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/filesystems/f2fs.rst |   4 +
 fs/f2fs/checkpoint.c               |   7 +-
 fs/f2fs/f2fs.h                     |  18 ++++-
 fs/f2fs/super.c                    | 114 ++++++++++++++++++++++++++++-
 4 files changed, 132 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index d0c09663dae8..6aa14e03f337 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -341,6 +341,10 @@ memory=%s		 Control memory mode. This supports "normal" and "low" modes.
 			 Because of the nature of low memory devices, in this mode, f2fs
 			 will try to save memory sometimes by sacrificing performance.
 			 "normal" mode is the default mode and same as before.
+errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
+			 "panic", "continue" and "remount-ro", respectively, triggers
+			 panic immediately, continue without doing anything, or remount
+			 the partition in read-only mode (default behavior).
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 0c82dae082aa..109e96c15b84 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -30,12 +30,9 @@ void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi, bool end_io,
 						unsigned char reason)
 {
 	f2fs_build_fault_attr(sbi, 0, 0);
-	set_ckpt_flags(sbi, CP_ERROR_FLAG);
-	if (!end_io) {
+	if (!end_io)
 		f2fs_flush_merged_writes(sbi);
-
-		f2fs_handle_stop(sbi, reason);
-	}
+	f2fs_handle_critical_error(sbi, reason, end_io);
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2ed00111a399..254f7f153477 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -160,6 +160,7 @@ struct f2fs_mount_info {
 	int fs_mode;			/* fs mode: LFS or ADAPTIVE */
 	int bggc_mode;			/* bggc mode: off, on or sync */
 	int memory_mode;		/* memory mode */
+	int errors;			/* errors parameter */
 	int discard_unit;		/*
 					 * discard command's offset/size should
 					 * be aligned to this unit: block,
@@ -1382,7 +1383,11 @@ enum {
 	MEMORY_MODE_LOW,	/* memory mode for low memry devices */
 };
 
-
+enum errors_option {
+	MOUNT_ERRORS_READONLY,	/* remount fs ro on errors */
+	MOUNT_ERRORS_CONTINUE,	/* continue on errors */
+	MOUNT_ERRORS_PANIC,	/* panic on errors */
+};
 
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
@@ -1818,7 +1823,13 @@ struct f2fs_sb_info {
 
 	struct workqueue_struct *post_read_wq;	/* post read workqueue */
 
-	unsigned char errors[MAX_F2FS_ERRORS];	/* error flags */
+	/*
+	 * If we are in irq context, let's update error information into
+	 * on-disk superblock in the work.
+	 */
+	struct work_struct s_error_work;
+	unsigned char errors[MAX_F2FS_ERRORS];		/* error flags */
+	unsigned char stop_reason[MAX_STOP_REASON];	/* stop reason */
 	spinlock_t error_lock;			/* protect errors array */
 	bool error_dirty;			/* errors of sb is dirty */
 
@@ -3563,7 +3574,8 @@ int f2fs_enable_quota_files(struct f2fs_sb_info *sbi, bool rdonly);
 int f2fs_quota_sync(struct super_block *sb, int type);
 loff_t max_file_blocks(struct inode *inode);
 void f2fs_quota_off_umount(struct super_block *sb);
-void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason);
+void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
+							bool irq_context);
 void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
 int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
 int f2fs_sync_fs(struct super_block *sb, int sync);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ee0a5a17ba39..2b6d9617ef01 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -161,6 +161,7 @@ enum {
 	Opt_nogc_merge,
 	Opt_discard_unit,
 	Opt_memory_mode,
+	Opt_errors,
 	Opt_err,
 };
 
@@ -238,6 +239,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_nogc_merge, "nogc_merge"},
 	{Opt_discard_unit, "discard_unit=%s"},
 	{Opt_memory_mode, "memory=%s"},
+	{Opt_errors, "errors=%s"},
 	{Opt_err, NULL},
 };
 
@@ -1253,6 +1255,25 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 			}
 			kfree(name);
 			break;
+		case Opt_errors:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "remount-ro")) {
+				F2FS_OPTION(sbi).errors =
+						MOUNT_ERRORS_READONLY;
+			} else if (!strcmp(name, "continue")) {
+				F2FS_OPTION(sbi).errors =
+						MOUNT_ERRORS_CONTINUE;
+			} else if (!strcmp(name, "panic")) {
+				F2FS_OPTION(sbi).errors =
+						MOUNT_ERRORS_PANIC;
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -2031,6 +2052,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	else if (F2FS_OPTION(sbi).memory_mode == MEMORY_MODE_LOW)
 		seq_printf(seq, ",memory=%s", "low");
 
+	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_READONLY)
+		seq_printf(seq, ",errors=%s", "remount-ro");
+	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE)
+		seq_printf(seq, ",errors=%s", "continue");
+	else if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC)
+		seq_printf(seq, ",errors=%s", "panic");
+
 	return 0;
 }
 
@@ -2053,6 +2081,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
 	F2FS_OPTION(sbi).memory_mode = MEMORY_MODE_NORMAL;
+	F2FS_OPTION(sbi).errors = MOUNT_ERRORS_READONLY;
 
 	sbi->sb->s_flags &= ~SB_INLINECRYPT;
 
@@ -3846,7 +3875,16 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
 	return err;
 }
 
-void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
+static void save_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
+
+{
+	spin_lock(&sbi->error_lock);
+	if (sbi->stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
+		sbi->stop_reason[reason]++;
+	spin_unlock(&sbi->error_lock);
+}
+
+void f2fs_record_stop_reason(struct f2fs_sb_info *sbi, unsigned char reason)
 
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -3854,8 +3892,9 @@ void f2fs_handle_stop(struct f2fs_sb_info *sbi, unsigned char reason)
 
 	f2fs_down_write(&sbi->sb_lock);
 
-	if (raw_super->s_stop_reason[reason] < ((1 << BITS_PER_BYTE) - 1))
-		raw_super->s_stop_reason[reason]++;
+	spin_lock(&sbi->error_lock);
+	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
+	spin_unlock(&sbi->error_lock);
 
 	err = f2fs_commit_super(sbi, false);
 	if (err)
@@ -3909,6 +3948,74 @@ void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error)
 	f2fs_up_write(&sbi->sb_lock);
 }
 
+static bool system_going_down(void)
+{
+	return system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF
+		|| system_state == SYSTEM_RESTART;
+}
+
+void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
+							bool irq_context)
+{
+	struct super_block *sb = sbi->sb;
+	bool force_ro = reason == STOP_CP_REASON_SHUTDOWN;
+	bool continue_fs = !force_ro &&
+			F2FS_OPTION(sbi).errors == MOUNT_ERRORS_CONTINUE;
+
+	if (!continue_fs && !sb_rdonly(sb))
+		set_ckpt_flags(sbi, CP_ERROR_FLAG);
+
+	if (!bdev_read_only(sb->s_bdev)) {
+		save_stop_reason(sbi, reason);
+
+		if (irq_context)
+			schedule_work(&sbi->s_error_work);
+		else
+			f2fs_record_stop_reason(sbi, reason);
+	}
+
+	/*
+	 * We force ERRORS_RO behavior when system is rebooting. Otherwise we
+	 * could panic during 'reboot -f' as the underlying device got already
+	 * disabled.
+	 */
+	if (F2FS_OPTION(sbi).errors == MOUNT_ERRORS_PANIC &&
+				!force_ro && !system_going_down())
+		panic("F2FS-fs (device %s): panic forced after error\n",
+							sb->s_id);
+
+	/* continue filesystem operators if errors=continue */
+	if (continue_fs || sb_rdonly(sb))
+		return;
+
+	f2fs_warn(sbi, "Remounting filesystem read-only");
+	/*
+	 * Make sure updated value of ->s_mount_flags will be visible before
+	 * ->s_flags update
+	 */
+	smp_wmb();
+	sb->s_flags |= SB_RDONLY;
+
+	f2fs_stop_gc_thread(sbi);
+	f2fs_stop_discard_thread(sbi);
+}
+
+static void flush_error_work(struct work_struct *work)
+{
+	struct f2fs_sb_info *sbi = container_of(work,
+					struct f2fs_sb_info, s_error_work);
+	int ret;
+
+	if (sb_rdonly(sbi->sb))
+		return;
+
+	f2fs_down_write(&sbi->sb_lock);
+	ret = f2fs_commit_super(sbi, false);
+	f2fs_up_write(&sbi->sb_lock);
+	if (ret)
+		f2fs_err(sbi, "flush_error_work() fails to commit superblock ret:%d", ret);
+}
+
 static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -4256,6 +4363,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		goto free_devices;
 	}
 
+	INIT_WORK(&sbi->s_error_work, flush_error_work);
 	spin_lock_init(&sbi->error_lock);
 	memcpy(sbi->errors, raw_super->s_errors, MAX_F2FS_ERRORS);
 
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
