Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C1CC282C5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Mar 2025 03:54:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1towtO-00083c-9I;
	Mon, 03 Mar 2025 03:54:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1towtM-00083O-RA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Mar 2025 03:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+1tdsMZ2gE2sF5qVI+tewtAsnRHXukduBPnz5tEAWs=; b=M1CbP0GRU8Y/aPHeCKCenYeuHk
 3234fUJR4D2uPMeOIGYUJZya7/EHtI/PmKE144vLp9LT0FPXgd/O5JCHzIocsnoV36DZliy/n1wsG
 kC7gDncqMNlkHH6R9iRYsQRBo0eBgRxre2wCNC9qBzJovUbNBsMHaR/2u0seA8zc/jbQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w+1tdsMZ2gE2sF5qVI+tewtAsnRHXukduBPnz5tEAWs=; b=cEJtATF/bZO1ivNODMNmRi9ruV
 3LS3MgtVq/MiJhsKRdyDc/aQFTBLf8M3zS9nFFyCqNCTSC4aSdmPHuIAlEcDrpE30lj6v9EZCX0Nm
 TcgS+wgs94p/HHHo93qcaDzvs+kW640IgswXcukQWo8QOaVAUWSxu+Gjj3rZSXjqKQ48=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1towtB-0007Fj-Hm for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Mar 2025 03:54:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5849D5C55B0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Mar 2025 03:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6FAC4CED6;
 Mon,  3 Mar 2025 03:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740974075;
 bh=Dit0+cvWSyhtAoDZ4pYoyGBm0QT2XB2itAoOVj71vb4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kstfaV/hE+1Dr7mq+ZLMZqAWJ8aglk6HLBplQjRX5sAU30W8Omj6+dupI0N6y04wb
 IxL9h0fKKehurf43akm1JTPMU4lGWHvM/0WsSpQojCXLvAG7z5kj0mh6Bsm63iJzuU
 EcolcB6bwXn7APL/xdO4xULt3FmqJi8v4hDR7AJLU3NnQQYBHYzBwL9Zemt3spSXOn
 oTDRc0alRUDGzDRVi2YaOnF0wHlp1pKdYtds33L+oJec0B/zfnrSOX+wkenXT0z/fD
 lMSwFibPFq6ST7sHJu281OKkRQO7olpogs7waeOjkASaoNcqy5G2+bhpCeU17MxzIs
 GRkZDmlpiEvuw==
To: jaegeuk@kernel.org
Date: Mon,  3 Mar 2025 11:54:23 +0800
Message-ID: <20250303035423.1357211-3-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303035423.1357211-1-chao@kernel.org>
References: <20250303035423.1357211-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1towtB-0007Fj-Hm
Subject: [f2fs-dev] [PATCH 3/3] f2fs: introduce FAULT_INCONSISTENT_FOOTER
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

To simulate inconsistent node footer error.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 1 +
 Documentation/filesystems/f2fs.rst      | 1 +
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/node.c                          | 3 ++-
 fs/f2fs/super.c                         | 1 +
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 81deae2af84d..b9a000e5098a 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -734,6 +734,7 @@ Description:	Support configuring fault injection type, should be
 		FAULT_BLKADDR_VALIDITY           0x000040000
 		FAULT_BLKADDR_CONSISTENCE        0x000080000
 		FAULT_NO_SEGMENT                 0x000100000
+		FAULT_INCONSISTENT_FOOTER        0x000200000
 		===========================      ===========
 
 What:		/sys/fs/f2fs/<disk>/discard_io_aware_gran
diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index fb7d2ee022bc..42f28dbf2410 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -206,6 +206,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_BLKADDR_VALIDITY           0x000040000
 			 FAULT_BLKADDR_CONSISTENCE        0x000080000
 			 FAULT_NO_SEGMENT                 0x000100000
+			 FAULT_INCONSISTENT_FOOTER        0x000200000
 			 ===========================      ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 38016d24e59c..99cc933faf8c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -62,6 +62,7 @@ enum {
 	FAULT_BLKADDR_VALIDITY,
 	FAULT_BLKADDR_CONSISTENCE,
 	FAULT_NO_SEGMENT,
+	FAULT_INCONSISTENT_FOOTER,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5be8badc6261..58803cab2235 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1463,7 +1463,8 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 	if (unlikely(nid != nid_of_node(page) ||
 		(ntype == NODE_TYPE_INODE && !IS_INODE(page)) ||
 		(ntype == NODE_TYPE_XATTR &&
-		!f2fs_has_xattr_block(ofs_of_node(page))))) {
+		!f2fs_has_xattr_block(ofs_of_node(page))) ||
+		time_to_inject(sbi, FAULT_INCONSISTENT_FOOTER))) {
 		f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
 			  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
 			  ntype, nid, nid_of_node(page), ino_of_node(page),
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7a8fcc1e278c..3a7e4e8ab010 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -63,6 +63,7 @@ const char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_BLKADDR_VALIDITY]	= "invalid blkaddr",
 	[FAULT_BLKADDR_CONSISTENCE]	= "inconsistent blkaddr",
 	[FAULT_NO_SEGMENT]		= "no free segment",
+	[FAULT_INCONSISTENT_FOOTER]	= "inconsistent footer",
 };
 
 int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
