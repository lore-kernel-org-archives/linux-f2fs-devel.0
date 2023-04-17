Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F8C77B76
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Apr 2023 20:52:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1poVpR-00023y-2N;
	Mon, 17 Apr 2023 20:52:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1poVpP-00023k-Ry
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Apr 2023 20:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+WMJEZfT4Ys0KbwwujZL+IDwoeH9cl1f3Tq+Kx4YCfw=; b=eXLa4hoDxxIMRkVjxq4spKTBvQ
 Simb+aRwxzZx3/2z++hWFO1D3S6kpT8shRTW+cw/TLb7OYi0UKbFmyW2Ln8rZEKni8inyIo9c6peF
 UG3GbEQs410H4ElsPTDs0Vbbp8GrtRoaWCyscTr+Voa1MHzwGJgzDvH8xMQ9ctxVkVTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+WMJEZfT4Ys0KbwwujZL+IDwoeH9cl1f3Tq+Kx4YCfw=; b=J
 tdi5UmuoTw4VCnokOdkh0148B1bP5a5fa/8SDRe1ciPb7h9xSYTS7J8VQZyQB66ka20Zs8fBbhSWF
 z6Q2/Bx1oXkZjesdEbYhdljSHMLhj+0HD5tBiIWNYxy33KOOhp6m3Bv3VtZauM6PAKFcZmwyTULmM
 njY0TxShNAx1MmkY=;
Received: from smtp-17.smtpout.orange.fr ([80.12.242.17]
 helo=smtp.smtpout.orange.fr)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1poVpM-0006Lc-OC for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Apr 2023 20:52:00 +0000
Received: from pop-os.home ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id oVpEphQ3ExZmMoVpEpeIvB; Mon, 17 Apr 2023 22:51:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
 s=t20230301; t=1681764708;
 bh=+WMJEZfT4Ys0KbwwujZL+IDwoeH9cl1f3Tq+Kx4YCfw=;
 h=From:To:Cc:Subject:Date;
 b=WBPHdQE97FnrU3THe4rGoRLKR4JHK/Y5ILwItWtgz+4CItd5B2ajxtyUpjmuMsadm
 OIBLe18VtBypBBIJTwCfVI17B3bWEoRX/EabCkIP1PIAmGXJzddsL2ygaJX7NxCg5P
 kbuFyvrAwmcaUgC8RBPQ3SHfOcJ+3AHhCoGRn6wqVwf2ePJEq+WwlX4TT0eCjns9WW
 J1xcHPyx0j4Jh3NLHA7K900dtaGr4yga7NXKh5bIzuGM4qhhqy8vM7pgBEtxhUtpfB
 PKtXc1kLhtlbyB1AnUOykeKQuBDkB/moakVNYmxGc8vV+NrkRpUbPxspxJ8RSdYLKO
 exQjeJs1mre4w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 17 Apr 2023 22:51:48 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon, 17 Apr 2023 22:51:46 +0200
Message-Id: <523ec4b037d064e92e19203e3ab9a161e3d9aa71.1681764681.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1poVpM-0006Lc-OC
Subject: [f2fs-dev] [PATCH] f2fs: remove some dead code
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
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

'ret' is known to be 0 at the point.
So these lines of code should just be removed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The dead code became after commit 	8358014d6be8 ("f2fs: avoid to check
PG_error flag")
---
 fs/f2fs/node.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bd1dad523796..e7bc87177e18 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2063,7 +2063,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 	struct list_head *head = &sbi->fsync_node_list;
 	unsigned long flags;
 	unsigned int cur_seq_id = 0;
-	int ret2, ret = 0;
+	int ret;
 
 	while (seq_id && cur_seq_id < seq_id) {
 		spin_lock_irqsave(&sbi->fsync_node_lock, flags);
@@ -2084,14 +2084,9 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 		f2fs_wait_on_page_writeback(page, NODE, true, false);
 
 		put_page(page);
-
-		if (ret)
-			break;
 	}
 
-	ret2 = filemap_check_errors(NODE_MAPPING(sbi));
-	if (!ret)
-		ret = ret2;
+	ret = filemap_check_errors(NODE_MAPPING(sbi));
 
 	return ret;
 }
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
