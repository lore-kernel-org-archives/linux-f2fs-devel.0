Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F99F30271
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Mar 2026 17:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yj+uaMSKZjDz2YKcNYijMkXFMRRg448xxKTAHUUgG58=; b=UKu4H9NBEhFuuO+FITxa9q+hC1
	B/FzNqu/lWsLZw6pXbRwupJx9SeTRW1lgpn9fvmMzQ3SZytT2dSGHw0WrI3CJm6U4VO+CGl2pym/q
	UXzYTxIs4I4K/iCER1RjbzUb35we+7u++LygQu0tiM8yV/tvyMJkT5xFdenzH02S1PkI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w1pJt-0007wj-Lb;
	Sun, 15 Mar 2026 17:32:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w1pJs-0007wb-Am
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Mar 2026 17:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCkkzh0Rx/GMDQpub8GieWuNOlJBpCrYvVC2ZrQ9AKE=; b=Twy5e4g7u8KGhR0+s533s4qLiX
 dfnjgZNcwfb68uZ8zqfuBf2w5uRDnDxsiZskWF6Hlpd/QXsOn3BVpJxpVvpmynTuLrnjaknfTIN7h
 k/EhwN00QE0DboBRUlzvaZ18MfvXryyj76LE9EaQlJeTKEDIxAy3Gk7qJbeEmRWZ92C0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZCkkzh0Rx/GMDQpub8GieWuNOlJBpCrYvVC2ZrQ9AKE=; b=V+Z+oovN2qcOgLv15Q4ACDTfJo
 y/dxgeys1ZjnD+ybimTZT6xtaZncmKwbscccW0UpGQxFHNzpd0vzvIUBum624wumwltXZ5lB8bP9s
 vqkKhkaKN+kddLHh5+3kGbgMQB4X/TgX67G5unM4n8BKmMVztQKELaCewJYTZe4bAG8U=;
Received: from smtp153-168.sina.com.cn ([61.135.153.168])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w1pJr-0005Yn-Hn for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Mar 2026 17:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773595923; bh=ZCkkzh0Rx/GMDQpub8GieWuNOlJBpCrYvVC2ZrQ9AKE=;
 h=From:Subject:Date:Message-ID;
 b=oA/uGIYxfkPVr3azLy2xSU0WqdL8vXucbnGMEk17E8yap9Z1Yb2rjwHySszPfpn8g
 W5W5Nnv25k/MGg4wjuKP3B6hDf7HglbiRF8gGh0tKlpWChyasnCzE48GaqU8/uMHsE
 jbjIYCkDVInTsUZ102kpb6fLG0T7tt0PwOL4owCU=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.33) with ESMTP
 id 69B6ECF90000240D; Sun, 16 Mar 2026 01:31:51 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 1328166685349
X-SMAIL-UIID: 17A8791E9D614FDDBFBD00ECBA366060-20260316-013151-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 16 Mar 2026 01:31:19 +0800
Message-ID: <20260315173118.4048271-4-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315173118.4048271-2-monty_pavel@sina.com>
References: <20260315173118.4048271-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1w1pJr-0005Yn-Hn
Subject: [f2fs-dev] [PATCH 2/3] f2fs: fix fsck inconsistency caused by FGGC
 of node block
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

During FGGC node block migration, fsck may incorrectly treat the
migrated node block as fsync-written data.

The reproduction scenario:
root@vm:/mnt/f2fs# seq 1 2048 | xargs -n 1 ./test_sync // write inline inode and sync
root@vm:/mnt/f2fs# rm -f 1
root@vm:/mnt/f2fs# sync
root@vm:/mnt/f2fs# f2fs_io gc_range // move data block in sync mode and not write CP
  SPO, "fsck --dry-run" find inode has already checkpointed but still
  with DENT_BIT_SHIFT set

The root cause is that GC does not clear the dentry mark and fsync mark
during node block migration, leading fsck to misinterpret them as
user-issued fsync writes.

In BGGC mode, node block migration is handled by f2fs_sync_node_pages(),
which guarantees the dentry and fsync marks are cleared before writing.
This patch ensures the same mark clearing behavior for FGGC mode node
block migration.

Fixes: da011cc0da8c ("f2fs: move node pages only in victim section during GC")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/f2fs/node.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index bd0039d16568..3bcf34534736 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1871,6 +1871,8 @@ int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
 		goto out;
 	}
 
+	set_fsync_mark(node_folio, 0);
+	set_dentry_mark(node_folio, 0);
 	if (!__write_node_folio(node_folio, false, NULL,
 				&wbc, false, FS_GC_NODE_IO, NULL))
 		err = -EAGAIN;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
