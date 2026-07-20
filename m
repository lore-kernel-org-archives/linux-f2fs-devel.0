Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89835C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBatrioos2NNhuN86FzAWnd2XUGGIpe9YQd5qsL6mRo=; b=J7/c+bS9+lg/CHcVM6rvI6ladm
	AavftWXVHw/EVJzn4qtVj0Sydi+wHeurYRrGE3+jzj2yZNmocN3tUwPC9vEZ3zv1O5FoyFSe1Ay/q
	no+fJykgizawnDzaAkCRSnXTr5DxSP2PwoQ248pHTBWHHwjw1zbI+Z9zmyI/5AWQp+PY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wljwC-0008Or-OA;
	Mon, 20 Jul 2026 09:05:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wljvu-0008Md-JJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=; b=cQTY9lKbdbhHswWl5K/9MXSCsL
 AaSyvTfYUsJk4Ydh00Y06MfqrELEzuPBc3bS6zVbh9w1tmKGy9K/0vGX9kPEftx9Kv5JoJ78KQZL+
 vXuGtbp/S1ZpkieWx0YbP3BXvSJudneTDDunaKluhXzOj6onp6OLzxiEYRKKHr3Yxpf8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=; b=g287m791dqbn1G4wgveoUKWG14
 QBq9UVGNcrVqn5vEsyv8IDLQiV/buXOAhY7KvqsoglEdjPUsyKswzITbwomvimvAiGd+RcSGziJrf
 BiSMXz4TafY0aAGUxYS75lgM39cUxR0JYNk8j5bxt5OU5ClNrv4t3UCWfGPs5Lggdr94=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wljvq-00085g-Ot for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:05:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7CBF843CDD;
 Mon, 20 Jul 2026 09:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04351F00A3A;
 Mon, 20 Jul 2026 09:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784538297;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dFDAmq/O751nHlfU/ysdhZmnBEWGVNmgKL/GJ0Hsmsgp6bGK0JW8eyw6HE4D71qt+
 KX6NFjlIn4w7Z/kbfcrk8a+97KBN0dDhVXBrF0c0jH5AYgqn+yRtP9iomFIB1AiLFi
 XDsLi5FRHMh/JGHyKUoUQ/DQzREaC047TUlHNQXJRqmIRiJ6hr7X/7pmJs56gf8ffJ
 F9KSkf5dE0ni1nbEYf4oA0uKO/ZgWDyM5tkqqwXS2iV/T0R3OhUJJbueRwhr7GZ3hE
 ZKg1fdUn+EjoVCQadALnHZ6K5hE8FbpZlneVpK8LG7TIAS6FTJMy7FWPdGyTEYRw5G
 k36r96HzKlXgQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Mon, 20 Jul 2026 11:03:29 +0200
Message-ID: <20260720090410.3487990-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720090410.3487990-1-aalbersh@kernel.org>
References: <20260720090410.3487990-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wljvq-00085g-Ot
Subject: [f2fs-dev] [PATCH v12 01/21] fsverity: report validation errors
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
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
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
