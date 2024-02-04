Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774A0C4828F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Feb 2024 03:11:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rWSus-0004AP-Vw;
	Sun, 04 Feb 2024 03:11:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1rWSus-0004AJ-Bu
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Feb 2024 03:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+usYO9kmYXbpy+mniJppEmKl5G0Ak9hnYSfizal5zIo=; b=cqki76oOZ0kCKDS5CGTEdbizBU
 nPNwXqrsUzl812UgujXAs4/cQAVDFlBnimEqYIdSoRcrbWI7g20cBZX5zWW1jBInJWfOnsYFBFZ/J
 ssdhjuzHoxeaHJdkbG2qxnCPuveRzEgDgHe7r4RQ4HNKX9TLF6urVQJlgJD6Pz5D6EWA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+usYO9kmYXbpy+mniJppEmKl5G0Ak9hnYSfizal5zIo=; b=B
 L9ONk/2ehCqZXHyKihGECwHnBHRdiRqKXHgzTjRKrbtVx8zr3309N9wAnxyDDIhqRSKTLyDrxDm2j
 iV3IXzvXOlircaqtvnwTu5gcc4hvqupCVCPEQXFafL7OjRB7ml0hl/nyTpPwXh4j9c/Mi84kZGN0B
 bUPCCxHfXmIz6Uv8=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rWSum-0006iQ-VP for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Feb 2024 03:11:34 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-290a55f3feaso2746117a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 03 Feb 2024 19:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707016279; x=1707621079; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+usYO9kmYXbpy+mniJppEmKl5G0Ak9hnYSfizal5zIo=;
 b=LmsCuSDnqx5/oxkfTn2E8SY2Znppb+8E37BkpghowQ421gsNgrGcKaPELR0s2x7VRr
 x/RbrDR6BoKkC7hmUfBrRXqwN0HCiBmt6hrgTfcd6A9BUaQ2oPziXUww5PutETH5+Jly
 a+171igLHfzjKoBgEcoaL0g/P2XCZ/KzMDpsRYuLfoI+E5QvWNXctOJgUsrM6b9CAUzA
 4AzHfd8vtELnFKrb7j3a4pdlL5fyrOohQloE9Ol5JmQCRsGGu10a9xHxj/c687jOWRyh
 kCZpU2dpFCScDN/O6ZOyVLLNrY/d5mQc1/3/TJjxZ/R2XI9nSbpMQ3bhL3KUsnxqguW3
 LQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707016279; x=1707621079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+usYO9kmYXbpy+mniJppEmKl5G0Ak9hnYSfizal5zIo=;
 b=V3Zk+WZ2ez8oPkf8PP0OghfjDhOrfquvaxUe/ic7E1i+eOGM7LyB7w+lubQWjnaCxY
 ZfGPmMA62DGdMosEITuCTmgJDV7OhaYclRiNL9+3xXwbKdhWsLYR0We3WmPebzdNUKm2
 2cnQmPivdeDhjAiIIcinHvA30lgQim00wW7REHasOpHYsefFEUAjvUQ4f3TNLsdPXXeI
 43foxr+uAD0X67gR2QtPn55mczmtY06b/duA0Oj64MZvVXDpmhSKFQvDDxHLAB1vItY/
 Rx+0lVcr9pWM4GAhct9yTClGhKL1C2TLtfUrKemRJCUrqdsMnz4ycqv1bmNqPxk4l7//
 7H8g==
X-Gm-Message-State: AOJu0Yy4BxdotqUJyxz7CYAgETpd/90u238YMEY5Ie16+Ts18XjKMOlR
 h28e4m7MbVRTeSsXJIMsR4EyOw8cJYsNDQbvEosLqm8suQcLKQDR
X-Google-Smtp-Source: AGHT+IGx2qqIW96Pfh8jonNWQmOXBn1OWquAQPwRPRYif17747FkB7bAA3tCN3Te7DS2ydaz7PcPxQ==
X-Received: by 2002:a17:90a:17e2:b0:296:3779:813c with SMTP id
 q89-20020a17090a17e200b002963779813cmr6504495pja.4.1707016278986; 
 Sat, 03 Feb 2024 19:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVzR7hi5WM5nw9LaiP+Ix1SnjAyaZWBh8NaFdwA6BLv2FwdR/AUj/+M5eCWX0EQVYaPyN39+RXrUfByI0ST/ePJETynEugUz4p5XLd5USeD2fjh0VFfPkup7Jug8KdywlviXnNuiBzWbOaUTyVrrWdQBrSu+v9HnnK4fR9hrakRzRVA0Ni9RPnVTCoG6/J5mP+wGIM++byp8K74lCXM+rqaQSqDcKePM58DRq2IrSSM6A==
Received: from localhost.localdomain ([112.38.163.83])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a170902d0c900b001d8f82c61cdsm7312pln.231.2024.02.03.19.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 19:11:18 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org, yangyongpeng1@oppo.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Sun,  4 Feb 2024 11:10:22 +0800
Message-ID: <20240204031022.1189-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
X-Headers-End: 1rWSum-0006iQ-VP
Subject: [f2fs-dev] [PATCH v5] f2fs: fix zoned block device information
 initialization
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
Cc: Wenjie Qi <qwjhust@gmail.com>, hustqwj@hust.edu.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the max open zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs
are being written at the same time.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 543898482f8b..161107f2d3bd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1558,6 +1558,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_open_zones;		/* max open zone resources of the zoned device */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b718bebfaa1..c6709efbc294 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2388,6 +2388,16 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		err = -EINVAL;
+		goto restore_opts;
+	}
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3930,11 +3940,22 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	sector_t nr_sectors = bdev_nr_sectors(bdev);
 	struct f2fs_report_zones_args rep_zone_arg;
 	u64 zone_sectors;
+	unsigned int max_open_zones;
 	int ret;
 
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	max_open_zones = bdev_max_open_zones(bdev);
+	if (max_open_zones && (max_open_zones < sbi->max_open_zones))
+		sbi->max_open_zones = max_open_zones;
+	if (sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max open zones %u is too small, need at least %u open zones",
+				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
@@ -4253,6 +4274,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
 
 	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
 	sbi->aligned_blksize = true;
+#ifdef CONFIG_BLK_DEV_ZONED
+	sbi->max_open_zones = UINT_MAX;
+#endif
 
 	for (i = 0; i < max_devices; i++) {
 		if (i == 0)
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
