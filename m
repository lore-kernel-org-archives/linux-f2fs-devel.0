Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2E3C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 May 2022 23:35:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nu0XQ-0007l5-5Y; Wed, 25 May 2022 23:35:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nu0XO-0007kv-Sm
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 May 2022 23:35:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zZ81w3Hx7ELWK4RQtZ4SoH/6WmjuGA/OwCDR1LAohk=; b=AZZ+5hwrwmhOM3oly8ypz2pKp6
 aFX1bWPm4X4hValOizr3oedG41aLqDrj8mnfXkHVqCVykeR2N/tByYfJDk/KOikP3hwKEFDDd56id
 9vlJguBhB6pBudWD8tSUY4gRTs6qCpDUvK/oCWgJYiYVOQ5W5OwJru5xureaDLdnnjkA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9zZ81w3Hx7ELWK4RQtZ4SoH/6WmjuGA/OwCDR1LAohk=; b=g
 p3sxLhQys4wqVlGzkpjB5M8ObXRwOY7pfYKbfFoD3/P0P1SCgfrFnSXlYEsTbNrAjdGANimx0L3cy
 XzGajHxNOKbBiSXL+o15MIkYPEhwJjPKzM0FpGnBKt5C/swlsrOQN7v0X7Zd5s6RtTXo1UKjkZBuv
 yrSPU+SnqjaS5aco=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nu0XH-000hRO-0M
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 May 2022 23:35:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CA56FB81E6A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 25 May 2022 23:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAB7C385B8;
 Wed, 25 May 2022 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653521714;
 bh=3P6s718zR/c0BTIA3Zyd1VlYc9gQ5XLtfKyZJx6KhzQ=;
 h=From:To:Cc:Subject:Date:From;
 b=gExDLFWbfC/UJihztto8AUEUlHFxXrkVzt8gj+avHM8lL0XhAWZVUfeRqjncybanU
 6b7nGDllCU5wha1UdKYZ78xwrnVBLd97Xfl6Iv23mC5oi0s9866fLC+C2H+GxevrIj
 Lx7FsjVr84G0UYMaK42CjmgfU+D9Yh56klaHrkJyMnpJB457juDq/8cXQxNPSvA9m7
 BsZosurOMFTvBgD02GwV+6Zfkh/j9uJ1xt8ucGqe6FEAo7eKDcx3sCcS4BDS9hD6G2
 oqeSCjK2s+bljQ74GOEnpUIn/ybUWHwFP+PSUyeNRHiWs6BqBD9he6BaEaI6hiqMVN
 XK3LeDpPHsnGw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 25 May 2022 16:35:07 -0700
Message-Id: <20220525233510.4023217-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
X-Headers-End: 1nu0XH-000hRO-0M
Subject: [f2fs-dev] [PATCH 1/4] libzone: remove duplicate header
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs_zoned.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index c5c6ddee7cdd..f383ce275342 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -27,8 +27,6 @@
 #endif
 #include <libgen.h>
 
-#include <f2fs_fs.h>
-
 #ifdef HAVE_LINUX_BLKZONED_H
 
 int get_sysfs_path(struct device_info *dev, const char *attr,
-- 
2.36.1.124.g0e6072fb45-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
