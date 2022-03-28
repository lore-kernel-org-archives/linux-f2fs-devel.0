Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA2C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Mar 2022 19:43:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nYvGy-0000nL-4S; Mon, 28 Mar 2022 19:43:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <sashal@kernel.org>) id 1nYvGx-0000nE-4Z
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Mar 2022 19:43:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d7LZq9lymTCoUB9g7w6BQCN3fOCfqrT7aTq+Nkgvli8=; b=IDiqiLMfWIlGbeqcW3ETyRkX4h
 539C5cNFgjH2B9zeOZ4azH4AEGEhl4DfrhjlMbueWwQ60UXVAgXVhlTSuhTecUkB3ba8G8BsZ9Y4P
 k6Pzepr0qaLE1kxwVbrT5zUNZt/DwDBRZfov8Js81mu1knTJltNvUm1IvWM76o2axbJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d7LZq9lymTCoUB9g7w6BQCN3fOCfqrT7aTq+Nkgvli8=; b=i0HKSHwEd5sg9e+oUDo3zTn+U0
 UwQLL4DL3Y2akJkEJdkbpvEczPkc0RG1OI4gaB/H53KGophz6PsREi/dvXbxIWIcI5HkkHlpyewt5
 ind2/8YQajwWmEroYNuGG8285v+sDmiR8WkrKD5roa3mhmd92EI2U5lkrcKxYCNAg8N0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nYvGu-0006v1-WB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Mar 2022 19:43:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 95DFC612BE;
 Mon, 28 Mar 2022 19:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D54CC36AE2;
 Mon, 28 Mar 2022 19:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648496599;
 bh=3mVceC6AcY9ncUUXgaCeHhUlEPjZyjB+lH7uocOn1Dw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k56QBf5bz/S7DAR1jKzeKT3s2IH/74M1QmXQWlP3My4eAmiRoU1/mVX3BZ1xzVaNs
 CWJt8oLQAnGCL31GIEvEBFrYey+9L9puh19EnTJuVZ9QzvKbmK/2gVMyunVerkNw+I
 sZJY+3ERehfH0Lig9VId3a8CTe/ZppK2ZF/NZQhAhkYCVNbF3jg43nvgqqADQwQzIa
 QvrOY4AzYQ6D/vt/Xxckueio1BXryd7if9aFHknubAseYaE5H+9aNtz9JgDLSkQrHz
 Vb14xrqzk1n/WlmG/s3OOBj9glXyC4yrfn4yhTtHImu/VGAIQkiJrKyFRhH0Pgsp5n
 QCIbo/hLvIDeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 28 Mar 2022 15:42:57 -0400
Message-Id: <20220328194300.1586178-14-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328194300.1586178-1-sashal@kernel.org>
References: <20220328194300.1586178-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1nYvGu-0006v1-WB
Subject: [f2fs-dev] [PATCH AUTOSEL 5.15 14/16] f2fs: compress: fix to print
 raw data size in error path of lz4 decompression
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
Cc: Sasha Levin <sashal@kernel.org>, yuchao0@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit d284af43f703760e261b1601378a0c13a19d5f1f ]

In lz4_decompress_pages(), if size of decompressed data is not equal to
expected one, we should print the size rather than size of target buffer
for decompressed data, fix it.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 58d255d3a518..6adf04725954 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -312,10 +312,9 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 	}
 
 	if (ret != PAGE_SIZE << dic->log_cluster_size) {
-		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid rlen:%zu, "
+		printk_ratelimited("%sF2FS-fs (%s): lz4 invalid ret:%d, "
 					"expected:%lu\n", KERN_ERR,
-					F2FS_I_SB(dic->inode)->sb->s_id,
-					dic->rlen,
+					F2FS_I_SB(dic->inode)->sb->s_id, ret,
 					PAGE_SIZE << dic->log_cluster_size);
 		return -EIO;
 	}
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
