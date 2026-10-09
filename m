Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60C7CA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iqVMxzX+L1XU8cHN/C+v/dOg3Lf2+YxPYK3Yo1VcPSI=; b=HM1eU286q/EbQRN9gtfTvcAezm
	2h7LDfJ4L8gEHFwEjylCSlBnNNiX94LlhBlup8VjaOj4Vz+tLZuOk5vCc0Kf2e1YDROvxKY8KBgO9
	S/6/aFSsi+bSts6Lw0mzi+/Wvw/9UCgnyQpHb4KAn8KIM/ZoYg5oZvjRRgX00lttsgYo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF8Jx-0004Jz-JT;
	Fri, 09 Oct 2026 10:59:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xF8Jw-0004Js-8L
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:59:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=; b=DcZ9vXL08ivXKJE++rR6R3BgXI
 lNIdHeHyVnALRLJP4rJVk7r8ke2PpHRKwnPG/tc549eH26bwGO/F6x9v5RFnbhRBmS2YZ60VfOBOS
 z75nCbFxGXMgvO228lhKG4FnJlenAitMQ0HMIpTrMfqjjuV+sn+j4S8FQNZr84oeNN8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=; b=VObp7KSGy/SaEcw+0t5L4gvWUF
 3b7UywxgxMBUSHqEMpF+Cwmh9TyeEcBRFP4Up/qWOwJy3/eLHxZQToa7L1ZkC5WNZYk/SJy9nWXVm
 uPmkWtZ1ao72Oybxi1i3Z5/kpIBwLd/X0wLupcf77r3eGK1///XfUBrJVtsrlr1LtHe8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF8Jt-00055x-LX for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:59:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D84360DC4;
 Fri,  9 Oct 2026 10:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD901F00893;
 Fri,  9 Oct 2026 10:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791543555;
 bh=O7Xi6h1I5Mb6FlicJ0w7Ua9QyL0wb103FvJh6JPXnG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QXt4+sYLNeO8lwuHdgchBnBOQlnll7Do8nta0N+/PO54Y1EnlOE2c9gy+P5Wz9nqi
 29wzZpF3rAp7h0AdSKTuqz4BZeoaSdXZoiqMkDvu1xtyRbg5Mg3jCvzgaCDuPDeGhK
 IOaszuUpAXazVXb0pafiWISAstGub6PQ+euczbOfuGZdbsVtRSmJi4xb8jmErEhaYO
 bPCApAumjOTy+yjHelHFKVRNxIKUj/JAk751WoEr16eoosynMvQnHTo66kc29tTDoy
 MNl3bk4+pslocBtAfosNf1dn2nqPR4GAlI82/jHUnq5JBtXFHbQz+IC+D5z4MWQ7rD
 ZgoFx4JTgIG/A==
To: jaegeuk@kernel.org
Date: Fri,  9 Oct 2026 10:59:06 +0000
Message-ID: <20261009105906.1861478-3-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261009105906.1861478-1-chao@kernel.org>
References: <20261009105906.1861478-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF8Jt-00055x-LX
Subject: [f2fs-dev] [PATCH 6.12.y 3/3] f2fs: fix to reset all pinned status
 during fggc
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2b8704b6a8b2896ccad1f5941d9a3e2c5031a470 ]

Otherwise, the pinned status may affect latter flow of fggc.

Cc: stable@kernel.org
Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 664260807072..6c831276d81d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2132,6 +2132,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
+		/* reset all pinned status during fggc */
+		f2fs_unpin_all_sections(sbi, true);
+
 		if (!dry_run && get_valid_blocks(sbi, segno, true)) {
 			err = -EAGAIN;
 			goto next;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
