Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0203BC71133
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 14:06:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZXS7-0004AR-J6;
	Fri, 25 Aug 2023 14:06:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hao.xu@linux.dev>) id 1qZXS6-0004AE-6h
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 14:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o5eD4gq5Ypmv7xNjaJcQB3ZOSw79lNA3YgufxQ7kbUU=; b=UedNVGiGYIWkN4hjfXmv+Fjo54
 CfENgG/MNAzHh8s/B9cwl7+tV8oqiSf83JzJEXgf78j3wQ3RW7uCrxPNaIn38j4PBTI4MNR4nF2Ro
 Za5infCqajVRlMZ2v1s6ojdg7H2hE/XjuHKJN0GKkOTF3BFE1oLdOC9Bel+oiiWbULZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o5eD4gq5Ypmv7xNjaJcQB3ZOSw79lNA3YgufxQ7kbUU=; b=IpByl2jfb5vGs0N4155iCjK4RZ
 mm6VYwc+XOCoQU2G35lE/sCOUIUHXXHUAjGqEFRmIz3ZxeqdQAeU+pF4YfK6L8xOxawYgzAcp6+Gk
 dyvDdBXyQ0J9ivacweqyBrNZ2qpPARrmoxOlqzXIkCovW56p0gFllNeQ/G8vJa7D7c7w=;
Received: from out-244.mta1.migadu.com ([95.215.58.244])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qZXS4-00FIBE-FA for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 14:06:18 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1692972368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5eD4gq5Ypmv7xNjaJcQB3ZOSw79lNA3YgufxQ7kbUU=;
 b=IDkI/8FcKGXMrBLpAzKCujyKyUIvnRClPZG+PDDA+Kg6Ww/HgNrG0d8/UaYBPttRvdNV2G
 ImRsaH6EObyEWgQtf31bAS82oxf65cz7kpZXIj7D5nH1V4igKHLmt2T1OZkYhVy9UsI8OJ
 u9rq7LaZ7EE10dyazZwRdVBs5aqDaMI=
From: Hao Xu <hao.xu@linux.dev>
To: io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Date: Fri, 25 Aug 2023 21:54:30 +0800
Message-Id: <20230825135431.1317785-29-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1qZXS4-00FIBE-FA
Subject: [f2fs-dev] [PATCH 28/29] xfs: support nowait semantics for
 xc_ctx_lock in xlog_cil_commit()
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
Cc: Wanpeng Li <wanpengli@tencent.com>, "Darrick J . Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-cachefs@redhat.com,
 linux-ext4@vger.kernel.org, devel@lists.orangefs.org,
 linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-block@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 bpf@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Hao Xu <howeyxu@tencent.com>

Apply trylock logic for xc_ctx_lock in xlog_cil_commit() in nowait
case and error out -EAGAIN for xlog_cil_commit().

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_log_cil.c  | 12 ++++++++++--
 fs/xfs/xfs_log_priv.h |  2 +-
 fs/xfs/xfs_trans.c    |  4 +++-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index b31830ee36dd..6d054359bbb5 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -1613,7 +1613,7 @@ xlog_cil_process_intents(
  * background commit, returns without it held once background commits are
  * allowed again.
  */
-void
+int
 xlog_cil_commit(
 	struct xlog		*log,
 	struct xfs_trans	*tp,
@@ -1623,6 +1623,7 @@ xlog_cil_commit(
 	struct xfs_cil		*cil = log->l_cilp;
 	struct xfs_log_item	*lip, *next;
 	uint32_t		released_space = 0;
+	bool			nowait = tp->t_flags & XFS_TRANS_NOWAIT;
 
 	/*
 	 * Do all necessary memory allocation before we lock the CIL.
@@ -1632,7 +1633,12 @@ xlog_cil_commit(
 	xlog_cil_alloc_shadow_bufs(log, tp);
 
 	/* lock out background commit */
-	down_read(&cil->xc_ctx_lock);
+	if (nowait) {
+		if (!down_read_trylock(&cil->xc_ctx_lock))
+			return -EAGAIN;
+	} else {
+		down_read(&cil->xc_ctx_lock);
+	}
 
 	if (tp->t_flags & XFS_TRANS_HAS_INTENT_DONE)
 		released_space = xlog_cil_process_intents(cil, tp);
@@ -1668,6 +1674,8 @@ xlog_cil_commit(
 
 	/* xlog_cil_push_background() releases cil->xc_ctx_lock */
 	xlog_cil_push_background(log);
+
+	return 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index 41edaa0ae869..eb7a1241deab 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -580,7 +580,7 @@ int	xlog_cil_init(struct xlog *log);
 void	xlog_cil_init_post_recovery(struct xlog *log);
 void	xlog_cil_destroy(struct xlog *log);
 bool	xlog_cil_empty(struct xlog *log);
-void	xlog_cil_commit(struct xlog *log, struct xfs_trans *tp,
+int	xlog_cil_commit(struct xlog *log, struct xfs_trans *tp,
 			xfs_csn_t *commit_seq, bool regrant);
 void	xlog_cil_set_ctx_write_state(struct xfs_cil_ctx *ctx,
 			struct xlog_in_core *iclog);
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index f1f84a3dd456..e5beda636a37 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -1037,7 +1037,9 @@ __xfs_trans_commit(
 		xfs_trans_apply_sb_deltas(tp);
 	xfs_trans_apply_dquot_deltas(tp);
 
-	xlog_cil_commit(log, tp, &commit_seq, regrant);
+	error = xlog_cil_commit(log, tp, &commit_seq, regrant);
+	if (error)
+		goto out_unreserve;
 
 	xfs_trans_free(tp);
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
