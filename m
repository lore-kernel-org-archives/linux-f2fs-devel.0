Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB2CC6B3A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ngWdCigsHtEwbzwaDGRS9TUUBJCSlUFzBCjgFEPuCjM=; b=HAqN9d6DGEEwZo84Kiuwt1cOTm
	tnb599nwjT1li1Ra6tV6Th9M19mWhlB5wGV5Q+zJ2xNbPXgf48zL7KpRx1pmnEDRI1GdkYosCxz+7
	S9bF336id7yw38NhnwdnfpHX+G5uypU5ZPRkju32WqugQPX9gF//NE7JRImj0JjC+juk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHO9F-0001xB-2X;
	Thu, 15 Oct 2026 16:17:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xHO91-0001ww-Ct
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 16:17:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e/dtXorIWh5RpuBhW8iMUT+F6g07/k8JXa1ZHIcQO4A=; b=X1ulpqokrCtqBYn06oWx81RXcd
 mCC4iT2r/eecHRTYz4UoVxb7ioxFvTxJdihbIc0YA1fuixG8rPMy6CguI/i2K8K0+vKje9FdFPCPs
 AdTDRLSxlbZUBad8RgzKZAiUF9I82felubqVNvmmmOE8DuABg/UXrn8W49MJJEtyGADA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=e/dtXorIWh5RpuBhW8iMUT+F6g07/k8JXa1ZHIcQO4A=; b=K
 HJTsVMUupLgeRkRnLjoX4y8vIpjaLicsb6kILNJ5c4iA2JfWniRI0PT8/axvoEJgTAKDzYN2smPRt
 B2zOf6fZFTMyPQM1JGmXwiS+xP5lXTdilA9qZpCV4BAB7mat8/Ts6KrXfB8jfRcWzfqYjgE1tb0bS
 z6tQO5uYFu8K0sMk=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHO8z-00051g-He for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 16:17:28 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-3ac77270fbfso1216743a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 09:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792081040; x=1792685840; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e/dtXorIWh5RpuBhW8iMUT+F6g07/k8JXa1ZHIcQO4A=;
 b=pWrlzw+clSBlrB8HI51v/QF6Gk54q781J8I5rzcrNk9/+kZFFle/VFEnlyVBXlXPWr
 sKftyLzZDg2YNZFoEpImxWnjf6eHeTLb9MXS4XdaASqQubh6trH9DYLJqw23d13tHxZg
 YT4ZghBQijYp3tmbTG+3mzdW+NdDHztMYuwYXcFvbdbC7i9RkAQ1MP7mSTXm9DtcfFxO
 YS6Pzls9DUmW2ZD2qvEoGIop1Y9RLQ9MEAHAWvuwMDhaCf41KbF4zKSZAUyUTH+HbtO2
 ezOoqM0pafL6/d2fHVSEdIvELnbb9vTAr+d3kmD8FQntiLpwmQty2ZkRJ2fEmiGMso5T
 iWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792081040; x=1792685840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e/dtXorIWh5RpuBhW8iMUT+F6g07/k8JXa1ZHIcQO4A=;
 b=KhBNoh9JeoCg4XwYMqWoLkDIJeoXw0Gha8fk3EwQTNOSmmbrvfYae/cTxi82muweJ5
 4m63cJyWYFU6UANbZCYbzPH8VLXn9Hr4++lqeICBsjNhdFE+cZkRLfz5e7YXhgNAxJg9
 +h+G9mSVXmARiVdanzGEAqyagLob5+DyzVM8dW6SDfWTs5+pD4oK6/sSr3YtWDzkMedu
 7he+6H1pojrKaBr7p0InjU+YMH7JTd/9H8aUq6ADfIjkhLOZEPVWDP8Lm+pEpZSv0g1T
 8x+qC187X4EsI6SkIL/Qu3UhEoXqpgxOHo2YnMIcPHN0ZC3gPSZyqvE1gF6jLuaclrJn
 J4lw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQEygcA2oL/raLMGQL10AxVP0p0DJiYmwmShy0UjTJO9ayhPv+qzbM1VLztt0A/jAxCbvnALFFcKFIJ1zFHrvO@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK+rU1czXuWUjyOvZBB/IQMAiKA6g6Su1mOGFIx4EMpFvc39DYZ
 Ttw7wRR+/sCqUv7sHjaC9LzMFf0pOzIq9hmM4aJhQlPdmtUb5D27ZGKX
