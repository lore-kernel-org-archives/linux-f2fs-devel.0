Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AD606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h4zNNHeR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WYt8dYoK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B+5zSJI1;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TuBqHl5C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=cL1hc4ncyQs+6oSnd8Qxeazi4wXTMVzGJtpRmqyKW2Y=; b=h4zNNHeRmcLg89hrjd/9JujZV6
	C1evYcLVSuGSJTuhucKMfNF2tm7KBtpjcEQ+qZ7plA5dYiIIECn2TOjrqAJTKHOPo1Cpbmb7KxQcq
	vks/I6ZQN1lNyaXbHwiZYSNPOtl3P6d0DTC5zeH9fEYAElRBuKlE+vYEW1gmXfPMZ/18=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOAZJ-000000005Kh-0Rci;
	Tue, 03 Nov 2026 09:12:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <huangzheng9869@gmail.com>) id 1xOAZI-000000005Kb-17ME
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x08pBy7JHzFk3zdtUYyZqQMUJl2jZCPGbCAQOF9eG6U=; b=WYt8dYoKqexFUUbrHNrbdH2j12
 TsHRVcKqjhAtdxRn3Hxpr2cz4XtTSkF6ncGFuL4e4+noTsDPJcuzYtqnZ0Ib3Xm6It9lF5e7dPbpY
 NPiEowJD3qMK92ktK+1Ban+MAPm+2RzU2TSIQJ6cJQ9BalLapSFqHAR/+IAAvs+JZlCM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x08pBy7JHzFk3zdtUYyZqQMUJl2jZCPGbCAQOF9eG6U=; b=B+5zSJI1ibsTmwjASjNTTAWxaO
 NkBVixSr29KlKzn4rorF12wB6gId+3A0FPDL2gwKXyMqDOi7qTQFELeCzGijn1HIFHYGAWqEaV95j
 QJwy/0pAfBE7mTqzgGyOrZNwfvZeMKNG0yL8K8z84Uxr/R/D3mdo/CfdGuWJpiErL1Lg=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOAZF-000000006uW-1z4P
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:12:36 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso23833015ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 01:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793697148; x=1794301948; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=x08pBy7JHzFk3zdtUYyZqQMUJl2jZCPGbCAQOF9eG6U=;
 b=TuBqHl5Cu7/fz8ZlToT7lXw0H/GmWO3wazurO+KcgDvpICLXSDxqg3Y9G+hsOR7iXw
 XAiOuX3t1rgmJ3t+X09NxeYED701ign79AFEHWdQBcqQKfic8iiyccO4fKAqeqj/dj6E
 3FaRbVLjo/3VL7VZXD9aVLjX68ggXZxG0N62WG14rDluaIRHKh/BP5RzZrjhW68JxGVD
 oFrIcgdB9YytXNvjsLsOpVqNIsR62n3xBwA4igrwaz7212DIgUEC/0xqC1GLz8hk6xkf
 Yh7t0KGGjbtnVMd6ONqxec9ICWOOve2YMwqcQeePR1UBPS5O/xVfFn2qOm+1fMnbN2n/
 klCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793697148; x=1794301948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x08pBy7JHzFk3zdtUYyZqQMUJl2jZCPGbCAQOF9eG6U=;
 b=PC0ItTnkbG+/VjdTRVmf33qHEPOCE+DHE/DO651sqqHPN/i21gSR9/+DMsIE+QOv4N
 lk83KS2BqQPzEv2h0AuPttpdOZNUDC/7b7tr0RYeYZBpsKqAfPqnWDOw5ntOfNeu37aL
 7OWi4HlhwER/2hjWG49UlMHshV8Ski5I8pQZM5ZKln1a6Y/xnauNPGDM+sZqLIFCr48T
 VrTYRsNbVdFeGP0KgATufgC+XyymWI/FH/m1P69ciiAouWT2/M1QBA4e1NkoMrX09X4A
 inwEe5Tnwmtr6xdDtWRQgLm/cwV+qrpwW4F+5OwF8rz2Neir0dfxdNic2PinuI6Eq31Y
 C5SA==
X-Gm-Message-State: APuU4Z9WvE522GO/aX5QJllt8vJt/xEt5MxabQM2WRP9Qc4BLsBJA3g/
 ZTnY0HDIm+pEi1VqVvVPHh45pfP+Ir81Vt9RrFb84AkTWruq0GBBEjSQ
X-Gm-Gg: AYBFou0nd+J8uoQ9jh9YNTLP7reWPTLD9lZUqvNrux4iEwFOd3sHSFu4IBy6glD8+j4
 zCpqGsTGRvb3hoMO+Lscwix5UVpLA16phh/y8K8dP92zwN+0lVI2EjdaqTtg/FEC/zcb4dt2oFm
 Ao/V2Icah62uuEhxfadyAfk4wbAo2dfYPNjb3ebSl/OFKpn5/y8IHaitBtEnK0yCTMUbNZsNVe/
 ALjxTZRtTi59y8EMpWa94/71QNd4M4iOqBy8E/dzgsMlnw52vWNVAmS+1ijg4hOLGT3hWZdwKf+
 eRrt5v8SDO19BpCXOqIbA+jsBeAG8WOqoPcXx+tcv7dXbC+Puwv1Pt1+n6W2+Lp3Bbjd7S1+j+O
 WqUjtpbz080zKB4uW3Lzr9zN2JjdxynpOhas3F3yOsIM9sVzTdzIKsT31uj+1L4H7fu1mZM2dD1
 sBeB1IppCjL8acDky57A1W0HtiCS2/qnYkYMY9zMH+ARqB44k7TvwOXYVH7O8f7sCywEhWL1EKu
 vrMNMjYeMDz9ZlnGMTeIobfOhjQSoaPgZ3qG9VYEwee2jLxtMVY6JJh6R2K7HSsCplYeX+DRtTN
 GIWTA+zDpkjHxiG4eYF5
X-Received: by 2002:a17:902:db12:b0:2e8:93b5:c555 with SMTP id
 d9443c01a7336-2eb3650622cmr113307145ad.61.1793697147686; 
 Tue, 03 Nov 2026 01:12:27 -0800 (PST)
Received: from hp.mioffice.cn ([2408:8607:1b00:8:57:9df8:32f9:efc1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39278e13sm37747745ad.45.2026.11.03.01.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:12:27 -0800 (PST)
From: huang zheng <huangzheng9869@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  3 Nov 2026 17:12:15 +0800
Message-ID: <20261103091215.180531-1-huangzheng9869@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xOAZF-000000006uW-1z4P
Subject: [f2fs-dev] [PATCH] f2fs: add checkpoint step timing statistics to
 debugfs
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
 linux-f2fs-devel@lists.sourceforge.net
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
 fs/f2fs/debug.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 6fe606e2c70d..8fd76a69dcad 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -445,6 +445,22 @@ static const char *ipu_mode_names[F2FS_IPU_MAX] = {
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
@@ -631,6 +647,14 @@ static int stat_show(struct seq_file *s, void *v)
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
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
