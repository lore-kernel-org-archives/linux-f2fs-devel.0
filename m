Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABC5EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Jul 2023 15:37:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qJbu3-0003Ms-JU;
	Wed, 12 Jul 2023 15:37:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qJbu1-0003Mg-QS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jul 2023 15:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RJkiT5URdSqgSHDorv91vXIkKWnn85NbSYhMYW7jBc4=; b=XUKIEqn1Na5VBSwdjAH4HrY8wz
 ibs2RVDSTDtbuTCIIg0VsfhULL7A8CG4wvw+l0BZy5f6PyfELQ4WD1ImIxbPYuAi6tNyse7lRezx0
 gDgOgtvvszY3VxNCa+dAJXuYVYTh+Pjd+aharvXng81hKMu/mReYNxt1uqYbVvrxg9Jk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RJkiT5URdSqgSHDorv91vXIkKWnn85NbSYhMYW7jBc4=; b=b
 0usJEL4kuHmmaqD+KysvukSdtqoip0XTs7EuXkj5YbPhM3PXf7v6PRLsOZGa14AmP1p5E7yceHjse
 Uk242T+G4d3MbzBFp5yXsNYFAb4+JCVCpFNjpHkg0/jkTFDn8R4DzoLAibWe9QjYkNQ3AcwwxSlRW
 oW+XLI9h1SV+gO9Y=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qJbu0-0008U2-Ue for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Jul 2023 15:37:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3B67F61844
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Jul 2023 15:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF812C433C7;
 Wed, 12 Jul 2023 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689176225;
 bh=OILACASUQuNBny7ncHi7TU9onZ6doz2v4VcsFgSmJsI=;
 h=From:To:Cc:Subject:Date:From;
 b=O6NPKaincgWQcVkv+hw4hzpMudod6daSbCgq/ZMBH7+V2yFEOBbPaGe616LZWzgc9
 NGpaHrlt3BrQjtPwgTvYZm591aN8dwPuiO+GNylATNypiZ7qdOHc2Ol4+8f8tOnWdG
 VQroY2LMKGOw6RKLFiwjavbSvTWCg2AEkBYSeeQO50Yv6IhAfbNTJs2vq0uqgRMFQ5
 rao8hpG2xROPTMINXdzBqy9W6avYPW9wix2qJCvNj7caV+zPSjwPJI84MgI26Gikk/
 f9SuWGQ3Cb+JytkyOk0rY5UwZKUJ1Q2OFkcghXNYTw3hLApumCALuTGGb8LEsKl31y
 fo036TIjMYMSg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 12 Jul 2023 04:08:05 +0800
Message-Id: <20230711200806.4884-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1qJbu0-0008U2-Ue
Subject: [f2fs-dev] [PATCH 1/2] f2fs: allow f2fs_ioc_{,
 de}compress_file to be interrupted
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch allows f2fs_ioc_{,de}compress_file() to be interrupted, so that,
userspace won't be blocked when manual {,de}compression on large file is
interrupted by signal.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d9073afe021f..79cb6a41f128 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4107,6 +4107,12 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 
 		count -= len;
 		page_idx += len;
+
+		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	if (!ret)
@@ -4181,6 +4187,12 @@ static int f2fs_ioc_compress_file(struct file *filp)
 
 		count -= len;
 		page_idx += len;
+
+		cond_resched();
+		if (fatal_signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
 	}
 
 	if (!ret)
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
