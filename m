Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF6AC5479D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  9 Jan 2023 03:47:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pEj8c-0006lH-Hr;
	Mon, 09 Jan 2023 03:47:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pEj8b-0006lA-4q
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Jan 2023 03:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2r7sas/9J1FBVf3GFl8ES5/XBH/KZQvSHm//SRNSRY=; b=BUrTMdEK9yE9Jesg0FFvFtzzv/
 luXd/G/SNh+3jHa2jv74cCenNfPztge36yeUvcgEk3NSQTzgHc9xpeK0tD7U5XeQ0UrlEzLK0OtnP
 KbSVWf1i5M7rgZ2RLBqdWT8eh5R1nPdf42Zo6RIP7VUmqLGIujR07JFohp/uhylbcsuM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K2r7sas/9J1FBVf3GFl8ES5/XBH/KZQvSHm//SRNSRY=; b=G
 0scjgZml8km7tzT0JbXOm2YQiLo1mi+qYnL+AtJWEpKh1PWJUBusuqfA8UAiLx269wq0Cj0dgg7wN
 974zwdsNfJliEs3XBzFJ8n90BEk7oOlRu9J5+vQv7HyQ+BGR2GpHimeIKpHMEu/Tl+3m9B2N58JeJ
 YbRUFWK7YRNyWrXw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pEj8a-0003h2-Il for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 09 Jan 2023 03:47:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 32E1360E17
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  9 Jan 2023 03:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609E8C433D2;
 Mon,  9 Jan 2023 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673236066;
 bh=bVMllKVymzErfe1oVh1phFGGebLRoiDWdp3ZzO703Ts=;
 h=From:To:Cc:Subject:Date:From;
 b=J+WioKvUkcckgC2UD76uzWAjNEy9n/kAIXOBWoCOd3NS2G7/WWequuKcAo5Dqo7K/
 Opy/2V8Ajrn9dM1Jg22faM2CaHAY0UaIWKOQR8wn38wuuYoQnDmL6qieaXgPNPSgJi
 /tSxlZ1n/u9FdPSK/VUxwD4SFYk7SDXvbxSyF9Oc1MiiY3MoEpkMpGsTPgrL1uko2B
 FLi0fQ1nQDTgAo9RpyCokD/jt8TrWH+qhmAouTJZli0fTMgsj2yuMXxMCDlXUeA0KD
 3+NYa4NkrKd8nJM9PJxUTpndWjXOw6Gnl+X9So6Ruh7KAEjZIHvS9WCZkfbn8YTp61
 DGk53B1hbGBaA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon,  9 Jan 2023 11:47:34 +0800
Message-Id: <20230109034734.491518-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1pEj8a-0003h2-Il
Subject: [f2fs-dev] [PATCH] f2fs: remove unneeded f2fs_cp_error() in
 f2fs_create_whiteout()
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

f2fs_rename() has checked CP_ERROR_FLAG, so remove redundant check
in f2fs_create_whiteout().

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 6032589099ce..82923273f4bb 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -926,9 +926,6 @@ static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 static int f2fs_create_whiteout(struct user_namespace *mnt_userns,
 				struct inode *dir, struct inode **whiteout)
 {
-	if (unlikely(f2fs_cp_error(F2FS_I_SB(dir))))
-		return -EIO;
-
 	return __f2fs_tmpfile(mnt_userns, dir, NULL,
 				S_IFCHR | WHITEOUT_MODE, true, whiteout);
 }
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
