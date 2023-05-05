Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F64C77B7C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 May 2023 19:18:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pv0xE-0002ll-4E;
	Fri, 05 May 2023 19:18:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pv0xD-0002lc-0I
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 19:18:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bpz8/L7ngC/KzRPalivh+Qmuxnl1zFk1r2BrOaCvykg=; b=jIe+U3hcu+KH9kf2C0IoepJxrY
 3ybixXPhg7Bbu3DeK76H/DJaf47VdwtJzZLRT3UkYUcsU/g/8lEGsSoGxHQUyh3hr2k2beP5z4XOG
 wBL6ve7ZCzCvMipEEa8ypW/CMmaLun0YzVmdKqyQqpSUxXTnyOak02VpW2FBuW1tZERg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Bpz8/L7ngC/KzRPalivh+Qmuxnl1zFk1r2BrOaCvykg=; b=L
 5WJIkV/1Gc6ttKPeUVHSwfK4HSWg/EmJz5W3jWIMo39cv8gNswqHcgnPOcbf/ZeyOQGGLin6oYaUS
 7s0NfPqhVzG8yS858UM0LR/FDOhB3csah90mMHeahZQJMgrsZI4N9dj20om7lcO2lvSBgwD3NYJaU
 fEVI/hI3hhUNHM48=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pv0x8-00FbaN-2L for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 19:18:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7F99564010
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  5 May 2023 19:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5877FC433A4;
 Fri,  5 May 2023 19:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683314323;
 bh=WqR7xSNCDj5K0Ml3rB03N8hM6nrYRl2mEIN/908vw7A=;
 h=From:To:Cc:Subject:Date:From;
 b=OGiaSO4C8fvx6Y/tXE89myDZ3z0EaZDePnhKDQdzQTiH4ZWzD41u3/cRLpdtriKnT
 pXPLCHrnWPODUjfcrYSzu1NFJadNUUY0aYGgnwGDAlnAmyE9IY0yIE5nVhbACq+VSK
 jGdUTs8Jtahsc0eZy06KwcGQdlgFyGR11sFFCFu2sZLGQcA94lMrFFVyimfQOUJ34/
 J4f4MDvjhx+hvJLf38UEkgF7QJkPQDrq0PNreAofB/QVHhOh5bpeAE8bhpRjE/4qEm
 d/JuHUhXJ2DH4VCxv8hNHGr6HM+EHP6BRNQw9QQY5qSC+GxISStqwZXoprusM5noCR
 HsLAtcY1zf5NQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  5 May 2023 12:18:41 -0700
Message-ID: <20230505191841.3185179-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
X-Headers-End: 1pv0x8-00FbaN-2L
Subject: [f2fs-dev] [PATCH] f2fs: fix the wrong condition to determine
 atomic context
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

Should use !in_task for irq context.

Fixes: 1aa161e43106 ("f2fs: fix scheduling while atomic in decompression path")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11653fa79289..10b545a1088e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -743,7 +743,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		ret = -EFSCORRUPTED;
 
 		/* Avoid f2fs_commit_super in irq context */
-		if (in_task)
+		if (!in_task)
 			f2fs_save_errors(sbi, ERROR_FAIL_DECOMPRESSION);
 		else
 			f2fs_handle_error(sbi, ERROR_FAIL_DECOMPRESSION);
-- 
2.40.1.521.gf1e218fcd8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
