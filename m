Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8CEC624D3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Sep 2026 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YGPVZth3X9ueET+YiPIT2M13qtWgCV9AHpZdNhSyAVI=; b=VsfTm+MGE8VwHM4MuIl5HJlVFL
	sDXS3Eik5VUVvcZPD+COqqw5OYrL3PzCGpZELJa9dPIygvccoVNS9L1TgGcc/juebQhvykC+ROhrN
	zir/bmZdO+p4dSC3gMw+zX+7QCtSvRmUIoO2mc3zmcQ4FlZ1hg3bTQksKgVginL7gJ54=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2oOV-0006gE-VJ;
	Sat, 05 Sep 2026 11:17:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jinbaoliu365@gmail.com>) id 1x2oOV-0006g3-5I
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 11:17:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VRfLue6LbHST/tEsX4qzbZ5YqoOYwYrthx4a3NE3Mzs=; b=QtaCgVR8Cab+Fl9iMGSxTwr4+5
 UY9PihDsA1fu622DxmnfsiHflkSR/I1+qgRZJ8sHr+1zdqaRKJSsDg46+V48pUPbymnkvkgbVBubW
 T9AE7ZGwgbLxcYZgdS1uIRrUcO7lUIS3A6VyCS4GTqkdjRReYSjXwyPAQUQYq+ESD/dc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VRfLue6LbHST/tEsX4qzbZ5YqoOYwYrthx4a3NE3Mzs=; b=L
 DXDv3h0kz09sKANs8zQeTetsS57Ms2zoWABCzNiKhlfEl4m4m67KYka59bChlSTO4TwxyOuDyKixQ
 ihcVbtqXJPJIMS9cQvDxDQIf5jAn6vAG0jEiPDayFm5RjrmeWYJMyJyofUDHdUaU+R3nipXYkwgeg
 vhxPnYE+i9V/d8vE=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2oOV-0003Zl-7O for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 11:17:11 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d91518a63fso14350705ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788607025; x=1789211825; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VRfLue6LbHST/tEsX4qzbZ5YqoOYwYrthx4a3NE3Mzs=;
 b=i441kYLndSC9JJFGXLsYxnDobSgNPOHmiKQYGgGNIsqOFHErfLejTVTjhAXKVJRijm
 HdOCEM1IYHkDihc1w0SaGmeLruefk4OJEEOgQNZn3xYV4EyfJlRy2lj07H7zNHdD2cVe
 /2gIek50Ysv0b8xrqiMteagZwx+N+z79nksjo5zHgKBobBSWgEqWesQVFfO+zbGymOf1
 5GpPi5tBUwKDliow9ZpunHOSJwz97w6tyO1gzAhxtKkmUQ+WneXu3pfdQ8kMX0oxZIZn
 NMkgBI9E7D0j0Wuz6kTDJT0GuAmTsBXb+e2I2VlooWR6iYMlYVNX5OUkNy6N4/SgxFQB
 st/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788607025; x=1789211825;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VRfLue6LbHST/tEsX4qzbZ5YqoOYwYrthx4a3NE3Mzs=;
 b=RK8znOEIS6sfH82UVKmohAMR3De6i5MAqVFbCRdfsWsFormLf3udWu20ZRQTHH92AT
 +0e0bcLm3tyoKn34xWbdhwepFhyA+Ey5f3cJf9tdnSsFxLJ7KoV9/wFMtxAYq84JbHeR
 dNr7Aq9wU+6ZCZzR6USbGbAnF7PirMTqGAufudXPKL4itCpn2fcE7Vu9ch0Lbi4vCUh3
 GCuTw1IRyyH1WbP899pVIIuWpMCCwVtjAl8ObIJCTns8VjUAVtbengGzC++gJtA5+AnD
 OTi/ahELcxhf4O+PkW2OvXqk60mCCRZT6v9BDmtAGRvr/7gOtrkCPdLyvgrP0HdX05N+
 LaMw==
X-Forwarded-Encrypted: i=1;
 AKwUvByYZGKkVIvPoJVZPLv56OMGCRSKY66m991H/5TMGdm20tWQss3KEqGuzAb1UAOI5/20U74MLIoRZ0mBsK5BtlXe@lists.sourceforge.net
X-Gm-Message-State: AFuF++kZYOZ2xvlg5JTh3zhhATCcafR/f6TaDEV7cIzQHteX/CmUIF5+
 vkjo7dGoUCsxqM4chyqvK3Bziqj0ylB0dOC4FaPRmQMIDG4oIpvHbfLVxJfjZQ==
