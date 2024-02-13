Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EC0C48260
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Feb 2024 23:41:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ra2Or-00015n-1v;
	Tue, 13 Feb 2024 23:41:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ra2Oo-00015h-Tj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Feb 2024 23:41:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s2LSFg5uarGhJnRpbNK4ijzi9oT110cyOlYvizZt8S4=; b=V4Q+vM2NMUFye+PtAAe5IrJdAB
 FfiJqUjVsVg3MaqI/IdAEcLkGNh5Fvkug/tPtODieK89k3kL9qxmdK/R5r/av7H69QSgCNKcL4CNK
 dCqJHfDVVdCII8rJFKPQsa1q+EmDl120F2s30/ixpYhEeCWMscpXzZhfK2HCBw8iuow0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s2LSFg5uarGhJnRpbNK4ijzi9oT110cyOlYvizZt8S4=; b=W
 TFdlVoRFUKHzmDT+Wgk3zzPaYBlsT1djTXvibwVLkl4xcVBtdKIIOFzlO9T9rmBDY2C8AS9skDTUp
 fNVakru/94CT5DU7YSmnqPUUJ/RQGu9Vsijyxw5fnmM6K+gd9EHy7ATkD/dwSZVUOmhnLYU51N/yf
 x9Ent3TpW8o6+Zp0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ra2Om-0003mx-HM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Feb 2024 23:41:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CEF05615E7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Feb 2024 23:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E17C433F1;
 Tue, 13 Feb 2024 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707867662;
 bh=IoBQJXI6va9TGfQwToNoXISsg2WBMtKVsHoASwjTkww=;
 h=From:To:Cc:Subject:Date:From;
 b=RDprSUj3zwiQBJTgDfWFwHMlqAX+jMZAEkHHH0+bh1PvdHZmFBx3y8w7pxi80hBAF
 nQPtwcsIW+3uDompWAk+/FEw6H0t595vAjJlPpEMW5Duij+wM+a9k1f0iPXA4pRaHr
 FQydkyUVTRhxsQCNnsQqpNm1REqS5i8+cqI8LNTIGYutueRPlVrhmRZCPzfRxLWi22
 fVip8s04f9ZfMa8ffN9Z4043NkmREObbYIolswphqZxpOGvfXkQa/vivX56UBhRXeC
 cx39NYSSJqcNSjM+Jh+FTWtLyjJfCZTrh81Yozxo18XdoN3DDtb+rD9xmnBTWp1Cji
 g3fifdjIHM//g==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 13 Feb 2024 15:41:00 -0800
Message-ID: <20240213234100.2445417-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
MIME-Version: 1.0
X-Headers-End: 1ra2Om-0003mx-HM
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: fix sparse_mode case on stat
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

When we turn on sparse_mode, stat() will be failed, as the file will be
created afterwards. Let's fix.

Fixes: 14197d546b93 ("f2fs-tools: fix to check loop device")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 lib/libf2fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 5c6c5b7bf8a7..d51e485361ee 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -814,6 +814,9 @@ int f2fs_dev_is_umounted(char *path)
 	 * the file system. In this case, we should not format.
 	 */
 	if (stat(path, &st_buf)) {
+		/* sparse file will be created after this. */
+		if (c.sparse_mode)
+			return 0;
 		MSG(0, "Info: stat failed errno:%d\n", errno);
 		return -1;
 	}
-- 
2.43.0.687.g38aa6559b0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
