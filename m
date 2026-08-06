Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E289BC56208
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WcBfKc302VV2gE6kAGG9TdbH+5lQMfcIdWue7IGM1nM=; b=QpPibNCBLm8d2Zl2qjXogWFFZC
	KhVPGE2iphuSAvy+5UjUAyBvklRMNEqrZRsxU1vCyFtMKFYL/ix341pEu1l6508vcIU4w0Fr4Wimd
	9grqBOiRNY45ZHYHeE0xiPkrZfpN4R5KQgvHLzkzE5wuaIOGIJJnuazzwtrr4BYCdguE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ws1T9-00015V-8v;
	Thu, 06 Aug 2026 17:01:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1ws1T7-00015O-IO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 17:01:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L0SMwlBFnyx74CBd/tXEFrEAcxTvSO7TVd4l/vFfe8k=; b=DQaj5JTiMbE1Oq/yFC2R3pQWri
 nySGsdc0T+iHjsnG6/HBzhCfMoGcB1xOBo8HxCnnqba0msbLQ+99+IeS4DtaivTt7MdIk55pIps2Q
 bwsMXA4m7Ro1axKCSu4nkACTDVfQHlLf0nlO8q1OZZGFg0LOsNXCdpTFuMjmIziCoFUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=L0SMwlBFnyx74CBd/tXEFrEAcxTvSO7TVd4l/vFfe8k=; b=O
 6ONyHJjBSWJ5b7zwR25sJ3hYdWaar0+P419Chje2tWiLMNr5B3XSv0v9gSatjNUnNp1kDAvqikeNe
 scB2fZIdl8VzhZYIJ2zqS2+d+Y4fBR0gOeAmQ+lGV/vcOLyghbrVZ0rljnnYZMdbrD1E/s3b1/MsL
 W+AhQOYG9vVMvotw=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ws1T5-0004IA-NO for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 17:01:22 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2d004f135b1so30405475ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786035674; x=1786640474; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=L0SMwlBFnyx74CBd/tXEFrEAcxTvSO7TVd4l/vFfe8k=;
 b=TEGaHnN16S1qc7ADgq/D+0uddP3c8W0wryuy8AZaurxT5pckzPb/PSkERKPEDqv9sJ
 2/TAne4N4GfbtOXuqx+/RSBGWx4EFkUiym8Ot+ulCCEBFVPo3mldPZjy7TDZBIHVK6Iu
 pu9awjDEEfabtMJFPYNGyAOwU44j2Ij8i4aD/qx3KaP55E7JBjXaDMJ8ep5uU+cz/NnR
 L7Prr8+ueg1MpWtlpCd3nkVxTJOcbj7gn47A00xkIXl+0G7eIxm9F1UxgsLrq6rXGUBB
 KjBCfCc7CAuIHYxZsXkLJto3GnogbiGqF1vPUMVtJqOdSwkjjN92VtCv+V9r+nXC+c2P
 OuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035674; x=1786640474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L0SMwlBFnyx74CBd/tXEFrEAcxTvSO7TVd4l/vFfe8k=;
 b=fdDVBvzZkwgIKuqgL/c5paY/gwD6tRUngxuEpcm9VfpXZv02xeFDmKu8IK90QRUQ6M
 38YkLjKsCnC2f3lLiQEwL10U3PiIxwRJatVD7YxA8KHRLvBhOpFQlehejTQfPZRntwH8
 V1rDmDt6kIH2VlCNRc6vQoWb+iFjy7dG4q5KmgS+cDHzYtiKlWGAUjBbnrnYX2OsfwzL
 b3wVEP57r6S0p2lRNyAyPQfaaNhbYMCXZ4KzuqgO+scO/iTzNdG0kHyD8upSJ2fxLrGA
 mlh3guqkr/R4i69AutUzFnJblleSqzso4nKEJW3gtxznVUdC5eN2Aiwp5bQMp3E3AGgs
 GtxQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbCCyIGOaWVxWFGK46HiFjZwjKv2l5hamFcGAUZzSf0W/dzvid/QvdPugkGKKvkieYGUvazY2z/TubC0L8Wpb1@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyoHi+TAzITzPngZCjROGHbVbKGJ4E6+cI0RUcPzbaeM0Gm5ejg
 xzcbI+ct8TSosY5QdNsrKZhduRBURPvLgLoyvuDlCxianhphqL/8o+r/
