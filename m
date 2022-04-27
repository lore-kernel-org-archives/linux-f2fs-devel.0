Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5A5C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Apr 2022 09:51:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1njeKv-00063G-JF; Wed, 27 Apr 2022 09:51:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1njeKu-000635-0T
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 09:51:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2o91D3kl2naPXikSXPnaPOGwQUNiqaHPGy3voNUPRbk=; b=TSOSP2+k5Xld3VagYnutuP727k
 IOpPgMOsQi3H29lnpvuhjznPA2ASdtgWu/jNO8AOfVzMBhbUlnrEzNenw1j0QB71R9EOrsHqAk+0/
 20HS9rYvP8KO2oVmcR1n7aNjvYstqIVQ96Y9eXbQCpslXKt9zG/FP4uLTsCKC9gf8e3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2o91D3kl2naPXikSXPnaPOGwQUNiqaHPGy3voNUPRbk=; b=j
 Xc24toGSNinWRbMIvdhR3qSFAOUmQcFW/1jruLIxbA3A0SE+jx3ReDGP7IyAkmZ1dcY7nydmah3VM
 RUIrR4dDcK5Sg1gbY0QhqndSI8HKMQb07dxfzGbH1Nk9zKS04GRZG+Q7860s4KhjsZk9HDUD5eEnb
 iZRZvPV0RYVC9uq8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1njeKu-00Bfmt-9y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Apr 2022 09:51:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E245661D27;
 Wed, 27 Apr 2022 09:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C822C385A9;
 Wed, 27 Apr 2022 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651053106;
 bh=8wR5U0Lo7t/lof4mVVlPPXUXiVd+FoYZJSHjiQ3mwDQ=;
 h=From:To:Cc:Subject:Date:From;
 b=is+AxdK0OLdpUzJf63o/GYRDmsUOosvXINqt2avnTeJDTUxBaEHmJdA+VgacQE6w0
 VMOa0LJhsRcBud0e3yvos599W8VTo5Ou4fBqttnObZBr/0yV8L/GGChMFOvl3QVBmR
 Zw0fyHoHucVO0ZPuTFswx5rb8kmsTRqC5mXMzCbgqs78G9NyOmvjZrgtnEc+/JMHPW
 glfkoCVTnIN/DxlaoQtxCQUhhUMZEVira98rRVEykVyDSQchkj7Ju8UkvvKhFWCXVd
 eQClSGJhOV9ijE0DvY8/3h22PQylMLGtt0oDMRZrsx0VDRjq3TaTyZ2l2ty4JQ4Xia
 d4vslQEB4FD3A==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 27 Apr 2022 17:51:40 +0800
Message-Id: <20220427095140.227316-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1njeKu-00Bfmt-9y
Subject: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on block address in
 f2fs_do_zero_range()
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Ming Yan <yanming@tju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As Yanming reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=215894

I have encountered a bug in F2FS file system in kernel v5.17.

I have uploaded the system call sequence as case.c, and a fuzzed image can
be found in google net disk

The kernel should enable CONFIG_KASAN=y and CONFIG_KASAN_INLINE=y. You can
reproduce the bug by running the following commands:

kernel BUG at fs/f2fs/segment.c:2291!
Call Trace:
 f2fs_invalidate_blocks+0x193/0x2d0
 f2fs_fallocate+0x2593/0x4a70
 vfs_fallocate+0x2a5/0xac0
 ksys_fallocate+0x35/0x70
 __x64_sys_fallocate+0x8e/0xf0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The root cause is, after image was fuzzed, block mapping info in inode
will be inconsistent with SIT table, so in f2fs_fallocate(), it will cause
panic when updating SIT with invalid blkaddr.

Let's fix the issue by adding sanity check on block address before updating
SIT table with it.

Cc: stable@vger.kernel.org
Reported-by: Ming Yan <yanming@tju.edu.cn>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/file.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f08e6208e183..342b1f17a033 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1437,11 +1437,19 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
 			ret = -ENOSPC;
 			break;
 		}
-		if (dn->data_blkaddr != NEW_ADDR) {
-			f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
-			dn->data_blkaddr = NEW_ADDR;
-			f2fs_set_data_blkaddr(dn);
+
+		if (dn->data_blkaddr == NEW_ADDR)
+			continue;
+
+		if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
+					DATA_GENERIC_ENHANCE)) {
+			ret = -EFSCORRUPTED;
+			break;
 		}
+
+		f2fs_invalidate_blocks(sbi, dn->data_blkaddr);
+		dn->data_blkaddr = NEW_ADDR;
+		f2fs_set_data_blkaddr(dn);
 	}
 
 	f2fs_update_extent_cache_range(dn, start, 0, index - start);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
