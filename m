Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13705606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MaM4nPyb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eZ8WztYq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PEpMDjnP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ak/iXPlK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=x36Wwkw93oHX3+Jcd6xW0GQLGOE/ivplqi1GhjPG2PI=; b=MaM4nPybmSSLHT0ayQQCr7nAy7
	cZcD+sCzz4fhtJ9MbHDvFH0zfc9cW75Q8I+mtxqiL+DKi2IA4z9+DiD45R8m1TDyP40ZbECyVidn9
	qoPEgTlGIEys1O1erAgVDASboI0wo4Izjb4iH0Ed/ZfAiRjwZhY8px4H3nQ1XaeqsgvM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTDBI-000000000Oo-2VSY;
	Tue, 17 Nov 2026 07:00:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <huangzheng9869@gmail.com>) id 1xTDBG-000000000Oh-3V4Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 07:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U3P0AtUP4KhdIQUUOen9w3NNVWGFvqPKse8JMMmbPrs=; b=eZ8WztYqkA0pOvKCaeEWbEpzj7
 H21iaVNbEmpxHFpTZLHoWoySz3ewq01mx3ahsngOZ6eDaq3BlwXfuSP1OXOpnR7+tEifEENPPZmTu
 E0quUxLlT4J46Th3kdkOZTqMWB8p/NPCm7nHOxcvhqnBnavb9bomPOZaBiLEwii8DKT8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U3P0AtUP4KhdIQUUOen9w3NNVWGFvqPKse8JMMmbPrs=; b=PEpMDjnPKTH0ZxTqw5NgnlaN+o
 DRtXHeM72Y6UwduMPfan+DtGWGKJrXVzOz6rT5S38gNUQG48bnCNN3QKezvKjDZX7WQMO+MIl2aM5
 +/hoGOTF6QBJb1hoOU8p6nGJmHUSf35Af2dMiuAtb5fr45naUA/W+Rc0eVK4v+NigllU=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTDBG-0000000036f-0KIh
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 07:00:38 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cdb2893531bso3083693a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 23:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794898832; x=1795503632; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U3P0AtUP4KhdIQUUOen9w3NNVWGFvqPKse8JMMmbPrs=;
 b=ak/iXPlKoebqrwHFQDeEVAlTALJY10zfAZh8uMz87+3Q+WUckvirwz4xj4oafBeVQ5
 k1zcurf9u0TYQ40F8ITkifXH9F3FyOaWC2aG9+57bs2vDnAUTn+UIbgqdFC5UXBzzhDs
 QJvdoe2KdSKielFUxv/xqdnK2lqNy7m4ifuZMqvJ+l9FGbaP6uwiiLgz4Z8vOVBtIsyk
 7R8XvXEqxyNfoh3OqEYPSVYCgmfiF5SYbbefbYxLaOFtBux3MzKs4nxT5497k/3q2lnu
 OkWwVWXTAypcQafiw+oPD+2Wyir0HIcK0E/9qFyoTQ3BI5pFFjVR5N4z59t746HNSrzU
 neIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794898832; x=1795503632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U3P0AtUP4KhdIQUUOen9w3NNVWGFvqPKse8JMMmbPrs=;
 b=BOZORh3IwSXdUi85c0FPitj0rU+CuDqhtd9I/KScrJbiN6i9WrSXncMCZM7aAYfiFS
 pLrXfSfkQcfnRii7HpwV7FvJtfbAj1KO5MjrFMZR2nQIOBVylgZhJg1pWw7F8tVWDK0u
 x82a1nSiRWT3+GElUSGs7Pvb+DwM8Wg94ecJx7x/8cdyHFX1c/3J6ZSABiC56Lx30ks2
 tUXpKo9e0slT6XNQqci0bmkRdWT1OMgKU12nXvFaLyyaqIOHs1w/kg269OkFVCpIpGfH
 uTvAeYCLykWKdM1fnnorTRNNdCWOwoouu8Abm+NW59jjikV1xdRUdwC6yDatme1pUucn
 oTkA==
X-Gm-Message-State: APuU4Z95Lv4iKaGYND7czWKAR/YRU/syh4GI9ReLmqfhJoC/DLBATUAS
 zCi+6iHJR9Rlq/zQT1BWdKe+I3zfIpLbwVQZdjQ/E7ABsLBIbQ5Qmu9WVM8irWMi
