Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F77BEA3C59
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Apr 2026 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZqJeCtE1YfFVsMJdoNoOE5rART6pJQ/PKNaS0/JhJo=; b=L8TCqXRdJ5O2HAJeWjfX3TWE75
	3SFEhJ5DcAsH3RlQiu1qVUAKgTEEd0ploxphqJZ/eo4W+A8Lov4r4ZyYtthJ+e8Hw6QF9vTmfNat8
	7MpqeLMRCjH8NqiFvTq4bax7ywko63YhmeT5Lxa/+5zrlXgJz/u6E2eveB6t81ojnR4o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wApDG-0002G0-Jn;
	Thu, 09 Apr 2026 13:14:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wApDF-0002Fm-IP
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:14:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2M9ZXhVJR3hOHKb6vLxjZkVz4jG7PCh50ykTScgsxUw=; b=H6yB3t4HOx56EWqVdtLqab9Xbp
 ChCL5N/Z1cvj3q0/1C8Fj5x0mPZ4KOSQipSDtsTuwEgiBnn7FLL0iavr43HHI8QCU1lDDM2rKXNWQ
 Fa1Zo74Y5zJpN6GQc5LRv62od8SnFCyGYi+bZzvkdPMocyh2Yc4rOX6yvuQtxoSBb2gY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2M9ZXhVJR3hOHKb6vLxjZkVz4jG7PCh50ykTScgsxUw=; b=Vf9khFJ9JhvwJJagAHyQ/rotaZ
 YxxUDczadDXTPz1M9Q++s5GNsYkuw+SNtUPATP1/s3mqXcGVPsTEJiA4iR3FJ+6jvGWHMXB2lgUQM
 ELWTk02KcYMExsIyAHJDLSlYAiopja/C6xR+xfXtf5/bhtTWV8liC6tPoAQ6bMY1Jc9E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wApDF-0002Ok-U6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Apr 2026 13:14:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 59BAA60125;
 Thu,  9 Apr 2026 13:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0810C4CEF7;
 Thu,  9 Apr 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775740460;
 bh=AbS2Yqdj6XUOqI6/cjToB96OIoO0+yHzdJktpA4Z80Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=X++ACa7DLl+MgBznlPIGUiklF6Chxrh9ZHMM4gerK3mUvoBHd+CbxfV5DkLtfzux5
 KOp7SmaabkjjnQdnMDRS2OEysOZd34tZ8pvFstTX+YAaIC61xJ2EExX5XPBfwuH8As
 YmLYuVldzi9E1Nj4SiNbv7K7CfgEyrrfft5eV5WoySY0yHbYgmdK1lRVTYhmphy/03
 oO8fb1WGpGapxlB0ulw55D/rukwTDNDvgmhVF00hdZ7N2w/VCfwVJ/rghg0wchXRne
 Gg+c3M5e/Qxp76TJVhox2uKf99wuaCXBoL9xqCFqtQoRUNgElMw9/qaqjsr13/bWnX
 rA8ICZpvK3gKA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Thu,  9 Apr 2026 15:13:35 +0200
Message-ID: <20260409131404.1545834-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260409131404.1545834-1-aalbersh@kernel.org>
References: <20260409131404.1545834-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wApDF-0002Ok-U6
Subject: [f2fs-dev] [PATCH v7 03/22] ovl: use core fsverity ensure info
 interface
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fsverity now exposes fsverity_ensure_verity_info() which could be used
instead of opening file to ensure that fsverity info is loaded and
attached to inode.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/overlayfs/util.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2ea769f311c3..8bde5dc31d7d 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/ratelimit.h>
 #include <linux/overflow.h>
+#include <linux/fsverity.h>
 #include "overlayfs.h"
 
 /* Get write access to upper mnt - may fail if upper sb was remounted ro */
@@ -1377,18 +1378,9 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int pa
 int ovl_ensure_verity_loaded(const struct path *datapath)
 {
 	struct inode *inode = d_inode(datapath->dentry);
-	struct file *filp;
 
-	if (!fsverity_active(inode) && IS_VERITY(inode)) {
-		/*
-		 * If this inode was not yet opened, the verity info hasn't been
-		 * loaded yet, so we need to do that here to force it into memory.
-		 */
-		filp = kernel_file_open(datapath, O_RDONLY, current_cred());
-		if (IS_ERR(filp))
-			return PTR_ERR(filp);
-		fput(filp);
-	}
+	if (fsverity_active(inode))
+		fsverity_ensure_verity_info(inode);
 
 	return 0;
 }
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
