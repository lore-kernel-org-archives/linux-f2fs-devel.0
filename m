Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032B7C27C79
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2024 02:23:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sJOVh-0005Gm-KI;
	Tue, 18 Jun 2024 02:23:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1sJOVg-0005Ge-Qd
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 02:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6f7wAxsgLR4oD/MhymM7isuZuCs4AnvmpxYCOe/iisw=; b=US4yY8OlHl2mTDKJz/1IQLGoE8
 avyTyzec+gaNdhwMtRj/pVkOjJ6szgNcYp5rYgB5HPa8BcnqNIhk6dhZp6txf+5JtoslkRKRmZiWq
 MqfO+3B7hq/PuhvbrpdZKiSRs8NKiIWV7Zhw4zBs32l8fEp4zVex6WyDl11Yl7C6ys0o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6f7wAxsgLR4oD/MhymM7isuZuCs4AnvmpxYCOe/iisw=; b=i
 YL+c3nBPdyiWDHlwNDUKok/ijVfRblBU4QEgqveA7L1I/MgO4Ct4WpaAeGsAsfscrv8EP8aspAgAO
 NTe3Mi9v4T08l5MpCVe3auqv5cOVAXkiGdZkKfXi7IwLGqGQmRtLo2fxvRQm6D2T2pqgJWoTE4qE8
 t/RXzIeogdFEv/44=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sJOVh-0001LQ-Ug for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 02:23:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 81B55CE0D85
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Jun 2024 02:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2558C2BD10;
 Tue, 18 Jun 2024 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718677416;
 bh=DPX6Yo3uKpQvU+s+OUpbimrmWAxi/0KqSd23VcY7cgU=;
 h=From:To:Cc:Subject:Date:From;
 b=pJ8kn9q2QdsmWTXpISZiAgAOalEzOy30BKEapBH7qcUQnn2ZF2wAk9Uqf06DhT6sc
 JWCq7l0QRX3n/yKTgwDR266gR1tXhbZJrxg3E4179PrnvvKzfuHFhKNdmyHTN1wlF2
 7GPwLezMeoxQXlJ/gsdDFU+3t4P9+vW8Q5dee8tCUFWRkNu2KwY34e2gAh4+bmPJdN
 Qw6py0CeXbOX1LRqJXHm+/0BJ6Bg6a7XpyYSnuzexjG3aUHpr6kA3IrI8MzIZTarPS
 jDSCYKkwQ/HEcJciWL7gVNuFjQlGJX2WFNDa6742T8qdArAccWJUrVZQ8TaDwbdghh
 XmIPBTHgnAPBg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 18 Jun 2024 02:23:34 +0000
Message-ID: <20240618022334.1576056-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
MIME-Version: 1.0
X-Headers-End: 1sJOVh-0001LQ-Ug
Subject: [f2fs-dev] [PATCH] f2fs: assign CURSEG_ALL_DATA_ATGC if blkaddr is
 valid
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

mkdir /mnt/test/comp
f2fs_io setflags compression /mnt/test/comp
dd if=/dev/zero of=/mnt/test/comp/testfile bs=16k count=1
truncate --size 13 /mnt/test/comp/testfile

In the above scenario, we can get a BUG_ON.
 kernel BUG at fs/f2fs/segment.c:3589!
 Call Trace:
  do_write_page+0x78/0x390 [f2fs]
  f2fs_outplace_write_data+0x62/0xb0 [f2fs]
  f2fs_do_write_data_page+0x275/0x740 [f2fs]
  f2fs_write_single_data_page+0x1dc/0x8f0 [f2fs]
  f2fs_write_multi_pages+0x1e5/0xae0 [f2fs]
  f2fs_write_cache_pages+0xab1/0xc60 [f2fs]
  f2fs_write_data_pages+0x2d8/0x330 [f2fs]
  do_writepages+0xcf/0x270
  __writeback_single_inode+0x44/0x350
  writeback_sb_inodes+0x242/0x530
  __writeback_inodes_wb+0x54/0xf0
  wb_writeback+0x192/0x310
  wb_workfn+0x30d/0x400

The reason is we gave CURSEG_ALL_DATA_ATGC to COMPR_ADDR where the
page was set the gcing flag by set_cluster_dirty().

Cc: stable@vger.kernel.org
Fixes: 4961acdd65c9 ("f2fs: fix to tag gcing flag on page during block migration")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6e8a4b332ad5..ce2300391031 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3484,6 +3484,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			if (fio->sbi->am.atgc_enabled &&
 				(fio->io_type == FS_DATA_IO) &&
 				(fio->sbi->gc_mode != GC_URGENT_HIGH) &&
+				__is_valid_data_blkaddr(fio->old_blkaddr) &&
 				!is_inode_flag_set(inode, FI_OPU_WRITE))
 				return CURSEG_ALL_DATA_ATGC;
 			else
-- 
2.45.2.627.g7a2c4fd464-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
