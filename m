Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB9BC77B6C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 14:55:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pji4R-0000jl-OA;
	Tue, 04 Apr 2023 14:55:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1pji4P-0000jC-Cr
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 14:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mf1FPmX34sPBqBJ1RqvZnmanS11JhvTJ+HM36CjFqII=; b=buViPMlZjgtgu0d9NXAH+RTH3c
 WV75Fo4XqpEuVaE3uJywOrLdfjvOA2wEEFiQg434RjUdU98I0CFs95P6ko9cKFa22HLu0D/FJn2kV
 e6Dr4SDSGbORLR661kA40M9sp9ft7aCDHx2dwEKGFhIEXz7OQeI+12g6csGltFNKoyyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mf1FPmX34sPBqBJ1RqvZnmanS11JhvTJ+HM36CjFqII=; b=IU4jS4oV0lHxlY3QsOYxP12a8d
 l7x2IdmMUlPjzNcoWmmZdCoEg93+8Xjmao8/iagqWNA9eCU645jWkgVNGDy5+keGfy+tR4MEW15T4
 VhqKkbB9C6yDjq9LpTtNmuzIsYBYGpBNhzhgZR1s0Nj0qgpmB1SMOBebfI/jQtuH6PGE=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pji4N-00025V-L9 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 14:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680620129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mf1FPmX34sPBqBJ1RqvZnmanS11JhvTJ+HM36CjFqII=;
 b=hObF0eTNOzV/ChyfgCdz87MpVMgrd4c43YoZnB1LD4Bm75QeuZzbkgvbIQdRX4941a+YFg
 O8gUT4kHL9I9cdDBxXhAzzwYqM2fhveXdXh6cihMaIFzESFWk2xCBDzUbx9ZPXBNYsvf4w
 ce+HiWSU45jmsS5IA+CTPLdswGAd5Cs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-H_tx-w18Mwm0-ZQf0abp0A-1; Tue, 04 Apr 2023 10:55:28 -0400
X-MC-Unique: H_tx-w18Mwm0-ZQf0abp0A-1
Received: by mail-qt1-f197.google.com with SMTP id
 w13-20020ac857cd000000b003e37d3e6de2so22338772qta.16
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Apr 2023 07:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680620124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mf1FPmX34sPBqBJ1RqvZnmanS11JhvTJ+HM36CjFqII=;
 b=HYqfAp4fQTdRqNlppSeqP28fyDF1mFD1J6gzY/zVZLVI2vtxFsfHyiVBtJE5IC9sGQ
 PpBbQSWnbuqle2jdquhM6V96UszzqoHZjaIvafPjyBh/7bHBjPwWT4gLlcW9VdLFUErU
 xDPnNjMBT0HAl/n/JVf6UKg4JQR8WNILAtNv+MXxvIdUSNqClrsPMgabO+GVM2DXI8fy
 AuA2RwykNz4f9VPrlV/JbmaR9iehCxVOGFGyFSdDOF5Gu44paNqfe370WdcDA7nz23uU
 DrkKMybGj2mgx/CnDo800sjSOSV2Dcrc1fhFxzVmdBOiz2AH1RzcRkr0L5JjHjm8q4JV
 h79w==
X-Gm-Message-State: AAQBX9fhlHpCLVlBn2J3RHnWSbiZBggiCQXEmZvpUBwQwhaWO9+Xbn5j
 rxFK98TlSLDDpYcoN5JlchIOrwT8ChUMM6egFuNq4bv9IthTg5IBsr+eaheFFW6wIcV356WuwT4
 g+Icw6RWwe9HA3GBu+lybNqrSCxTZYse/c9km
X-Received: by 2002:a05:622a:586:b0:3e4:df94:34fa with SMTP id
 c6-20020a05622a058600b003e4df9434famr4035273qtb.37.1680620124177; 
 Tue, 04 Apr 2023 07:55:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRYRoH4ADtP4T/X8Xk7AmNG3QGNTCPUhw/3V50RQPtNVC1H25ltfcQUL3M/obCpWJOFk1Kng==
X-Received: by 2002:a05:622a:586:b0:3e4:df94:34fa with SMTP id
 c6-20020a05622a058600b003e4df9434famr4035211qtb.37.1680620123789; 
 Tue, 04 Apr 2023 07:55:23 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
 by smtp.gmail.com with ESMTPSA id
 j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 07:55:23 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
 hch@infradead.org, linux-xfs@vger.kernel.org, fsverity@lists.linux.dev
