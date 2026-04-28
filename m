Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BACCFF886C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OSPDeUzN+piD85IwWp7HIv9mS7vhKpIEaHnbpJEBEYk=; b=I3ujt3ikLDdin/6FTPRq91E/MM
	O+Dszi0iEDQ2WUQyEoAkWhppfB3rYkTrKWs5kYV2pHdLImYml7kSM9Z66ISuHLNkpt8VG+zm1tEy3
	SUrexmjBF10A0toVhJIJ0SjzaSBIWhPPpl0L5Tq1FYFEXMwBgmicsnBw85mLYAY3Qc1s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHdta-0007UO-Pg;
	Tue, 28 Apr 2026 08:34:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wHdtO-0007PO-F0
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:34:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q24umAnIhjJWMMv84GCWO2VASOQlpvqwGDh+ApTBnaM=; b=QP9/4hG2FQUAzAsIiv5lVfFVbD
 95YY/QiReJQDdS3/Ye8J63EVFkM6VZouj1CnDn7xuEi8QDaAq38EFX08c5aGuNh8g1ZLCrH5gPrie
 EsSkJlb4pF240kfNz8HvPj6U9l9iynEqSokjb/Sd+64gw/Vm74EVau08gd56zqk+vCB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q24umAnIhjJWMMv84GCWO2VASOQlpvqwGDh+ApTBnaM=; b=OGY13eGy0HKsQuKT/X9+BRtLIn
 5nP9Dr8e4z9VYmktFDCZy6HXsY8OF82krW7bVhSBANDEvJWZgA1LW5Zb0m6rpJGspZ2R8cx98BGNh
 24DGzxjU5GDLVoZM6Xp3TXWPeTNVKLLs0t+coroiLJgRrvr0PUwqIgOoGQybk9emHVWs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHdtL-0004dj-Ie for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 08:34:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 030C860142;
 Tue, 28 Apr 2026 08:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AB4C2BCC6;
 Tue, 28 Apr 2026 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777365237;
 bh=xdJuXteL2kuBB7E/JnTWxaOughFhLnHqfW8AFjBOmQ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ojbNuxPphsyZ8HTdoGBHp75YXhvdjhHRFllJFwGaRUsTdPgahL+YYPuRJpxFWpJFY
 nj7fZ93YVXV5Xp1MPs1uWNBM04QafiDgJVASb9cmjW1zKf40idIp90p2iCPKrgmt9E
 R/x6chOm337GJGH4oH2CnyngHdKg3yqxnObUYffupEjPXWt9ysZ/8C3HzsP+bc+bK7
 DxVc84nh/gvLvhv/9eHXlzKV8GmbakbRmUFcRyfTqBwfwSIoHpsiMMhXGEETgP7lC0
 YLHUa+NnnS1fcjfs18Ls+WqfE7HEuwohAV1fv4o0lzcCQ2Ia0V2GL3CaQ/H+cCKsKf
 iZlaHaf13QZzw==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 28 Apr 2026 10:33:07 +0200
Message-ID: <20260428083332.768693-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428083332.768693-1-aalbersh@kernel.org>
References: <20260428083332.768693-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wHdtL-0004dj-Ie
Subject: [f2fs-dev] [PATCH v9 01/22] fsverity: report validation errors
 through fserror to fsnotify
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
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Reported verification errors to fsnotify through recently added fserror
interface.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/verity/verify.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4004a1d42875..db8c350234bb 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -9,6 +9,7 @@
 
 #include <linux/bio.h>
 #include <linux/export.h>
+#include <linux/fserror.h>
 
 #define FS_VERITY_MAX_PENDING_BLOCKS 2
 
@@ -205,6 +206,8 @@ static bool verify_data_block(struct fsverity_info *vi,
 		if (memchr_inv(dblock->data, 0, params->block_size)) {
 			fsverity_err(inode,
 				     "FILE CORRUPTED!  Data past EOF is not zeroed");
+			fserror_report_data_lost(inode, data_pos,
+						 params->block_size, GFP_NOFS);
 			return false;
 		}
 		return true;
@@ -312,6 +315,7 @@ static bool verify_data_block(struct fsverity_info *vi,
 		data_pos, level - 1, params->hash_alg->name, hsize, want_hash,
 		params->hash_alg->name, hsize,
 		level == 0 ? dblock->real_hash : real_hash);
+	fserror_report_data_lost(inode, data_pos, params->block_size, GFP_NOFS);
 error:
 	for (; level > 0; level--) {
 		kunmap_local(hblocks[level - 1].addr);
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
