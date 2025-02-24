Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E19C021B3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Feb 2025 06:20:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tmRpp-0001Zx-9r;
	Mon, 24 Feb 2025 06:20:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tmRpo-0001Zo-Eq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Feb 2025 06:20:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1z7dyvA4L1Z1meKvlko5/q/rST0BL8cBs6ZSDmVV4bk=; b=ZkzPpo73hWfhUSScAZkJmVoLzZ
 l4/sk84/1YFNH2mECpv+IistqyDHNlkYrxwubyH9DsYDyJ86lJ5o3B0PqLAYRJI/lKdxlVS6jnE4Y
 /f+5H05lAvh80KpRwXZwag5OFLNVR/TrDwdDv4GGqpJTaiG2vQxd2UiEpSOW8Wn6Gaq8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1z7dyvA4L1Z1meKvlko5/q/rST0BL8cBs6ZSDmVV4bk=; b=N
 +2dtAUjBHjeEHPD0cNDKaLFcrWgtXLbNFqgZ3njEXnEhM0m8Av3uWWr7B1o7CE1dS0iHQKXih6nmZ
 vNE/MeHxFidGoWoxpUS/qfKf1GRj2NWJx2/Iv0kcsqnpFBoxoEVY2BRiHLqT9gdBFUh0WtetQ0oxX
 vrxU6qr7Ur9DH5Ro=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tmRpn-00007B-PG for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Feb 2025 06:20:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6769F5C3F5D;
 Mon, 24 Feb 2025 06:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D980C4CED6;
 Mon, 24 Feb 2025 06:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740378045;
 bh=7OtZJfqDd0ZrnQtT/O2ih4YwberR7j86G/2C/12j1BE=;
 h=From:To:Cc:Subject:Date:From;
 b=R9A8gXtRMyEOrT96mcStzZ6V40YMpw2B3JohNiCQ6NX1CLsLlBcaemiAs+2q+apLo
 uze9RkxGyxbuUBT1tidHi4p8A4j8T2Lp+p2ltQlyYMuJyGR31FWO3fpCvF9PtGJaqF
 7/GKvzz4pSG3pQhQG0vNI3zJxuwKzJz2Bap9bhbCcoRYYYa6iSjvMv10E0PWJmq2F+
 ipwE5uw7zFuJe7TBgnGf+5TuvN7UetXoGieiuN+vPt+sqb6zIf33XQEvY+wLmahTEv
 MxBOEfTzIjgrN3Fc7iTR+hqs/C5vIH/ZluIG9TUKPBIn90tLiGGt4C517t/k1Mx+PX
 VdeXnvFUKGF9Q==
To: jaegeuk@kernel.org
Date: Mon, 24 Feb 2025 14:20:07 +0800
Message-ID: <20250224062007.1324623-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
MIME-Version: 1.0
X-Headers-End: 1tmRpn-00007B-PG
Subject: [f2fs-dev] [PATCH] f2fs: fix to set .discard_granularity correctly
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introduced
a bug, when we enable discard_unit=section option, it will set
.discard_granularity to BLKS_PER_SEC(), however discard granularity only
supports [1, 512], once section size is not equal to segment size, it will
cause issue_discard_thread() in DPOLICY_BG mode will not select discard entry
w/ any granularity to issue.

Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Yohan Joung <yohan.joung@sk.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ebe25eafafa..2b415926641f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2320,10 +2320,9 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
+	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT ||
+		F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
 		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);
 
 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.48.1.601.g30ceb7b040-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