X-Gm-Gg: AZFdTZcaJ8lJrQOz8YkDIlzQ4hFvK+CyeHa4h6MBHxAFySyldr5nGp4G7oYUI4xs/Ya
 PYBbcT7I3t4XHSqC/FNvQxvmq0UiqfgcsM2LJGq40CuI4tG9N3QK9IT0DevWA2Ym/hGtxKCvMNz
 Ni2G201E9UKBGTzexPdw8uqgbdVt4yGD/ZsTDZC75v6hbdcFHAicKriVjJzlZ92Wur4SEPZj2lU
 XG2b4c6l2cWMKK3aoyf5ToMdNhgEwupX5BVWooQZo/lk88tobVATRvPqqA0mrYBmTwIHC2N65Po
 J7rXdiAgSCWTFTQcM1ebK6b7shOWcxi2OOvBNlvaUerVA0yt9s5Og9nagDYwsGmuTAW+BZt3D9Y
 kU10G7auPNtnKEDILq4z5XUFZYgP/wANcaEx5gZaBbgNKucFIpOO/jjA9Hw+Q7sI7qcRra6Zl6B
 somheVp0WHregexhiLIxyTIic3R/aVvLTuaehbGRidQ1Wa33ZRn5HjuX/a5/77xxVMh+LM00gc/
 6MB6QdcNDfSH6MbkR1UFLzSaRi+iJpUi7HMhgh5tH7XZFOKbeffr+dcE71WwDgDoaCAJi9zffBS
 XwQoBl+fBy8mKdVjgp2rU/2xpttvFf/CSStwPg==
X-Received: by 2002:a17:90b:3c4e:b0:3ae:c413:c07e with SMTP id
 98e67ed59e1d1-3b1b0b667bfmr11646462a91.14.1794898832250; 
 Mon, 16 Nov 2026 23:00:32 -0800 (PST)
Received: from hp.mioffice.cn ([2408:8607:1b00:8:401e:3331:e6b7:ac3a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ac4d98b8sm2492672a91.13.2026.11.16.23.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 23:00:31 -0800 (PST)
From: huang zheng <huangzheng9869@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 17 Nov 2026 15:00:16 +0800
Message-ID: <20261117070016.3457670-1-huangzheng9869@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xTDBG-0000000036f-0KIh
Subject: [f2fs-dev] [PATCH v3] f2fs: add checkpoint step timing statistics
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

v3:
- As `f2fs_stat_lock` depends on `CONFIG_DEBUG_FS`, `check_cp_time` updates stats even when `CONFIG_DEBUG_FS` is disabled. 
  Revise the stat concurrency protection using `stat_lock` resides in `f2fs_sb_info`. 
---
 fs/f2fs/checkpoint.c |  2 ++
 fs/f2fs/debug.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5c5b45d3c67b..bbf8bc9a9f34 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1738,7 +1738,9 @@ static inline void check_cp_time(struct f2fs_sb_info *sbi, struct cp_control *cp
 					cpc->stats.times[CP_TIME_START]);
 
 	if (cur_diff > sb_diff) {
+		spin_lock(&sbi->stat_lock);
 		sbi->cp_stats = cpc->stats;
+		spin_unlock(&sbi->stat_lock);
 		if (cur_diff < CP_LONG_LATENCY_THRESHOLD)
 			return;
 
diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6fe606e2c70d..4fa44eb38bc8 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -445,9 +445,26 @@ static const char *ipu_mode_names[F2FS_IPU_MAX] = {
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
+	struct cp_stats ct;
 	int i = 0, j = 0;
 
 	spin_lock(&f2fs_stat_lock);
@@ -631,6 +648,19 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "  - Total : %4d\n", si->nr_total_ckpt);
 		seq_printf(s, "  - Cur time : %4d(ms)\n", si->cur_ckpt_time);
 		seq_printf(s, "  - Peak time : %4d(ms)\n", si->peak_ckpt_time);
+
+		spin_lock(&sbi->stat_lock);
+		ct = sbi->cp_stats;
+		spin_unlock(&sbi->stat_lock);
+
+		seq_puts(s, "CP steps (longest):\n");
+		seq_printf(s, "  - Total : %llu(ms)\n",
+			   (u64)ktime_ms_delta(ct.times[CP_TIME_END],
+					ct.times[CP_TIME_START]));
+		for (j = 0; j < CP_TIME_MAX - 1; j++)
+			seq_printf(s, "  - %s : %llu(ms)\n", cp_time_names[j + 1],
+				   (u64)ktime_ms_delta(ct.times[j + 1], ct.times[j]));
+
 		seq_printf(s, "GC calls: %d (gc_thread: %d)\n",
 			   si->gc_call_count[BACKGROUND] +
 			   si->gc_call_count[FOREGROUND],
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
