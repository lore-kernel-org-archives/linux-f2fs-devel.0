Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE700C48260
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:25:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rb5hi-0004dh-IQ;
	Fri, 16 Feb 2024 21:25:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rb5hf-0004da-VJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 21:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hryzUS0A4oTQ6IR7z7v1g3pNVNzqE1hRuZsE/mtHNow=; b=meDZ7LVJ4/8XZtyQXw19LBDn3X
 8m9XcKpTRiWgphPbZo3cOWq3yMYqUSKnQg9t/HJh0JOMO8US/vnPyesygacn513Lk8Qpy3kbogij7
 FclhI9V9jo1b5Wt2HJuj4w8QmaVbIEamrXmqwhhooXEAvUNps5taulsp9ERwIJZlhDN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hryzUS0A4oTQ6IR7z7v1g3pNVNzqE1hRuZsE/mtHNow=; b=N
 l0+pL8rkBQ/qtTe+4wEowD3gX9O7nfxqPC1Hvdd7rB3pREGs1tRNK0OBaPazM63tg1I8//euG7Mk2
 nJhA72EQ1wA7fGsfYgm4FpZylGNiRCPhYzQhIxPzLB+GHiJLyffJ4bk2APChVqqFv7RXYSMzdaWJF
 LxwIVeV3gl8sLOgU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rb5hd-0007aV-SM for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 21:25:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 34954620DE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Feb 2024 21:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1906C433F1;
 Fri, 16 Feb 2024 21:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708118691;
 bh=1i+pVhlJw8ZeK4z5/rWVxY4m52zCv0TCoSsszJOhmhM=;
 h=From:To:Cc:Subject:Date:From;
 b=OAkv1vKlJ8174j6KWIriPqCu4xUhlEMrQY5j5RML+usHREDTOS7T9766wI/+8lafH
 nA7hTqmMcdl+MUEX50CftxdNsbRCKnT/k2ncxCxzv0InZMOHAz07l+SbukuXn2HCek
 ubNgjoro7Bog802NVnIkUUzeOk1E3KFQJq6cyMMvTZ+bseWip6niSkR3PRlJ2kHvDh
 YECZr089G2MNp1c7u8GsU+wtqXJ5fKrMY2h2c+upsYJmvA2AGwgzzGrYSU4S2qIoUp
 CH/kytN5PQkLNmyTMkcr3g7xMwVzprgNW493xTaVIxTpv7lM4JzbhdsMCH+eE9ISfw
 UsOJA6LDkm2Xw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 16 Feb 2024 13:24:50 -0800
Message-ID: <20240216212450.31162-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
X-Headers-End: 1rb5hd-0007aV-SM
Subject: [f2fs-dev] [PATCH] f2fs: fix write pointers all the time
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

Even if the roll forward recovery stopped due to any error, we have to fix
the write pointers in order to mount the disk from the previous checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b3baec666afe..8bbecb5f9323 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -913,7 +913,7 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	 * and the f2fs is not read only, check and fix zoned block devices'
 	 * write pointer consistency.
 	 */
-	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
+	if (fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
 		if (!err)
-- 
2.44.0.rc0.258.g7320e95886-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
