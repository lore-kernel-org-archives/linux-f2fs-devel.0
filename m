Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6020CC76196
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Apr 2023 16:50:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjNOR-0000a3-0G;
	Mon, 03 Apr 2023 16:50:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pjNOK-0000Zw-Ia
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 16:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EjZCpXfh72JFXGOUONGFb7mydk/44UHBgGk2m4Z4BKY=; b=RHroSzCDuEq07TygCZaNUYpjXS
 rPJiRBV7nfZzMohLvEYUvZlkg30gk4ayZMA4m/7gA03rhq77I0STu2uXrC8C4qsURLdT3LrKLaEwh
 Y/Ec9UJQE4qLk2e0h+jFN0tQc2e8C+YGA2llPpuMIIeGszNVPNIcUgSZBWQJxljc4dqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EjZCpXfh72JFXGOUONGFb7mydk/44UHBgGk2m4Z4BKY=; b=d
 4PSLy+TiSCzRFH/ty673me35A69UkItCrQFlDLJUasirvxYIdwH7JBs03rO9+nUmMTUsIcJgCMLrx
 jVE0TDApCLRxzQg9NbCIJicJ0anrquFb5xrAblTaG0vunvMR84EAxpYoZq96EHhApluC5VDmdEmFg
 9Gi+kPMw4wn2NkXI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjNOJ-00DudN-0e for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Apr 2023 16:50:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9A37D615F1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Apr 2023 16:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E816AC433EF;
 Mon,  3 Apr 2023 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680540641;
 bh=0ob/hFAIfCGbkHjr+Z2bHwcAANgfDHKR2sqmW+DCfRo=;
 h=From:To:Cc:Subject:Date:From;
 b=nGV7GIESm8duFk1qFhH2HHFziJEwQBrM6CVfBvifvGUxrnFb8s2XDLN40E3yzEh4M
 Eo/B+QGGHGtOgYPLtnoj3Dfj3vLccX8L9dRW9VbjVbxkQ1c7FXNBUislHZjJH/EvQG
 80Wpcw6SdzvNyEEU2QThKuSDz6aEhDN8AL9VsWZEmFQ66Wg00JvasgoY4Os4tyaURt
 VYYU7NqPORiFY8NanHsnmniCQC2uTRkYt5K7nX813Vaqrr8rXjUdFrUDPM7RWPz4vD
 WUzO3UNylaDjd8JNv4KKcsulrcB/xppBGpLuTbBqc0B3CV2c8NJ3z3RyVJSOCyll0K
 rPx3WIrIYayfQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  3 Apr 2023 09:50:38 -0700
Message-Id: <20230403165038.3018949-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
X-Headers-End: 1pjNOJ-00DudN-0e
Subject: [f2fs-dev] [PATCH] f2fs: fix null pointer panic in tracepoint in
 __replace_atomic_write_block
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

We got a kernel panic if old_addr is NULL.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 72bce3808394..2439d7029e64 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -257,7 +257,7 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	f2fs_put_dnode(&dn);
 
 	trace_f2fs_replace_atomic_write_block(inode, F2FS_I(inode)->cow_inode,
-					index, *old_addr, new_addr, recover);
+			index, old_addr ? *old_addr : 0, new_addr, recover);
 	return 0;
 }
 
-- 
2.40.0.348.gf938b09366-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
