Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC87E6F095
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Nov 2024 23:53:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t71SQ-0004Fp-4V;
	Fri, 01 Nov 2024 23:53:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1t71SN-0004Fg-VC
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 23:53:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JpcEf4TJYo4HtF5cRx/wl9piaHZd5CZHBapYWy28FqU=; b=dU+mooDx7+I0+nPnh31FBbHSE7
 svRzrzPAqYPRn0KKasSP8eAzxFelpM0oVFsuvNHEXjNDDywwrC63MsJQrYHF4fwDvB1/n98FuBfiJ
 mHyhkiTwYVGO2pOhSRFnbTmhTqPF/m1Z8JndJT6/VNOJFn32SqNAbJ0yeo1qsLA1mDSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JpcEf4TJYo4HtF5cRx/wl9piaHZd5CZHBapYWy28FqU=; b=N
 ORDNjO2FOBa5P4f+YKWtPfkjBbR1J1gPoBmTsYvofb4UEAmiso6dHMX1qftlcuqtw9QDXIB00cpFZ
 3dzzSLzv2D8d6VR360g019KBXesrssukQZofN6La61+pbvPyaVM9Tuc0vthgyrVKtrJMsKD7vySex
 6Wk27mghqwvc5Kd0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t71SN-0003fb-5D for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Nov 2024 23:53:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D94025C0FCF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Nov 2024 23:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A927C4CECD;
 Fri,  1 Nov 2024 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730505200;
 bh=va9H9iI0O00VgULrnUSrnZYDe2E91e3RVuwvKrhhdQM=;
 h=From:To:Cc:Subject:Date:From;
 b=dppGHJ9vGyL089tjEmK1ozkl8Gle3m3Xznkvhq/9i4W8cgCX4+/fxFpEve6Hs5tYJ
 Vbk2n4OLDVfD67SxTwzpChswORhFrKWqTpO+SLBDY/3ZPvAGZ1qekut2A78vPghqAN
 /d1EEZK7I8bTdgSH3mw2qKt+oQ/Ypl0vFmp52YP39NQpaFQuFN8xzWL4cB7zZaTn1e
 ikIQUmthVMsXFF2YhFCNx/31m8rmLl9IMZOc2/Rvc0ilnUyg1N2KbHmeKsJeNa/DA/
 gqvzFXrTa8Yz3xIlnOK5Ricobk7ZIl+Z3UpNKFbAX9yRjV7L5lnnu9zUM9ZfgauQ3S
 SSfCilrnDCbVQ==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  1 Nov 2024 23:53:17 +0000
Message-ID: <20241101235318.300320-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
MIME-Version: 1.0
X-Headers-End: 1t71SN-0003fb-5D
Subject: [f2fs-dev] [PATCH 1/2] f2fs_io: support 1GB dio buffer
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

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 837f8a9fa247..487040ad21d4 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -872,8 +872,8 @@ static void do_read(int argc, char **argv, const struct cmd_desc *cmd)
 	}
 
 	bs = atoi(argv[1]);
-	if (bs > 1024)
-		die("Too big chunk size - limit: 4MB");
+	if (bs > 256 * 1024)
+		die("Too big chunk size - limit: 1GB");
 	buf_size = bs * F2FS_DEFAULT_BLKSIZE;
 
 	offset = atoi(argv[2]) * buf_size;
-- 
2.47.0.163.g1226f6d8fa-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
