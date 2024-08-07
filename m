Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA13C3DA7F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Aug 2024 10:24:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sbdqZ-0003n3-EO;
	Wed, 07 Aug 2024 10:24:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sbdqY-0003mt-IS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Aug 2024 10:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aQAuRnG7gspFG/q5P8ir+z6H8YjYo34Q8CgJ0kssY0I=; b=MkuUUV07BGqkDzadPT1Og+zw5a
 azKUoAVrQC5sWX9OZUwvA+Sx5auB57EG3rUcP0dkxtirFR1H++4/m0b3iQhjv1t6jK4YmZ7TnxK9S
 pGvRDnUYnjIdcygQDRGTfnF/CaXsPuXn4QeELQygDLFa976GoyjYG3VKIJLVqkg1uj1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=aQAuRnG7gspFG/q5P8ir+z6H8YjYo34Q8CgJ0kssY0I=; b=Y
 SjOeutwawTmNciAwnOizY/mXqSIoq98n3p/pyoPrLhWVJlqUU6HBCkCiFQ9oV1mluTSfOEPjRj71A
 dqzly5asPybwFNEUnptPUIXoDz491PZIr0xRatNikLqr0hFGPJBNArGcQus/n8mZoGObS9ik0zI+z
 JeQafhILeE4TsaJg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sbdqX-0007Fw-UQ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Aug 2024 10:24:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 95362611BF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  7 Aug 2024 10:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17892C32782;
 Wed,  7 Aug 2024 10:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723026280;
 bh=hQ2kmHqbQj5Y7D/m0ApaSU/8XWhA6CYNdlXlnJpjXpg=;
 h=From:To:Cc:Subject:Date:From;
 b=jK6F6K78K495WJI226I22sczTpiBJJyJof6+y/GkN4h2K2cxQLpBtJr1oKLv5mR21
 22m7n5H2Dsx4723yK9MzCFj1FhkhtiBq0qoyJI054bHEp1S9kqpxVKvM5JrwA6jG15
 UIewTpGsbIfqLJWwIll1H7sqQWLXpJyfCRvjiTMq1wvkfcJmKKDtkpaoCjiPLgzlWQ
 zWarK4pjAmD+emf5Mto3b6KgT7PBsQODbUjxi282CFJZLJAlMtS9VHzx1mVB0mbFZs
 UjBxbfGAvPLdC/aiJ6VpntV/xQ7Arc+5B/jQruzq85iLNAKwZiRrmfC89gLeOikeMN
 GEZrp0MK0U6mA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed,  7 Aug 2024 18:24:35 +0800
Message-Id: <20240807102435.2198055-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sbdqX-0007Fw-UQ
Subject: [f2fs-dev] [PATCH v4 3/4] f2fs: atomic: fix to truncate pagecache
 before on-disk metadata truncation
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

We should always truncate pagecache while truncating on-disk data.

Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v4:
- don't reset i_size to zero.
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ac61c88f7688..eaa39c50f782 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2199,6 +2199,10 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		F2FS_I(fi->cow_inode)->atomic_inode = inode;
 	} else {
 		/* Reuse the already created COW inode */
+		f2fs_bug_on(sbi, get_dirty_pages(fi->cow_inode));
+
+		invalidate_mapping_pages(fi->cow_inode->i_mapping, 0, -1);
+
 		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
 		if (ret) {
 			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
