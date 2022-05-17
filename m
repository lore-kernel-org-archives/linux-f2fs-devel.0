Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E834CC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 May 2022 03:37:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nqo1l-0006jO-TU; Tue, 17 May 2022 03:37:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nqo1k-0006jE-G9
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 May 2022 03:37:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mOldMgM88EJABI6CJuT40qasUrdJzla8HlTdsANag1g=; b=JNR1+hOKxcKfepZyuCpy1O3+aF
 kxrC7aKUcLhkhd4gUCKiYouVMIyhdSoYsovJzrxuCZNLP6wS55TxUtQNx6W6EW6yQ0SY13PzuhRnb
 7sKd+3P8BrIliaMvo97o/KRfj1c7r+UUIQnmHPtqxcSw+SRIvYn2pfyq/F9pN33bI9wQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mOldMgM88EJABI6CJuT40qasUrdJzla8HlTdsANag1g=; b=b
 5TL12k6y4CVPwEelh4k/kVll8VTb29eY9SNzUpiCNyIRpFYMKcW9fLPY9vErP2QTGvov665wm6UxZ
 PhrWkE1gt4gMJoITZRad049Tfc1EnNkWKjEVcVcYMDTs4YtrDMF2Wr4RMaXynmjqxaslWMsED60fs
 IE8PRYxoVdix231M=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nqo1f-0005Nh-6q
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 May 2022 03:37:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CB5CC614AD;
 Tue, 17 May 2022 03:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B6CC385B8;
 Tue, 17 May 2022 03:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652758649;
 bh=isWA7aLKx1dRpSJoWvz9DhEYkVr5Q60QsXwO9Q/jGhM=;
 h=From:To:Cc:Subject:Date:From;
 b=V78V9rnoN5nzFCHqK1RTxSX8hlyxcPv3GqZMMY0OuyTVq7hyMyizIsdYegR/duGMo
 Bm5RFnJ+H8kOLMuiFJ6wPOSJrAb0KwgZXki1N4QL3HSIyAyh4fR5n3XuNd5uDKNC+3
 JV7JNffFcrH0hEHccTWRNCR8ACMTdp4KvXLhOhHDpEpgyMPdNJrAoUahqgNm70h/kc
 ODyDp6jGNzBF3MEWjryW/Hlc2mwwMXcRKLw1lhUP+oURDQaK0/r19qFJea8jekLwf0
 rQeWQXHGPpX1L9fdmmg64JiIRiIqSFqQ2QUFWUo0HIJZsIODH8gc1qpMpd0q+HpjBk
 3aSXPLclokfWg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 17 May 2022 11:37:23 +0800
Message-Id: <20220517033723.3565469-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1nqo1f-0005Nh-6q
Subject: [f2fs-dev] [PATCH] f2fs: fix fallocate to use file_modified to
 update permissions consistently
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch tries to fix permission consistency issue as all other
mainline filesystems.

Since the initial introduction of (posix) fallocate back at the turn of
the century, it has been possible to use this syscall to change the
user-visible contents of files.  This can happen by extending the file
size during a preallocation, or through any of the newer modes (punch,
zero, collapse, insert range).  Because the call can be used to change
file contents, we should treat it like we do any other modification to a
file -- update the mtime, and drop set[ug]id privileges/capabilities.

The VFS function file_modified() does all this for us if pass it a
locked inode, so let's make fallocate drop permissions correctly.

Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 73ba1c6dceaa..f23a7cdee657 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1783,6 +1783,10 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
+	ret = file_modified(file);
+	if (ret)
+		goto out;
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