X-Gm-Gg: AR+sD113TFmS9NPafHWDhE38foLgpOksvtTjLHe98xmLmZu3FPTaP8GATu8x4eIIWbl
 lXqYlPHKt4DAmu1HG/NG7STeEj3S1Yf5RSutBplz6nImfT32ikGbHDHToACq0SAcDTIx9nz2lgk
 IDUAhV+E+3X+xRjOsvd87B9LgZRwtMMmxj07anIvHTUUHKxEPXKWDtLoAqB1EWpNelusYU4hzYC
 3wIUTs0eFZwpvy4ps8h+6fpEaZUfh0ta5/SCICvZME68yJZ+vDbnXr4rUSUmZv5MFVNSpc/SRRD
 qhnMJn5Z+Uy3avMWGah8Vo/cfvTCzxTuAqBUwz8eiQOTJvsL6wFkhKjSNsrIG27E5IHA6PdVyGy
 UlI1o9wh5q+UnDxJ8re8+PbATwR4Q5Gr21GoNjfIGwx9pdadAGyjVYC1M49h19lheq8lYd1kGh6
 BsMCEqrVUP7EVHLJTrtLtlcB60AKdzXdPYCJ4nLzlFF0No0gxqFQlmBjaNYKu0R7wEgReDiB5Q5
 ab5wh8bFKbmnDs7voI31zF+A6MO7N/9+jsl3A5L0v6stitsNA7FaB/DIaDS3IEPSfY1HJUlGQYh
 a6EXSXKatGarDF9uglqCSUs=
X-Received: by 2002:a05:6a21:3a82:b0:3c3:704d:57c4 with SMTP id
 adf61e73a8af0-3cb85ded954mr20531218637.12.1786035673609; 
 Thu, 06 Aug 2026 10:01:13 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:40a2:8f83:8b73:662d])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3158673be99sm47751776eec.15.2026.08.06.10.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 10:01:12 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu,  6 Aug 2026 10:01:08 -0700
Message-ID: <20260806170108.2100312-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1ws1T5-0004IA-NO
Subject: [f2fs-dev] [PATCH v2] f2fs: quiesce background threads during
 system suspend using PM notifier
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

In addition, check freezing() as a fast path to stop issuing new I/O
when non-PM freezing (e.g. dm-snapshot or cgroup freezer) is requested.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: check freezing() together for non-PM freezing.
---
 fs/f2fs/f2fs.h    |  9 +++++++++
 fs/f2fs/gc.c      | 13 ++++++++-----
 fs/f2fs/segment.c | 12 ++++++++----
 fs/f2fs/super.c   | 25 +++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f1774d4e18d2..2a7b0fe8419b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -25,6 +25,7 @@
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
 #include <linux/rw_hint.h>
+#include <linux/suspend.h>
 
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
@@ -1492,6 +1493,7 @@ enum {
 	SBI_IS_FREEZING,			/* freezefs is in process */
 	SBI_IS_WRITABLE,			/* remove ro mountoption transiently */
 	SBI_ENABLE_CHECKPOINT,			/* indicate it's during f2fs_enable_checkpoint() */
+	SBI_IS_SUSPENDING,			/* system suspend is in progress */
 	MAX_SBI_FLAG,
 };
 
@@ -1755,6 +1757,7 @@ struct f2fs_sb_info {
 	struct f2fs_rwsem sb_lock;		/* lock for raw super block */
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
+	struct notifier_block pm_nb;		/* for PM notifier */
 	struct mutex writepages;		/* mutex for writepages() */
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -2309,6 +2312,12 @@ static inline void clear_sbi_flag(struct f2fs_sb_info *sbi, unsigned int type)
 	clear_bit(type, &sbi->s_flag);
 }
 
