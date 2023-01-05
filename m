Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10117C4708E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Jan 2023 23:39:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pDZpT-0000HA-Q4;
	Thu, 05 Jan 2023 23:39:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pDZpS-0000Gz-HO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Jan 2023 23:39:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rjGczAJyQRL7BmyHPUbOFaJ9k11bk4Df8A7L4oXqu5Y=; b=BGsczKWms+nOioRtiucWgYdY/g
 CNtlMu8iReRMFvor0UIg9/PUdy8ibG68GR+A9l3FUolJtYzi/Opf7SUNeDYyUmoZEMkh781eaqGzh
 xhxMY8HHcp9HBjU9EpPV7UEPyspBz2u5DwfdiDHH+lrJAVwsVIeqyFOLW5ESkF0dd8ek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rjGczAJyQRL7BmyHPUbOFaJ9k11bk4Df8A7L4oXqu5Y=; b=T
 yGvtGYqrws1hNSIEFn7428BTRoKw8uR8j7PLbFt9xEUBya+VxzE8EYoGFarki0piDDg3c64jJVnX3
 h6NBJgluWsAGV0EjRvJ19sjI6UYonbtoL8ehn05U7lTaRZ6Ctw4GYehY7Vjj//DRVXsPnxtR8dquL
 1uIiYx4kDYLH9maA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pDZpQ-006kT7-P6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Jan 2023 23:39:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA2A61CAB;
 Thu,  5 Jan 2023 23:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B427FC433EF;
 Thu,  5 Jan 2023 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672961954;
 bh=k2zX9ykuOQxejXRAE9f9jXrb0X06NknQnoJI39Wq2uI=;
 h=From:To:Cc:Subject:Date:From;
 b=RkwH/EqhZCJwBqJ5dkkcznlUnfj0cVy4Vc5roj2yb6DV6v450qdmWWY82DXxfL2gO
 GzWaq9cBVm7S6ZVy6/tSST7LMTtnQHM8HclV5zAjIxVvzuf63z4FlPDiqwRYSO9Bdd
 5/C4za4dfgHKapnAjjb6s90lDCduK2kyBbh2vdqeFezcPxmoamxf1IjtUhqKbe9Hpl
 45cCz9/cpqUQlQHYuKMZEcLGwsrNL95qjQphh6bp4Q719DgeXSBmdOdpovtL6C2+Fe
 Mr9vkj7pPCJH88S5c7hJAU+fknDB8E1rmObSfmmP820uTZs77a1zBxUJpoSfmbqK4p
 1VQOffNJb7PSA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  5 Jan 2023 15:39:08 -0800
Message-Id: <20230105233908.1030651-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
X-Headers-End: 1pDZpQ-006kT7-P6
Subject: [f2fs-dev] [PATCH] f2fs: retry to update the inode page given EIO
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_update_inode_page, f2fs_get_node_page handles EIO along with
f2fs_handle_page_eio that stops checkpoint, if the disk couldn't be recovered.
As a result, we don't need to stop checkpoint right away given single EIO.

Cc: stable@vger.kernel.org
Signed-off-by: Randall Huang <huangrandall@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 01b9e6f85f6b..66e407fcefd3 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -719,10 +719,10 @@ void f2fs_update_inode_page(struct inode *inode)
 	if (IS_ERR(node_page)) {
 		int err = PTR_ERR(node_page);
 
-		if (err == -ENOMEM) {
+		if (err == -ENOMEM || err == -EIO) {
 			cond_resched();
 			goto retry;
-		} else if (err != -ENOENT) {
+		} else if (err != -ENOENT || f2fs_cp_error(sbi)) {
 			f2fs_stop_checkpoint(sbi, false,
 					STOP_CP_REASON_UPDATE_INODE);
 		}
-- 
2.39.0.314.g84b9a713c41-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
