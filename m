Return-Path: <SRS0=pHl4=GP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648B4C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jan 2021 19:04:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003FE23107;
	Tue, 12 Jan 2021 19:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003FE23107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kzOyC-0000y3-Je; Tue, 12 Jan 2021 19:04:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kzOyA-0000xV-59
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 19:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uRJj+xf/6+AtHz7iQcnFbkBrvu2f68eBMZQdXHvuHfg=; b=UmDiMITRz9RgGqDjGvGm89Vguu
 G1/mMMzvnKyEMX3eqRtRAwcTqvA06/02TXhjhzLQRngz7y92O8DyikuQq/CuzYwyeszQZf0XJPkpU
 rFhRihRdsYwQXBGs0bO0nlh6AZ0/Ntl39sQ/FQlFmb8EncRmpZgpRzU6l2TYv/jB4GFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uRJj+xf/6+AtHz7iQcnFbkBrvu2f68eBMZQdXHvuHfg=; b=a1lBX/uF983vokbrNa2Dof39xb
 SPJcF4h629LtEizz6L2VnnHxx2k2wDXnUs8m19LTUwXpy4LR44gf03y59Zkcxmbq+QyqonJ5lLZW7
 X8mxoR0u8OlD7VdofbHxN57A+yJqNpPOs6HkN6L5bOnMh3Ec9gajoEIQtCiQS9ev4Lzw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kzOy3-004zDh-G2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 19:04:42 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE1EC23133;
 Tue, 12 Jan 2021 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610478252;
 bh=APAXDrWezK5HVIGjbIEklXvxKBuY3jOk4QoaXXPyPsU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JR7BV63iI5jgPGhz2qNN+JPf5iJrmkunJig27hVsc1kwuLgvJdp4+dgOLu6cMvvFO
 wshU9koqNENnrej7mbVBZMChiirLpyecMJObe1DnzKBfexuGtnuguZvDktJL8nMorp
 3Sfggo5INVs5GQnRsFgVkXpxicS2m+h2jXSKPnhDis9/BdX5y6cgjYGm1/lILslham
 V+ttL7qFmRKTyq2biIaIvwRwfY7r5PzzJm7X5gYGfvDbHmztq4ICemQaQKQc3682FE
 p7HGwU8nrWCMKTeDXAG3DDd6sOXLq4KJpsxJQSV5BOy+L8cD8w5hKGz4Xi7pbNmAym
 s6nuriYCc1LWA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fsdevel@vger.kernel.org
Date: Tue, 12 Jan 2021 11:02:52 -0800
Message-Id: <20210112190253.64307-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112190253.64307-1-ebiggers@kernel.org>
References: <20210112190253.64307-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1kzOy3-004zDh-G2
Subject: [f2fs-dev] [PATCH v3 10/11] gfs2: don't worry about I_DIRTY_TIME in
 gfs2_fsync()
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
Cc: Jan Kara <jack@suse.cz>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

The I_DIRTY_TIME flag is primary used within the VFS, and there's no
reason for ->fsync() implementations to do anything with it.  This is
because when !datasync, the VFS will expire dirty timestamps before
calling ->fsync().  (See vfs_fsync_range().)  This turns I_DIRTY_TIME
into I_DIRTY_SYNC.

Therefore, change gfs2_fsync() to not check for I_DIRTY_TIME.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/gfs2/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc9..7fe2497755a37 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -749,7 +749,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 {
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
-	int sync_state = inode->i_state & I_DIRTY_ALL;
+	int sync_state = inode->i_state & I_DIRTY;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	int ret = 0, ret1 = 0;
 
@@ -762,7 +762,7 @@ static int gfs2_fsync(struct file *file, loff_t start, loff_t end,
 	if (!gfs2_is_jdata(ip))
 		sync_state &= ~I_DIRTY_PAGES;
 	if (datasync)
-		sync_state &= ~(I_DIRTY_SYNC | I_DIRTY_TIME);
+		sync_state &= ~I_DIRTY_SYNC;
 
 	if (sync_state) {
 		ret = sync_inode_metadata(inode, 1);
-- 
2.30.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
