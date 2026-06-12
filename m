Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29CACD8CA8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S3cvwcs4FZ+E1XebWVr1FIRj5jid9qH9aIL8rjKR5ug=; b=FEMtJ71CvZ104YRF2FMYuZIu3y
	FfzxY66CFsgKK7LfGO7k76bXGjypAXSvRFyI4vPSiWw+V7lRU/Af8M+MBdO4+fpWToM6r9LbqocoQ
	nYpT1vBXOu6nVpaMJmguG8HIdEUD6vvf0WmTeAgL2Kn67gfms9Rax26monuWS3VfP/go=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXwsO-0007vf-UF;
	Fri, 12 Jun 2026 08:04:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wXwsF-0007uv-OP
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EzHzeW3zThDUo4c+pzNHy8BvVmPdEEDspTlL7QYuWNE=; b=P0A5EzbTtJZL4fc8lSNLTAbK+Z
 NnzeNRK2WhEEtRSEUGgawcFjPEtpBpO32xAtgs/1xzbbdh2d2cFpM1zkOnFyx4EWTxHW1qpWFEYNj
 WlWA6NZB+nXGQAOH+IABSQIWCZbSBUFBWVpLlFISFe4Cmgz92B/6J0FYelC7JxHtzFz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EzHzeW3zThDUo4c+pzNHy8BvVmPdEEDspTlL7QYuWNE=; b=N9LvUMOSAwrHLYdxI9xX3z8oJi
 rOSgeZMqP99Gv10JnaTMcEqeLzYW6lgXFpldU80aFcINjRQEUKRz0xG0bhyKdcskUiTDfpEPeHYGJ
 uiwNajl0YbSteA9AxCfsO2JdUWAInQjVC0ou5FDzbEBMfpmHyxbKafXCrf+uqpPLYjB0=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXwsE-0004J4-KW for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ez
 HzeW3zThDUo4c+pzNHy8BvVmPdEEDspTlL7QYuWNE=; b=hPhG5wKTU/2z0EQtn5
 eO/wo5BMnpnOvaiLkMMvgsqKg1JgnkHzL7XeW3bSb0ht+LfgMpPuWL3PRn3mVbUa
 9yRgC7qV9wyh4kcjQaEeM6s5W6qpTwYnTj0B2AdA4aay7oTpetzopNWtlg4em25p
 xHH+AdGe/1v3952TMsKniVJu4=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDX_ytWvStqyXqrBQ--.43664S10; 
 Fri, 12 Jun 2026 16:03:46 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 12 Jun 2026 16:03:33 +0800
Message-Id: <20260612080334.70657-9-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
References: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDX_ytWvStqyXqrBQ--.43664S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1xXrWrXr1UJFWxGr15urg_yoW8ZF15pF
 9xG34fKrWDWrWqgr1ktF1qvr1Fqa4xKFWUZaykAwn5ZF1DG34SgFW0ka15uF4UtrWrJrWI
 qF4jkry7Wr4rGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb739UUUUU=
X-Originating-IP: [223.104.43.40]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowLsvGorvWKtsQAA3z
X-Headers-End: 1wXwsE-0004J4-KW
Subject: [f2fs-dev] [RFC PATCH 8/9] f2fs: allow large folio support to
 writeable files
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe <zhaonanzhe@xiaomi.com>

Now we make all write path support large folios,
so we open permission to let writeable file set
large folio mapping.

Signed-off-by: Nanzhe <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/file.c  | 14 --------------
 fs/f2fs/inode.c |  6 ++----
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c1b3c9d1ab92..bf5497aad1a7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -87,17 +87,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	int err = 0;
 	vm_fault_t ret;
 
-	/*
-	 * We only support large folio on the read case.
-	 * Don't make any dirty pages.
-	 */
-	if (unlikely(IS_IMMUTABLE(inode)) ||
-	    mapping_large_folio_support(inode->i_mapping)) {
-		f2fs_err(sbi, "Not expected: immutable: %d large_folio: %d",
-				IS_IMMUTABLE(inode),
-				mapping_large_folio_support(inode->i_mapping));
-		return VM_FAULT_SIGBUS;
-	}
 
 	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		err = -EIO;
@@ -650,9 +639,6 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	if (mapping_large_folio_support(inode->i_mapping) &&
-	    filp->f_mode & FMODE_WRITE)
-		return -EOPNOTSUPP;
 
 	err = fsverity_file_open(inode, filp);
 	if (err)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index e30f9a2c18b9..2f1ddcaaf5d3 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -581,10 +581,8 @@ static void f2fs_mapping_set_large_folio(struct inode *inode)
 		return;
 	if (f2fs_quota_file(sbi, inode->i_ino))
 		return;
-	if (IS_IMMUTABLE(inode) ||
-	    (f2fs_exist_written_data(sbi, inode->i_ino, LARGE_FOLIO_INO) &&
-	     !(inode->i_mode & S_IWUGO)))
-	    mapping_set_folio_min_order(inode->i_mapping, 0);
+
+	mapping_set_folio_min_order(inode->i_mapping, 0);
 }
 
 struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
