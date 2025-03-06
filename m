Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3AC282DE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Mar 2025 08:18:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tq6RB-0001LV-M0;
	Thu, 06 Mar 2025 08:18:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tq6R9-0001Kt-JH
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Mar 2025 08:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q2EtckheadEwVLf0vgHE6aRopaIapuvftmpZRvSSd6E=; b=KP9AOFucRXoWZgos8IhfYhPnt1
 WAJepJI08AVxyIA7h4pjE8kzWiHmbiPYDrdKmiUGu7CflYc/K5Mdukq2QqVrNzuqIDKDQ6zgkiEw8
 ySMMsVyKl65z3/z+X8EdeldMH/KCLu7p1nx2BEG2hNCPD2ZvRnUEme8TsHpR6lD2wSUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q2EtckheadEwVLf0vgHE6aRopaIapuvftmpZRvSSd6E=; b=l
 N5XLEWMVPZ2ijqY8v8/Vpohf4twnPbeMrqqtsnZzFGwtzWdzy1S+1vGf8P42q9Da4NhtJm7bMnuV8
 a0TPyeD421XPEzXH8i5wqlSDH68vt+MAXIitNS2Jt4ypuoo6nsaLJ05p9rDOj1ldJE/iaqYOgxddu
 iRaORzcJBqynyT4c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tq6R2-0005wh-J9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Mar 2025 08:18:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6185C5C010D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  6 Mar 2025 08:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC685C4CEE0;
 Thu,  6 Mar 2025 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741249102;
 bh=RWP4wpZ3zNZLUM147XjXn5XnwdN3KEQbeXE8EZAKops=;
 h=From:To:Cc:Subject:Date:From;
 b=ZjBC3PsrECQaYu2hurjO31ZdC5Txicqu8AlfPeIytdzmAl9ORsxLUzwuwZMDma/fN
 fWgKcrqMzfXOJwe5q9rxQJ9ppEHyuVAez6CmhCe6FhKi+apJzckE88rx1/q4HqVj+4
 BPMB7FZL8I6iIAaoA22khI95RZ+sN1jiGsAq+2tZk21kcZdJRHhk4c630moatZhDq4
 eiOUgSFwcOh9ON+GlBA1LzobnfttFonoUpZDAFcpJBioMSv1Idr31TKmDLy9iXq1ko
 MlNS3LfKZY0IpuGS01UVv9b1JeNdEp1GSbFpIox8YN1rzv45pFKEMxe36JODqDxnmJ
 F5jxxj/eaZCPA==
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Date: Thu,  6 Mar 2025 16:18:06 +0800
Message-ID: <20250306081809.2397527-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
MIME-Version: 1.0
X-Headers-End: 1tq6R2-0005wh-J9
Subject: [f2fs-dev] [PATCH 1/4] common/config: remove redundant export of
 F2FS_IO_PROG
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS_IO_PROG was been exported twice, remove the redudant one.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/config b/common/config
index 2afbda14..8d3047a5 100644
--- a/common/config
+++ b/common/config
@@ -191,7 +191,6 @@ export XFS_COPY_PROG="$(type -P xfs_copy)"
 export FSTRIM_PROG="$(type -P fstrim)"
 export DUMPE2FS_PROG="$(type -P dumpe2fs)"
 export RESIZE2FS_PROG="$(type -P resize2fs)"
-export F2FS_IO_PROG="$(type -P f2fs_io)"
 export FIO_PROG="$(type -P fio)"
 export FILEFRAG_PROG="$(type -P filefrag)"
 export E4DEFRAG_PROG="$(type -P e4defrag)"
-- 
2.48.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