X-Gm-Gg: AYBFou2ZH83VcSVUb5GWcsgRE1b1z0Afxx6ef4yTou0OqvXdEBrfwM9lW8sSrmJ5AOX
 N3UTso9FIlzIDkbFR8zO9U7kKWRZHcWfG8kbLZPq57EDZ1L2Zwvo6fWzX4yc9M4vU+CgwR1AJiL
 ntYYBKWW4shyz91fSezLPhfSqG8guY5OcsPSA18t2X9O0+QZyOGjAzgCsFjGhSH4hmjLeBnOFDM
 CNg5wN8QMCMt0Zw1CaDDLWKBFXrHCD6VUVxZwzBuqhEwB30kd0cG+h+tk6+14WBv0bgiQBhzIyd
 Hmp7IrUXEZs/a7US4+yR0Q7+aFJ5VBBBFRY9hCUZrKblfjrphfdfBfBl7d4G0E47xGkeibUHC7K
 YsgSDPkx4Tba55jVEYmqtBEuqo+WcDzdGWKExSnO1r1xsL7fiGeSbZrXqH5Tp7v3kRSgvBjP9oP
 e7GVZUlUJb0zggqMKmIaQjoui4o1Sei2qPL5jXuUSf0BUd8FbYrjSRdNRtYxPlohe2JlW1RBIKV
 LPOvu0Kt+ikLjKDGJ33CtDXuxThhT7j6czKC1l8Zb+abP5lF/j/7rVbuvgtLgdZV+evPSuZDTJB
 /gYQyjEr2fOKKfMT
X-Received: by 2002:a17:90b:55cb:b0:3ac:403d:6239 with SMTP id
 98e67ed59e1d1-3ac403d6baamr7208538a91.43.1792081039779; 
 Thu, 15 Oct 2026 09:17:19 -0700 (PDT)
Received: from f2fs-test.c.googlers.com.com
 (225.134.16.34.bc.googleusercontent.com. [34.16.134.225])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac945e74bcsm5082958a91.3.2026.10.15.09.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 09:17:18 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 15 Oct 2026 16:17:14 +0000
Message-ID: <20261015161714.1586334-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
MIME-Version: 1.0
X-Headers-End: 1xHO8z-00051g-He
Subject: [f2fs-dev] [PATCH] f2fs: don't use truncate_inode_pages_final() on
 live inodes
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

truncate_inode_pages_final() is meant to be called from ->evict_inode.
It sets AS_EXITING on the mapping, and nothing ever clears it, to tell
the VM that the inode is going away.

f2fs calls it in two places where the inode stays live:

 - F2FS_IOC_START_ATOMIC_REPLACE uses it to drop the page cache of the
   original inode before setting i_size to 0. The atomic write then
   goes on through this inode.

 - f2fs_abort_atomic_write() uses it to drop the uncommitted data. It
   is called on eviction, but also on the last writer's close in
   f2fs_release_file(), from f2fs_file_flush() when the atomic writer
   exits, from F2FS_IOC_ABORT_ATOMIC_WRITE and when
   F2FS_IOC_COMMIT_ATOMIC_WRITE fails.

Other processes may still have the file open or mapped in all of these
cases. The mapping then stays marked as exiting for as long as the
inode is in memory. This stops reclaim from storing workingset shadow
entries for it and breaks any code that assumes an exiting mapping has
no users left.

All we need in both places is to drop the page cache, so use
truncate_inode_pages(mapping, 0) instead. The eviction path is not
affected, because f2fs_pre_evict_inode() still calls
truncate_inode_pages_final() after f2fs_abort_atomic_write().

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c    | 2 +-
 fs/f2fs/segment.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7020b3e8940..1e6f1f02357 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2466,7 +2466,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	fi->original_i_size = isize;
 	if (truncate) {
 		set_inode_flag(inode, FI_ATOMIC_REPLACE);
-		truncate_inode_pages_final(inode->i_mapping);
+		truncate_inode_pages(inode->i_mapping, 0);
 		f2fs_i_size_write(inode, 0);
 		isize = 0;
 	}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 794e0d99fc7..781995fedcc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -194,7 +194,7 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
 		return;
 
 	if (clean)
-		truncate_inode_pages_final(inode->i_mapping);
+		truncate_inode_pages(inode->i_mapping, 0);
 
 	release_atomic_write_cnt(inode);
 	clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
-- 
2.56.0.385.gd3acb90ef8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
