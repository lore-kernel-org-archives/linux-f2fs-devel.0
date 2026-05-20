Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C365FCD5BAE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 12:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lf8qbibeUxWq7+1bi/pRaDIWN1LXTzSkHGYT0b3aDjk=; b=CoowmR8q2RTT1UJvu6LmGqsuo/
	qbCVrhdGmXKiEgRdDRj55LL8XGKOpWvHtP68E302yYv7VAaO9KauZkG6m8LZ1+11T4RuIZt4ovY2C
	5Bhyu0AfkTFYWkEUGVXTTwzzu39Y7WSrq/YCM7rbVdTdgeMq6iI8w5fq6kmriZwkvrb0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPgBe-0006zs-50;
	Wed, 20 May 2026 12:38:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wPgBK-0006yw-R2
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:37:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S6DVheQpRL47ADeu0p23U/KgTF/b8n3o4ctQu4PeRXA=; b=Y3mx8r/DQfpo0K7DQgXDrZcrXK
 SRsjQIkrERLu3TXRAqRZYW0Y6e4srto/q17gzvUmF82mD+mdTM9j6Y7aDr2LDCiZ+DsF+Jlw8MUzs
 Rhbs6w24Wl4ulVMiYC2P+WZ4VakEs+3yIwMwH/QWzqeyqZMktOU7DqU0M4n6x6BjwAsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S6DVheQpRL47ADeu0p23U/KgTF/b8n3o4ctQu4PeRXA=; b=Lis56OxWqyeHRvVHPnHZIU5AB9
 dBKJIfIIBljhf0LkaAfbE3tJkzCMAhMgVmaAQHAx3rCc1U8bVk2lV2Pu8VA+I0xEfh61IKw38vjgJ
 pH+kZaHxxElZ1vmU/yjCxlLZjwuekOuFWXoiNUjcn6PcgVXcHjljAUNJGg3rSX7e42DI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPgBG-0006YY-9B for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:37:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3736860126;
 Wed, 20 May 2026 12:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E21F00893;
 Wed, 20 May 2026 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779280655;
 bh=S6DVheQpRL47ADeu0p23U/KgTF/b8n3o4ctQu4PeRXA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bz1mjG/igVr51QMf/GX/vNogqKcrJsXkQsKiEc99VZY6J2rrwZ6r3ZTbJo0LxzBfp
 Wlls8sWGix1E+yEsVg3oFeYVDMBe7iENfCopFYq/BPqeBL8KGAQQB7QkmrMdNKDR2U
 lnTvzFuLeF3AAKPT0trN9C2lz0REmoKiIMRD+n+kH5R01CpW9B0Ih/FUEMy0gtjYMo
 uVzSGkapGiUfQwPiuLTQ7P4N7xCDCof8Kai1n/SKcSQCOBfX2PNFflCw2Oekjzcpaa
 3MLnlE2qiGHaVcWDSsDIFxYyR0n+rQp4rDFDKEOGEroEg9EqLPOjxhhZUhp9eOMbAY
 ovRmwD0AoY94g==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Wed, 20 May 2026 14:37:01 +0200
Message-ID: <20260520123722.405752-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260520123722.405752-1-aalbersh@kernel.org>
References: <20260520123722.405752-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wPgBG-0006YY-9B
Subject: [f2fs-dev] [PATCH v10 03/22] ovl: use core fsverity ensure info
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
 Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fsverity now exposes fsverity_ensure_verity_info() which could be used
instead of opening file to ensure that fsverity info is loaded and
attached to inode.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/util.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b41f4788e4f0..1e783cab4fbf 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -16,6 +16,7 @@
 #include <linux/namei.h>
 #include <linux/ratelimit.h>
 #include <linux/overflow.h>
+#include <linux/fsverity.h>
 #include "overlayfs.h"
 
 /* Get write access to upper mnt - may fail if upper sb was remounted ro */
@@ -1352,18 +1353,9 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, const struct path *path, int pa
 int ovl_ensure_verity_loaded(const struct path *datapath)
 {
 	struct inode *inode = d_inode(datapath->dentry);
-	struct file *filp;
 
-	if (IS_VERITY(inode) && fsverity_get_info(inode) == NULL) {
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
+		return fsverity_ensure_verity_info(inode);
 
 	return 0;
 }
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
