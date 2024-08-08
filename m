Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAFFC52D71
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Aug 2024 20:57:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1scACi-0005Zw-6J;
	Thu, 08 Aug 2024 20:57:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1scACg-0005Zo-Jr
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Aug 2024 20:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FYwedYS9Hg40duzkJFTbP0P8VSdUTT8yJ1ieY7fxwdY=; b=e4EOJohLj7SoxVBbVMRo3wET/X
 6wNS/PkPWyQlFnilHb3Ni8cAkeH2uYW0kbYlSuJtWvDhnY6fSEtjyl3vWhlo5gO+iCNKZZ9Oh12QI
 IfbrxL3YJp8XMj+7QVCE9FsRisSB60egH5M39m1Y5QNVj1xrZ0eiHjdTHCErVVwITG3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FYwedYS9Hg40duzkJFTbP0P8VSdUTT8yJ1ieY7fxwdY=; b=J
 hwtolwxGnzDO81rW8PCxl57qusHUToBSy9dT9pvYRR9zUf8fmkqw6dodlef0iH57blIjiwJAhVZkn
 1wVetWYMrTyUkpKH+aTXa1P9NVmGXZ1x2vJ1mwePoNiB3XqaTzmXskMt3E07ckB+s3C2SyvAUx7GJ
 MituoF9c879xL9x4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1scACg-0005Bn-0O for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Aug 2024 20:57:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A440D615B5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Aug 2024 20:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CCAC32782;
 Thu,  8 Aug 2024 20:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723150655;
 bh=4yzlQrcZXNiLzTX5F20mj6lid7SEECniwl867Zkhdnw=;
 h=From:To:Cc:Subject:Date:From;
 b=WejhZPqjhf29zDOLu+NmYNmTk9ilq+0OTj1mwlOhcyQ6AsdcWlKWqUwR5x2snQNtq
 oqy0UsGLErH7AsBDTUbBJOqcG1SL53WmpFXx+G8vhOwK2gljvuwkUrAIS/MiWDWtpV
 n7bFfmJfDRUICT1YyD3IqXqVhQhPIWBhWBHNmpAT81/PNlNr7wP8YxgpLwBzqWtzbG
 nARUY2ZV6qFFVWJ4d84k0W0y0KyvQYHz0LVwU1OG7AgeAy0s5DunXwJZqPnpyEJLRX
 lW/FckNgBsK6xJxbcYuOaHJ1WW6Jqm6Il9/VHINTRvMXcLeM+DzwGTHnYNfjPP6wpm
 x4b1LcZz5p+Ng==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  8 Aug 2024 20:57:32 +0000
Message-ID: <20240808205732.292600-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
MIME-Version: 1.0
X-Headers-End: 1scACg-0005Bn-0O
Subject: [f2fs-dev] [PATCH] fsck.f2fs: don't finish zones if it's not open
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Should finish zones if they are open.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h   | 2 ++
 lib/libf2fs_zoned.c | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 3f5583d18329..15a1c82ae18f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1742,6 +1742,8 @@ blk_zone_cond_str(struct blk_zone *blkz)
  * Handle kernel zone capacity support
  */
 #define blk_zone_empty(z)	(blk_zone_cond(z) == BLK_ZONE_COND_EMPTY)
+#define blk_zone_open(z)	(blk_zone_cond(z) == BLK_ZONE_COND_IMP_OPEN ||	\
+				 blk_zone_cond(z) == BLK_ZONE_COND_EXP_OPEN)
 #define blk_zone_sector(z)	(z)->start
 #define blk_zone_length(z)	(z)->len
 #define blk_zone_wp_sector(z)	(z)->wp
diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
index 221d7d1337c7..89ba5ad73a76 100644
--- a/lib/libf2fs_zoned.c
+++ b/lib/libf2fs_zoned.c
@@ -513,7 +513,7 @@ int f2fs_finish_zone(int i, void *blkzone)
 	struct blk_zone_range range;
 	int ret;
 
-	if (!blk_zone_seq(blkz) || blk_zone_empty(blkz))
+	if (!blk_zone_seq(blkz) || !blk_zone_open(blkz))
 		return 0;
 
 	/* Non empty sequential zone: finish */
@@ -522,7 +522,8 @@ int f2fs_finish_zone(int i, void *blkzone)
 	ret = ioctl(dev->fd, BLKFINISHZONE, &range);
 	if (ret != 0) {
 		ret = -errno;
-		ERR_MSG("ioctl BLKFINISHZONE failed: errno=%d\n", errno);
+		ERR_MSG("ioctl BLKFINISHZONE failed: errno=%d, status=%s\n",
+			errno, blk_zone_cond_str(blkz));
 	}
 
 	return ret;
-- 
2.46.0.76.ge559c4bf1a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
