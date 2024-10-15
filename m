Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2770CD1D88D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Oct 2024 16:56:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t0kqU-0003m0-2q;
	Tue, 15 Oct 2024 16:56:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1t0kqS-0003lt-V8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Oct 2024 16:56:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cX837K8t1CLAkbbfSHctpIIC1BMJvw6yBvsoQVreriM=; b=W62wJnemS8nBAFv3z93ANc4wAa
 rejgLNO1e54tDmvXrZNPqp8U4H6uGo8vcx37um+aF+XWwpng5diAb7ZesOSCNXby0VEaQ2GwrcDgk
 tAGgictfzocKDZtAVgRcXBgJwk8r3HnM35KzPnDJnleGoZNXB9enQpymZnlUBlPywHv8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cX837K8t1CLAkbbfSHctpIIC1BMJvw6yBvsoQVreriM=; b=O
 xf22b6ZsOvE0k2KRUyglYaPZJZB/hHWYSoh5oXVx62rZBHU1ckvCklbkZEpFOoPgy74yOvggUO4b9
 dnPH6EVFcsclE0l/QY7tmnCL3X9GVCeRD3TjuvS92/Lpz6lfkrUPP7E8Bv//PBLCV1iAhIwBkOXqW
 bc6CrlwKYZHTo1lA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t0kqT-0003Hc-3T for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Oct 2024 16:56:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3FDA65C5A55
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Oct 2024 16:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D9C4CEC6;
 Tue, 15 Oct 2024 16:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1729011378;
 bh=i/NUO7s8KR8rQ5a4oLGDv7r3DF2h/6EEG2NgKNtrjoA=;
 h=From:To:Cc:Subject:Date:From;
 b=o/I1g+3dQJMZbM/F5zRg7Zkx3D8AIEQIrCAgLrwoR1lkgrTPPK2T1v4rMZnGMPLQu
 bN+SCYU6dql/cpDW+32Ed1IM+jXLM6QZN6HR0rmpUuKl0hCwMY8h9Ly6Q8tJpJtdxp
 zSCfpoWCaqu7L8UyT6xj4eSsE+kg2c7e3uK5CqXVhMjg+pOIH+n0sJhDoeaxjx4Suj
 /tvCkghR8Gix/VXNN08fqcGbM201+9D0fVs0Z6kTaC3iMUilf6CqnzPtPSYVeiRPxz
 Mmy9OurF1udMUcGUSThGHzoBd1wojGnsewDJl2qK/stCrHIQ4cBYgml/B+wOZDWYN1
 7uH4j48NOF7wQ==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 15 Oct 2024 16:56:16 +0000
Message-ID: <20241015165616.65434-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
MIME-Version: 1.0
X-Headers-End: 1t0kqT-0003Hc-3T
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: don't trim on aliased partition
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
 mkfs/f2fs_format_utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 1c2003e8d107..1a9746a77184 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -48,6 +48,11 @@ static int trim_device(int i)
 	uint64_t bytes = dev->total_sectors * dev->sector_size;
 	int fd = dev->fd;
 
+	if (dev->alias_filename) {
+		MSG(0, "Info: [%s] Skip Discarding as aliased\n", dev->path);
+		return 0;
+	}
+
 	stat_buf = malloc(sizeof(struct stat));
 	if (stat_buf == NULL) {
 		MSG(1, "\tError: Malloc Failed for trim_stat_buf!!!\n");
-- 
2.47.0.rc1.288.g06298d1525-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
