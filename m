Return-Path: <SRS0=cS7Y=J4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAA8C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 May 2021 14:12:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A200613D8;
	Sat,  1 May 2021 14:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A200613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bi-co.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lcqM6-0000wp-7c; Sat, 01 May 2021 14:12:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bevan@bi-co.net>) id 1lcqM4-0000wV-Q3
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 May 2021 14:12:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WXa4Cuw9qKU4xwgXJS27MAyWxh8oNeCPTop2rSAzDf4=; b=lhC7sysNYn2KpYB5YtND5C9BX7
 MIho/BrhGA6P9lp1IVXIoV6qvZgJXKNXqFUqTwTl0L89qn5foPh5NRGyOtOUggHmsLZU/oUuwdD6e
 LeTmjz9vnSHlEMfnFPP+m17QgSjKl5YGgPDQhtwf00PyIOgNY8dmn1pUCYrffNsklhaA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WXa4Cuw9qKU4xwgXJS27MAyWxh8oNeCPTop2rSAzDf4=; b=C
 7NAEj4ssktjBZzm3HDkNJp+/VY0up+znTXO9Vf6SpRnJ3DvYcRZCGw0CMwp/lpQPtj0y3dI71hDqm
 VQ4HmEJp1E9yDQfXENoEcDOQFOPJkybCvtpyKo7dj9DyIgOSKlOUYN9qJM2JBH3r1vqhXlio3//Ij
 JvIP/XTBcURxiRPA=;
Received: from voltaic.bi-co.net ([134.119.3.22])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lcqLz-000gLq-S0
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 May 2021 14:12:24 +0000
Received: from rasputin.fritz.box (aftr-95-222-25-254.unity-media.net
 [95.222.25.254])
 by voltaic.bi-co.net (Postfix) with ESMTPSA id A644A20A17;
 Sat,  1 May 2021 15:52:51 +0200 (CEST)
From: Michael Lass <bevan@bi-co.net>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat,  1 May 2021 15:52:41 +0200
Message-Id: <20210501135241.947-1-bevan@bi-co.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Headers-End: 1lcqLz-000gLq-S0
Subject: [f2fs-dev] [PATCH] fsck.f2fs: update kernel version in superblock
 on forced check
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In 1126e38 (fsck.f2fs: add --{no-}kernel-check to bypass kernel version diff or
not) the automatic check on a kernel version change was made optional and
disabled by default on non-Android systems. This also disabled the update of
the kernel version stored in the superblock if --kernel-check is not given.
Restore the update in case a full check is forced via -y or -f to properly
reflect the version in the superblock.

Signed-off-by: Michael Lass <bevan@bi-co.net>
---
 fsck/mount.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 6b2f17e..cc140a3 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -967,12 +967,13 @@ int validate_super_block(struct f2fs_sb_info *sbi, enum SB_ADDR sb_addr)
 					c.sb_version, c.version);
 		if (!c.no_kernel_check &&
 				memcmp(c.sb_version, c.version, VERSION_LEN)) {
+			c.auto_fix = 0;
+			c.fix_on = 1;
+		}
+		if (c.fix_on) {
 			memcpy(sbi->raw_super->version,
 						c.version, VERSION_LEN);
 			update_superblock(sbi->raw_super, SB_MASK(sb_addr));
-
-			c.auto_fix = 0;
-			c.fix_on = 1;
 		}
 		print_sb_state(sbi->raw_super);
 		return 0;
-- 
2.31.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
