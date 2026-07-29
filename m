Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E73C53219
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 29 Jul 2026 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=N5zlkGhHUOl16FbsNutFg3TNOMCfOg9/Nop66GlebNY=; b=Yc7MGpmhfTIfp0LbeMIf1RHP4H
	Hndj93jwPEQiDsIe42vZM9HBWNWt6gtARYx/8YCsrWWoqcfwxZLLiJ17iDTZHrC9dJHro2BKZjzdP
	tNucLOluRA2Q3Sh0rZP8zlsKRVRjZ3FK1Rz+Hq9ClMCEGIP3r+7n2qwI6vG9PYoYka6E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wp9sP-00074L-FL;
	Wed, 29 Jul 2026 19:23:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wp9sO-00074E-EP
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 19:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ir8mro0pAa9FSPU6tRbweq5r7VV90UZUh0X/s7tjkNg=; b=LPMWZB7XveDqWYw3lfhXfcICqs
 2ybM2sG1OsQeiYySuaHPsSQpyKD+eD+wQ4PkCDrL99fmtdqbS+0e+b20YAAjaJpUhu/9tS8pXoaM4
 30Nq2vS1Hw1b+oRFJIKirpA/OTuGPthy4Tzr5EEXLNCBpJD+sROfn7JlbeeGTAAJprfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ir8mro0pAa9FSPU6tRbweq5r7VV90UZUh0X/s7tjkNg=; b=j
 bw0hQosmjRWofFR99Mj8c0xxTda46h1J/DvKHVBmNUhhORwTR/eN99NY0v6H/ystP+bGZzj+BZ9RS
 jwEMnL2sA3CrvyK4x4rfB8qE6OW5xLQ3Av7TCP70aWGg2gkEYi1y1NOhucpV2iQpwaXIuJrF4ZIwV
 y3GOUaEYrtR24wbs=;
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp9sL-0000dV-53 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 19:23:33 +0000
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1213547a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785353007; x=1785957807; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ir8mro0pAa9FSPU6tRbweq5r7VV90UZUh0X/s7tjkNg=;
 b=L3+q0ZNUYOtgRI7Q6yISWWG+tqUknOwtTY+iLNkvhjpRRNLZw8/5t4BU+w+z9LDQj8
 x6t6rYtvIzH4veT+qC4P+HA+5nxELqDOxRcMeAMpZPxN+wozAJE5r0xuk17dAMBH6h7G
 NKAFtFn4P5bFTk20gT5LzVkoN1mbFh8gX/xtrsdCeYsn/yUMVH03zP32oBgBLEm/eJ3t
 m0SODh6gubcJPqAAzP2lJDON7r8tMfk6sMoxOGlqyuyzR/ij5M/3FDw1atiuSLGhrkWI
 9LYH6lnhVf8hogvT22ZGygTjVimbTxrOBte9RuV97cv5mprpXS4VTQxWrdqzcA5YAdJL
 OGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785353007; x=1785957807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ir8mro0pAa9FSPU6tRbweq5r7VV90UZUh0X/s7tjkNg=;
 b=tLMCpZLM7l76c8dBIfGHim6bZQxq7eTuAIXZhevoGtKUo5Oc3BddhcuxGIzJW6j19e
 5SNpyrcTaVpEDhjsYppCX3g0xVFDCMIVihkjRVeTw5jrq8fxJCDLtkxB1cGm7GHR3Bec
 Cnr/qGJAMBFwUPbXPXPnxvrPtDZilBkwm4Aj7lYxmHaejMHjInxAHCw+XT08xZpCVdBr
 DOXnVnoh9zpsm0kw7NMhs9ZsPyaDbRIw5JFnIuxN8rpno1Yw4gvdON+h1SoF7ox4ceyI
 L10AZo7mmxTB+ogozYZ4ZYWjWkNHswFfp5oKmagvwd8JkHrDb/jRQXpEz0679jFsOWWQ
 E8nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxAqDAZhajAaXJA9BTiXYfyyBYAIvOSZc2l8D20lwYSe8xuA4VQkXmuzOWRKUJgpPwMjRYSwJNimKjgGKlG3rM@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzhzljBARgRoAU1lOSZsU1xtwgbHZrsFCzXtKuQ6F2KUCDRxKIF
 55LOer5R29AwqKKn3wAg09Pnx0iJQBmnsSZNLLnPWpNqEUSSoxZQTqqER1dLpQ==