+static inline bool f2fs_is_suspending(struct f2fs_sb_info *sbi)
+{
+	return is_sbi_flag_set(sbi, SBI_IS_SUSPENDING) ||
+				unlikely(freezing(current));
+}
+
 static inline unsigned long long cur_cp_version(struct f2fs_checkpoint *cp)
 {
 	return le64_to_cpu(cp->checkpoint_ver);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ffaa7ba76a1b..6c7ea38eb70d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -71,7 +71,8 @@ static int gc_thread_func(void *data)
 		if (kthread_should_stop())
 			break;
 
-		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE) {
+		if (sbi->sb->s_writers.frozen >= SB_FREEZE_WRITE ||
+			f2fs_is_suspending(sbi)) {
 			increase_sleep_time(gc_th, &wait_ms);
 			stat_other_skip_bggc_count(sbi);
 			continue;
@@ -1064,8 +1065,9 @@ static int gc_node_segment(struct f2fs_sb_info *sbi,
 		struct node_info ni;
 		int err;
 
-		/* stop BG_GC if there is not enough free sections. */
-		if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0))
+		/* stop BG_GC if there is not enough free sections or suspending/freezing. */
+		if (gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
+					f2fs_is_suspending(sbi)))
 			return submitted;
 
 		if (check_valid_map(sbi, segno, off) == 0)
@@ -1611,7 +1613,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		 * Or, stop GC if the segment becomes fully valid caused by
 		 * race condition along with SSR block allocation.
 		 */
-		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
+		if ((gc_type == BG_GC && (has_not_enough_free_secs(sbi, 0, 0) ||
+					f2fs_is_suspending(sbi))) ||
 			(!force_migrate && get_valid_blocks(sbi, segno, true) ==
 							CAP_BLKS_PER_SEC(sbi)))
 			return submitted;
@@ -2015,7 +2018,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 		goto stop;
 	}
 retry:
-	if (unlikely(freezing(current))) {
+	if (f2fs_is_suspending(sbi)) {
 		ret = 0;
 		goto stop;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index d71ddb3ee918..7b03b3d06161 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1300,7 +1300,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 	if (dc->state != D_PREP)
 		return 0;
 
-	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK))
+	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_is_suspending(sbi))
 		return 0;
 
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -1341,6 +1341,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
 		unsigned long flags;
 		bool last = true;
 
+		if (f2fs_is_suspending(sbi))
+			break;
+
 		if (len > max_discard_blocks) {
 			len = max_discard_blocks;
 			last = false;
@@ -1615,7 +1618,7 @@ static void __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
 		if (dc->state != D_PREP)
 			goto next;
 
-		if (*issued > 0 && unlikely(freezing(current)))
+		if (f2fs_is_suspending(sbi))
 			break;
 
 		if (dpolicy->io_aware && !is_idle(sbi, DISCARD_TIME)) {
@@ -1688,7 +1691,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-			if (issued > 0 && unlikely(freezing(current))) {
+			if (f2fs_is_suspending(sbi)) {
 				suspended = true;
 				break;
 			}
@@ -1955,7 +1958,8 @@ static int issue_discard_thread(void *data)
 			continue;
 		if (kthread_should_stop())
 			return 0;
-		if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
+		if (f2fs_is_suspending(sbi) ||
+			is_sbi_flag_set(sbi, SBI_NEED_FSCK) ||
 			!atomic_read(&dcc->discard_cmd_cnt)) {
 			wait_ms = dpolicy.max_interval;
 			continue;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c448d992ff2a..8c97b5d1ee68 100644
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
 
@@ -5436,6 +5458,9 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
 	f2fs_update_time(sbi, REQ_TIME);
 	clear_sbi_flag(sbi, SBI_CP_DISABLED_QUICK);
 
+	sbi->pm_nb.notifier_call = f2fs_pm_notifier;
+	register_pm_notifier(&sbi->pm_nb);
+
 	sbi->umount_lock_holder = NULL;
 	return 0;
 
-- 
2.55.0.654.g21b8a5bc05-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
