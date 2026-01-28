Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D982FD3F082
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2L0FGGvuGdNfNxGAEJpdzu+iSqblT0IMao17GqwQAM=; b=Ln0NYkEmj9iUUGYvc/NIAzGh9H
	zR63rK+cwECAUEyPOYgh2bgQG65ufJdXcthSY+euJsXl3MUI1+yC7n8SRQo71eAZ1a/iCeJRZ2paq
	bTgv4XZ8yZBGJgYhWy60cXPylKY7EaZrp/KgP1ncvxxabeuo1IGrgBSHpxuFjMoOwjTU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vl7SR-0006w6-Hz;
	Wed, 28 Jan 2026 15:27:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+97ec6e74097c8d3e794e+8193+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vl7SP-0006vY-AG for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 15:27:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hUAqEc59OqndWFQYZRxKv7dVUe5Vgp361WDh/DQTsVE=; b=HbEgixXEtXuBs6zA5NfI6wB8JY
 l1eukhL2RCOABTN8i5CVjtpAN7m6cKKGf977yJ8dY1l09hIQKtfdNltVg5GrPHWVrVT4Mr+GC1Mqa
 HO6KhwfUc0eZ6/Kv2RMxzt67Yn1lL4gZkYcqqW5j5gD5ObiAIWgDE+udvHdd1oMql2FE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hUAqEc59OqndWFQYZRxKv7dVUe5Vgp361WDh/DQTsVE=; b=GRr7TLzIoWUqbNNR1+t0pQJ+Kq
 ROj56JDzag8/Fk6z9qv7PYSCLgyilG3rN6zZpK5qmKGJeP3wzKYIx6LdSMplSVJ3eEhUJfE4OJ4da
 ai9M6ryLV+QBs84FttPukfxluQohR1vTS9F+3EupxVl0RzlJjYsk29CSkT+/I9MSylug=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vl7SE-0002UA-CC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Jan 2026 15:27:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hUAqEc59OqndWFQYZRxKv7dVUe5Vgp361WDh/DQTsVE=; b=FQXZqcmDLkw4PxhiZ4rX8hq5s0
 X4YQJyGhSEz2Zmv4nwlN9OaV+Sd0zSDuR90vWcnaWbUP2DwnCtPT/lCk+EB29c+ul5zUlWaFNB4np
 PPz34IWwEjNr+JE9YlQ5ZW6rzXN/rPBJq68mPF6hHTgH7YxRO57bM4CXXLAuTRmhyyOuBhENM5axX
 Diim7PpbZW73Cxpudf/58gHedTNLRFAYfXtrZmYvXCfF4UNGEjLvZviHO5FH2BRIB2/faWO7xpzCc
 O+FwKwV7FMmHPm/NHwaaOLMMoP1KbHu9KmBmvwX07LhvyY5ZMznwJOEu/iIZP2FyJtEKcvhayG3Pa
 g36Ox2Bw==;
Received: from
 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at
 ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1vl7S1-0000000GHQh-1Rje; Wed, 28 Jan 2026 15:27:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 28 Jan 2026 16:26:18 +0100
Message-ID: <20260128152630.627409-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
References: <20260128152630.627409-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vl7SE-0002UA-CC
Subject: [f2fs-dev] [PATCH 06/15] fsverity: start consolidating pagecache
 code
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
 Theodore Ts'o <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>,
 Andrey Albershteyn <aalbersh@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ext4 and f2fs are largely using the same code to read a page full
of Merkle tree blocks from the page cache, and the upcoming xfs
fsverity support would add another copy.

Move the ext4 code to fs/verity/ and use it in f2fs as well.  For f2fs
this removes the previous f2fs-specific error injection, but otherwise
the behavior remains unchanged.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/verity.c         | 17 +----------------
 fs/f2fs/verity.c         | 17 +----------------
 fs/verity/Makefile       |  1 +
 fs/verity/pagecache.c    | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/fsverity.h |  3 +++
 5 files changed, 44 insertions(+), 32 deletions(-)
 create mode 100644 fs/verity/pagecache.c

diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 2ce4cf8a1e31..a071860ad36a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,23 +361,8 @@ static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	struct folio *folio;
-
 	index += ext4_verity_metadata_pos(inode) >> PAGE_SHIFT;
-
-	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
-		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
-
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
-	}
-	return folio_file_page(folio, index);
+	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
 }
 
 static int ext4_write_merkle_tree_block(struct file *file, const void *buf,
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index c1c4d8044681..d37e584423af 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -259,23 +259,8 @@ static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
 					       unsigned long num_ra_pages)
 {
-	struct folio *folio;
-
 	index += f2fs_verity_metadata_pos(inode) >> PAGE_SHIFT;
-
-	folio = f2fs_filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
-	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
-		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
-
-		if (!IS_ERR(folio))
-			folio_put(folio);
-		else if (num_ra_pages > 1)
-			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
-		folio = read_mapping_folio(inode->i_mapping, index, NULL);
-		if (IS_ERR(folio))
-			return ERR_CAST(folio);
-	}
-	return folio_file_page(folio, index);
+	return generic_read_merkle_tree_page(inode, index, num_ra_pages);
 }
 
 static int f2fs_write_merkle_tree_block(struct file *file, const void *buf,
diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index 435559a4fa9e..ddb4a88a0d60 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_FS_VERITY) += enable.o \
 			   init.o \
 			   measure.o \
 			   open.o \
+			   pagecache.o \
 			   read_metadata.o \
 			   verify.o
 
diff --git a/fs/verity/pagecache.c b/fs/verity/pagecache.c
new file mode 100644
index 000000000000..f67248e9e768
--- /dev/null
+++ b/fs/verity/pagecache.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2019 Google LLC
+ */
+
+#include <linux/fsverity.h>
+#include <linux/pagemap.h>
+
+/**
+ * generic_read_merkle_tree_page - generic ->read_merkle_tree_page helper
+ * @inode:	inode containing the Merkle tree
+ * @index:	0-based index of the Merkle tree page in the inode
+ * @num_ra_pages: The number of Merkle tree pages that should be prefetched.
+ *
+ * The caller needs to adjust @index from the Merkle-tree relative index passed
+ * to ->read_merkle_tree_page to the actual index where the Merkle tree is
+ * stored in the page cache for @inode.
+ */
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
+		unsigned long num_ra_pages)
+{
+	struct folio *folio;
+
+	folio = __filemap_get_folio(inode->i_mapping, index, FGP_ACCESSED, 0);
+	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
+		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
+
+		if (!IS_ERR(folio))
+			folio_put(folio);
+		else if (num_ra_pages > 1)
+			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
+		folio = read_mapping_folio(inode->i_mapping, index, NULL);
+		if (IS_ERR(folio))
+			return ERR_CAST(folio);
+	}
+	return folio_file_page(folio, index);
+}
+EXPORT_SYMBOL_GPL(generic_read_merkle_tree_page);
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index e22cf84fe83a..121703625cc8 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -309,4 +309,7 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
 
 void fsverity_cleanup_inode(struct inode *inode);
 
+struct page *generic_read_merkle_tree_page(struct inode *inode, pgoff_t index,
+		unsigned long num_ra_pages);
+
 #endif	/* _LINUX_FSVERITY_H */
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
