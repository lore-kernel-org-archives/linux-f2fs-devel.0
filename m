Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54584CE79A8
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Sep 2023 00:47:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qilN4-0003Ab-Qq;
	Wed, 20 Sep 2023 00:47:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1qilN4-0003AV-01
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 00:47:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VmZ2tPmtmZ2KchS172kus413p8d8pxhndwqPNypf7HM=; b=RQBIr9etlXC3BHtbx8WLpasYty
 E+bjlLO5V/dAiNRjge0en9jVFGouzKyJepYG5wK9CedWcJXYXV4+BQB4hxEIcHSizTio6347kcJ2F
 m9VXSzFbh387q8oFWW/82b3/cC7dwG26QzSXfhUsLE6ciEJj+mgFhM0EqyC0GmYP73I4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VmZ2tPmtmZ2KchS172kus413p8d8pxhndwqPNypf7HM=; b=Z
 LIQeZxYdFTViF1v3twaOn0/PYe0sjLrDj+BmnlWzR0W/Y/16wmSS9USRIbs6F7Dm+9Z2NoD1jcEY0
 dZVFqZ6z8h6JiD85KWti6+7LUxAJGtEaf5rr43h3olr2v+0dsu9aqpK1iiX2eXCDDrFHyeAAlmdwv
 mi63cVNa/uYuU4LY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qilMy-00Fl6N-AM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 00:47:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1E6316181E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 Sep 2023 00:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727C5C433C8;
 Wed, 20 Sep 2023 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695170821;
 bh=hIe7iSfzxlD1Ssky6t8tpNboP78N0LngZBkea2BN3Rk=;
 h=From:To:Cc:Subject:Date:From;
 b=D/+bENO1pwEuPTaRAaguImitaJz1Y0zXTJ8C+HrEyNgAQrd5QVA/RtTx2A1539PAy
 +lmO13z0FP6zQ/6XRni1I91F3+IWAPcDX6ByLfbHNeKjuV9XasIjZZ+mS7sPu4uHDc
 lA62UFazSBO1BFb4TbxND7gtfzhTSN7UpR9ZHV5ae+G4510Md4Z+dmYzkVxn/rxyYF
 jDc578zj+TQD477ASBCQeB0WYRHWF3UtUDM/aNc22i2eIEHU9WWqWEKQvlPE3Bu7Iz
 tWIkBXnGfV2s/Z3iSQdjCEKuOQjAA0xRB4/far3aKd4meEP2ehCgLbtFsQjgxQ9s8Y
 eV8PJq2+voe9A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 19 Sep 2023 17:46:45 -0700
Message-ID: <20230920004645.1462354-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
X-Headers-End: 1qilMy-00Fl6N-AM
Subject: [f2fs-dev] [PATCH] f2fs: preload extent_cache for
 POSIX_FADV_WILLNEED
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
Cc: Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch tries to preload extent_cache given POSIX_FADV_WILLNEED, which is
more useful for generic usecases.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 09716127e107..df7703c1f7d7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4858,6 +4858,8 @@ static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
 		filp->f_mode &= ~FMODE_RANDOM;
 		spin_unlock(&filp->f_lock);
 		return 0;
+	} else if (advice == POSIX_FADV_WILLNEED) {
+		f2fs_precache_extents(inode);
 	}
 
 	err = generic_fadvise(filp, offset, len, advice);
-- 
2.42.0.459.ge4e396fd5e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