X-Gm-Gg: AYBFou2LVT1+uJ20qfUZ2VfrXWGSVIJo38J9yacCiEXXD7yNaLT1qOs3UQ3+T2UbOSa
 Xr8lfdwaZSmBwKJbAbb1hX+/Efzt06k58kjb347qwnFwqSPYOVDDPRNF8x6da7UnZSdWEObjTfZ
 XT6Qu9kWbtYEC6bPM+YG+qVmx3gOMjORQKei4FO0ytkDitLjDDWWT6TuFGdYc+S0MLhLiyTcq3z
 n/+sBHXSxrlBUsnNDXeTxCWcggwfEx11N1Eswq9xsR6hV3df1x9+ZDiU3RDHJ0huFjvhzlU8wAu
 XkzMCDY5vx8qj3+IGNGUf3PM1tPHwS1mnJ6BkOJ2qM+RIEJWLtMQjV1w2jJXTOl6qYB3DrRbjsf
 npPT8aEB65tY5ongZxE0Xy0b6bDg3+8VahvO24KE2WhRE47PXqX5QbSpDeNBn4i+1wE1SsaDtzd
 +E1+RR1gi4rcHjWAAFVK6hdKgw2gzkgwXLKSld6NbiPkSNv2lIrEnGrU8xaKk/jpi5Ij4=
X-Received: by 2002:a17:903:11c8:b0:2d8:d4de:fa80 with SMTP id
 d9443c01a7336-2db1235721dmr161030505ad.4.1788607025429; 
 Sat, 05 Sep 2026 04:17:05 -0700 (PDT)
Received: from mi.mioffice.cn ([2408:8607:1b00:8:a021:f0de:2ec0:e856])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497da0fsm21370635ad.37.2026.09.05.04.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 04:17:05 -0700 (PDT)
From: liujinbao1 <jinbaoliu365@gmail.com>
To: jaegeuk@kernel.org
Date: Sat,  5 Sep 2026 19:16:52 +0800
Message-ID: <20260905111652.43148-1-jinbaoliu365@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x2oOV-0003Zl-7O
Subject: [f2fs-dev] [PATCH] f2fs: force discard when undiscard_blks exceeds
 threshold
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
Cc: jinbaoliu365@gmail.com, liujinbao1 <liujinbao1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: liujinbao1 <liujinbao1@xiaomi.com>

Asynchronous discard issuance can build up a backlog.
Force discard when undiscard_blks is large relative to free space,
or when undiscard_blks is too large under high utilization.
This reclaims pending discards in time and keeps UFS performance stable.

Signed-off-by: liujinbao1 <liujinbao1@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 +++++++++++++
 fs/f2fs/f2fs.h                          |  4 ++++
 fs/f2fs/segment.c                       | 28 ++++++++++++++++++++++++-
 fs/f2fs/sysfs.c                         | 11 ++++++++++
 4 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 0cebc89799dd..be1ced3dc8db 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -791,6 +791,20 @@ Contact:	"Chao Yu" <chao@kernel.org>
 Description:	It controls to enable/disable IO aware feature for background discard.
 		By default, the value is 1 which indicates IO aware is on.
 
