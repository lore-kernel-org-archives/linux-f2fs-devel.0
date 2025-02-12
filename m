Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0407C021A0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 01:55:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti1y1-0003q6-97;
	Wed, 12 Feb 2025 01:55:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ti1xy-0003py-Dc
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 01:55:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=995c5LESKrxAqGpUs+s8O+5YcT98e3tZWGvaeRjg4l8=; b=QrOFmIWFq8Fu8gfPyBOyzKj+PF
 pNu4M9R0HKqyY+75PSyHh8TQHfbiDi3LHsdftIRJ8lX9DL8IcfZK4/fssUlm9g1l08FdCvN0kUBCj
 wxJV7pe0t3KC08ChzNriH02JxHrfz5jWV69ZCsA2zxnnQ7UKG0gq7Yaq/ekwWYQDvfIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=995c5LESKrxAqGpUs+s8O+5YcT98e3tZWGvaeRjg4l8=; b=l
 Ycckz63K5XCUsUFAx6caQZsU0c65oWZH8BjGPzdFBxcAFVoYf7/5CQcmFmwLA10ZQtbwUFRii8gRd
 4LRm6kXd5GpXAzAOiglrD3K/QHEjg6prlFbKsilSC4HaCFxXbYOTPyi3I8tnSSoFhpr6J9JZ5NoYs
 eq1e2BU1VIngJ/bA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti1xx-0006nb-3S for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 01:55:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 25DD35C59C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Feb 2025 01:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6675CC4CEE4;
 Wed, 12 Feb 2025 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739325294;
 bh=k1i6OnM4vggKxSRbw8FWHtmyl30AxTlQ0Io8rRqVT3s=;
 h=From:To:Cc:Subject:Date:From;
 b=fzisAyF9kn2B5OPov1zXdhCd/Kiy6J9cWng1fouKc8AzXJMW7jidDhjDGO+K4A9ks
 gwCC0cITtqzWZ7PPsyGg7M34l/STKSbWNgfnTrRwVvdbphR9lYqbfNdmx9UyngTg2y
 ME9ymtOvmaERx4jwhkJB0NGDLl7SB2+RVygmZqxEKSvJ5c5/S9HNEMwzNfvy9HeXCE
 ncO+jhTjVoxDt+YPPk4x1AKjEq1SGjvCaeantoxtkkXLmwMi60sruFvmrKd6pBSycA
 vontoo041CE0xjMJFLf05MAUXlBkeVEzB+U9IM/4d+KAlDnerTiywOWTm80MkpofCU
 30P3oAjxR6XrA==
To: jaegeuk@kernel.org
Date: Wed, 12 Feb 2025 09:54:12 +0800
Message-ID: <20250212015413.666375-1-chao@kernel.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
MIME-Version: 1.0
X-Headers-End: 1ti1xx-0006nb-3S
Subject: [f2fs-dev] [PATCH 1/2] f2fs: don't retry IO for corrupted data
 scenario
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

F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]
F2FS-fs (dm-105): inconsistent node block, nid:430, node_footer[nid:2198964142,ino:598252782,ofs:118300154,cpver:5409237455940746069,blkaddr:2125070942]

If node block is loaded successfully, but its content is inconsistent, it
doesn't need to retry IO.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index cba2f6bacde4..d6ad7810df69 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -765,8 +765,12 @@ void f2fs_update_inode_page(struct inode *inode)
 		if (err == -ENOENT)
 			return;
 
+		if (err == -EFSCORRUPTED)
+			goto stop_checkpoint;
+
 		if (err == -ENOMEM || ++count <= DEFAULT_RETRY_IO_COUNT)
 			goto retry;
+stop_checkpoint:
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_UPDATE_INODE);
 		return;
 	}
-- 
2.48.1.502.g6dc24dfdaf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
