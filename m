Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E25EC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HRDyrG4QVhwEpAuSkZZDGBEMGeU/Q6wTXN/VKJIjRzc=; b=PzjpNoRTnq1aSnrdZAvHVLcmHw
	MbDQN0c2tuQXE7sZYDa3St8NJ3anGXQoGFT0Yx6FQh1G6fdhIqaJuSH3RTtVPc9E59Kzoq6Dal67k
	Z96fIlH1kXohGsLKHb50iaYH/+qZKp519NQeH/2XhHVv3MmYpGIYWZKRUFM51cQoHIUg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyUYX-0007bd-Vh;
	Mon, 24 Aug 2026 13:17:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyUYW-0007bW-RU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iua+q5KymKXC2X2HgbKYzSUhq3fQTcywe3dvlXKgpmA=; b=Wt+6sqOepvcZ4YtqCpCRTAN3Gx
 sv7HmOgGuYjY9GQAK/5DEaIWk1koWOUUCjNcC2ZmVyn1+oCR9eQgH9JOZ3ViSVQRnYKqLtZtG9GcT
 7oy2NcV6lwcdkk11erB9qyLuN3MJgKual+2pnBHnNLsB4Kgf6je0He3j865N60wgmSy0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Iua+q5KymKXC2X2HgbKYzSUhq3fQTcywe3dvlXKgpmA=; b=X
 9DKEfJgLtbkYiqbset6a+BjbvNw3AWObDWuLZp5vuwjFsaxKeKYe8a0sQz6SU8k9fmhFSNMf3YBIc
 cfdRe/PI9nr2oZ0koXCo5M++yqWqeeAq3YneL0u+zrJ6eO0+MsncWaawjcKs0PWWCI9GZx6XjeUL6
 62nVtO+XWnjIVCUw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyUYV-0002c2-R4 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:17:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 765BF415D5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 13:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD91F000E9;
 Mon, 24 Aug 2026 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787577454;
 bh=Iua+q5KymKXC2X2HgbKYzSUhq3fQTcywe3dvlXKgpmA=;
 h=From:To:Cc:Subject:Date;
 b=Z/eKKKHINL0IvvisKFTF753/tJZAKNEl2zABtn+ckCUQXEMV/4mmUYHANGjz+3+2Y
 JG3uZV6tcbzXLTbQiZXg4FIm0iNJQSfuBcImC2lTCHbazgU2knxAY3gSaOT2UUm4S4
 qCOkknIwL7G38xtwQHNxUy7r6P0QtFUIbg/RYd1gd6MxvF5KlyR+KKiNOwmM60/Rjb
 G8jUvpV8kpanwm/a6SAvHbCwvzHV0ySuk+/vdsF32o12RFpzLYZAa6ow00rBeBXLuS
 DWT+fRc9eX8jWn93zZcsfWCZf6xknBQs5h13Xxkynf6fRjpB3smkzUXJ998tFg/kti
 Vfu/arNKc5+kg==
To: jaegeuk@kernel.org
Date: Mon, 24 Aug 2026 21:17:29 +0800
Message-ID: <20260824131729.3694378-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
MIME-Version: 1.0
X-Headers-End: 1wyUYV-0002c2-R4
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadloop in
 f2fs_fsync_node_pages()
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
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

There is potential deadloop in race condition:

Thread A				Thread B
- fsync
 - f2fs_do_sync_file
  - f2fs_fsync_node_pages
   - last_fsync_dnode
    - folio_get(last_folio)
					- f2fs_setattr
					 - f2fs_truncate
					  - f2fs_truncate_blocks
					   - f2fs_do_truncate_blocks
					    - f2fs_truncate_inode_blocks
					     - truncate_dnode
					      - truncate_node
					       - invalidate_mapping_pages
					        - folio->mapping = NULL
   - is_node_folio alwasy return false
   - atomic && !marked is always true,
     then goto retry

Cc: stable@kernel.org
Fixes: 608514deba38 ("f2fs: set fsync mark only for the last dnode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 968e5ed38816..86c2e67e43b6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2016,6 +2016,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_folio->index);
 		folio_lock(last_folio);
+		if (unlikely(!is_node_folio(last_folio))) {
+			f2fs_folio_put(last_folio, true);
+			ret = -EAGAIN;
+			goto out;
+		}
 		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
 		folio_mark_dirty(last_folio);
 		folio_unlock(last_folio);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
