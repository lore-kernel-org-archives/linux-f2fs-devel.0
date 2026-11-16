Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017E7606A329
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JqZ6cpVU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zyhy+qSY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AQOuJIz/;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AB2n4rsJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=Z8hQn5yM4ilrrvrhryWZtaeBmCnwiUas2RiFG9HK++E=; b=JqZ6cpVUKpH8sGJ/1gBnwBPEh9
	7HcXofKaxeq+u22DKzMXoSklYxIShqpO/1DreDbvwLwu6P9aRtYZxEMFDWbKJ5x2YySSkk2caY/4d
	5uuxONrSxpVtcnXhZSzLOFxFY1SMWx0ZPsXRwEg3LYRtOjBKeYQoUu6zZkJIz40db3Is=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xStM9-0000000078E-28QD;
	Mon, 16 Nov 2026 09:50:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <huangzheng9869@gmail.com>) id 1xStM6-00000000785-3JTK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C5A0lqtK+Mtifsjo6m0FKzz+TIKe/pUlM6bIYuB14yE=; b=Zyhy+qSYn7Zswx6clwbKZFEogT
 blNeixFWHKmVIsLzLEoqmBRy/J6MYWefo/blAkN5xMm3bMw53ams0FOTnzvoy5GsOm2IiP+xL3vdU
 nXw7JLClUbmUAFs6EOokX1/1hBNTwg3MBdUPJchgOgfsslbTCHjukSFZVxg4BH0ypjh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C5A0lqtK+Mtifsjo6m0FKzz+TIKe/pUlM6bIYuB14yE=; b=AQOuJIz//3AVG0cKue/esFN/s/
 A8BLky+VRVe+LFGjLicmmFtQsjJu3VPgke3pIzZxVmnZa7oO8T37oM3rzKgMfVvbjAZEMdi3s2Ilg
 +oha94kXDC52vmm5E7c8fes1U5oO3138Og0Bx++J4BqqJivPlJ0EYeXGy3GH3O3IdrEY=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xStM5-000000008TY-1gx5
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:50:30 +0000
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso1711399a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794822624; x=1795427424; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C5A0lqtK+Mtifsjo6m0FKzz+TIKe/pUlM6bIYuB14yE=;
 b=AB2n4rsJkNNRR6SLLZQiatucNxOWS1PkjnC+c6cM/cvZWWygCJ/4MkrKe+0kfYTsCJ
 IXqnLsaeOYnEV306rlEQBO5EALln2N4OQVFhIUSSJeq6v4Sprbpk7c+E9vy7p74dqmUI
 k5vZ1GEicjAHN/UYCX8kE3IyatndKYtyEth2M2MaG/XwMp79xbRRrUcg7UMQNB8DUXIF
 vg79xb4rtdhTNEZQQ8cgtlHOhV/rn/W3LW+d4mGqQKsCQOaW/j0S7j02SpKrXqoZg987
 g+YOjQVyVCnJ0YVi2C6J1R/3SJRqiha7gKLgm19QkmlyOAJRc0qGtFN9kwu8tvQYjKVM
 dK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794822624; x=1795427424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C5A0lqtK+Mtifsjo6m0FKzz+TIKe/pUlM6bIYuB14yE=;
 b=ZCxyQcozhpE1Lgf2rlZ+5AHLVIA5ZV3hzh/O54bOQZEuuMTMleta7R680/DMjVPsOA
 lPjxaVN3RI9G4nAISatl2XaULT+0z2NyQkA4K8GcIn5J1aX3XV4Un41Yvk5STerBmmno
 S/reO414fXxJFOvcGFIsiaDZhvaMdAKKRj/mQkBz5139zKIboUCU98iqKV3/aY8KVCmm
 fxwb9751hJ1ljEp3BfWS213QJqXdIxBJ5Ln7XP+GSRamiOG8yG3YzP5tRgrppUKA/1Ng
 EhVSrNHkts+UaIC7XhM/bBpjGViQH8qknTq+3hzlbtbhtCDvvbNO/PRtnDVTPhBaxd6+
 pUuA==
