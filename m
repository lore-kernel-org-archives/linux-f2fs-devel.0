Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C14C83F17
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q/sFi7RVeHdizIi97QL5lTQbffTnAm8BMRpdvGnFnYU=; b=XtJp6hKgdEtzMvmjePyIfYZr1N
	Uabi0OKsqOV+BBvigfogq/FlR6SVMP/UzBd98yjg1TQRIt7iGJ9ouZ0G62+XkqG0h5PDV8ixWgkFC
	7g1Tg9B/VcVay1eDURn7H0090LKf4BqinC6E7+ttMlNxG8YI26jOjgr/hDsIboMaPUnA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ugRHI-0000CO-VR;
	Mon, 28 Jul 2025 17:04:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1ugRHG-0000CH-V3
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Jul 2025 17:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lxjc2xR5JFXNirG/cV66jE1QTbUqCpT1C3LCgQSBfqI=; b=CBFET14HMz1NUMW8iaZvofZIRq
 nZMYQ+pAr2dMB0MTZCh48PYSynNPfMMc+YIlrWZGLSLYjZwPnYUfDZhtARmRHwxpSdAKRNOatIe1z
 mQWUeIE1OXXAakyA2ixo5pQl1T5llnBomKP4Y63A4CpbBrwjkvDhcIIGgjXkGYI7UZlc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lxjc2xR5JFXNirG/cV66jE1QTbUqCpT1C3LCgQSBfqI=; b=B
 TYpxee5j4uk3z1F79kdKZ6tyqUWegwV4j5Q9yGc6W9cvZgVGo9itWoLwhvKKqVNKfmLV1nUEAUUOx
 sGHFja6FBC0g9i4nyJ/Xmh/aO8/5ONH7p3Ga/fxg1IA7qmy0zqTnOn1TNd325u6RFyPfPZV5dsBP4
 sofrAhK30KB4Blq0=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ugRHG-0000xU-FX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Jul 2025 17:04:42 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-31e41cfa631so4848431a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 28 Jul 2025 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753722277; x=1754327077; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lxjc2xR5JFXNirG/cV66jE1QTbUqCpT1C3LCgQSBfqI=;
 b=P6W+tC2wsz4LtlKYkThNeMJ9Kwb096xlB68E4bsDKV1SgfEdPcIzEz1vd6JyyBQqFD
 +V1DEfQrv3T1Jhx+t2ZCTuIxWi6PeC9wLOIK78YE4OyIDBTYeJUaPb95aS9owKyqZ1G7
 lxV7VT23yf18L+dl5D+IMh3QgMmkGDKc9XQjtM6L3Dt3b1w0Njmmnx48jmXBrtjReOHq
 0zrnNJ8SJjAl0pFW03e6AkTsd1tuFa0w/S9Z5zkRSXxLd1lwHzUfjQ3FNAKa0ZggqvqV
 CJ4BMPTDZvttxiVZ8XMLPv4dyPNXwStkPW8JskTdA7MU7Ivl8kK1EPtJBiyDjXd9Pon7
 1U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753722277; x=1754327077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxjc2xR5JFXNirG/cV66jE1QTbUqCpT1C3LCgQSBfqI=;
 b=bY50W3QcoOUR+DP2NtF8DMaIPghqp/sTKBUOm9ONR3C4XCsU6UgxDDhcWUDptLo78R
 GWYP3foNzAiei6AiOEUErmp2ZGEe+yFbIiqdeuBNA0RiOH6TaCuVUyhZ1Vs9qscm0yF0
 yQ8OlpvQVYSPNYpGbgYPyZJtucafKo59ehmCesSYUmdpNCPlpg1uwFJJYW888nWjcanL
 En30hply+n3ZvtDNlSXpC5MVNrK3V7aOhcIyn5aRAkGF77GoWaU7DMz5WNkgmjfZ34CZ
 2lq04SS+njahYPhmWNRi52RXsLf61o8XiHapMNBqRPq6zhlVbtblaNtl6sYakiT63jSx
 VGUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkV9zXnwKZ/hzmgYdxBvkuWxFQ3wC3Gbj/FsLT4Y9dxiDsCjJJDVIvpWxiaP4of89pPdsY/K/jVqHmJ+pJuwPe@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwR6EyKXYGprsSfCIMLg0HCAA/5JGfR6R4jnW3gHmROMfOT4cfF
 fGMd8nqRmU/QuZ7Ua8HA7CdgjHNuF6N05PV3KwhKqW3dB4BKi+ZowJNll5zDtQ==
