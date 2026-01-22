Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B4C44536
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qo3oz26RQXU25f8usuTEas6KtZtypG2LJxGHQRB724M=; b=ho0N4E24NpKhTAq3gRTpMTjjVX
	jFNBeC3bOAuQOorRndSILsOeGf2Cozo7+jvAfdXMQSfFOc90aVeL9Pc7cOIbWw1h40XIuWYlhNOAP
	6z/2LMZg2CQACuVmTPGOzNNZUzYK44u0Av5gyf1C5m3gR03oTYRyClWtXFQSauzVYylM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vipxq-0004ul-6X;
	Thu, 22 Jan 2026 08:22:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+561f00ef1fac768e3611+8187+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vipxo-0004uR-Ns for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 08:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4bYg0QMchl9Q+OOatAPzNZds96rjnjIt58SQA24EC6Y=; b=ETFkNsT0BfitBfB8H6ZZYTfRVe
 snzNTknMaXWnNASpAnLIX+bSFRzrLVeenU2KV1tYRAM0vdpU+ZLQ4qrW+b9zO2CYOLl1scFE6xw3S
 zL87CQpLkp9QWj/lsxZvNRdJWNbnewngiqRX+mHrsZErW2N0aL3fHJVs8Kz2RfkvOJ7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4bYg0QMchl9Q+OOatAPzNZds96rjnjIt58SQA24EC6Y=; b=GjqhAwAeD7VED4eIORIsbmOPOm
 nU9VAjklPr9WaQV+4h7A9C4iH9hhCP8dzBGm1CNFWelc8tP46PnmJE7+Gkr0LEBx6x6V8SmdADb7e
 JwZlIw0ABRa5/9NyKjJEF0vyyKWiNYoM3QWyyPposkVnLWz1/j4pgJ/9jYWgVtZxPuxw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vipxo-0005Ee-78 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 08:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=4bYg0QMchl9Q+OOatAPzNZds96rjnjIt58SQA24EC6Y=; b=zKER5S4LoQcr2hvmiM3DP2Vh97
 0i2D7QwlZ692sfFutJLV3VoaDGqRywizQx3ovu20P3ASVCXSz3NmL76Smt+e7oKzaV9aEr68b+BcB
 kQBsyaA3h3UPYw6YcIMkMURBBjpKjhvt4ees3maaRbMUD551VtqyjKC7d4UHV5VA3kOT6V5nMNlV1
 K5NAGL5804mItraa1vMn+1db1pICwmgOlfCmkUPLdHK7JCgTQ9WEESZ1Tqzy1UU26+6J/ygkbaf7g
 pTAVtJvQchocJFalRm7D+uazKt6h8OUu1F/bHkB0uBTqB+tOgfDYwCfGJFNn7hysSlKhLfVK87DlA
 RzBG0VIg==;
Received: from
 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vipxb-00000006dt5-0vor; Thu, 22 Jan 2026 08:22:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 22 Jan 2026 09:21:58 +0100
Message-ID: <20260122082214.452153-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260122082214.452153-1-hch@lst.de>
References: <20260122082214.452153-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vipxo-0005Ee-78
Subject: [f2fs-dev] [PATCH 02/11] fs,
 fsverity: clear out fsverity_info from common code
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
Cc: fsverity@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Andrey Albershteyn <aalbersh@redhat.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Directly remove the fsverity_info from the hash and free it from
clear_inode instead of requiring file systems to handle it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c         | 10 +++-------
 fs/ext4/super.c          |  1 -
 fs/f2fs/inode.c          |  1 -
 fs/inode.c               |  9 +++++++++
 fs/verity/open.c         |  3 +--
 include/linux/fsverity.h | 26 ++------------------------
 6 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2b5b440637e..67c64efc5099 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -34,7 +34,6 @@
 #include <linux/sched/mm.h>
 #include <linux/iomap.h>
 #include <linux/unaligned.h>
-#include <linux/fsverity.h>
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
@@ -5571,11 +5570,8 @@ void btrfs_evict_inode(struct inode *inode)
 
 	trace_btrfs_inode_evict(inode);
 
