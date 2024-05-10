Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62CFC25B10
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 May 2024 03:43:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s5HAm-0003KO-IA;
	Fri, 10 May 2024 03:43:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s5HAk-0003KE-Jz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 03:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6LzJ43WvAOHJxCE0K8BVemedBb4VsdOejNFQGDR0UhM=; b=dFgmVLnyu0t2JBUmHIkpGeRZWY
 HbDgmVLQqph6Nun5VOtKVjtLeB+Cy9pwfHOQbKIhUrbdYXDH3n91c4BZBeGb6XuZ0A8CrwkMdBKB0
 aRgi3xITeLi74F5Cr3IGjJ+2KVY4N8C+kRtMJ+NRomNJgAvOF1l4stLaPmCWzJCgLxdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6LzJ43WvAOHJxCE0K8BVemedBb4VsdOejNFQGDR0UhM=; b=b
 IuP/vdGzyFruhJK8wXQjKzKFanIwkffq12P0/QtJmcjg55AEBtYyUt2rh3B44vv+hyy7fE4K7fykZ
 b8Sc1Gz7GmKTEqlEOPyRyvEBmTB7vFGq6Ybu/6Cikq9L6jl5ikJNvY0F9iALRfGLwWew9wmFDDN1Q
 YGzOk2Y0C2r8QjU0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s5HAl-0005DY-3h for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 May 2024 03:43:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F27F661E21
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 May 2024 03:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF0FC113CC;
 Fri, 10 May 2024 03:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715312619;
 bh=26S/wLyNbf+8N1bKoCdjjtV3ExKiUVLPx3+HHDN4lT8=;
 h=From:To:Cc:Subject:Date:From;
 b=jxJXsYrJxzgp0rFoAf14zhFKuKl2CFtJl3j9DPQXefWPbOSBvDcGuHss8iBTy8dhk
 sDh1YsjLgJXNupOHbCJ841Tc4aCdtxnBiDTkodDU+3Jw/nINTVKleRRGSEPE8MhVj2
 w7zgQmr1g6V/V+rfiyZzDIzSAszwMZmbfSr1lW7xbdmLb9uZjlsfYWLDUo8egchsvz
 RTPQwe2UzT6BrFbUqp5A1CBNF8hSHE72W+TqpN3gIssHlNtVopnMOPnixQ+mp2v947
 nll9uYIeX4dNLmWpxnCxfWjZybdaJl+Z7WRigUMk7RSseuMFQc/Crx528LacIu11es
 WgaHvGh6XsDEg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 10 May 2024 11:43:33 +0800
Message-Id: <20240510034333.358653-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1s5HAl-0005DY-3h
Subject: [f2fs-dev] [PATCH v2 2/3] f2fs: fix to add missing iput() in
 gc_data_segment()
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

During gc_data_segment(), if inode state is abnormal, it missed to call
iput(), fix it.

Fixes: b73e52824c89 ("f2fs: reposition unlock_new_inode to prevent accessing invalid inode")
Fixes: 9056d6489f5a ("f2fs: fix to do sanity check on inode type during garbage collection")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix wrong fixes tag line.
 fs/f2fs/gc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ac4cbbe50c2f..6066c6eecf41 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			int err;
 
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode) ||
-					special_file(inode->i_mode))
+			if (IS_ERR(inode))
 				continue;
 
+			if (is_bad_inode(inode) ||
+					special_file(inode->i_mode)) {
+				iput(inode);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
