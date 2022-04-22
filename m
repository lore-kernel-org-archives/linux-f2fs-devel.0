Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B856C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 22 Apr 2022 01:57:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhiXm-0001qW-Ba; Fri, 22 Apr 2022 01:57:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nhiXJ-0001pv-1D
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 01:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VLO6n5Kyx5Jt1lDOIMAhd6sizYhI+Qn7Hd+uBN8pjgE=; b=YHUpKxfpFYItCSQGK7lWft+bko
 v/4zVcP3XcN/T11674Vgr4PRuKOzGuO2Er1ds5hH2hHz0qGxTxkc/xbJtN/JH9JCqOXDGB+jCWqwx
 B5sANrpYg/cv41WpEQjya8sRAXnMQpCdxjRxbM8fRNWmYrEY18KGwAZUYeQaresnd2Lo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VLO6n5Kyx5Jt1lDOIMAhd6sizYhI+Qn7Hd+uBN8pjgE=; b=C
 tIhuLyFOBpiVP0djEdvMqmrneFqiXmIJEPfdQV1cHyt0W4dUpLvXEvzhHJEZH0Jy4MosH6mbaTZ8q
 sVFaqz5Z6VgVb1rjdQyhuCZSKElQ/FQUG8oSJTNXw8Ijj7eX9a/N8RJbt3LtXA3hUCyk1MvZMKriw
 sEtYpZwMd5Byv4NQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nhiXE-0060dJ-Ox
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Apr 2022 01:56:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8700E61F52
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 22 Apr 2022 01:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F9EC385A5;
 Fri, 22 Apr 2022 01:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650592585;
 bh=CzcOPGlCV2xBPZx/jKlTI8M8Y1NunJ0Bj92iUue9INk=;
 h=From:To:Cc:Subject:Date:From;
 b=iiLN8BDg66zTXKmHVej8yVayRizhGuBO6B+N2pie/4oFdO7UER4X0grM5jKZfUd5X
 +l0pfAj72kDnySTte91S4LoxcsVEjE68ufCnw7zdwmBU5yMniRL/NKJEdiQAUPPLXZ
 k8sdEWmmwA00Jc9SQa/QIWcGgucBqOF5oDVB5KKU2nM1GS0nSvIw/vegRomfXUuHfy
 bqgaR4JGg1AavxejnRftYJp/6+mxq+KuomAQi1Az1kNY7WLhHn61GrJm3jApHLyvB8
 cvR4UtgHXunncIwzmHJdcnjh7xB8q+tXreEONhBmKJplF6tUtCHvWNEFKG9xD75BdB
 R42WeyOzze27A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 21 Apr 2022 18:56:24 -0700
Message-Id: <20220422015624.3521607-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
MIME-Version: 1.0
X-Headers-End: 1nhiXE-0060dJ-Ox
Subject: [f2fs-dev] [PATCH] f2fs: should not truncate blocks during
 roll-forward recovery
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If the file preallocated blocks and fsync'ed, we should not truncate them during
roll-forward recovery which will recover i_size correctly back.

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Cc: <stable@vger.kernel.org> # 5.17+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 71f232dcf3c2..83639238a1fe 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -550,7 +550,8 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode)) {
+	if (file_should_truncate(inode) &&
+			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
 		ret = f2fs_truncate(inode);
 		if (ret)
 			goto bad_inode;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
