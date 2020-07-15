Return-Path: <SRS0=ibKk=A2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F666C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Jul 2020 17:30:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA7B2065D;
	Wed, 15 Jul 2020 17:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="E7ArcWP0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MFw3l4Em";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGB1ZbCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA7B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jvlEm-0003x2-Jq; Wed, 15 Jul 2020 17:30:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jvlEk-0003wt-Ly
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jul 2020 17:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q/xPnX2TAkjAjV7MkePZg3yO6mxqzlO8lUfpvqeqDtM=; b=E7ArcWP07xblrrVDyMctsCmGKw
 PV9Hmx29bZKVTWB7M8D5a3KPl00KuIayCU1qHu9YYBfWQBkiU6Jgea75AUpR2OrvovMvACIh7q0G1
 tG0fmbLp6gwcJ3IE57H225kJE4JoGaZqSbC9L6MkcFPNMvNhgFtkITQFK8GeK7JfsLq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q/xPnX2TAkjAjV7MkePZg3yO6mxqzlO8lUfpvqeqDtM=; b=M
 Fw3l4Emibj/6WNEYgFXGLcEMwL8SfiBG+b3gkKXN2Fdei1W9ozMRoRsOYDbEnO/GkoXTwBG9G9rQF
 v7u7xHQdnb8vpt8YGcgQ98/uP5ps9YnPTMfRHGUb2rPvd6CV2YQwQenrMXAq514bQcV37ptWLXQcg
 7v+lPidyLqfQkUnM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jvlEi-001j1Q-U3
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Jul 2020 17:30:30 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 944E52065D;
 Wed, 15 Jul 2020 17:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594834218;
 bh=1DC6kVSj17Ywj2YYgdW3q0F+Z7TQU5VksSaSNsRw5vU=;
 h=From:To:Cc:Subject:Date:From;
 b=GGB1ZbCHCAxjd5xhbrtFWNaswxLfjqfdGqW7BT7lAELQe+tB/kMV5QAHvaxfRIMnH
 wOGRUfNVXMwnKwym2UA7AoN74TVSsWbQ0/aKuzPiAKTc1pdo/QIPti2v9oWe0F6ET6
 QHDFbFYsRk2rDYafv+qO582v7wkzrutM0YkjBGl8=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 15 Jul 2020 10:30:16 -0700
Message-Id: <20200715173017.1887640-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
X-Headers-End: 1jvlEi-001j1Q-U3
Subject: [f2fs-dev] [PATCH 1/2] sload.f2fs: fix missing fsck_init
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch allocates some data structures that will be used for loading files
on existing image.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/sload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fsck/sload.c b/fsck/sload.c
index c064f7f..59ba4a6 100644
--- a/fsck/sload.c
+++ b/fsck/sload.c
@@ -313,6 +313,9 @@ int f2fs_sload(struct f2fs_sb_info *sbi)
 {
 	int ret = 0;
 
+	/* this requires for the below sanity checks */
+	fsck_init(sbi);
+
 	ret = configure_files();
 	if (ret) {
 		ERR_MSG("Failed to configure files\n");
-- 
2.27.0.389.gc38d7665816-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