X-Gm-Gg: ASbGncuBTGZPQa7jVxkCcfivn2bt/K3DhFsZKDyqxaTmSV45RX3esquUaJcvrlRoFQc
 rc8MpPluFmnHCRQBSLOqERGKsoqsh+XgZqF4Xk5EB+cN9j8R5c4anGhkKgP0zNueVIA5W68WApU
 4dXtr7ik2xyyNfYwxwBpZYXmMmfy2y187QM9h+YyoMJKszORg77DJn5fv5ZbspP9EudRkssxu6f
 qjacl7KZrIQMImPvyxuxtIm4/UIkhtIJnbafXGxemMqJbcyhKYNb4A2MbtjyoQPXIMD4uFlJvW8
 ma1xZanjDWE/K77ZMH0wTkmKp5fnjTC8LO3Hz7jFbEY9wVXPMFOq0WwiOqE75bTB11KazUt1mBe
 oPWIXa4bLklC3WNgqPu2fdsIAVDaMjiQJvgamo4xF0XeC2IXYvj8I6RrHtyym2Y+/v1H1fIcoYP
 wo/y5H2o3mRekOVGJVhTLLW2ef
X-Google-Smtp-Source: AGHT+IH+ndwT3hlDz5e7HfXxFgSwhqGIuulx/XclPHWpH/Y7XNIFRMhBmBr3mp4Dosq5rVN9owcW3A==
X-Received: by 2002:a17:90b:58ee:b0:31e:1311:2033 with SMTP id
 98e67ed59e1d1-31e77a1a541mr16931818a91.29.1753722276504; 
 Mon, 28 Jul 2025 10:04:36 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:b166:cd51:360c:c503])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e832f8766sm6257912a91.5.2025.07.28.10.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 10:04:36 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon, 28 Jul 2025 10:04:30 -0700
Message-ID: <20250728170430.1060976-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
MIME-Version: 1.0
X-Headers-End: 1ugRHG-0000xU-FX
Subject: [f2fs-dev] [PATCH v3] f2fs: add gc_boost_gc_greedy sysfs node
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

Add this to control GC algorithm for boost GC.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: fix the range check condition
v2: use GC_GREEDY instead of 1
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 6083119851a6..d6881572c53e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -869,3 +869,9 @@ Description:	Set a multiplier for the background GC migration window when F2FS G
 		boosted. The range should be from 1 to the segment count in a section.
 		Default: 5
 
+What:		/sys/fs/f2fs/<disk>/gc_boost_gc_greedy
+Date:		June 2025
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
+		Default: 1
+
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index de7e59bc0906..0d7703e7f9e0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -141,7 +141,7 @@ static int gc_thread_func(void *data)
 					FOREGROUND : BACKGROUND);
 
 		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
-				gc_control.one_time;
+			(gc_control.one_time && gc_th->boost_gc_greedy);
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
@@ -198,6 +198,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
 	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
+	gc_th->boost_gc_greedy = GC_GREEDY;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index efa1968810a0..1a2e7a84b59f 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -69,6 +69,7 @@ struct f2fs_gc_kthread {
 	unsigned int boost_zoned_gc_percent;
 	unsigned int valid_thresh_ratio;
 	unsigned int boost_gc_multiple;
+	unsigned int boost_gc_greedy;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b417b655d4e8..3a52f51ee3c6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -831,6 +831,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_boost_gc_greedy")) {
+		if (t > GC_GREEDY)
+			return -EINVAL;
+		sbi->gc_thread->boost_gc_greedy = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1058,6 +1065,7 @@ GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
 GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
+GC_THREAD_RW_ATTR(gc_boost_gc_greedy, boost_gc_greedy);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1229,6 +1237,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_valid_thresh_ratio),
 	ATTR_LIST(gc_boost_gc_multiple),
+	ATTR_LIST(gc_boost_gc_greedy),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.50.1.487.gc89ff58d15-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
