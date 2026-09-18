Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE82CC982DA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBatrioos2NNhuN86FzAWnd2XUGGIpe9YQd5qsL6mRo=; b=ZlBCrMMIdmEdxVxGY4aaeTQGmJ
	/6BlqPShspfNqNTXf4BK/VxwBroHFO3jjLpQcrdf7QPYORdO1SICEGvKBJKVYKblJ1+05kqvt/l7o
	5jBmM05PoYRDAEXMhwb0eOzrqybx9RhGoXF906oTmzxp58itBCglVHCAnen4RHieySO8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7WZV-0005Uu-EW;
	Fri, 18 Sep 2026 11:15:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x7WZT-0005Uo-Ur
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:15:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=; b=LZCgCHdZpRomX0W1mCuuSfcpNb
 Lo6d6pM0NoS3J8u3+HuM2irDRQZa1XM6PZmLGAMs7wZoAQGFa6hqg8RV1Cx9yS1kGGyXbZcgaP9fD
 ypXw45F/xo2ZqxC51ShQUBN9e7YZHdbwqcoLbrCvdlyefyeXhh98VSSKKvGgPSSFV+Q0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=; b=HelfSlqAJnMgKeEYQNsvYTty9A
 w4ums34Ao6PN1pbkW6x7GxIQES+4h5YAeS/lRi6PHWQcYws9vZgjafpG3yMr0N4LI6qd+eLq15k4x
 rCX8R43xaShAdgH9teEOJXaK2mZNvjIx5AUbtpYg5dDRFFR2mQheUDhTHJ+aUsC6/xGc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x7WZQ-000069-Pu for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 11:15:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 20FCA60A82;
 Fri, 18 Sep 2026 11:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB88A1F00893;
 Fri, 18 Sep 2026 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789730150;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FP4QTApr7hJpLklEqz9WwyeMYVNaxpIg2K3e43l/pCgPGpUtciPs82wAPpncpAvZx
 yRRVdEkd0hIO/ahsnsrxgIoeWCcNUyKwBoi3zJHPA+UDVH9LQ3wxd3DwvZwfNz4CDC
 J0YjgxZdLnWOoVKxQWJfiuyamGJqhcvAIZ/mydrZr4qJXrzWhKoQarHeMEkmNfgotj
 91T2fe1j4uelrmVioNeBoqLY/7No++Z9U3IT2pwUKG6hb0VJQCGmpOioebmBaf/VhM
 GSYIOAKKgjpKmmxOTosQk9I0h2ko3dw09FURbc17GXv73kToLoL5rBX7yHSe6U+KU4
 og1zEjvY5ciWQ==
To: djwong@kernel.org, ebiggers@kernel.org, hch@lst.de,
 Carlos Maiolino <cem@kernel.org>
Date: Fri, 18 Sep 2026 13:15:13 +0200
Message-ID: <20260918111539.1003439-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918111539.1003439-1-aalbersh@kernel.org>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x7WZQ-000069-Pu
Subject: [f2fs-dev] [PATCH v16 01/21] fsverity: report validation errors
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
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
