Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300A8C10F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 May 2024 03:31:18 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s4BXv-0001on-42;
	Tue, 07 May 2024 03:31:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s4BXu-0001oh-1f
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 May 2024 03:31:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pq0+KuPhkV91D5i7EEnuryOU/nXKDDatKqCGN3ReHhg=; b=RnrdEWJxM0dVrRwEEWSOY6WOCD
 TXqxli9f51Ls+d7BEBGYrKe6C5NCRiXpFWpjGBuw5MzrT2ykPNedQ50ezzGF3R0KIbOMDpAFxt5R3
 K2OrgZvAE6MCh6s/x07yp6nUQK9jE4Ceb2YdDZcs6qQ3wuYfA0iRZ9idnpZN4RqhXUtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pq0+KuPhkV91D5i7EEnuryOU/nXKDDatKqCGN3ReHhg=; b=J
 sqjc/L3MxKbuGTSD5KJzjFxEMrNhSMjRWoORf9oas55ikU/NQdubrEV/RZfROq6iJd0+6aFd986Am
 4IVme8MdRlAj8NE1z7mX0p2zNUOdMh/NhyrW+mqd8TDT9dRN9bG80ndB0AKabAuLxEoszQ95d4zGh
 mYm1lgIugiiZHeZA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s4BXt-0007Ws-Rl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 May 2024 03:31:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7B8686033D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  7 May 2024 03:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9719C2BBFC;
 Tue,  7 May 2024 03:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715052668;
 bh=WEn57ZpMPjcw1lMUxGYEU0m2DwBeLhYddgmX6aoQ1nM=;
 h=From:To:Cc:Subject:Date:From;
 b=uMlsUM0oWh47ThJBil5c2EetKK0vGVlcuipp91NLbvzVr/malBRi/8qcDmZ+lXl5r
 cit/OxCDcuY0hlmc09NoP4A72ppqnHkdnKWdMy6IrAUHzACSTj66tGwLbHRCHvWLK+
 duX16sVoiecHSxu8WoLkcmt2jvtF7EJnNRblec/PAkhS/u1y9bYuOA1IBvYv2tn9aa
 Ejm5BFUFsTGTGRawYDH5osVPkyaeTr13c10R2C8W+JvGXF65rupgro1IeFUbKQdwS2
 5M8Ontb+7rN83I77Z1XwFcqXNHR0TpzeiGPq5kr6OlxmDx7kF07W2jKqaN1t9MCmCy
 6mE0s6DqFZVmA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue,  7 May 2024 11:31:00 +0800
Message-Id: <20240507033100.1044884-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1s4BXt-0007Ws-Rl
Subject: [f2fs-dev] [PATCH v2 1/3] f2fs: fix to release node block count in
 error path of f2fs_new_node_page()
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

It missed to call dec_valid_node_count() to release node block count
in error path, fix it.

Fixes: 141170b759e0 ("f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- avoid comppile warning if CONFIG_F2FS_CHECK_FS is off.
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb02..7df5ad84cb5e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1319,6 +1319,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	}
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
+		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto fail;
@@ -1345,7 +1346,6 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