X-Gm-Message-State: APuU4Z/EpnyC6qroO2hTaNyCSIRYwZZobNaryscrqhaYl+G5g1LCOmMt
 31RUS3a/V+SMQXW63GKxaVcsUW5+CyKvgF+Gb0CUK/xLh4WVwImPJFiF
X-Gm-Gg: AZFdTZdOAohCwksj5AY+IVsvznOPLNa8H/CG9HT184MgBZ8Z/j+xkM0Uro3i504H526
 W2BGCWCZB2UPOJ89nFPgQSXB6TpX7uaM5bPvLYz0akmd2RzC4Z1NA95UwT+wIOhvLybQ/cTYg1L
 T229YSN91YhbJc5mcNqSA7cHlkiJqfeKEaLGjF3WvJYFnZzEPKl0FIgc2PKhoaBi7aNBZhn1WEt
 bT4GJk7s38CKIfHLiLDKOMbOXabtg9LY+5yPopISVW4Qcd18XmURMR2KmRAiVVyELeVG0FPqbCa
 ywxx+BIPzL3pqJI9cv6v9P5J/YMrzVMYJ1MnlAMDDJ7ZKhkaGsbiaihCKNnsGC8F5IVFYliGZdr
 WDxrYXuVPPggLd9AEU93wnDvvRJwHYq8ElqFCsRGP1sEKwW9rJWpxtF25UIdLFyJEvURt+pA710
 4EfR4BRPOVcaZqOPxbB2yY/LAUnhfXDsUuIT45UhHh3tExzESTNzSp3OLIdRRCbr+0zwfxZhJO+
 HTnPcPX9dvJ1TuMHNa8KHYKgNbWlytl1t4HKBsCpFsnpn/lM2i+sKJmoa7qkMOMJ3WdRnZZutm9
 BejpQ157zeCbssiMI0oRJcydcWlrK86Smsc=
X-Received: by 2002:a17:90b:3d87:b0:3ac:9259:122c with SMTP id
 98e67ed59e1d1-3b1b0a3956bmr9566639a91.40.1794822623621; 
 Mon, 16 Nov 2026 01:50:23 -0800 (PST)
Received: from hp.mioffice.cn ([2408:8607:1b00:8:398c:7f:ef48:2423])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b2133c5dsm7830877a91.0.2026.11.16.01.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:50:23 -0800 (PST)
From: huang zheng <huangzheng9869@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 16 Nov 2026 17:50:11 +0800
Message-ID: <20261116095011.2868219-1-huangzheng9869@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xStM5-000000008TY-1gx5
Subject: [f2fs-dev] [PATCH v2] f2fs: add checkpoint step timing statistics
 to debugfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Huang Zheng <huangzheng9869@gmail.com>, huangzheng1@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Huang Zheng <huangzheng9869@gmail.com>

This patch adds detailed timing statistics for each checkpoint step
to the debugfs stat_show interface. It displays the time taken by
each phase of the checkpoint process, including:

- lock acquisition
- block operations
- flushing data/node/meta pages
- flushing NAT/SIT
- syncing metadata
- waiting for dirty meta/checkpoint data
- device flushing
- waiting for last checkpoint

This information is valuable for debugging checkpoint performance
issues and identifying which steps are taking the most time during
the checkpoint process.

The statistics show the longest recorded time for each step, helping
developers and users understand where checkpoint bottlenecks occur.

Signed-off-by: Huang Zheng <huangzheng1@xiaomi.com>
---
v2:
- Use the global lock f2fs_stat_lock to keep statistics consistent 
when updating cp stat data in the super block
- The qualify test result as follow:

#cat /sys/kernel/debug/f2fs/status

CP steps (longest):
  - Total : 524(ms)
  - lock : 0(ms)
  - block_operation : 13(ms)
  - flush_data_node_meta : 0(ms)
  - flush_nat : 93(ms)
  - flush_sit : 56(ms)
  - sync_meta : 32(ms)
  - sync_cp_meta : 0(ms)
  - wait_dirty_meta : 0(ms)
  - wait_cp_data : 0(ms)
  - flush_device : 0(ms)
  - wait_last_cp : 0(ms)
  - unblock_operation : 327(ms)

