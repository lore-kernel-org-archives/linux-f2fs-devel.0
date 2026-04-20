Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018E8F5581D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CdOg/MHAs7F8PQ1L0NnsbpfSMETwEVK9vMWkHRcWof4=; b=Zup2R+ZMhDTp3jrGGiLfEE3D2L
	GCQ0cfrH2MF4U64hIp5T1uv8azIXNkX4yHNBqMEj8t18mu5tKK9UfyFsfueE4LBvlpOIb+0pQvLsO
	L7AB2oL610eB/h1KJrCllwRIQKUAWdSEkGU8PBAvGI+VPOvyLsu/FzwlHSI6sl/MHECU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wEn6W-000138-Ec;
	Mon, 20 Apr 2026 11:47:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wEn6U-000130-RT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Apr 2026 11:47:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gLN6w7Js5RLu5drJwAcDxLuRy7aLXqdarmwXm2uOIRk=; b=cRB6meAqRaFqVStzJuoyQYtKU8
 okSZFP5/rRKg8tnVvtb+bIMhVgI6nBw4EMxl01S97HaVHRv8cX921mQ7N9aJb5iAsM0dRwix4Nbiq
 2bHk8VSKKCeYNu8hPcEApiiDoGE2Vmu+RGR9cYVa6O8Q/8rilJuEZVngkQ2HLBTFfgzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gLN6w7Js5RLu5drJwAcDxLuRy7aLXqdarmwXm2uOIRk=; b=FlncsnMXWHaLm2t7Vgji49vL9T
 IPqms6Bl26sKMot2m+utoX/2/NXKxEWaz7Fot0DXDdoYhEvfYhmnl/i6MXU2UzQGnOoG0DJBxyfbl
 +WuES/AwqX9i00FJSoeiusdn471w6l1hhEvB8ehXIk4HzZu+beG/3pBLDZw0YcTzOXG4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wEn6U-0007D6-6p for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Apr 2026 11:47:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E4F560142;
 Mon, 20 Apr 2026 11:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92866C2BCB4;
 Mon, 20 Apr 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776685664;
 bh=079Sd9B0THqZauyTaA39ffFEl5GJG+gEUoXDQzKrZpo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hs2fKTwUNjLyzcf4Gg/boqTc52L2ObmmkOldSQy6U3VerH5A3zs1R7oYoF7W7OQI5
 CGWPWVZKNDeDrIAdzSLRnTAniNcutZx4TRNeeWvDXNdGDuXkOvzaSfJm0HFAswmbmd
 spVyBpWzHtGJMCaLhJxn8Y0QYQ2Fv928gX4eUv7vbrBzP/KmaSQFNGSh9wcIDnWIPH
 DOWJ1YUKXgpgpvM36lK6SfTFggdsRPTONF67YD3NuxX5tVnKZrRDtR2rSsWpOVxUga
 r29QpZ7aPWnbwTOwHexYMdGtCUF7xabwKdxKehFTFoZjjH/dh4fkyaFjx8TqogKoOp
 POIUQ50kLWyLw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Apr 2026 13:46:50 +0200
Message-ID: <20260420114714.1621982-4-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260420114714.1621982-1-aalbersh@kernel.org>
References: <20260420114714.1621982-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wEn6U-0007D6-6p
Subject: [f2fs-dev] [PATCH v8 03/22] ovl: use core fsverity ensure info
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
index 2ea769f311c3..dd2e81022e4f 100644
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
+		return fsverity_ensure_verity_info(inode);
 
 	return 0;
 }
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
