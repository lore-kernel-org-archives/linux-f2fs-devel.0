Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CBFC79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0phdYZ3b0soWmf2Q1TmkocVI5AFlDhmP9/Wh1REMIl4=; b=EINNVJHAmRUolgjt0E7sp75AG0
	JIamZxnkpaBYfmS1jeuaop77UYxSpFtTCCx2ys61MtTZxYkvrBFnKbyyeBxaVxFyhZVNfl5M4bqZD
	j3w1nJ2bM0oOYh4CDwJAgUy08yoBQwvSUN7JIh+ubbvV5XACdZTt5dO2AwD75e/YUfCs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3mwS-0001Fn-0i;
	Tue, 08 Sep 2026 03:56:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x3mwQ-0001Ff-CW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wHuXN+TozonanTrHY2nOVJpLzPnOvGV5cbx8xr3LhCY=; b=glhd0df8Il+7s5n8ITYvQH3Ufc
 MktgB5pEUlyi1IBxITRNOYpEhIDCD9KUbAtS2AiLgjeKulZPRu8xz/EBD+umuj49exkOczGv3p1h2
 PCgQfgBEMsH6pbXPtCnBP8B/CV3yudXAdJzHx9fmoEVKuv33/2E6w8zSNWH6nlK10qPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wHuXN+TozonanTrHY2nOVJpLzPnOvGV5cbx8xr3LhCY=; b=dlSYu+Mssc+e0GWa7tnT9iUiIh
 MueXlnpNYPAOy91RW9CkAQCkMRT8XZAiH2T183zObBNuhnSDVaW3Ok37zASJc/K0eg9A2jTCXl7g0
 8ZlF1yoUSRDBZj/Crff5o01RShEtHIPXbsTTU5IKp4stBlqr1SWdJCuIaCH8w47Sj+CQ=;
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3mwN-0004BK-5m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:56:11 +0000
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2d71ae3455aso64966485ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 20:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788839765; x=1789444565; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wHuXN+TozonanTrHY2nOVJpLzPnOvGV5cbx8xr3LhCY=;
 b=KNa19u3hus99tkfYKmnbgaBkch2mlKB7x212Rz1VPMBLjTfhq5NMQZYCnkGP7cGRhx
 tsvcRNPa9sJOgB8XtuW9HBRvsfhJUM8EAiJP8YcxxvAUg7SeT+049nJFtooMJorawP5h
 N+4DFMv6m58u6B3eqjCRRrO0slM9jvp1/l0dAylmiWS1+p/prSsj7GL8c+TrXhxWjzFo
 1fpNGoEP6N/IJwDLsUm8V1q706FBekE8rXDthiqrucot+mDxyqqe4fjIhAITbofIMdhm
 dObATC7u5G2zw62meNGelWoDfKmSeohmajICcUEZ/3x1qF+WnHEg+hnewF8wu26Fs/DU
 k2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788839765; x=1789444565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wHuXN+TozonanTrHY2nOVJpLzPnOvGV5cbx8xr3LhCY=;
 b=NBu8pPjWCnn0LS3bzdjmWocEjDzA8FI8rP1pmf3WeToWIzIQjE3aRctVn/q0fA/7e+
 MzjnZPRH3YJVNs/mQFPN38ubED1ozCO/3OLNa806GOxGlGv0pKKx0rdW1iwDqnrmPuhC
 lUspe09XtGsdlN8RiYZhDw+AJvIrQn4BKc/4Sn9C/zkeI9e4EPR1tSmq1h4HL8VoFCNH
 xC0e1KWfeA5Z4WMzhVrWFnG7wyZQCoJGodCfRa+D+bwO68EsE77EUU/yg7L+XXDJfMZx
 OkJ4ez85+HP7VimiGTfAhCXdHq5wIAAujCeyZ07zH0B/v/29YK3XEEkG4SQS54KvM4q0
 XQ9g==
X-Gm-Message-State: AFuF++kIEKaYSeyA84WVckbKMlUGDwx6HpvnQjG0WJ5HJClhUx1sflCx
 i9s7iGLwkKxPjbdKiE3+ZEnT/Jf0AtoJ71tSnZ+156cfbCteQ+RhTXo9
