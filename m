Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84614ECAAD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Sep 2022 02:03:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oW6tY-0006De-JI;
	Thu, 08 Sep 2022 02:03:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1oW6tX-0006DO-45
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 02:03:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M0nnz/eBgAUWjQ2uD1Sz1GDx0gxpQA+lzf1LGa75LpY=; b=Py8JUTewYKdgepzLAGTH3d+7jP
 6LBRAkqPEqznLWQqqGBwdCZPT6LN4KWiCdOUVJgXjrEh2aqqXmuSqzbW8+BJxzHlzlHz4Sih+qetl
 4eWz9eoyWHkggKnNZFvDloGxBVIlWpT6iE+NtQ0udH9WPFuiNg1HOcN9SpfCjPXXIh9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M0nnz/eBgAUWjQ2uD1Sz1GDx0gxpQA+lzf1LGa75LpY=; b=m
 XIdv121xd2lKL+1pGAgiHjdswd16353TyNV4GJ/A/fWq4aaxYTy+sN7rekezsOoCxeJLxzyPMJhAk
 evww2GAYML65Ad7QedtK3ZU9s4p0LwwKDtZC/lumWjkgUcyWDmj6vz5Hkssh2AbkClGYCIAFnClee
 eAM9t6+M/PNPqI/8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oW6tW-0006iq-Hl for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Sep 2022 02:03:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 31D5661B27
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  8 Sep 2022 02:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE4C433D6;
 Thu,  8 Sep 2022 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1662602628;
 bh=ZRoN5ydAHEDnbsftKiQF4/ZtyyGQtaXX75vsEjShNGU=;
 h=From:To:Cc:Subject:Date:From;
 b=FA+DKTW5zvN9s7HYQaY6onFCWt33ICHk1G27OKo7Li1qM6ahBDYsbbOe/xyI6kXyx
 P7qYvZwAgSoXf/MwdS/vERwo5msZ1qrjI9gpHzuVeU7Vv5mo8j6vdmQiFzMVpTVWQw
 3G+kEITnosji++9GioUGssJJN6jv6Z+3F+F0N3IQ2WWtmHMQ+KmXI4s3sKl92kDVKl
 hHtx9IeI1qBNiPdJJJPtyy3bEl/QXLmuo7rYH6q60EIgU8Z3FWJUQOdc8ELsN/yNSA
 Lt0NP74jNDQA3o/U75ji1z9etIREUiKap5EHZHOdY0zNsjg09reHx9wPJ4/Y7klcfQ
 iVNHG97fHtqcA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed,  7 Sep 2022 19:03:45 -0700
Message-Id: <20220908020345.190466-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
X-Headers-End: 1oW6tW-0006iq-Hl
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix build error on lz4-1.9.4
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

LZ4_STREAMSIZE_U64 is undefined in new lz4 lib.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/compress.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fsck/compress.c b/fsck/compress.c
index b41349207e38..b15f0a41c46e 100644
--- a/fsck/compress.c
+++ b/fsck/compress.c
@@ -32,10 +32,7 @@
 #ifdef HAVE_LIBLZ4
 #define LZ4_MEMORY_USAGE		14
 #define LZ4_MAX_INPUT_SIZE		0x7E000000 /* 2 113 929 216 bytes */
-#ifndef LZ4_STREAMSIZE
-#define LZ4_STREAMSIZE			(LZ4_STREAMSIZE_U64 * sizeof(long long))
-#endif
-#define LZ4_MEM_COMPRESS		LZ4_STREAMSIZE
+#define LZ4_MEM_COMPRESS		sizeof(LZ4_stream_t)
 #define LZ4_ACCELERATION_DEFAULT	1
 #define LZ4_WORK_SIZE			ALIGN_UP(LZ4_MEM_COMPRESS, 8)
 #endif
-- 
2.37.2.789.g6183377224-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
