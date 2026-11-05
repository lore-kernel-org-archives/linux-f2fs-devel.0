Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5260E606A32D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=POgky6+l;
	dkim=temperror header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FJiTN7hS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JATLdQm1;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2q6Sr6h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=WbYmzMrjdz8/h1hduenYuQlvlgePRFFYvYpM2M5FAmQ=; b=POgky6+lREQcWWCVKOpLCdw+Kx
	H/RndCf0fMqdJQZ69JBhSnRV0q5rBKC8sxVHGW2Fys4pTIjdVa6deaUYUILS6Ux6j/rJdt7TRe1+Z
	WufoGoJ9IUPrJZ9NyKRXPAFyCvF/dSmAqs9nrVGon8w+bdZnZVSQZgix9MwP5/bErktA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOoOu-000000003ez-0Zqq;
	Thu, 05 Nov 2026 03:44:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zhanxusheng1024@gmail.com>)
 id 1xOoOt-000000003es-03i8
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 03:44:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVB1DrB3lcAejFSUkzSavFgFkaENftsrN7fvqCjWIpI=; b=FJiTN7hSeUkfjKCPN4+Xq1tOCo
 pPYpASEyhCJFVWC+o+HlvTE3KZWhKpwln/r695D3k8CL/UUR6A+6/j+gmP7aTYVpE+OPo5NphsS61
 YMnKcE8PpoR9BZBMCRKs7qyQqjval+SDFmodztcVK5j/Ho18DL3JMTOeQiR6R5KNB9ac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PVB1DrB3lcAejFSUkzSavFgFkaENftsrN7fvqCjWIpI=; b=JATLdQm1HijmeZ6RnJwYVng7Yc
 erCbTocZqWLSxSQhdnSXzFQ/OFcv0vh5V8gW/lgZlbjk+iHHR1EgiWT2ikwlY7D3NnT44PLAyJpxt
 C7FhIqMQQz/eJsYX/SEJHbFB78YaXv4I+O1+gNNKtYrRIdYGgr4F046c0/ZFdxir0of0=;
