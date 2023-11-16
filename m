Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9547C54FB9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Nov 2023 06:26:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r3VpV-0004v5-8Z;
	Thu, 16 Nov 2023 06:26:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r3VpL-0004ux-8u
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Nov 2023 06:26:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g1hZefIHY8SFwKkLVv2TQxgJr4q8W7A1nr2ia8yTO8Q=; b=EseMPVbCswoXhNHxUM4Vw8za3c
 UFbyskDtiFK7zsk34YvKu4PxahzMVkeoUmQ8pFokmUd+fl+Kv0dqgOjoi9IeiW0DGydKLIyxveu7Q
 hGoNBjd9r2iTAIB8m5OKBh3bySZpsnMfcxWeZZcvv9yVijkJW3dWkFAlE+/Hcmgyx/ZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g1hZefIHY8SFwKkLVv2TQxgJr4q8W7A1nr2ia8yTO8Q=; b=L
 N+ggidB0kJJqpsXrol1bw/8PVccNDHFgOuJAMw2mOXLz+3i79Y14e4nFK8hA56ig3uxeUftQDeWiW
 uuS/pRAnRS2wbMvLbl5n165pcLid+tYuOA3NuLQile4VPB04ArFHndcCYtDPeXV5YFDx73WNYIkUo
 KAYw3dq6odTQ3wnA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r3VpJ-0077Dl-K5 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Nov 2023 06:26:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 5B382B81C85
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Nov 2023 06:26:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5B1C433C7;
 Thu, 16 Nov 2023 06:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700115962;
 bh=LdQ7fpYx4XjHDzsyZXb0qCihyPciooXY4TAlO70WFe0=;
 h=From:To:Cc:Subject:Date:From;
 b=tjzg/XJu3pN7sLj7482nvRPWD4ZfXv+y3cwgmIn6dzesDklcub5lzV2vPAqSnq+xi
 5sZ7lQgMTzc2xmxBS6TyyrrJiYgw14NCfohsaxtFcZyGBdtI2aepFCjc6SiL1R5AWa
 7qSuKpJq3NNgR4vN4xPVMO2APRWkFgIiSBIrB0vXvcKmhfTw/bwSbELJZgnigeMgtH
 ojsdDCKgTnsOmXziWm7yNe61anSBtCITcLPKy1/W1jbUrXpqBaA6KMid+xG/03Gg7S
 vcvqH0+aXghk7vYHW3L9C9998PKLak/kDOGlwGBodDMS4ztHxM7QyZ4VgE36uIgXuP
 JognBF4pI0rWw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 16 Nov 2023 14:25:54 +0800
Message-Id: <20231116062556.2451839-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1r3VpJ-0077Dl-K5
Subject: [f2fs-dev] [PATCH 1/3] f2fs: clean up w/ dotdot_name
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

Just cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/namei.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index d0053b0284d8..a9360ee02da1 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -459,7 +459,6 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct qstr dot = QSTR_INIT(".", 1);
-	struct qstr dotdot = QSTR_INIT("..", 2);
 	struct f2fs_dir_entry *de;
 	struct page *page;
 	int err = 0;
@@ -497,13 +496,13 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 			goto out;
 	}
 
-	de = f2fs_find_entry(dir, &dotdot, &page);
+	de = f2fs_find_entry(dir, &dotdot_name, &page);
 	if (de)
 		f2fs_put_page(page, 0);
 	else if (IS_ERR(page))
 		err = PTR_ERR(page);
 	else
-		err = f2fs_do_add_link(dir, &dotdot, NULL, pino, S_IFDIR);
+		err = f2fs_do_add_link(dir, &dotdot_name, NULL, pino, S_IFDIR);
 out:
 	if (!err)
 		clear_inode_flag(dir, FI_INLINE_DOTS);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