Date: Tue,  4 Apr 2023 16:53:09 +0200
Message-Id: <20230404145319.2057051-14-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Headers-End: 1pji4N-00025V-L9
Subject: [f2fs-dev] [PATCH v2 13/23] xfs: add iomap's readpage operations
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com,
 damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, rpeterso@redhat.com, xiang@kernel.org,
 jth@kernel.org, linux-erofs@lists.ozlabs.org,
 Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The read IO path provides callout for configuring ioend. This allows
filesystem to add verification of completed BIOs. The
xfs_prepare_read_ioend() configures bio->bi_end_io which places
verification task in the workqueue. The task does fs-verity
verification and then call back to the iomap to finish IO.

This patch add callouts implementation to verify pages with
fs-verity. Also implements folio operation .verify_folio for direct
folio verification by fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_aops.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.c | 11 +++++++++++
 fs/xfs/xfs_linux.h |  1 +
 3 files changed, 57 insertions(+)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index daa0dd4768fb..2a3ab5afd665 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -548,6 +548,49 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
+static void
+xfs_read_work_end_io(
+	struct work_struct *work)
+{
+	struct iomap_read_ioend *ioend =
+		container_of(work, struct iomap_read_ioend, work);
+	struct bio *bio = &ioend->read_inline_bio;
+
+	fsverity_verify_bio(bio);
+	iomap_read_end_io(bio);
+	/*
+	 * The iomap_read_ioend has been freed by bio_put() in
+	 * iomap_read_end_io()
+	 */
+}
+
+static void
+xfs_read_end_io(
+	struct bio *bio)
+{
+	struct iomap_read_ioend *ioend =
+		container_of(bio, struct iomap_read_ioend, read_inline_bio);
+	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
+
+	WARN_ON_ONCE(!queue_work(ip->i_mount->m_postread_workqueue,
+					&ioend->work));
+}
+
+static void
+xfs_prepare_read_ioend(
+	struct iomap_read_ioend	*ioend)
+{
+	if (!fsverity_active(ioend->io_inode))
+		return;
+
+	INIT_WORK(&ioend->work, &xfs_read_work_end_io);
+	ioend->read_inline_bio.bi_end_io = &xfs_read_end_io;
+}
+
+static const struct iomap_readpage_ops xfs_readpage_ops = {
+	.prepare_ioend		= &xfs_prepare_read_ioend,
+};
+
 STATIC int
 xfs_vm_read_folio(
 	struct file			*unused,
@@ -555,6 +598,7 @@ xfs_vm_read_folio(
 {
 	struct iomap_readpage_ctx	ctx = {
 		.cur_folio		= folio,
+		.ops			= &xfs_readpage_ops,
 	};
 
 	return iomap_read_folio(&ctx, &xfs_read_iomap_ops);
@@ -566,6 +610,7 @@ xfs_vm_readahead(
 {
 	struct iomap_readpage_ctx	ctx = {
 		.rac			= rac,
+		.ops			= &xfs_readpage_ops,
 	};
 
 	iomap_readahead(&ctx, &xfs_read_iomap_ops);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 285885c308bd..e0f3c5d709f6 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -27,6 +27,7 @@
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_reflink.h"
+#include "xfs_verity.h"
 
 #define XFS_ALLOC_ALIGN(mp, off) \
 	(((off) >> mp->m_allocsize_log) << mp->m_allocsize_log)
@@ -83,8 +84,18 @@ xfs_iomap_valid(
 	return true;
 }
 
+static bool
+xfs_verify_folio(
+	struct folio	*folio,
+	loff_t		pos,
+	unsigned int	len)
+{
+	return fsverity_verify_folio(folio, len, pos);
+}
+
 static const struct iomap_folio_ops xfs_iomap_folio_ops = {
 	.iomap_valid		= xfs_iomap_valid,
+	.verify_folio		= xfs_verify_folio,
 };
 
 int
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index e88f18f85e4b..c574fbf4b67d 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -63,6 +63,7 @@ typedef __u32			xfs_nlink_t;
 #include <linux/rhashtable.h>
 #include <linux/xattr.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/fsverity.h>
 
 #include <asm/page.h>
 #include <asm/div64.h>
-- 
2.38.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
