Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8CBE77197
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:09:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tVExI-00020F-40;
	Tue, 07 Jan 2025 19:09:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tVExG-000209-EV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jan 2025 19:09:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UChTaO8HBY0OGgoQMxJB4sc91sg2YBr4vzTPb3z2y4I=; b=UWJWtiaoLAFuvlQimZxjcG5eWh
 8WZhSezYJH1SL/sDqMe/NSAorNXa5CrP28NEmV3lAkVPHcEhADH9QTyyiFbk2d+5K8mT/w2LXn5un
 zIIjAfG3vjrNl8fNJuX/MUkU+uUdfVmBhDNJRphHOQGUSsAinBvS4Qe63VqS/zaV/HIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UChTaO8HBY0OGgoQMxJB4sc91sg2YBr4vzTPb3z2y4I=; b=ckSdkkgO8MWHl69AeeQtc4d8ZE
 2sEYsx4reMI0UkA+8ZoM/u2WpxjBEvUATnkBBfhTINjR90nKHoFYg+US6vEAUlb+TPajveKIT9We1
 +IKJCrt2pL3hhCaJnfljrOGFrogqLV4/pXxGrTuJM0P1PvZDCTwwaqU2PcQAAQtNSwcE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tVExF-0001ww-R8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jan 2025 19:09:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 620215C3E0E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 Jan 2025 19:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFE1C4CED6;
 Tue,  7 Jan 2025 19:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736276959;
 bh=3ChjLEH2Vi5qdMF9ShjXrArq8O//qh0p1xCr5BlE03I=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=IRN52XIvf5V4VHO1r39tAOGNg+FK0i71i81xzsfDbIAxCSWJ9kRj0l5KcgNE3Fsec
 C6j76jSUVIl1D0dGUNWUlgVTTIQbbzZ68Gxmed3n7tkiHsaAGJGGNLWpRR26CAxUEc
 Lio6tBVBELWViRCwx66fNZPVil3ZQukeXexNd2rVYp3u2JRk4vnfBpz9usO4I2txxS
 5V6MO2UYZx4aqkop9PRKqgik1YLGnu7XoxPzZq0U+7kFCycEnWsz9SX3Fq8Mgdbg+o
 qgPkZEAidVcCpZOMETk0whlZJOsu13qQmltZ2eezsh1qO9MB4sb1LEQX8oKBaTphpI
 83xTa83GgH9+A==
Date: Tue, 7 Jan 2025 19:09:17 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <Z3173YjGWtV5r_W8@google.com>
References: <20250107023248.3702924-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250107023248.3702924-1-jaegeuk@kernel.org>
X-Headers-End: 1tVExF-0001ww-R8
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't call block truncation for
 aliased file
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch should avoid the below warning which does not corrupt the metadata
tho.

[   51.508120][  T253] F2FS-fs (dm-59): access invalid blkaddr:36
[   51.508156][  T253]  __f2fs_is_valid_blkaddr+0x330/0x384
[   51.508162][  T253]  f2fs_is_valid_blkaddr_raw+0x10/0x24
[   51.508163][  T253]  f2fs_truncate_data_blocks_range+0x1ec/0x438
[   51.508177][  T253]  f2fs_remove_inode_page+0x8c/0x148
[   51.508194][  T253]  f2fs_evict_inode+0x230/0x76c

Fixes: 128d333f0dff ("f2fs: introduce device aliasing file")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c04ee1a7ce57..00f340c91fcb 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1275,8 +1275,9 @@ int f2fs_remove_inode_page(struct inode *inode)
 	}
 
 	/* remove potential inline_data blocks */
-	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
-				S_ISLNK(inode->i_mode))
+	if (!IS_DEVICE_ALIASING(inode) &&
+	    (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
+	     S_ISLNK(inode->i_mode)))
 		f2fs_truncate_data_blocks_range(&dn, 1);
 
 	/* 0 is possible, after f2fs_new_inode() has failed */
-- 
2.47.1.613.gc27f4b7a9f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
