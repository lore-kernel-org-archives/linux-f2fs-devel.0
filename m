Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C62C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Jul 2026 06:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gfgeg4MOT0OEiHn3WNb0RQ8C8YvMFU0beOg2ivkrjog=; b=Gv54fUZ0zHHVnqEDqyxke/bDH2
	5QlaEjSvOB7EwIlRNHkSrN5LuGY3d7tUNOmoj1cTbY4GfWD1LeR5KftxWZVJGSodm9ijaj3h7TK/q
	Ig4Qzxj2/mwiiU1GPwgDPfEgepHudqXEk7F8RDcWyyPRgJ+IlPJRuf/i0qFhXtladAeY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wfBLM-0007bn-O8;
	Thu, 02 Jul 2026 06:56:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wfBLJ-0007be-Vl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 06:56:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1sKwPDyZ0U5zvcvyk5EMJ6dm01+RsjR3z6zM65NNHOA=; b=hDTtCRe7d+kjja0l3rF3GsN5UB
 hkTZm3AqmvtD8tt/PO32qcSVqul1LU+dr6Y/Z5d22mZp2noCx7KQDOYLa4iq4+JcxcpUFq6ziifZm
 FIXLifIMAT0sQIpCmpm05cgHWZwjgOnFaErcqgaT+rNqw12m2f7a3bgOqyNlOOk140Eg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1sKwPDyZ0U5zvcvyk5EMJ6dm01+RsjR3z6zM65NNHOA=; b=OeSI98y/Ztws+86d5jPhI2eKAj
 kwuegv9lZAjUP9qSGpCZCoTAZT6ZjdjZRjF3AcgAm1FsiSZ4Q6SPcTtnwbqcxjtIgT2zPVQSKLw8B
 g+vv8QtFnZw5rRw+zvR7BLIApPla1H2X8wnmVBrHL6SPqbgwAARwG4I/CZNHD9TKcYFM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wfBLH-0002XW-PD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 06:56:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 02A0040BF0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Jul 2026 06:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38D71F000E9;
 Thu,  2 Jul 2026 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782975366;
 bh=1sKwPDyZ0U5zvcvyk5EMJ6dm01+RsjR3z6zM65NNHOA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lkwM5GtE20bNCiNlfRtOwCHrnIW1ntjqfCzHkgES294J2Lc93+2k+C7nSDxUg5cPT
 lYw26rZmN11KKl6AKojE9qwtURqU0xhvmvm7Aq29ccmcb8yLCnOIw6iIbIRQaOipLm
 9PTBeGagfvQcnpig9n1mMFjPtQ+fCW546YLzx6hUX/ogWMcpakyZLd/wDr6RDJXjMV
 ZDStKRBypqmMP8FuoyFamOrtOa605xiZrGehbnOoFVA6ynaK+v1e7U8RjfavK+jsk6
 hglk9TMxbpyDc2Q1sXj2Gij9oD0hSEbGIHvcOofCCodJ4hk22XUXhUSvozja6FvsXM
 bi6a27jQ1gylw==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  2 Jul 2026 06:56:02 +0000
Message-ID: <20260702065602.4120914-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260702065602.4120914-1-jaegeuk@kernel.org>
References: <20260702065602.4120914-1-jaegeuk@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wfBLH-0002XW-PD
Subject: [f2fs-dev] [PATCH 3/3] f2fs-tools: fix build failure on mac
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

external/f2fs-tools/lib/libf2fs.c:1019:12: error: use of undeclared identifier 'BLKFLSBUF'
 1019 |         ioctl(fd, BLKFLSBUF);
      |                   ^~~~~~~~~

Fixes: c188a3e303d9 ("f2fs-tools: invalidate block device page cache before reading metadata")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 7f8b643d117d..93f36ca6a30c 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -1016,8 +1016,9 @@ int get_device_info(int i)
 	}
 
 	dev->fd = fd;
+#ifdef BLKFLSBUF
 	ioctl(fd, BLKFLSBUF);
-
+#endif
 	if (c.sparse_mode && i == 0) {
 		if (f2fs_init_sparse_file()) {
 			free(stat_buf);
-- 
2.55.0.rc0.799.gd6f94ed593-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
