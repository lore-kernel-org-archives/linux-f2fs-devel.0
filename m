Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ED6C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Dec 2022 15:44:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pBHYD-00080g-Th;
	Fri, 30 Dec 2022 15:44:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pBHY8-00080M-9a
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Dec 2022 15:44:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5FkAXejz5uBbv0wStUEWSGXMribKnjxSOu1iG1c6Xyg=; b=FJJmVqICsmTwZIH2U5e7AUZxeh
 7URNdGmVuV1IpjvpPJTR0+4MvD7lIu4TAtN2oe3J6jTKHVef2VLvGvUWbRJJKEcgJ82XTnJDgFi5G
 JHgAaUdd5EeCoxGYndJ7Lo+Qy36GqB5jCON/gen6Ywg/Axy7SyhKIpyQ6BkGa7eSwu9E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5FkAXejz5uBbv0wStUEWSGXMribKnjxSOu1iG1c6Xyg=; b=f
 3wTM06Pt3FSWA94eKcUhtD382XTBxJ7bfQUfHW2nawefs3Nx3HMy6Kmt7r8s46h7see4YGZHEutzu
 +EeI5SThFCoBXVq3zWvZIpwLfeLSvf0DpgfYvCiYk6/EYY9HF2riE7nZ48ffi1aeKFMc+oWpIobpS
 Jk6A1GR8MhFltVf4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pBHXx-0007Yk-6w for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Dec 2022 15:43:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C7D5B61637
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Dec 2022 15:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47014C433D2;
 Fri, 30 Dec 2022 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672415019;
 bh=MApoGiLoefSH4r+JR0/qNkucbn2OhIB8DVcH1zXvi+Y=;
 h=From:To:Cc:Subject:Date:From;
 b=dphRm1ggz5v5Qt0dr9xZHKVqpoJYqh+TqKT0mwChf9iJ0DXpweo8sWg6BglnJC6UG
 WWx/5ujniUx/QKMwjspaDHwCG3nd0P3RGZzNYG1W5vz8zI36ncnLPRIXcpUPtigKr/
 CO43Bi/z41So2x/cU5Kd/dbcy3Rprh/oUzvEmmwxfY9VglK6Q6Swa75R/O28/gZs4L
 jASNVmrE4/tpLv4hsiV04XJZhqxK/FngemZnGvLgo9jReq34kcej0OftJ3/7WgxAE2
 byqABOKT/GhBA3BmdFzQpk5JbY+07d9I+C1zd7fJ9Yo89i8KLCz1K0OJr72wXK9LpH
 yeUCiuANGj0xg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Fri, 30 Dec 2022 23:43:32 +0800
Message-Id: <20221230154332.5082-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1pBHXx-0007Yk-6w
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid NULL pointer dereference in
 f2fs_issue_flush()
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

With below two cases, it will cause NULL pointer dereference when
accessing SM_I(sbi)->fcc_info in f2fs_issue_flush().

a) If kthread_run() fails in f2fs_create_flush_cmd_control(), it will
release SM_I(sbi)->fcc_info,

- mount -o noflush_merge /dev/vda /mnt/f2fs
- mount -o remount,flush_merge /dev/vda /mnt/f2fs  -- kthread_run() fails
- dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync

b) we will never allocate memory for SM_I(sbi)->fcc_info w/ below
testcase,

- mount -o ro /dev/vda /mnt/f2fs
- mount -o rw,remount /dev/vda /mnt/f2fs
- dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync

In order to fix this issue, let change as below:
- fix error path handling in f2fs_create_flush_cmd_control().
- allocate SM_I(sbi)->fcc_info even if readonly is on.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 2646575f43de..16f60c646cc2 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -663,8 +663,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
 	if (IS_ERR(fcc->f2fs_issue_flush)) {
 		int err = PTR_ERR(fcc->f2fs_issue_flush);
 
-		kfree(fcc);
-		SM_I(sbi)->fcc_info = NULL;
+		fcc->f2fs_issue_flush = NULL;
 		return err;
 	}
 
@@ -5137,11 +5136,9 @@ int f2fs_build_segment_manager(struct f2fs_sb_info *sbi)
 
 	init_f2fs_rwsem(&sm_info->curseg_lock);
 
-	if (!f2fs_readonly(sbi->sb)) {
-		err = f2fs_create_flush_cmd_control(sbi);
-		if (err)
-			return err;
-	}
+	err = f2fs_create_flush_cmd_control(sbi);
+	if (err)
+		return err;
 
 	err = create_discard_cmd_control(sbi);
 	if (err)
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
