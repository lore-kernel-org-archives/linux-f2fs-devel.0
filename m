Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3F7C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 Dec 2023 11:36:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rCI6a-00044B-Ii;
	Sun, 10 Dec 2023 11:36:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rCI6W-000445-Ug
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 Dec 2023 11:36:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LoV3aU+OeYj0J0DMe7rQ2hXcaDTfLCZAvSvKZ4YzN/M=; b=akbSTOjcd0HpD1G/LilRa0Z5Df
 hnvYo5PYbr4O6oLtYaNKUMw7S6tkN5p5nB/CZV8hZaaJeP45PZjkFBasvIG2RWOpLYHUQ0cqEIr89
 Drd5oX/0WMhYRWZlOtiDKaislQD9Wya+stEKHVUySBnUD/SyQeGwTHBknM7ZajBoAG9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LoV3aU+OeYj0J0DMe7rQ2hXcaDTfLCZAvSvKZ4YzN/M=; b=GgtlHSOnvRkAxbCkZdojKEklqt
 Vbyyns4nsauxKrMKe8F3IvTK9JJuHgQiqoxHyLqs1pi/B8Y8pOaUcB7RjFV/0GRLwvQHSoQgvX+Vz
 PcnzGVYsmaZdzw89rNHuWo2luoPVPxk1SYAFTUDXu10tIh0SOebGhp+qr3kdaQibCgaA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rCI6W-0000UZ-Bj for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 Dec 2023 11:36:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E41A360C5D;
 Sun, 10 Dec 2023 11:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2476C433C7;
 Sun, 10 Dec 2023 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702208166;
 bh=hIUlpOJ3aDB7nGkcog2qFsHcADMxnRlMDotLaomis/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K6wvItDiHuOzned+j4BhIjpFIQoZDWqwoE4wwGaR4Fw+eY5+AkRtDWnwteNFlwMrv
 +CaTN0Kh7EwMjhsSMWh/CfmCoTSjUstW04Q4ro+besEvfsC0nVcfwpr256ctyDlolw
 QCKDXMbUs5vv2nMM4qA7zii7GlhNcLsokDcrr8yVYiHm9OLgW6xznggE816B5fwOnb
 o/8/3pCllvh2sUfJolQ+l0fVepwd1uImEVX8aMmesN5mM8e61tuCJROLZI5Pl1XUrO
 xOK08NqPz5D2euciBnLvdkzhWYo2cVrDSUTy+0hPQoWwhowAezT3QysEst52Hq92Tn
 GYBWdA36GuvXw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun, 10 Dec 2023 19:35:45 +0800
Message-Id: <20231210113547.3412782-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231210113547.3412782-1-chao@kernel.org>
References: <20231210113547.3412782-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1rCI6W-0000UZ-Bj
Subject: [f2fs-dev] [PATCH 4/6] f2fs: don't set FI_PREALLOCATED_ALL for
 partial write
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
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_preallocate_blocks(), if it is partial write in 4KB, it's not
necessary to call f2fs_map_blocks() and set FI_PREALLOCATED_ALL flag.

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5c2f99ada6be..1a3c29a9a6a0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4561,13 +4561,14 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 			return ret;
 	}
 
-	/* Do not preallocate blocks that will be written partially in 4KB. */
 	map.m_lblk = F2FS_BLK_ALIGN(pos);
 	map.m_len = F2FS_BYTES_TO_BLK(pos + count);
-	if (map.m_len > map.m_lblk)
-		map.m_len -= map.m_lblk;
-	else
-		map.m_len = 0;
+
+	/* Do not preallocate blocks that will be written partially in 4KB. */
+	if (map.m_len <= map.m_lblk)
+		return 0;
+
+	map.m_len -= map.m_lblk;
 	map.m_may_create = true;
 	if (dio) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