X-Gm-Gg: AR+sD112vC/DLDa9RCdPQEoKD6ahVwLLw2oIyBevMuuO7ewiGTNJDUVu88oeNkAWHxt
 Q/TZtyJlfSs6lRCm8Ka6Oz/njq+eLgs0JqDQsocBuVgBO+NWGN9wfKvKEfmNrcss/nzUDwp4o0y
 UKYnu32ksfJE7tfhIEG3BUByFmyhTzQ4EpQrPX7NquUgiYLloQIogCjISfl5xW86XqsQ0ErHiMB
 YRk/ccBcATXs4r6zhU+T7GbUejatjEB9WVNdWxoUePLiL+ckUuw/NlBozZQx6Cc9m3Phhctf9L1
 9qDLTJOmjx+4XzK6JfkYKAUORl3Zf8zyZHXZRbsP0GJu+CaD6EfgQt7RGlSp5R48JYpj8EwzpZf
 Y7GC5bFoZ5w6zNOTpIqrEZPT2lQ3MPyqEw7DRy6bdJvZd4EUmn/MntEo0uia0TPpqaUoI2WB8qI
 eiRpeGzy34CnoO/MtEFj+pYkiv5ocaGmcJqPtPytxACoGpeLjCLOtlLVNtR8fzcGtXVvIcjTsMi
 5GyDtINJIEVxyydFVn8ByKTVvC/3RHpAdaQxyGHrqPGxkgW+DqY8WccCfdr2XUKdEBHXVnyt+x5
 pmwT5arymdF1
X-Received: by 2002:a05:6a21:6b87:b0:3c0:9c1b:d0b4 with SMTP id
 adf61e73a8af0-3c8ba62710amr9029686637.63.1785353007265; 
 Wed, 29 Jul 2026 12:23:27 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:b81d:6d68:981d:e404])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7263cfd9sm17761715c88.4.2026.07.29.12.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 12:23:23 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 29 Jul 2026 12:23:19 -0700
Message-ID: <20260729192319.4051409-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
MIME-Version: 1.0
X-Headers-End: 1wp9sL-0000dV-53
Subject: [f2fs-dev] [PATCH] f2fs: quiesce background threads during system
 suspend using PM notifier
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

During system suspend, a race condition can cause f2fs_gc and f2fs_discard
threads to call submit_bio() while the underlying block device (e.g., UFS)
is in Runtime PM suspend. Because Runtime PM worker threads are already
frozen during task freezing, the threads become trapped in
__bio_queue_enter() waiting on mq_freeze_wq, leading to a PM freezer
timeout.

To prevent this deadlock, register a PM notifier to set SBI_IS_SUSPENDING
during PM_SUSPEND_PREPARE. Background GC and discard threads check this
flag and immediately stop issuing new bios, allowing them to enter a
freezable sleep state cleanly before process freezing begins.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/f2fs.h    |  3 +++
 fs/f2fs/gc.c      | 13 ++++++++-----
 fs/f2fs/segment.c | 13 +++++++++----
 fs/f2fs/super.c   | 25 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f24e30bb5c3d..c46bf4df9412 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -25,6 +25,7 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <linux/rw_hint.h>
+#include <linux/suspend.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -1494,6 +1495,7 @@ enum {
 	SBI_IS_FREEZING,			/* freezefs is in process */
 	SBI_IS_WRITABLE,			/* remove ro mountoption transiently */
 	SBI_ENABLE_CHECKPOINT,			/* indicate it's during f2fs_enable_checkpoint() */
