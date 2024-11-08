Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E52AD43357
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  8 Nov 2024 01:26:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t9DlQ-0001tj-Df;
	Fri, 08 Nov 2024 01:26:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t9DlO-0001td-MP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Nov 2024 01:26:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0bbD3VzG1ld2zlzpGbuW8oWGC1SGtlFWv17gGmQQ/Fc=; b=RqhgI8pB6OMmWMm+UxVnBZpU3G
 CL0f5a6iUJp3uXwIdSgvGnH+6c9RGiAgrbHPUWUEZtzorFUela4kSg/0FDbdwrMiSNtpM3V0WdxQv
 rkoaJ7qRXigJByiiYPTpJCFcFW9CZFXXVTvg6yHRuM4Udool349CMM0IUKNnqzfl4ZVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0bbD3VzG1ld2zlzpGbuW8oWGC1SGtlFWv17gGmQQ/Fc=; b=F
 FXw0UvTFusNL8N+9TP8nl+e+LaXFUxFEa0AFPV5sjE3oOwRPJW2ip7z/DySy6IlMNZGucV8o2dkFr
 zMVWsmLZ4NeNpTd2AM1a3Uir0V6O5KFAgnhH3BJevlV6RnEEXfG5eweFwQZ2N8/uAKl9f4k5jygFn
 Y9c0LVzRBlPVc20Q=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t9DlO-0006B9-RC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 08 Nov 2024 01:26:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CF2FF5C0071
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  8 Nov 2024 01:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F40C4CECD;
 Fri,  8 Nov 2024 01:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731029164;
 bh=V97j2w44oH4Bt64bhHsn481jd5vtLuRAKMSr57gdZ+c=;
 h=From:To:Cc:Subject:Date:From;
 b=XQ4yV3kD9VFPJHEyN/pRHQpBTtlIhQoCHnK69H8E+314TNESx78zuyjzTVYSHM1jS
 JsOCR+EOEMCRL8uh9gtOVLQbeAwyrXLG6Q0Jq/LgUwTYnypqWd7R64ElcfLVptutEH
 +OxG5hws8wID07BT9mZQDPwndJBDpml2a+Xx5nSWJx0KNn+S2129wt5f2Map9NJrh5
 AsWAbYyYiLmqzQUfBdvUem1J1Cbpeg7n7HOxbvigUg91YWuEPOZBm8SFH15LCpfcfy
 JJFzO7LS3mNnqj6XDOzwXhlguuLmU3Pzqoao181U3Oz3fLGvQxgFyTXvwESf0hdo+B
 HhGFvKssIEuXg==
To: jaegeuk@kernel.org
Date: Fri,  8 Nov 2024 09:25:54 +0800
Message-Id: <20241108012557.572782-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1t9DlO-0006B9-RC
Subject: [f2fs-dev] [PATCH 1/4] f2fs: fix to do cast in F2FS_{BLK_TO_BYTES,
 BTYES_TO_BLK} to avoid overflow
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It missed to cast variable to unsigned long long type before
bit shift, which will cause overflow, fix it.

Fixes: f7ef9b83b583 ("f2fs: introduce macros to convert bytes and blocks in f2fs")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 include/linux/f2fs_fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index b0b821edfd97..3b2ad444c002 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -24,10 +24,10 @@
 #define NEW_ADDR		((block_t)-1)	/* used as block_t addresses */
 #define COMPRESS_ADDR		((block_t)-2)	/* used as compressed data flag */
 
-#define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
-#define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
+#define F2FS_BYTES_TO_BLK(bytes)	((unsigned long long)(bytes) >> F2FS_BLKSIZE_BITS)
+#define F2FS_BLK_TO_BYTES(blk)		((unsigned long long)(blk) << F2FS_BLKSIZE_BITS)
 #define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
-#define F2FS_BLK_ALIGN(x)			(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
+#define F2FS_BLK_ALIGN(x)		(F2FS_BYTES_TO_BLK((x) + F2FS_BLKSIZE - 1))
 
 /* 0, 1(node nid), 2(meta nid) are reserved node id */
 #define F2FS_RESERVED_NODE_NUM		3
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
