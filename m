Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0898C48BC4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:45:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcPVU-0000ox-Q7;
	Tue, 20 Feb 2024 12:45:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rcPVT-0000ol-Lw
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 12:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gz43b9HwF34kiL9Mz8e28kFJo/xsbHXMBXEu0vR3zt8=; b=SBI6NAF5g64r5nqRqYQk9noTHF
 0qdhhvcdF0Ak/1Kjv45l6oK+zn9pUMK8eNGKGWceLcosEi58TZHdPH5zV0GwyxsqEPvtgnaRgz0pV
 1tBq7m/UEacJBiZVCt7uxwopxuc6MYUdseF/MgA5C44R/bR5Vr+RxwfwcedzG9zNpHmM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gz43b9HwF34kiL9Mz8e28kFJo/xsbHXMBXEu0vR3zt8=; b=P
 bIoYyOTfeBzKi/vPZ4nTSVRttBdvdedFkFyOoNR3FlTGKu/ktuBg9ST/0n6YAP8TTzeHHIXEqYbUf
 NVdIMNaAGlzZQ0oggPua411/YW57o52rpPwWmWoNpBIcDPgNTUuaTqyyfAUlQiS31Uis3vRyd0Awa
 emNgnUl+Oqx15+K0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcPVS-0007az-7W for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 12:45:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2CA5B60F7F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 20 Feb 2024 12:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D44C433F1;
 Tue, 20 Feb 2024 12:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708433149;
 bh=NxeI5/+sydQ6FjSDx3lh9o9wcPPGiaQ/jn1SDP80AE8=;
 h=From:To:Cc:Subject:Date:From;
 b=DD8PLyeKhJGRzR7pUGnb7JX3cH4WqAYlSVAOCy8ptv5a9xxQlxkd9ahvqn5hGvArG
 ZnQeqStquieOsnYCzdt3dSVurMZOhzIGYF2NsUennXf/gccPorimStvXiyULq8RmfA
 +Pd/q7sR2pxZ/zRAGZ8c2Pqs4i+2dNRrEHQTPyFaCY9uPxkOGg7yf6vAmn6pn1x3zT
 7CCO59t/xoIzT2Lcx3C9X6RKgEiaZpkf5epql4yCmms8RlOtZOYkXpQ1ttyOJMKsaY
 3qpEYwGVRWZC6ZaooMkZI7uYYfN/sYDBlJJdNuMW/SxzoR3Lj24tJk5cOvE785VCTf
 B0Klv7kKB1Iug==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 20 Feb 2024 20:45:35 +0800
Message-Id: <20240220124537.11531-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rcPVS-0007az-7W
Subject: [f2fs-dev] [PATCH 1/3] f2fs-tools: remove obsolete fields in struct
 f2fs_sb_info
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

No logic change.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/f2fs.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index e31be22..187e73c 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -257,9 +257,6 @@ struct f2fs_sb_info {
 	struct f2fs_checkpoint *ckpt;
 	int cur_cp;
 
-	struct list_head orphan_inode_list;
-	unsigned int n_orphans;
-
 	/* basic file system units */
 	unsigned int log_sectors_per_block;     /* log2 sectors per block */
 	unsigned int log_blocksize;             /* log2 block size */
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
