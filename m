Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9586E10F9302
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJQcqjpgn3KCnkKffQmUTa1poAhxWf5NDMLEqI1z9zA=; b=OCl5py23CqzSRBMwBx/LdLGmEs
	wyd93tbkg4Gr5Gx7yI4h91+BZameLof1d7aU5l/Bp+vqvsgJ/5WA1yR0TG8KFJaEevidW9gdRO/7u
	8IFzmYq6nPVB+P7xxHdZCtZ7qb+bhHPkgxh4ux+pflIvny4u8aF4Yg82siGFJYaCUhf4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w7gdh-0002PA-H3;
	Tue, 31 Mar 2026 21:28:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1w7gdg-0002P4-0f
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:28:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DPei0JogPGZfDPhr9HN+HUu4IkqxLfvr4XhNBDR36Y4=; b=Z1j4aN3NEEnHOPivfO9acOh7WW
 AzOlPjHq03aOZIB0a6VlrGq6ReGOxdHRR5zhDAcrgxHlisWTPHmu+4XgIdFzoX/fm6Mlvsj5pBN05
 ISd3zjc10CgZ3R581CyENvRP5I9TDsO0AZxPQ0QNHKtB+ACNAidxVyos5f/VXXu+Ufek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DPei0JogPGZfDPhr9HN+HUu4IkqxLfvr4XhNBDR36Y4=; b=XZNUKUcK/84a/VJlPz5SOejMW7
 mOs/bR2zYk1+zC2MKUulv5OFfIr7VQcDayEV+XJPwsZTM9m3mzuswtdB26jEJ3/iY2DqnK4jWCkG9
 eNDPG4iq7PXQpVziFh/YzAITnGAkAvC8nEFx/jyhpyiw80BMF+bLVbWV736mRULfDS50=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w7gdf-000743-Lw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 31 Mar 2026 21:28:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 42D6441725;
 Tue, 31 Mar 2026 21:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B096DC19423;
 Tue, 31 Mar 2026 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774992518;
 bh=eEsDt5UPcnWAGREsZ+GTXv/Fu/DqiBIJrko1OcjenmI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aF0cyWLPlUI2IDqKP+3waVZOpUCCNJmbSvz42CEwFDRWonIsq74ZNyIFcq9OD4cwL
 4DN+PK4plFK6j2EZv30QoOAN3Ah8D1571D7JcucKRGrB/U9OitC8BtHR13H7MRj3RF
 1TDLquEs+c2UJyyNJbqfyFVkAwgHNQwhpRQgDhq2gFh+/aYPIfit964RbH8O4Z5y6M
 4Jd3hISVxGIjxiw0x56ZzV+tbBXcxAYsXdDEEuC8ZFZobGvQf8Ugv/6GX7AkQCOKV0
 rDOXvWn/e+uWRZZUiupwLgoqJ05p91ezS0ijosVoPwvGH+VDEKHAbt6jRwnLnTGx4/
 +OaCSczNfF7YA==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Tue, 31 Mar 2026 23:28:02 +0200
Message-ID: <20260331212827.2631020-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260331212827.2631020-1-aalbersh@kernel.org>
References: <20260331212827.2631020-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w7gdf-000743-Lw
Subject: [f2fs-dev] [PATCH v6 01/22] fsverity: report validation errors
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

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/verity/verify.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4004a1d42875..4ea494da694f 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -9,6 +9,7 @@
 
 #include <linux/bio.h>
 #include <linux/export.h>
+#include <linux/fserror.h>
 
 #define FS_VERITY_MAX_PENDING_BLOCKS 2
 
@@ -203,6 +204,8 @@ static bool verify_data_block(struct fsverity_info *vi,
 		 * to verify that any data blocks fully past EOF are all zeroes.
 		 */
 		if (memchr_inv(dblock->data, 0, params->block_size)) {
+			fserror_report_data_lost(inode, data_pos,
+						 params->block_size, GFP_NOFS);
 			fsverity_err(inode,
 				     "FILE CORRUPTED!  Data past EOF is not zeroed");
 			return false;
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
