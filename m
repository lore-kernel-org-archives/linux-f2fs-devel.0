Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B656F3026E
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 15 Mar 2026 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shve0q8sGtu/UizRRpyWQOXHugEoDHZ7WZLaPtNdJfY=; b=AGhxGi5+PCA9ehFmwBo3eJRse4
	Cx1Z4+u+BH+WRe8H9XX5mYRJwV+57hE46Fm4jb0CMg5Gk4hM2VHuy9z53ASx7lMDs5a/zgCSZyLVJ
	g2xI6PBj5JZZktznCS1xl4/G9ziHDPQnfOyQS+/SYHARs9/DfYpczKyRDuGfBQfZf8Rw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w1q0J-0001Hb-J3;
	Sun, 15 Mar 2026 18:15:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w1q0H-0001HF-Mr
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Mar 2026 18:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rytJHxLWQ5Jsk9Pg6AAmxXYAgr8Gnd0hS6JaN96DprQ=; b=aewJ8RA6inpV93kAfdo9Wzn0pQ
 SpbRXZ5rxRiA8szBP6kSBfJeDFVaS1FSjyrsfRVpc2xviDsYosSXOABZOteiQsds6J3O/gAf887d1
 I99hIgjU6NvU7o1Ebf8sLPuPr1YnauBeodslZgryjrhuQ9tqBaX/oGdtm00UKfMNa/CY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rytJHxLWQ5Jsk9Pg6AAmxXYAgr8Gnd0hS6JaN96DprQ=; b=K0B5I3fZ81SD1hkPiQnyGeolN0
 DRcySs84766Kftyzrm0ILvX69k0Mb0qNjdD5XS4LXbsw9CJ3Pwydbwj+s3/XmRU5Mpm3OMasA1Xqj
 etJ+w+YZdTXlQPt7gNlAgPQix7ldfIB0b7iSqi+JGB1A4sP9iCF9530vPQzGfgiAXDSM=;
Received: from mail3-166.sinamail.sina.com.cn ([202.108.3.166])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w1q0H-0007Mw-E4 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 15 Mar 2026 18:15:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773598553; bh=rytJHxLWQ5Jsk9Pg6AAmxXYAgr8Gnd0hS6JaN96DprQ=;
 h=From:Subject:Date:Message-ID;
 b=BNYBCeiJo0Qrjx2HB3Rly1BNhJc6IWHORh6h7cCi41Ar7p916MzLpJM9QwCABH8iI
 CE44307WTotTcB0kDFSQ6NWpva/3pgMtajrKLM/2HTgZIG9OCXT7BJ74qqIAnZ/6Xa
 WFKSaJCMhrBpDh+iERa3twjaiKIIEnqawkyWwQNA=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.31) with ESMTP
 id 69B6F74A00004EAB; Sun, 16 Mar 2026 02:15:40 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 8565756816249
X-SMAIL-UIID: 0B57940817CB4B4AA254E29C46F6867D-20260316-021540-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 16 Mar 2026 02:14:47 +0800
Message-ID: <20260315181321.4063984-4-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315181321.4063984-2-monty_pavel@sina.com>
References: <20260315181321.4063984-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.43.0
X-Headers-End: 1w1q0H-0007Mw-E4
Subject: [f2fs-dev] [PATCH v3 2/3] f2fs: fix fsck inconsistency caused by
 FGGC of node block
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
index 12b943eae4d9..fe97a54a25b7 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1871,6 +1871,8 @@ int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
 		goto out_folio;
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
