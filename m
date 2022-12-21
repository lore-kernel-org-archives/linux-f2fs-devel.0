Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540CEC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Dec 2022 12:15:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p7y0F-0005Tp-3H;
	Wed, 21 Dec 2022 12:15:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p7xzz-0005TG-Mf
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Dec 2022 12:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vDMILgjo93gbeP8I7Suf0o+pT3pn9DuYJgRLp9u3gfE=; b=Dpe+k3YAAE6ktiIZcGq9nZBalO
 wUt5CUyBj9Bi+537C5q5t0JLmLY88h7Y1qs1yF1KiOtlRSMW8XhL1kkHNICgLNU4E60FqyB631Pes
 iu6r4U29ShdGuvS3XUUr5CcZPciXs12NGMQ0/KUQcE0HCHyL6YvguCbMFr4q/ah2cV1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vDMILgjo93gbeP8I7Suf0o+pT3pn9DuYJgRLp9u3gfE=; b=T
 W9/zAMUQ7krQL1GrS6rXISUPJItiJYlw2sv/awwU6i6svJfI6DXbnlEjakU/6ffa+QwK4EvthU3wN
 udU6EydYHDjvyfDn8u1LC1Y70q8oY6ZADSHkYvCHOFuM1DH9qi+ZWNMwuhZ4NAB/5d5yzXjoJtAQu
 Y9cBzNI/MiPGTU54=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p7xzs-006h39-6C for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Dec 2022 12:14:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C74B361779
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Dec 2022 12:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2728FC433EF;
 Wed, 21 Dec 2022 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671624890;
 bh=xHeuYny/QiUYypo1l91/ZWGhfaqY5OXoUHg7oqTSwt0=;
 h=From:To:Cc:Subject:Date:From;
 b=b4BuqnZ9f7fXig9gfWkhZ4r0fC9Ka2RlZeZ3EGonvK9v4dpNo9GV3lUW9gMs5TXer
 IbPy63WfMasS8plSOoMQzjojtWoVk/xJWZuz1kz2R93h6aKeriu2OGg4giUG+4jYg9
 HZ1hS4fWwbSUFEr3oH5QotXa3PUW9usoSuSnRUXu3ZnIOXuCNaZ+sZbKpq24uYreTg
 Lmh7GirSDLqkTIvG+QMuEtMgYhaYC2QUw4oPnki6ipFL6jeymnDn16f1eaqeu330cY
 dlty8GEhAXe091aV6SLyxoahyCDzDwEZFQWa/td83g9rHHoq+xjrimizn3u7bzebQO
 DPeBBTe+gk+mw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 21 Dec 2022 20:14:45 +0800
Message-Id: <20221221121445.14400-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1p7xzs-006h39-6C
Subject: [f2fs-dev] [PATCH] f2fs: fix to support .migrate_folio for
 compressed inode
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add missed .migrate_folio for compressed inode, in order to support
migration of compressed inode's page.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 2532f369cb10..719b0a0184b0 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1813,6 +1813,7 @@ unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
 const struct address_space_operations f2fs_compress_aops = {
 	.release_folio = f2fs_release_folio,
 	.invalidate_folio = f2fs_invalidate_folio,
+	.migrate_folio	= filemap_migrate_folio,
 };
 
 struct address_space *COMPRESS_MAPPING(struct f2fs_sb_info *sbi)
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
