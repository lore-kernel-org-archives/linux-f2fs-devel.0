Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43604C47077
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jan 2024 14:06:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rPk5G-0003Gv-Cf;
	Tue, 16 Jan 2024 14:06:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1rPk5F-0003Gl-Cq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jan 2024 14:06:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tBb5M/z14WnWSl+A8E6m6rrdU0AHffCrKzLu1XjUw5E=; b=RISWN6eW0PXRSyxbiugTTl7Cht
 vd58ywGaeHSOaZ1e3IOw/7p7dJOLJ8eZeiX7pNYM8AIwlGby/XkY3UPQtxomY27osmtLQYumhBIGH
 dbbmxQAdpcu1SvjUsYv9F1OJ6feXM8FGH5lcWWlhdRLNY77mhZ7cL+il1ylXOo0udvUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tBb5M/z14WnWSl+A8E6m6rrdU0AHffCrKzLu1XjUw5E=; b=f
 CdPb4MWDn0q6KtowoqNkScQQmqjcB/GY/kDlCS7wMjHtKHJRkaAXCPLGIIjRb0e7BrvqMFsEMAouO
 OK4jFp9Iy3ygr/woMIKrBcIcr5iCSieiSvgUklh+7R3DMZdE6/Tj+a10UcAlXt6CqrhKq0ThtGtIB
 MjbEpoiq5PSnlQiE=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rPk5A-0000no-G0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jan 2024 14:06:29 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-1d3f29fea66so55274235ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 16 Jan 2024 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705413974; x=1706018774; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tBb5M/z14WnWSl+A8E6m6rrdU0AHffCrKzLu1XjUw5E=;
 b=hqovwNyZG4QFrzmRPDu6Ne55h9sJbfbK5dG/sA3kaCpA3VCdqbgw/IuuoNsI+UNZMX
 4iSORCeMnd91WHgz0pU6qZhTqqZTWi/rI0G9xdHxC//hJngTpogBtQKh3KjZMoPQZQro
 TXKxO7tIAZ/ZrnX2h6mQCw2leUMdBxAXFueJq5NtAThp09zgpzVB+wcnIUOrmebVivta
 RaxaeCmvUJKpfm7ZPNE7IoliXwK7nX7klv2OFFRdR7Sm1c3zO/ifG2f3cDhSuvGMXKOT
 QVH77MqLYvO539uMJt+3OqoePDKTf+/kO3y4IEywWT6ZpqOZ/ICf6HL8i36xu/CIIaCC
 JYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705413974; x=1706018774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBb5M/z14WnWSl+A8E6m6rrdU0AHffCrKzLu1XjUw5E=;
 b=fWfTrbrFBK1OwgDtQY3T0BSDCHX7NvbfNfY9RkqJcuqcY6pVMSni/xNEmspuu264QC
 PjghoLK9EQ5PNp4lmPzeZnvQctjs1lLr64eTc5y8ngtgrL1SrKwRuurmzN4bo/ccifPP
 gqTNztM7urROkjPxiRwLFdiZnhfpHAImTN1SJaAro/GSdR5/HqX9Xuo0Nj2ElRihSd+S
 RHuQmPNhZBRLkQ2i0DEcNqiMszC9QqkEoW7waMSNND8HUKvrVhagSDUF5+RommLwlcT/
 SU44sUUzXgniNzez21Av/TLlaCaIs2VbvgmUmDXYgOpZU5hyT1NlJzyuWWF92dRPxkyu
 LR6w==
X-Gm-Message-State: AOJu0Yw5vzPRLk3OKRYGnHZxesclUF2496kIH3A0UWXzsniTJpBUJBPZ
 1TPYix6yPAzbvTbHcI92T3Y=
X-Google-Smtp-Source: AGHT+IGAY1SVIEbtnn+B0y3YjKdZ2vC+ch+yaWFXuC1iIBEXpUnjN6SkMsXl8PCeSn882peT42GLug==
X-Received: by 2002:a17:902:eb8d:b0:1d0:8352:b71c with SMTP id
 q13-20020a170902eb8d00b001d08352b71cmr4607011plg.5.1705413973801; 
 Tue, 16 Jan 2024 06:06:13 -0800 (PST)
Received: from localhost.localdomain ([2001:250:4000:8246:8dd2:f82d:e185:367f])
 by smtp.gmail.com with ESMTPSA id
 mi11-20020a170902fccb00b001d59f061a29sm8245474plb.11.2024.01.16.06.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 06:06:13 -0800 (PST)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Date: Tue, 16 Jan 2024 22:05:13 +0800
Message-ID: <20240116140513.1222-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
X-Headers-End: 1rPk5A-0000no-G0
Subject: [f2fs-dev] [PATCH v2] f2fs: fix zoned block device information
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

If the max active zones of zoned devices are less than
the active logs of F2FS, the device may error due to
insufficient zone resources when multiple active logs are
being written at the same time. If this value is 0, there is no limit.

Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 65294e3b0bef..669f84f6b0e5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1551,6 +1551,7 @@ struct f2fs_sb_info {
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
+	unsigned int max_active_zones;		/* max zone resources of the zoned device */
 #endif
 
 	/* for node-related operations */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 206d03c82d96..b65547f4c710 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2385,6 +2385,15 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto restore_opts;
 
+#ifdef CONFIG_BLK_DEV_ZONED
+	if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		goto restore_opts;
+	}
+#endif
+
 	/* flush outstanding errors before changing fs state */
 	flush_work(&sbi->s_error_work);
 
@@ -3932,6 +3941,14 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	sbi->max_active_zones = bdev_max_active_zones(bdev);
+	if (sbi->max_active_zones && sbi->max_active_zones < F2FS_OPTION(sbi).active_logs) {
+		f2fs_err(sbi,
+			"zoned: max active zones %u is too small, need at least %u active zones",
+				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
+		return -EINVAL;
+	}
+
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors)) {
 		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
