Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A844C7EE29
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Jun 2023 10:26:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q51z8-0005g0-NO;
	Fri, 02 Jun 2023 10:26:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <korotkov.maxim.s@gmail.com>) id 1q51z7-0005fs-3J
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 10:26:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2mDyPrcLPpLQn9HuZOMdTp/PXzaxchIJm1mAyshNcIA=; b=URS//3b6bLbT4hJshxDmxD+tKS
 Hz6zyp3mT42OrE2rnnJlzpsnHET7Pjw2/czvlYvxkaHS029rM/UxcCK8M0fQVG9wL+HdmWAW53VvI
 vv9cDVINCrYcnmyYHtJw/W+pqjufFwsZiXK+RcEsrFCDeJeVVcsOlgGI/Pcc1hDdDBDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2mDyPrcLPpLQn9HuZOMdTp/PXzaxchIJm1mAyshNcIA=; b=P
 MvZr2FtAGalz4/lRAlH67GbwIQQFPi6cXHqTphUhd5T5bRtAXKDwIL8OdzvaydAIWLJsZx3wBwy76
 hESqYAsbxAqUGTfqTSbqofiZYS56ZpC9VTmeqyFAa6j2mI3ruEsRFAMSw+LgxvLdfDJtOs1AVkwYs
 Bn39MJLMJvrj4mKc=;
Received: from mail-lf1-f50.google.com ([209.85.167.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1q51z6-009B2G-2H for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Jun 2023 10:26:17 +0000
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-4f3a99b9177so2578404e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 02 Jun 2023 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685701569; x=1688293569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2mDyPrcLPpLQn9HuZOMdTp/PXzaxchIJm1mAyshNcIA=;
 b=FoOfbuZX7DRfLACejNEojOdEC3OFoyy2/GDzIHsNiCLMdhePu6S8E3IB+w7vzVYqZ0
 si6gdkCa0gca548RLOmcdv4eMvpyCSWhIIKWOTc3R1xeYPDwPuJOsC4P8Yh8vnXZeGwY
 7Jb94WnIPwaKafU5dq0jS7Q4mWGqstdiCNTsU2ulSS/9N4R/K6B/M4rw+BBlOBrKvRhm
 sIwiYdA6Rui89Hn7qUHDvILWajKthsTma0FftWPMspGl7PfZOOKWNWcJCBq9hWJBlFlx
 7cAB7RXtQrOKqtlq3WCYAtqwWymkkgWJ/HpNMxGVKxkHxRTrgPNCbFxzV9qk6dTYhWH3
 EMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685701569; x=1688293569;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mDyPrcLPpLQn9HuZOMdTp/PXzaxchIJm1mAyshNcIA=;
 b=EhIWnqJ+Dwz6r0dI0TL7+mpIIVAXrDb4EJ6i54B7O0Y61I3aZJwSxoHTmBSUlPGIti
 MnZc05LwaC1cBp2FMbyh4Koy//S/FSwHQWEtffj1iQ8lb6fEWrIBGR/BgQRHIayrQmWe
 gEWkK3JU/d+cfYX5KE7sFaDliat4pictHeDP9K7VGh6+oY2/ogx2Xx2kLayszuEnDxLC
 5qLkJqslCecvxBAI0SZ7iOlsVVmx61+5iGQJJjC2x+YgGjVbkV+QRxNDciSnaZzBKfOO
 GQrnjUQvAYKVaXRoP5EpF31NvRqutWdoDMjHdLt78s74Cgi/7lQwytW/YQYZpLss7Rwv
 ZuZw==
X-Gm-Message-State: AC+VfDxLh1Aaoz0yUb84ogVChv0KUQXEKLlCcHqrhaHXyZV+dtcvdzUQ
 tfUHSAe3erbwL4a3+13O6E0=
X-Google-Smtp-Source: ACHHUZ7iUCGVK8cO1kd7qfogzFFeMOfiIvWkQYXo1XyXSC2QnDdL7rE+Aj/hHHfCQrnFMYRlKAIWiA==
X-Received: by 2002:ac2:532d:0:b0:4ec:8524:65a4 with SMTP id
 f13-20020ac2532d000000b004ec852465a4mr1383503lfh.55.1685701569376; 
 Fri, 02 Jun 2023 03:26:09 -0700 (PDT)
Received: from mkorotkov.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 q11-20020ac246eb000000b004efe73ee01fsm114591lfo.306.2023.06.02.03.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 03:26:09 -0700 (PDT)
From: Maxim Korotkov <korotkov.maxim.s@gmail.com>
To: Chao Yu <chao@kernel.org>
Date: Fri,  2 Jun 2023 13:26:07 +0300
Message-Id: <20230602102607.602859-1-korotkov.maxim.s@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1q51z6-009B2G-2H
Subject: [f2fs-dev] [PATCH v2] fsck.f2fs: fix potential NULL dereference
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
Cc: Maxim Korotkov <maskorotkov@rasu.ru>,
 Maxim Korotkov <korotkov.maxim.s@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The input pointer "parent" was used unsafely
before checking against NULL

Found by RASU JSC with Svace static analyzer
Fixes: 603f8f9d3(sload.f2fs: support loading files into partition directly)
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Maxim Korotkov <maskorotkov@rasu.ru>
---
changelog: removed trailing indent
 fsck/dir.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fsck/dir.c b/fsck/dir.c
index 4a3eb6e..10d0310 100644
--- a/fsck/dir.c
+++ b/fsck/dir.c
@@ -225,19 +225,23 @@ int f2fs_add_link(struct f2fs_sb_info *sbi, struct f2fs_node *parent,
 	int level = 0, current_depth, bit_pos;
 	int nbucket, nblock, bidx, block;
 	int slots = GET_DENTRY_SLOTS(name_len);
-	f2fs_hash_t dentry_hash = f2fs_dentry_hash(get_encoding(sbi),
-						IS_CASEFOLDED(&parent->i),
-						name, name_len);
+	f2fs_hash_t dentry_hash;
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
 	struct dnode_of_data dn;
-	nid_t pino = le32_to_cpu(parent->footer.ino);
-	unsigned int dir_level = parent->i.i_dir_level;
+	nid_t pino;
+	unsigned int dir_level;
 	int ret;
 
 	if (parent == NULL)
 		return -EINVAL;
 
+	dentry_hash = f2fs_dentry_hash(get_encoding(sbi),
+						IS_CASEFOLDED(&parent->i),
+						name, name_len);
+	pino = le32_to_cpu(parent->footer.ino);
+	dir_level = parent->i.i_dir_level;
+
 	if (!pino) {
 		ERR_MSG("Wrong parent ino:%d \n", pino);
 		return -EINVAL;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