Received: from mail-dy1-f179.google.com ([74.125.82.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOoOs-000000003Jx-1JKB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 03:44:30 +0000
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-36661f953e4so1980397eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 19:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793850265; x=1794455065; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PVB1DrB3lcAejFSUkzSavFgFkaENftsrN7fvqCjWIpI=;
 b=M2q6Sr6hdO7BmbCFS3jQQbrW7a0/H+eK2HY7A4fuJpCy7oj8+0DSWK3mYP6ZH0wYyB
 npVyyk2z6gWpoRxNh4Hnr5d29SPHpOHKNi8qkpLW/0lYpsJ4qgbvznrptO4oAljlfFZi
 QXH5XjroP56epCcYabgWMdAZIVoiy0c5loo9OnbBidiXkjS4YwXyTxPhzPMR8y2Mggcz
 IZIBVvOzjWLJWAU0NBrDbL7ctzYCEEfTXsVNH1hPK0uvIOF0Dg7LKVbnqn3zk/mW50ix
 7bXVp6av0vZyYSr6HI1GX3Z8+H3q+8wLP7hs/FG7YuO/kMutRBhY63US+Yx8gBI8N9Ch
 MNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793850265; x=1794455065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PVB1DrB3lcAejFSUkzSavFgFkaENftsrN7fvqCjWIpI=;
 b=Z6NzsLt/vbwRvJQoYN3pSZVCjyKdIseypU2n1GwTGC/bAOlYKf4m9YeDaM8pgAbp1d
 wdojIjUQA1DNf4eUP3uKXn5PAhH08iUrebEbuQCgaYeckBgZMY7ZrkW8L7Bhb1Qc7u/Y
 vaOgcIZRd1YuwQW0MWZpyHf8IDLREkFf+9/SCgbtZRKZZOk8idgUSlg6BxwGzMLzGrxk
 QhR51w+moHdiQPLuIClTSD96bgVVUbR0EY9uBl47i930xqsneRYi9wWw6GwwGu+CfTts
 4wwAOZ4AzRBiawbc6IUe/T24qrGsLy6kOqszHacp0LK67EsfXtAgMCgKYpS66PdWzgsy
 3QPw==
X-Gm-Message-State: APuU4Z8qRKV1l3GUuRBzAYIlPVnacYh17zOv+SaTmLr6bIgzcqUe4l+o
 0XTX6JvVCfRko8dtX72jk4vAOODb9pkHHtTPvaNLi/J7c8LyJsXbc8Mp
X-Gm-Gg: AYBFou3IGXpF0tFWgeiKgyZpkUonvfnGCuFOGkjwXYh1CdN6Td5Cc6pr9dbmQt3B94e
 413F3m9+iQENY8T3HnNT+MfbLqYcs2GgrInNfjnBwLlnokegl3YKiajZFUStbdBglmId7pDzSe+
 PkRUdZMTiLO7xJKDZ7xK5VwYldhaXJEYew0krlS/2ZWFM2H8k7/EYM28ZoO5W0J1MS83t0YReFB
 3lNFrF2Ds8oYvq0rlC/rZCCSC6JeUKy2jMvhtJaP9EKYHmRpbyaOn5M3BPAQyuA0+feHRuQ2Ey5
 ntsROHn3RU1d02udqh4JEQzBXRBnTV6gf72RjhTSiYiHksh8+s9Eq7qOSlBJyWaS5900H1J+EPC
 97yzPIx8z8EDrPHhCZ+L/NSloxuCTkSC76+Tmem+WFp15S3KaQ+Wm0/HyF49B2NIvQ/LlW3xxAZ
 9HxwTSQjiNaqTOPfN0WDgm01lxtu452KStPIuSY8jAg2IeWFkY6c3JmAQ0MKXC1SOdi47ho/gmk
 CDXjD20sm/Re43i+GgARJWV/qxliuowSYYxU5iOF2aTj1NFU+TxL2nZh71q2G2tU/R7CYU3WV2v
 edlN2grysiVzQRsK3Vm1xIR88RszWwPjpnrEpFl72x5mQ+0=
X-Received: by 2002:a05:693c:20c1:20b0:369:f70e:bd40 with SMTP id
 5a478bee46e88-36a4237cf7fmr26430282eec.16.1793850264521; 
 Wed, 04 Nov 2026 19:44:24 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39c5f0csm11370113eec.29.2026.11.04.19.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 19:44:24 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu,  5 Nov 2026 11:44:19 +0800
Message-ID: <20261105034419.2701443-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_B30A444DF94444D1A63A7D6F8E2039F1990A@qq.com>
References: <tencent_B30A444DF94444D1A63A7D6F8E2039F1990A@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xOoOs-000000003Jx-1JKB
Subject: [f2fs-dev] [PATCH] f2fs: don't BUG_ON a missing orphan inode at
 mount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Guikun Yang <yangguikun19@qq.com>, stable@kernel.org,
 zhanxusheng@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

recover_orphan_inode() treats -ENOENT from f2fs_iget() as a kernel
bug, but the ino comes from the on-disk orphan block. An image whose
orphan entry names an inode without a NAT entry hits the BUG_ON at
mount with CONFIG_F2FS_CHECK_FS, or a WARN and a failed mount
without it.

To reproduce, unlink a file while it is still open, sync, crash,
then change ino[0] in the checkpoint's orphan block to an unused
nid and mount:

  kernel BUG at fs/f2fs/checkpoint.c:967!
  RIP: 0010:f2fs_recover_orphan_inodes+0x6a3/0x9a0

Treat it as corruption, the same way the entry_count check does:
fail the mount with -EFSCORRUPTED and record
ERROR_INCONSISTENT_ORPHAN for fsck.

Fixes: 8c14bfadeac2 ("f2fs: handle error of f2fs_iget correctly")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/tencent_B30A444DF94444D1A63A7D6F8E2039F1990A@qq.com/
Cc: stable@kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested in QEMU on f2fs/dev with CONFIG_F2FS_CHECK_FS=y:

  orphan ino   before            after
  4 (real)     mounts            mounts
  1000         BUG at mount      -EFSCORRUPTED, s_errors bit set

 fs/f2fs/checkpoint.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 1ed38c668fc5..e57904a33ff8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -960,12 +960,13 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
 
 	inode = f2fs_iget_retry(sbi->sb, ino);
 	if (IS_ERR(inode)) {
-		/*
-		 * there should be a bug that we can't find the entry
-		 * to orphan inode.
-		 */
-		f2fs_bug_on(sbi, PTR_ERR(inode) == -ENOENT);
-		return PTR_ERR(inode);
+		if (PTR_ERR(inode) != -ENOENT)
+			return PTR_ERR(inode);
+		/* The orphan area lists an inode that does not exist. */
+		f2fs_err(sbi, "orphan inode %u does not exist", ino);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_ORPHAN);
+		return -EFSCORRUPTED;
 	}
 
 	err = f2fs_dquot_initialize(inode);

base-commit: 9b12299b437e0cc3ebf402e7b36a89cc69151238
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
