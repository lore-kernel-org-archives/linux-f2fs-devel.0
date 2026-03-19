Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96335109025A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LunQiUtlOsCuvt0AkIT4MQrUrnwtHMvS6KHScnGhPXQ=; b=bV7ROujoLtE5Fn33gUX4Ld0dql
	BfD8tbl8rfPPGhY5XM7Pz2jMNLdVaynpsE3eKNOP3LfuXdC5glAUW6+mPMQLADhR7tg7wEx6HAzZW
	lrna0y6GSXfYnD8hql3JfZXIwIYbFu6Bw3drNCpgn7ru7lSuUdjzAQUaTYgEs4iNS6mQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w3Gm9-0008E0-Q1;
	Thu, 19 Mar 2026 17:03:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1w3Gm8-0008Dq-2b
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 17:03:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2QUgXX4karwS/CaOP83NoQtkdpIly6Knjld6roHIW8=; b=RVPtt6O7TjU7l52WQw8YGpEXMW
 JadqujdmyFSZvTdtaA558Ql+4YC2Rlj9hDUcNSBPSqCbUl0hA88MgUUebluP/VfuQt4xbJGQdUlX6
 8MRv13Tyn+MUgWzTqpr17PrpHQ0mYcbrZHtVMaa/qsq/Q6MBZXGzhpHFWZtgu/K+XzuU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q2QUgXX4karwS/CaOP83NoQtkdpIly6Knjld6roHIW8=; b=WqDlf/qMrcEPkK+h1F2V4jLrSJ
 vmgFnoeyy//u66QXPZac1hUS5VGzCV4FUvecnzMuLaRf7b8oTZ6X06ckB+DI9UotFAi/rjsBUUWIa
 Wzgmv4vnDima3DU8DsiY5+EYFqYwcgH1YEIRNv7o3LveIGYx0A7wMpPJJuQuFg+XATJg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w3Gm7-0005ei-GB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 17:03:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 39130442FA;
 Thu, 19 Mar 2026 17:03:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E661CC2BCB0;
 Thu, 19 Mar 2026 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773939781;
 bh=gP1sMkE4alGb06aslVUo05UwZR7+5Myev4BiXgKcL9s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G0FThI4tkK61/VPUW5H8oKb117kHgEAolLW4D2LdSathShqft1Trv1ibO4jv5Wdrk
 4Dr88SJsLA7yx6nTA+YSzgK4Ub602uac7809wrsMfpzYpBmXVhNJ8douzlGeFmgR6w
 giY90uDM9KxuNmLIcj2bE95QJ7McHn7UGU5wHA8iXY33AumPrxKa+pvSOA0Srjf458
 q3x8OWFSsCSY/wsnriiEWlTJZ3AOwsm7b8EFhS3b9bt2RmydkdkpKCg9TyD1S8wxB3
 eBhtNtR+XQZGmoxBYsh6ARH94s4RPnBd2klVrjWGxwVZoK1KqpKSmvASx9/33/ZlN8
 7QwAyKPDoft5g==
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Date: Thu, 19 Mar 2026 18:01:55 +0100
Message-ID: <20260319170231.1455553-9-aalbersh@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260319170231.1455553-1-aalbersh@kernel.org>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1w3Gm7-0005ei-GB
Subject: [f2fs-dev] [PATCH v5 08/25] iomap: obtain fsverity info for read
 path
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Obtain fsverity info for folios with file data. Filesystem can pass vi
down to ioend and then to fsverity for verification. XFS will use it in
further patch for fsverity integration.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 7 +++++++
 include/linux/iomap.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6d17858ffaae..bcfbfbf5cf7c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -9,6 +9,7 @@
 #include <linux/swap.h>
 #include <linux/migrate.h>
 #include <linux/fserror.h>
+#include <linux/fsverity.h>
 #include "internal.h"
 #include "trace.h"
 
@@ -599,6 +600,9 @@ void iomap_read_folio(const struct iomap_ops *ops,
 
 	trace_iomap_readpage(iter.inode, 1);
 
+	if (iter.pos < i_size_read(iter.inode))
+		ctx->vi = fsverity_get_info(iter.inode);
+
 	while ((ret = iomap_iter(&iter, ops)) > 0)
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&bytes_submitted);
@@ -666,6 +670,9 @@ void iomap_readahead(const struct iomap_ops *ops,
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
 
+	if (iter.pos < i_size_read(iter.inode))
+		ctx->vi = fsverity_get_info(iter.inode);
+
 	while (iomap_iter(&iter, ops) > 0)
 		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_submitted);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index dc39837b0d45..89e5a7abc012 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -432,6 +432,7 @@ struct iomap_ioend {
 	loff_t			io_offset;	/* offset in the file */
 	sector_t		io_sector;	/* start sector of ioend */
 	void			*io_private;	/* file system private data */
+	struct fsverity_info	*io_vi;		/* fsverity info */
 	struct bio		io_bio;		/* MUST BE LAST! */
 };
 
@@ -506,6 +507,7 @@ struct iomap_read_folio_ctx {
 	struct readahead_control *rac;
 	void			*read_ctx;
 	loff_t			read_ctx_file_offset;
+	struct fsverity_info	*vi;
 };
 
 struct iomap_read_ops {
-- 
2.51.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
