Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0498FC7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 16:22:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5u7-0007BV-Fd;
	Wed, 05 Apr 2023 16:22:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pk5u6-0007BP-5f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:22:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=33MXYDDb4OYTdD203d6enmcAPUh147sgohZ6lL/hbyA=; b=Z9gtzbafOIc8j2niTJY7qTBweK
 omgPCHCClnVjqAR+dGWiOBkH3bMBmFUZwi1xaY+KEwWm/GpsGcRXzDuEM7aAiC6+FoKRQbeP5SFQu
 5NdjfzmbwwXHQ5lwbBt6RBevDS/kSmHz6NQQgH/dsU7OGbAAUO4zNe7qpKRfar1tDohs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=33MXYDDb4OYTdD203d6enmcAPUh147sgohZ6lL/hbyA=; b=K
 kbSizCmdHJvR6WxEbNnKnhR2c51da+OHMa0em6t387JJ8g0EyRhik8lRRmzxDwFJdZjGn1mi0/ZGS
 KVXT+0TRnzOnYZ8oGA47pUruPF6pvX2S+7MZYGLUSTDNJ4gzetbFHsSGmQAnibpzR6G4xH6JBT+rs
 lw3Mxn/Qaswt7euc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5u4-0002qW-N1 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:22:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4F15E62380;
 Wed,  5 Apr 2023 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A5BC433D2;
 Wed,  5 Apr 2023 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680711746;
 bh=IKKd5/z6diLNwuttq1cK4BoG4eEmFEMFdox28Mo3uos=;
 h=From:To:Cc:Subject:Date:From;
 b=AAbjh4o1z/necfAjZKY1Sln6VweDJ7xXWEsUoZ2KWAdtadfcbfHDyuFfdCPjQ0TV0
 /QnxXK3/AzDHI4I909K4A7pA9y8k6e9uijWFJxSGnvy6oq8YVqfG7syd7wn+VyZVa9
 JOuBZI80K3uFps/zD19EUN2gzKbqwo0KcDTMD3oJkOfs6Vq4dcmLglKBPdHz1C9NH4
 HcIJt+yzuXVDGUyrfy2izT+eWHTvDHXYWSOvcMgDDcdXhbwN6OoHixI8ZgqrbIM38v
 DnS4ll5JbOu2168GJa0B8boo+ZnUr/W13wj6VEbcyKRJ7YquVi5T315DYgrSBloAlc
 +QNzVWlmiwdjQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed,  5 Apr 2023 22:45:36 +0800
Message-Id: <20230405144536.930370-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1pk5u4-0002qW-N1
Subject: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 inc_valid_block_count()
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In __replace_atomic_write_block(), we missed to check return value
of inc_valid_block_count(), for extreme testcase that f2fs image is
run out of space, it may cause inconsistent status in between SIT
table and total valid block count.

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fc0734e4fb92..17203e8b865a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -246,10 +246,16 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
 	} else {
 		blkcnt_t count = 1;
 
+		err = inc_valid_block_count(sbi, inode, &count);
+		if (err) {
+			f2fs_put_dnode(&dn);
+			return err;
+		}
+
 		*old_addr = dn.data_blkaddr;
 		f2fs_truncate_data_blocks_range(&dn, 1);
 		dec_valid_block_count(sbi, F2FS_I(inode)->cow_inode, count);
-		inc_valid_block_count(sbi, inode, &count);
+
 		f2fs_replace_block(sbi, &dn, dn.data_blkaddr, new_addr,
 					ni.version, true, false);
 	}
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
