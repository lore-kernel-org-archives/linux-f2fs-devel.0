Return-Path: <SRS0=Dbub=HQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1BC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 14 Feb 2021 09:44:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5635E64E29;
	Sun, 14 Feb 2021 09:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5635E64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lBDx3-0008Mt-MK; Sun, 14 Feb 2021 09:44:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1lBDx0-0008Mj-CU
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Feb 2021 09:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+aZeGU5ZZk2q9XrtkI6xk2cOLKV8C8YTGscjl7J0zI=; b=SoOVMI9zdMao6lSZjBDOeeKSNt
 8N+QP9OvNzqUFmGitzGWCR521uWYtkxUMOUcnoSG47KBFJBsm9h1n3JS9qN0oW3N6d1XxFXEqMdiD
 B6AenxwnbNcGdnvZdaWoWyzVzUMw50YaK162aAwmPnQ7pHfbhnTHGLb52QEDIFpTIqAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v+aZeGU5ZZk2q9XrtkI6xk2cOLKV8C8YTGscjl7J0zI=; b=L
 fYj6IeOmmmL6duV3J1LjOHmlFcCIcwDx3BuIRX1yCxhzWN7HtbbZOjpaZnkcphzZtTZMLMy/g7ZWO
 +4PY3uornJFFtQXR+oSjR4qWzkfvWNW/1I1nptK3x/xLSJvbw96WmZoRMstZC95Ox5XqpsIfKwR90
 ut3jnxe3WHX19cQI=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1lBDwe-008K8r-Uh
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 14 Feb 2021 09:44:21 +0000
Received: by mail-pl1-f177.google.com with SMTP id b8so2082301plh.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 14 Feb 2021 01:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v+aZeGU5ZZk2q9XrtkI6xk2cOLKV8C8YTGscjl7J0zI=;
 b=g0Vy3z75cfGZYZJSArTZunoLtiDYX/2ne54C1NI+twBCY29DZY91uCAVFixXK6zlIk
 LxgkZUOma4TgKFPeelwg5dktILf51F9LcSSMwoXBcjLa9E6PMFdWqtogsBCJjIxUEamB
 Ef9RVhA10+5oPO812PgacQQwx4fG950PbahmTbiDt1VDYyLU3XYmVMeCztf3fCCRGs/h
 EV7D7o85Zgmy4sTwz7TSCtE9MMwxSDmZX0n48LvK40tbqCGAYTDP2iOi9QzoytsjHJDO
 vfgjlMPcAERHGbgsj+PQPx3FXfRkdGT+dlCI5yk6fAZh9pLs3R/aC9UBH9GLxszRJoSQ
 aiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v+aZeGU5ZZk2q9XrtkI6xk2cOLKV8C8YTGscjl7J0zI=;
 b=gQmY9qs8J9gm+EPnH/X5fV0pFj5VukFrsWT7gmQt8iE3rV3YsJu0G75OkZCDEB01HO
 1MXemMNxH+pQ/Lf93uZBhX+bXJSOWQIhKqYBbvJj1EEv1duWP/xHEgU8L/yEyNvjn3Aw
 d8kBIRl1mumNJEp8h+GJDiJtWNF7Z8mjiDlcW+OnSuc1yXIrTj6p1jLtY4gFzHpT5IQ0
 E8SO31Z4GSm5DHJYGEv9wj59uuK1ID1bMPBPk6m9fB1/SlnKnb4CjuyBwwdppK8P/ByJ
 eMuDlMMMU0lYr8dIosv+r/GgwgT/QDhI+LBZeJ4D779JLnrNrufANNAKIrp4HIW9Vr5G
 wlxg==
X-Gm-Message-State: AOAM532KVkpBPUyVA7MUf75OC487Y9FEj6RE2MEiIuX32P3aJni6qU4p
 mIw81HVG0Jz6QLpJssqQiQEEVFoIc8+AYg==
X-Google-Smtp-Source: ABdhPJzjU61qS1XWDxRoctNbrxeIs59DNu/fUbIpxTEnJ2/mXl3j6qrAksKBz1fP7f5CWbYQiS6bIA==
X-Received: by 2002:a17:90a:183:: with SMTP id 3mr10863712pjc.99.1613295834982; 
 Sun, 14 Feb 2021 01:43:54 -0800 (PST)
Received: from localhost.localdomain ([218.156.77.138])
 by smtp.gmail.com with ESMTPSA id e15sm16412042pgr.81.2021.02.14.01.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Feb 2021 01:43:54 -0800 (PST)
From: Park Ju Hyung <qkrwngud825@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 14 Feb 2021 18:43:11 +0900
Message-Id: <20210214094311.43639-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Headers-End: 1lBDwe-008K8r-Uh
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: add VM disk files to hot data types
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Similar to .db files, these are randomly updated extremely frequently.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 mkfs/f2fs_format.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a6c542e8e1f0..dbb5bb3e2ba7 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -96,6 +96,13 @@ const char *media_ext_lists[] = {
 
 const char *hot_ext_lists[] = {
 	"db",
+
+#ifndef WITH_ANDROID
+	/* Virtual machines */
+	"vmdk", // VMware or VirtualBox
+	"vdi", // VirtualBox
+	"qcow2", // QEMU
+#endif
 	NULL
 };
 
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