+What:		/sys/fs/f2fs/<disk>/discard_free_ratio
+Date:		September 2026
+Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
+Description:	Controls when background discard should switch to forced mode
+		when storage utilization is low, based on the amount of undiscard_blks
+		relative to free blocks.
+
+What:		/sys/fs/f2fs/<disk>/discard_blks_thresh
+Date:		September 2026
+Contact:	"Jinbao Liu" <liujinbao1@xiaomi.com>
+Description:	Controls when background discard should switch to forced mode
+		when storage utilization is high, based on the number of pending
+		undiscard blocks.
+
 What:		/sys/fs/f2fs/<disk>/blkzone_alloc_policy
 Date:		July 2024
 Contact:	"Yuanhong Liao" <liaoyuanhong@vivo.com>
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2f7ab5888b07..36f2c58b0671 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -325,6 +325,8 @@ enum {
 #define DEF_DISABLE_INTERVAL		5	/* 5 secs */
 #define DEF_DISABLE_QUICK_INTERVAL	1	/* 1 secs */
 #define DEF_UMOUNT_DISCARD_TIMEOUT	5	/* 5 secs */
+#define DEF_DISCARD_FREE_RATIO		80	/* force discard over 80% free blocks */
+#define DEF_DISCARD_BLKS_THRESH		13107200	/* 50GB in 4KB blocks */
 
 enum cp_time {
 	CP_TIME_START,		/* begin */
@@ -542,6 +544,8 @@ struct discard_cmd_control {
 	unsigned int max_ordered_discard;	/* maximum discard granularity issued by lba order */
 	unsigned int discard_io_aware;		/* io_aware policy */
 	unsigned int undiscard_blks;		/* # of undiscard blocks */
+	unsigned int discard_free_ratio;	/* discard ratio of free blocks to force discard */
+	unsigned int discard_blks_thresh;	/* discard threshold to force discard, in blocks */
 	unsigned int next_pos;			/* next discard position */
 	atomic_t issued_discard;		/* # of issued discard */
 	atomic_t queued_discard;		/* # of queued discard */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 63b712d3d599..da4ed7e71c0b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1957,6 +1957,29 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check)
 	return !dropped;
 }
 
+static bool f2fs_available_free_space(struct f2fs_sb_info *sbi)
+{
+	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
+	unsigned int avail_user_block_count;
+	unsigned int total_free_blocks;
+
+	spin_lock(&sbi->stat_lock);
+	avail_user_block_count = sbi->user_block_count -
+					sbi->current_reserved_blocks;
+	total_free_blocks = avail_user_block_count - (unsigned int)valid_user_blocks(sbi);
+	spin_unlock(&sbi->stat_lock);
+
+	if (utilization(sbi) < dcc->discard_urgent_util) {
+		if (dcc->undiscard_blks >=
+			div_u64((u64)total_free_blocks * dcc->discard_free_ratio, 100))
+			return false;
+	} else if (dcc->undiscard_blks > dcc->discard_blks_thresh) {
+		return false;
+	}
+
+	return true;
+}
+
 static int issue_discard_thread(void *data)
 {
 	struct f2fs_sb_info *sbi = data;
@@ -1974,7 +1997,8 @@ static int issue_discard_thread(void *data)
 				msecs_to_jiffies(wait_ms));
 
 		if (sbi->gc_mode == GC_URGENT_HIGH ||
-			!f2fs_available_free_memory(sbi, DISCARD_CACHE))
+			!f2fs_available_free_memory(sbi, DISCARD_CACHE) ||
+			!f2fs_available_free_space(sbi))
 			__init_discard_policy(sbi, &dpolicy, DPOLICY_FORCE,
 						MIN_DISCARD_GRANULARITY);
 		else
@@ -2393,6 +2417,8 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
 	dcc->max_discard_issue_time = DEF_MAX_DISCARD_ISSUE_TIME;
 	dcc->discard_urgent_util = DEF_DISCARD_URGENT_UTIL;
+	dcc->discard_free_ratio = DEF_DISCARD_FREE_RATIO;
+	dcc->discard_blks_thresh = DEF_DISCARD_BLKS_THRESH;
 	dcc->undiscard_blks = 0;
 	dcc->next_pos = 0;
 	dcc->root = RB_ROOT_CACHED;
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 811e350a1430..ff12df62e83f 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -642,6 +642,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "discard_free_ratio")) {
+		if (t > 100)
+			return -EINVAL;
+		*ui = t;
+		return count;
+	}
+
 	if (!strcmp(a->attr.name, "discard_io_aware")) {
 		if (t >= DPOLICY_IO_AWARE_MAX)
 			return -EINVAL;
@@ -1250,6 +1257,8 @@ DCC_INFO_GENERAL_RW_ATTR(discard_urgent_util);
 DCC_INFO_GENERAL_RW_ATTR(discard_granularity);
 DCC_INFO_GENERAL_RW_ATTR(max_ordered_discard);
 DCC_INFO_GENERAL_RW_ATTR(discard_io_aware);
+DCC_INFO_GENERAL_RW_ATTR(discard_free_ratio);
+DCC_INFO_GENERAL_RW_ATTR(discard_blks_thresh);
 
 /* NM_INFO ATTR */
 NM_INFO_RW_ATTR(max_roll_forward_node_blocks, max_rf_node_blocks);
@@ -1430,6 +1439,8 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(discard_granularity),
 	ATTR_LIST(max_ordered_discard),
 	ATTR_LIST(discard_io_aware),
+	ATTR_LIST(discard_free_ratio),
+	ATTR_LIST(discard_blks_thresh),
 	ATTR_LIST(pending_discard),
 	ATTR_LIST(gc_mode),
 	ATTR_LIST(ipu_policy),
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
