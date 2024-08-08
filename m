Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14359C3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Aug 2024 23:33:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1scCd0-0004qf-Ld;
	Thu, 08 Aug 2024 23:33:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1scCcy-0004qZ-2T
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Aug 2024 23:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6EwkzYvpwjbkMPsbFqMbVQm7IQwP37odGXvFjZS7m40=; b=jHXC9G59AISv86/MxTXGMFEbFq
 MG0+09nWd+1XhMDWy3r1mkQuzehqmqsq97ny69ZPmcy8cxRv41MNE+aWMXH0ZxkPp7+duEAqUnYL0
 e0/dxYa50+zyYbmlOIckJpD4hnbZ4qw5x2u1FmBvmzhNLmXhqVatSaVQMC2qJBBL9TKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6EwkzYvpwjbkMPsbFqMbVQm7IQwP37odGXvFjZS7m40=; b=m
 vtC+TcghJsKb4uhPdW+FJn5zkoo4zbzX8IZ3q460ummmEPMU4fsbehjGQGClfxdnLept/NejwCH1C
 2wlz5GD9S8Tu/5glgC7NHWQkFZuqIw9UYEpaD5uTiKzeAmKKmzmoagI7xwEo16nqJonZO6b7ihBrr
 wBUlIZNTQJEQUCXk=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1scCcx-0005aa-99 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Aug 2024 23:33:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 96D8ECE1319
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Aug 2024 23:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC624C32782;
 Thu,  8 Aug 2024 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723159970;
 bh=SqbKcKgerBBcSMoxuW0vFyTYPvj2SwiCchQNiIKg/ZY=;
 h=From:To:Cc:Subject:Date:From;
 b=G8RycILBUAehWRxSyEijZbVifXt2gNF8vx+podPkP98qQsGTPoTOsz5KBFnqHKvet
 SgiVGWaBVjVa3dhyeFbP1zETG57AvxCef42V52Iif5kq+w4k8xJrPhYVY+avY3ksVE
 xzaBwtwlYnP9u6p+8+IZ2G1JKQAmfkvL9VZVT/EFrBDNbkVb7TPV5d/gjq0VhoTPKL
 W3d0ji478UFxBNLROnd3tZ87j+M5iKsv1CYWnz9nGJCyRD+kMlnRHPDnwf/5FUiM+2
 wHZsXc2TtsBq9OqvYMHpr7c2LR6Eh8hLmDKM4rrVo1cz8nMBEqQPLkorSdl0hq26PT
 YzSBsvdpB8WXA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  8 Aug 2024 23:32:48 +0000
Message-ID: <20240808233248.323318-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
MIME-Version: 1.0
X-Headers-End: 1scCcx-0005aa-99
Subject: [f2fs-dev] [PATCH] fsck.f2fs: don't call dev_fill w/ null buffer
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

It'll crach fsck.f2fs. Even, let's keep the write pointers and just finish it.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index a18bee9d0c3b..5fe8ad4ef327 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3299,8 +3299,9 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 					"segment 0x%x", zone_segno);
 				ret = f2fs_reset_zone(wpd->dev_index, blkz);
 				if (ret) {
-					printf("[FSCK] Write pointer reset "
-					       "failed: %s\n", dev->path);
+					ASSERT_MSG("Write pointer reset "
+					       "failed: %s, err=%d\n",
+					       dev->path, ret);
 					return ret;
 				}
 				fsck->chk.wp_fixed = 1;
@@ -3326,18 +3327,13 @@ static int chk_and_fix_wp_with_sit(int UNUSED(i), void *blkzone, void *opaque)
 
 	ret = f2fs_finish_zone(wpd->dev_index, blkz);
 	if (ret) {
-		u64 fill_sects = blk_zone_length(blkz) -
-			(blk_zone_wp_sector(blkz) - blk_zone_sector(blkz));
-		printf("[FSCK] Finishing zone failed: %s\n", dev->path);
-		ret = dev_fill(NULL, wp_block * F2FS_BLKSIZE,
-			(fill_sects >> log_sectors_per_block) * F2FS_BLKSIZE);
-		if (ret)
-			printf("[FSCK] Fill up zone failed: %s\n", dev->path);
+		ASSERT_MSG("Finishing zone failed: %s, err=%d\n",
+			dev->path, ret);
+		return ret;
 	}
 
-	if (!ret)
-		fsck->chk.wp_fixed = 1;
-	return ret;
+	fsck->chk.wp_fixed = 1;
+	return 0;
 }
 
 static void fix_wp_sit_alignment(struct f2fs_sb_info *sbi)
-- 
2.46.0.76.ge559c4bf1a-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