---
 fs/f2fs/checkpoint.c |  2 +-
 fs/f2fs/debug.c      | 31 +++++++++++++++++++++++++++++++
 fs/f2fs/f2fs.h       |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5c5b45d3c67b..b407adb9bf18 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1738,7 +1738,7 @@ static inline void check_cp_time(struct f2fs_sb_info *sbi, struct cp_control *cp
 					cpc->stats.times[CP_TIME_START]);
 
 	if (cur_diff > sb_diff) {
-		sbi->cp_stats = cpc->stats;
+		update_cp_stats(sbi, cpc);
 		if (cur_diff < CP_LONG_LATENCY_THRESHOLD)
 			return;
 
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6fe606e2c70d..7ff124784c1b 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -414,6 +414,13 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 #endif
 }
 
+void update_cp_stats(struct f2fs_sb_info *sbi, struct cp_control *cpc)
+{
+	spin_lock(&f2fs_stat_lock);
+	sbi->cp_stats = cpc->stats;
+	spin_unlock(&f2fs_stat_lock);
+}
+
 static const char *s_flag[MAX_SBI_FLAG] = {
 	[SBI_IS_DIRTY]		= "fs_dirty",
 	[SBI_IS_CLOSE]		= "closing",
@@ -445,6 +452,22 @@ static const char *ipu_mode_names[F2FS_IPU_MAX] = {
 	[F2FS_IPU_HONOR_OPU_WRITE]	= "HONOR_OPU_WRITE",
 };
 
+static const char *cp_time_names[CP_TIME_MAX] = {
+	[CP_TIME_START]		= "begin",
+	[CP_TIME_LOCK]		= "lock",
+	[CP_TIME_OP_LOCK]	= "block_operation",
+	[CP_TIME_MERGE_WRITE]	= "flush_data_node_meta",
+	[CP_TIME_FLUSH_NAT]	= "flush_nat",
+	[CP_TIME_FLUSH_SIT]	= "flush_sit",
+	[CP_TIME_SYNC_META]	= "sync_meta",
+	[CP_TIME_SYNC_CP_META]	= "sync_cp_meta",
+	[CP_TIME_WAIT_DIRTY_META] = "wait_dirty_meta",
+	[CP_TIME_WAIT_CP_DATA]	= "wait_cp_data",
+	[CP_TIME_FLUSH_DEVICE]	= "flush_device",
+	[CP_TIME_WAIT_LAST_CP]	= "wait_last_cp",
+	[CP_TIME_END]		= "unblock_operation",
+};
+
 static int stat_show(struct seq_file *s, void *v)
 {
 	struct f2fs_stat_info *si;
@@ -631,6 +654,14 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Total : %4d\n", si->nr_total_ckpt);
 		seq_printf(s, "  - Cur time : %4d(ms)\n", si->cur_ckpt_time);
 		seq_printf(s, "  - Peak time : %4d(ms)\n", si->peak_ckpt_time);
+		seq_puts(s, "CP steps (longest):\n");
+		seq_printf(s, "  - Total : %llu(ms)\n",
+			   (u64)ktime_ms_delta(sbi->cp_stats.times[CP_TIME_END],
+					sbi->cp_stats.times[CP_TIME_START]));
+		for (j = 0; j < CP_TIME_MAX - 1; j++)
+			seq_printf(s, "  - %s : %llu(ms)\n", cp_time_names[j + 1],
+				   (u64)ktime_ms_delta(sbi->cp_stats.times[j + 1],
+					sbi->cp_stats.times[j]));
 		seq_printf(s, "GC calls: %d (gc_thread: %d)\n",
 			   si->gc_call_count[BACKGROUND] +
 			   si->gc_call_count[FOREGROUND],
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f7423b3f6e4a..0f1255ff93d5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4642,6 +4642,7 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
 void __init f2fs_create_root_stats(void);
 void f2fs_destroy_root_stats(void);
 void f2fs_update_sit_info(struct f2fs_sb_info *sbi);
+void update_cp_stats(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 #else
 #define stat_inc_cp_call_count(sbi, foreground)		do { } while (0)
 #define stat_inc_cp_count(sbi)				do { } while (0)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