-	if (!root) {
-		fsverity_cleanup_inode(inode);
-		clear_inode(inode);
-		return;
-	}
+	if (!root)
+		goto clear_inode;
 
 	fs_info = inode_to_fs_info(inode);
 	evict_inode_truncate_pages(inode);
@@ -5675,7 +5671,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 * to retry these periodically in the future.
 	 */
 	btrfs_remove_delayed_node(BTRFS_I(inode));
-	fsverity_cleanup_inode(inode);
+clear_inode:
 	clear_inode(inode);
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 87205660c5d0..86131f4d8718 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1527,7 +1527,6 @@ void ext4_clear_inode(struct inode *inode)
 		EXT4_I(inode)->jinode = NULL;
 	}
 	fscrypt_put_encryption_info(inode);
-	fsverity_cleanup_inode(inode);
 }
 
 static struct inode *ext4_nfs_get_inode(struct super_block *sb,
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 38b8994bc1b2..ee332b994348 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1000,7 +1000,6 @@ void f2fs_evict_inode(struct inode *inode)
 	}
 out_clear:
 	fscrypt_put_encryption_info(inode);
-	fsverity_cleanup_inode(inode);
 	clear_inode(inode);
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 379f4c19845c..38dbdfbb09ba 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/cdev.h>
 #include <linux/memblock.h>
 #include <linux/fsnotify.h>
+#include <linux/fsverity.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
 #include <linux/buffer_head.h> /* for inode_has_buffers */
@@ -773,6 +774,14 @@ void dump_mapping(const struct address_space *mapping)
 
 void clear_inode(struct inode *inode)
 {
+	/*
+	 * Only IS_VERITY() inodes can have verity info, so start by checking
+	 * for IS_VERITY() (which is faster than retrieving the pointer to the
+	 * verity info).  This minimizes overhead for non-verity inodes.
+	 */
+	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+		fsverity_cleanup_inode(inode);
+
 	/*
 	 * We have to cycle the i_pages lock here because reclaim can be in the
 	 * process of removing the last page (in __filemap_remove_folio())
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 2aa5eae5a540..090cb77326ee 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -384,14 +384,13 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
 }
 EXPORT_SYMBOL_GPL(__fsverity_file_open);
 
-void __fsverity_cleanup_inode(struct inode *inode)
+void fsverity_cleanup_inode(struct inode *inode)
 {
 	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
 
 	fsverity_free_info(*vi_addr);
 	*vi_addr = NULL;
 }
-EXPORT_SYMBOL_GPL(__fsverity_cleanup_inode);
 
 void __init fsverity_init_info_cache(void)
 {
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 86fb1708676b..ea1ed2e6c2f9 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -179,26 +179,6 @@ int fsverity_get_digest(struct inode *inode,
 /* open.c */
 
 int __fsverity_file_open(struct inode *inode, struct file *filp);
-void __fsverity_cleanup_inode(struct inode *inode);
-
-/**
- * fsverity_cleanup_inode() - free the inode's verity info, if present
- * @inode: an inode being evicted
- *
- * Filesystems must call this on inode eviction to free the inode's verity info.
- */
-static inline void fsverity_cleanup_inode(struct inode *inode)
-{
-	/*
-	 * Only IS_VERITY() inodes can have verity info, so start by checking
-	 * for IS_VERITY() (which is faster than retrieving the pointer to the
-	 * verity info).  This minimizes overhead for non-verity inodes.
-	 */
-	if (IS_VERITY(inode))
-		__fsverity_cleanup_inode(inode);
-	else
-		VFS_WARN_ON_ONCE(*fsverity_info_addr(inode) != NULL);
-}
 
 /* read_metadata.c */
 
@@ -250,10 +230,6 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
 	return -EOPNOTSUPP;
 }
 
-static inline void fsverity_cleanup_inode(struct inode *inode)
-{
-}
-
 /* read_metadata.c */
 
 static inline int fsverity_ioctl_read_metadata(struct file *filp,
@@ -331,4 +307,6 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+void fsverity_cleanup_inode(struct inode *inode);
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
