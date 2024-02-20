Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8E0C54764
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Feb 2024 23:23:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcZS6-0000kv-TN;
	Tue, 20 Feb 2024 23:23:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rcZS5-0000ko-UA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 23:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qDyBaqIzeX83wC9UkXq7TkJ2CnOp3HTLCwXxLLTxCy0=; b=VV7kSXoTlthn908WQNc1tXkcNy
 gvkijYo4dJt8YLhnMkExV9OQ6OL4tI6MvJ7udLlOxVI+7hnz24zy2NXdU7a9Lqu9fstk3tduX0lh0
 Sw4at3GYmqCvIYlW/DHpoNjek30WcExlRwa598JvJ/mT61djt1isdlvVP8/cGJ7zkyIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qDyBaqIzeX83wC9UkXq7TkJ2CnOp3HTLCwXxLLTxCy0=; b=O
 aDV9TDZmEKp0ZXnqDtXyYAfY3suTs0aQmjks1ESPOOHUIn1iK4as1opS1ZMnQXefpo2WuGjWt8e4d
 zxkz+7olSHdflHZRhjdSP6OkrOZNHw1lQKlo2xkumeywb9UE9CgjKNQaOLm6i9zcVEwrx3lSn1viO
 Mub2EWGjmgKRJ2ks=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcZS0-0001OJ-Uf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 23:23:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5E393CE1A9D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 20 Feb 2024 23:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D29EC433C7;
 Tue, 20 Feb 2024 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708471369;
 bh=CBp5JjqsLlKrQ4BNGdzZd5rg9Xdr48xFXWUha9mjqMk=;
 h=From:To:Cc:Subject:Date:From;
 b=JCURf4g0DN9i5rfqoTbGnrdxhM3Icz9HiY+JaPFhD/Vy00aaUyiSlcDK+qhCKRHe4
 Ho23d5Tk0ARSTuOyIiXNl1w3y7WD7MxcbgvuUrvpLJGQ1LnK8nMWpX+g3GxQNyXSBL
 6lqJqOHjTWb0jWAnfk0Btwya+uHHAZpXGFNcVBKoX2w9ADVxVyLfvgBV7piMPa3vi2
 LlQFJ/qCULU8kupAvJvCWxJs3lSey6emyWkv8NnNU1Nq6lT4RRkxBsN8XwAcAER0+6
 oU8yqP8oNSNUb92exDuKtvR2ojnkhNf0eQmslQ8PHsD7TmRQla/mcX5711a0g49pIM
 BygBxghqVqC7A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 20 Feb 2024 15:22:45 -0800
Message-ID: <20240220232247.2856-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
X-Headers-End: 1rcZS0-0001OJ-Uf
Subject: [f2fs-dev] [PATCH 1/3] f2fs: check number of blocks in a current
 section
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In cfd66bb715fd ("f2fs: fix deadloop in foreground GC"), we needed to check
the number of blocks in a section instead of the segment.

Fixes: cfd66bb715fd ("f2fs: fix deadloop in foreground GC")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 63f278210654..9fe5ec619456 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -560,16 +560,16 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	/* check current node segment */
 	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
-		left_blocks = BLKS_PER_SEG(sbi) -
-				get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+		left_blocks = BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 		if (node_blocks > left_blocks)
 			return false;
 	}
 
 	/* check current data segment */
 	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
-	left_blocks = BLKS_PER_SEG(sbi) -
-			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+	left_blocks = BLKS_PER_SEC(sbi) -
+				get_ckpt_valid_blocks(sbi, segno, true);
 	if (dent_blocks > left_blocks)
 		return false;
 	return true;
-- 
2.44.0.rc0.258.g7320e95886-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
