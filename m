Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94671C79FB7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 03:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hBLj7+MZM26SxyVyOv3rAiV9h4aHNUxZ6HaqRw+3tZk=; b=Jv1Keseb7aAMTNCqQTSd7Lhl39
	o94TfC22Pncv2PqyGLsWqbFzFCZPgBJRbsjuIVjz2wBMdBqa/Wxka+x6hJUopGWgcbayMhc9SUSHS
	HcWcQ1aU2D10vErNnRLohksyD7OSyFKYhTDPro6HCY6eA6HBp7j+n/QbwwbWjJQdzM5w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4VKE-0008Lf-C6;
	Thu, 10 Sep 2026 03:19:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Zhiguo.Niu@unisoc.com>) id 1x4VKC-0008LQ-Nj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 03:19:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1CUB4dEzXN6Gea91X3OtNb4FA0wYGteZsp4Cdi9SamU=; b=WeeQkqU4IeIR1j/IgqKUF/20Ci
 OUfOZsaQ9r0RcQc6MMCfiWHvz6vMqH0Mx3AQXh4CMEzFSN0oLLB9HO4aQSBTqz7UOns74766ljzMr
 dDFi4Tioj58y+aU1jdNh/2vOLFkBw1yeI7glgR2qHoxaLSlJ0ggKVO5QmsEIXzZzWsFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1CUB4dEzXN6Gea91X3OtNb4FA0wYGteZsp4Cdi9SamU=; b=Y
 ekJwWCzhPq5P+0eoB+gpx2jHR6qDxK0tvKuQSDEBjWnofwgYpXzEPLqtMu7NiW4lU8WGey7KdIUW6
 5+0K18sjbz7+fMyOIbT0wzNedUaVkxpxnkrniQaz2fm9teENrD6RKBmFqrFJW4V2p0FPjLpfrhvnv
 RD7E/Gyf9k/Eyx/U=;
Received: from mx1.unisoc.com ([222.66.158.135] helo=SHSQR01.spreadtrum.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4VKB-0000Ff-Gc for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 03:19:45 +0000
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
 by SHSQR01.spreadtrum.com with ESMTP id 68A33kUW068191
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 11:03:46 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
 by SHSQR01.spreadtrum.com with ESMTPS id 68A335qt061859
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Thu, 10 Sep 2026 11:03:05 +0800 (+08)
 (envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX02.spreadtrum.com [10.0.64.8])
 by dlp.unisoc.com (SkyGuard) with ESMTPS id 4hgMr13GT5z2M2Pkd;
 Thu, 10 Sep 2026 11:00:49 +0800 (CST)
Received: from bj08434pcu10.spreadtrum.com (10.0.70.50) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Thu, 10 Sep 2026 11:03:03 +0800
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Thu, 10 Sep 2026 11:02:43 +0800
Message-ID: <20260910030243.3005578-1-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Originating-IP: [10.0.70.50]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 68A335qt061859
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
 s=default; t=1789009399;
 bh=1CUB4dEzXN6Gea91X3OtNb4FA0wYGteZsp4Cdi9SamU=;
 h=From:To:CC:Subject:Date;
 b=EjBVNOgMCzuFx54NqGzvSFLZM63VogNIS3hqkg5vdH59MlX5CuLxbAwsK5S5SOBGk
 rhjB6aPUs7qwoiPNYxpETxcpgO+Ns4B5AzSV8a3yUJMcgsdD4kqHsfpdFzOGStm+E4
 iSr9ToD4r2xOnRf85tQdDjFG9bJ/K0SZDeIz62MNwwMMGQaXUeXHNJN480Lcffnx0g
 z5ctyAc8oidUx0MUxn0LHRgKHlOYCFkD+NDjW1SHkjOJOZBEpl9/jnZzyROcnbGdVy
 0C8YBjMKLu8yS30r1hIoEEF26NUWz6WtX11VUWDtmt9FaWiWrtLw/k6Ft4bibnqI/b
 zBXSlbsny7urQ==
X-Headers-End: 1x4VKB-0000Ff-Gc
Subject: [f2fs-dev] [PATCH] f2fs: fix to record both APPEND and UPDATE ino
 entries
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
From: Zhiguo Niu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: ke.wang@unisoc.com, zhiguo.niu@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_post_evict_inode(), record_bits is assigned with BIT(APPEND_INO)
and BIT(UPDATE_INO) respectively, so the second assignment overwrites
the first one: when both FI_APPEND_WRITE and FI_UPDATE_WRITE are set,
only the UPDATE_INO entry is recorded.

The two flags are not mutually exclusive.Once the APPEND_INO entry is
lost after the inode eviction, the shortcut in f2fs_do_sync_file() can
take the flush_out path in the next fsync(), skipping f2fs_fsync_node_pages().
As a result, the dnodes holding the newly allocated blocks are not
fsync-marked, and after a sudden power loss, the data appended before the
eviction is silently lost.

This restores the previous behavior where the two ino entries were
added independently.

Fixes: 314c9e476ffc ("f2fs: call __add_ino_entry out of the eviction path")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 82ebcb338b0c..c20fcd8c2b97 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1058,9 +1058,9 @@ static void f2fs_post_evict_inode(struct inode *inode)
 		goto skip_record;
 
 	if (is_inode_flag_set(inode, FI_APPEND_WRITE))
-		record_bits = BIT(APPEND_INO);
+		record_bits |= BIT(APPEND_INO);
 	if (is_inode_flag_set(inode, FI_UPDATE_WRITE))
-		record_bits = BIT(UPDATE_INO);
+		record_bits |= BIT(UPDATE_INO);
 
 	if (!record_bits)
 		goto skip_record;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
