Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCE606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Oct 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GaCwzMzK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DTo8UlC7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FxDLzO0K;
	dkim=neutral header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=CgjBCxH1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=EwMPt6MKwM8ky3XmIAQB8Sz/12OAAw4vlFWXpu/sr5s=; b=GaCwzMzK7iZYvsEJa+qxMDnpKX
	w2h/Qsi2rqaSVCF5IrPv5W/RAKhJcaae5aztE3rMFVfs8xHF+WN5w/1/uq5je2b/olLGauB4jJxjT
	ut9zScJzzvVL8JmHtaA6WdCl34N3+X5L24nD8CZTx+2XrnFtjFU1PDJ+OX+rtBf8cJUU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xKxXs-000000004v6-03T9;
	Sun, 25 Oct 2026 12:41:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yaojiale02@163.com>) id 1xKxXp-000000004ux-2ypf
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 12:41:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUrqx1rvvs6o+dee+0TNtCMY/5xlNRoKRO5LvvKhg7Y=; b=DTo8UlC7x06SIs2kPDvPXYikwK
 TtX9U1Y7j6Y5jlRKoqOOoggpq8CEfnGJ7aeTwOewbAaub6fG0AGb5CtOcp1Lj3kY+A9Xmhe8Xkze7
 AodnRkvgCDt3PtslPLbW6uzKdLaPFy0f1Z2GDrKOf9JrqVUwUjZim25Jsr8oy1zIr1WM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZUrqx1rvvs6o+dee+0TNtCMY/5xlNRoKRO5LvvKhg7Y=; b=FxDLzO0Ko+cBZBfPt1hMFzWfGl
 ON+BGsRZfA1MUsbZTRxASq63J0JRmU0pkoJENxTjJXGJM36ze9qPoNfJiiMh9kdmNLs0yLIGCUues
 mX+bjBK/BU/DCBbWVXsu0tw0pEKfM9vFOE6LZsE6RfPYsACeuJZdPE97ZSgv0wdtEdEI=;
Received: from m16.mail.163.com ([117.135.210.2])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKxXn-000000003au-3RM5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 12:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZU
 rqx1rvvs6o+dee+0TNtCMY/5xlNRoKRO5LvvKhg7Y=; b=CgjBCxH1/Oc2JfWhDS
 OQiL4Vxzt2QEj/wPgkFG6ex2R86k2uIkiMSHUCroN3mB+1wYgE4ah2i1rBjQOzOm
 6+SezCV1pMmuInJE/CwGhkp/RAqFQqytW6Y8gOd96VvTzU+USTWFcxIafIybCW6L
 4MyFYZpDx6kxlWFJq9jdt2esQ=
Received: from pc.localdomain (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDnvTzs+N1qxJALCA--.54355S4;
 Sun, 25 Oct 2026 20:41:21 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Eric Biggers <ebiggers@google.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Date: Sun, 25 Oct 2026 20:41:11 +0800
Message-Id: <20261025124115.3178287-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025124115.3178287-1-yaojiale02@163.com>
References: <20261025124115.3178287-1-yaojiale02@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: PigvCgDnvTzs+N1qxJALCA--.54355S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWDGr4rXw1DZF13CF48JFb_yoW8CFykpF
 9xKa45ur97JrZrWrn7Ga1UZ34FgFykJrWfWryUX3WIvw1DGw4Yq3WIyF1a9F1rtFy7Jw42
 gan09FyDW3yjyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joUDJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BGMxmrd+PEPUwAA3J
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xKxXn-000000003au-3RM5
Subject: [f2fs-dev] [PATCH 2/5] f2fs: drain in-flight DIO before buffered
 writes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An asynchronous iomap direct write can remain in flight after the inode
lock is released. A buffered write can then dirty page cache before the
direct write completes its post-I/O invalidation, causing the
invalidation to fail and record -EIO in the mapping error sequence.

The pre-write checks can also zero post-EOF page cache while an earlier
direct write is still active.

Wait for in-flight DIO before post-EOF page-cache operations and before
buffered writes. Return -EAGAIN for a NOWAIT write that would need the
blocking post-EOF operation.

Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 fs/f2fs/file.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0c759cc99054..d3d0ebf2f6c3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5328,6 +5328,7 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
+	loff_t end_pos;
 	ssize_t count;
 	int err;
 
@@ -5345,8 +5346,14 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		return err;
 
-	err = f2fs_zero_post_eof_page(inode,
-		iocb->ki_pos + iov_iter_count(from), true, true);
+	end_pos = iocb->ki_pos + iov_iter_count(from);
+	if (end_pos > i_size_read(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_dio_wait(inode);
+	}
+
+	err = f2fs_zero_post_eof_page(inode, end_pos, true, true);
 	if (err)
 		return err;
 	return count;
@@ -5436,6 +5443,8 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		return -EOPNOTSUPP;
 
+	inode_dio_wait(inode);
+
 	ret = generic_perform_write(iocb, from);
 
 	if (ret > 0) {
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