X-Gm-Gg: AYBFou2zEEhadLfCoEkbDYKLiKg7sQQ0v9w4P/h7tojtYvP95UERAeNxWVa83/S7Kg9
 B5xmxStetIuJFh2Kk1JC8EMxomf4OXQ0dCp3q9Rtz10khh8YPHjJE6rehA381lrNhCdqqK9ZSoM
 DBHq5cbxyBzaIdn6r6u5yRoVYaQ0myJ/4MFOLLY5WFCT9Dk2Sef500PScyV4+6ghdg9ZIRm0qaS
 3WO0XkcSjRB0WjjhZVUecN32cY0jfDOrAdCcXGYK68vcPLQdSijEZljpCFUCzNPsSa4i+IwJ5wl
 Uzsdl2CT9coDCLViVYTiPmP9MqB3/NkUAbMk0yg2e/wG2JiU3oUXxgcRyW05xPhIwNl3GSmg2oI
 R6qFUZ7hvMQmpvLuGIl0XIuqXJQBmz9wT53XlqzBBL45bwHR7TxDtEzNQpufb/oVK5KqWDa7y1k
 4Jj0gIllbj5Dhxt59m5XXetiQJks3XX77cE1XmwPmOfbqBtFjUytK0Dw+gcfQ94kKhU8MbjhQAB
 WBoijutFMsADz06TnMtwhEP
X-Received: by 2002:a17:902:f70f:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2db1225b297mr394667095ad.0.1788839765501; 
 Mon, 07 Sep 2026 20:56:05 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db14aeaf74sm51899295ad.81.2026.09.07.20.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 20:56:05 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  8 Sep 2026 11:55:43 +0800
Message-ID: <1cd46ad6e0e566c283dd70be7864248f504b1997.1788795700.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <cover.1788795700.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x3mwN-0004BK-5m
Subject: [f2fs-dev] [PATCH v5 2/2] f2fs: enable buffered RWF_DONTCACHE
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz,
 syzbot+cid5582b8164122eda@syzkaller.appspotmail.com, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Pass FGP_DONTCACHE to f2fs_filemap_get_folio() for
IOCB_DONTCACHE writes and advertise FOP_DONTCACHE.

The address-space write_begin callback is also used by internal
callers that pass a NULL kiocb, including page_symlink(). Check iocb before
inspecting its flags.

Keep the F2FS-specific lookup because write_begin_get_folio() adds
FGP_STABLE, which can deadlock here.

Reported-by: syzbot+cid5582b8164122eda@syzkaller.appspotmail.com
Closes: https://ci.syzbot.org/series/cbb9ded8-1388-4a7b-bfa7-44082b04025b
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v4:

- handle internal write_begin callers that pass a NULL kiocb;
- add syzbot report attribution.

 fs/f2fs/data.c | 9 ++++++---
 fs/f2fs/file.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fc48a752fe9..c9b29882f07 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3883,11 +3883,15 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
+	fgf_t fgp_flags = FGP_LOCK | FGP_WRITE | FGP_CREAT;
 	pgoff_t index = pos >> PAGE_SHIFT;
 	bool need_balance = false;
 	block_t blkaddr = NULL_ADDR;
 	int err = 0;
 
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
 	trace_f2fs_write_begin(inode, pos, len);
 
 	if (!f2fs_is_checkpoint_ready(sbi)) {
@@ -3933,9 +3937,8 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	 * Do not use FGP_STABLE to avoid deadlock.
 	 * Will wait that below with our IO control.
 	 */
-	folio = f2fs_filemap_get_folio(mapping, index,
-				FGP_LOCK | FGP_WRITE | FGP_CREAT,
-				mapping_gfp_mask(mapping));
+	folio = f2fs_filemap_get_folio(mapping, index, fgp_flags,
+				       mapping_gfp_mask(mapping));
 	if (IS_ERR(folio)) {
 		err = PTR_ERR(folio);
 		goto fail;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c763fb972e8..92f916ca8b9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5920,6 +5920,6 @@ const struct file_operations f2fs_file_operations = {
 	.splice_read	= f2fs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fadvise	= f2fs_file_fadvise,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 	.setlease	= generic_setlease,
 };
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