+	SBI_IS_SUSPENDING,			/* system suspend is in progress */
 	MAX_SBI_FLAG,
 };
 
@@ -1757,6 +1759,7 @@ struct f2fs_sb_info {
 	struct f2fs_rwsem sb_lock;		/* lock for raw super block */
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
+	struct notifier_block pm_nb;		/* for PM notifier */
 	struct mutex writepages;		/* mutex for writepages() */
 
 #ifdef CONFIG_BLK_DEV_ZONED
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 93bcb35a5b5d..86b2b29402a5 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -71,7 +71,8 @@ static int gc_thread_func(void *data)
 		if (kthread_should_stop())
 			break;
 
-		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
+		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE ||
+			is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			stat_other_skip_bggc_count(sbi);
 			continue;
@@ -1064,8 +1065,9 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 		struct node_info ni;
 		int err;
 
-		/* stop BG_GC if there is not enough free sections. */
-		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
+		/* stop BG_GC if there is not enough free sections or suspending. */
+		if (gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
+					is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
@@ -1611,7 +1613,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 * Or, stop GC if the segment becomes fully valid caused by
 		 * race condition along with SSR block allocation.
 		 */
-		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
+		if ((gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
+					is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))) ||
 			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
 							CAP_BLKS_PER_SEC(sbi)))
 			return submitted;
@@ -2015,7 +2018,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 retry:
-	if (unlikely(freezing(current))) {
+	if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)) {
 		ret = 0;
 		goto stop;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d70dc5ef3de4..e27197953356 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1300,7 +1300,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (dc->state != D_PREP)
 		return 0;
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
+		is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))
 		return 0;
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -1341,6 +1342,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		unsigned long flags;
 		bool last = true;
 
+		if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))
+			break;
+
 		if (len > max_discard_blocks) {
 			len = max_discard_blocks;
 			last = false;
@@ -1615,7 +1619,7 @@ static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		if (dc->state != D_PREP)
 			goto next;
 
-		if (*issued > 0 && unlikely(freezing(current)))
+		if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING))
 			break;
 
 		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
@@ -1688,7 +1692,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-			if (issued > 0 && unlikely(freezing(current))) {
+			if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING)) {
 				suspended = true;
 				break;
 			}
@@ -1955,7 +1959,8 @@ static int issue_discard_thread(void *data)
 			continue;
 		if (kthread_should_stop())
 			return 0;
-		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
+		if (is_sbi_flag_set(sbi, SBI_IS_SUSPENDING) ||
+			is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
 			!atomic_read(&dcc->discard_cmd_cnt)) {
 			wait_ms = dpolicy.max_interval;
 			continue;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d5dc83e613e2..536f3ffe5354 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1979,6 +1979,26 @@ static void destroy_device_list(struct f2fs_sb_info *sbi)
 	kvfree(sbi->devs);
 }
 
+static int f2fs_pm_notifier(struct notifier_block *nb,
+			    unsigned long action, void *ptr)
+{
+	struct f2fs_sb_info *sbi = container_of(nb, struct f2fs_sb_info, pm_nb);
+
+	switch (action) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		set_sbi_flag(sbi, SBI_IS_SUSPENDING);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+	case PM_POST_RESTORE:
+		clear_sbi_flag(sbi, SBI_IS_SUSPENDING);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 static void f2fs_put_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -1986,6 +2006,8 @@ static void f2fs_put_super(struct super_block *sb)
 	int err = 0;
 	bool done;
 
+	unregister_pm_notifier(&sbi->pm_nb);
+
 	/* unregister procfs/sysfs entries in advance to avoid race case */
 	f2fs_unregister_sysfs(sbi);
 
@@ -5472,6 +5494,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	f2fs_restore_device_alias(sbi);
 
+	sbi->pm_nb.notifier_call = f2fs_pm_notifier;
+	register_pm_notifier(&sbi->pm_nb);
+
 	sbi->umount_lock_holder = NULL;
 	return 0;
 
-- 
2.55.0.571.g244d577d93-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
