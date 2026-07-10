Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F97C44506
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBatrioos2NNhuN86FzAWnd2XUGGIpe9YQd5qsL6mRo=; b=CrKTZq9+LTh0aVSTWnIDza1HZz
	yIeforcnq568U9lSJ5GuO0E7vXasWludTfT1w9eMiVODSpFO0iuZp8FNN54sKFrMyOQwNpm2i+oaC
	vIpLPZ8+/ErWMpwKSKaeWQZ6D8nMtDJvPi5Hfvvhgv98/ozjk2qFBDBBDFeJwp4Y25AM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi6zQ-0007KR-QZ;
	Fri, 10 Jul 2026 08:53:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wi6zO-0007KI-VG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=; b=I7voZ8WWIUsGYUyFVpAMAoeXjq
 rQESC6OqFnU0rGkGZLipvOIiSBCCpv4P4IIfn1XJnckwMepMYfyWgGHeZMsfHtmqmzimJ/eXK1puc
 uLXvmltHVbpREL7aNqVrF7kBfETZAvDSLhJ11zcJaW8EatRXGOBUyN3+Ume17qS25ob4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=; b=CiaIP6aor4Fzp7QZUlTnenib3q
 8fq1yFshcUhw+v4H2nE2GfhINC620Nqgb9xvIajUQSqzJmQZJQ8ln+PA4GGH1pKeqMIpgXRrVOQCQ
 pcZ4H1M2FEninEFGQriygtAxC9nrH5SItEtGa8PMyF2GjZtYG8s8G1x7e3C8GXNQXF/Q=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi6zK-0007TK-5g for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 08:53:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF9FF43A0C;
 Fri, 10 Jul 2026 08:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8951F00A3A;
 Fri, 10 Jul 2026 08:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783673607;
 bh=DLKRiRyzKQ3SHGS6qPdEtB2Y8TKgDvD/nkziuhY4NXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fnyQROum70ijbU5Z49G0hvrG8+doOE7gAQL/4D/D5cMRHq3l0iQco3fB0xdABkGm/
 J/OC9ihBFbPmQiGwfR/1uLFuNrjF4R4QJ5H1E1s63oTjdTa7c8n9OuNWkS4h/KPTys
 IaUU9CRck6mAC7dxxEZB+PPtQsEO6ullrsYQAJpYm2+L6vfgbX9OJqRo5a6Ex1HBCT
 /OBGtIxVW7mE6T+5PfF4JJ4UVJtMpCyv8bQPE1ofwK1ma4f0Ai1La1qWHlYd3wS3Pl
 InsRCTK3coXlAyVvfzUvTITKqSyN7+YiPTGp5C/CHLo9NjP/z++Iao+3UtY5iLW3BK
 FJRrWADQhjzpQ==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Fri, 10 Jul 2026 10:52:29 +0200
Message-ID: <20260710085256.3464201-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710085256.3464201-1-aalbersh@kernel.org>
References: <20260710085256.3464201-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wi6zK-0007TK-5g
Subject: [f2fs-dev] [PATCH v11 01/20] fsverity: report validation errors
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
