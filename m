Return-Path: <SRS0=JHSz=OA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98FDC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 00:22:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CFFA60FC0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Sep 2021 00:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CFFA60FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mOUJe-0006wG-CG; Fri, 10 Sep 2021 00:22:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1mOUJc-0006w2-R3
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 00:22:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aiksBCubKJi/RHHY2Nh94ZbsWAmzZeoV8b2581cLT0Q=; b=QnHa/VxXubioPtJB9iCTJqr6yZ
 y8QtwIYajRiN8IWWDdOcxo+oMisIA5L9+d5n4MjdqDtkVomf5dgDEvbxZW0WMERpMGv5/KD4q2xKJ
 rAl7uxhjJJm8e8yRHjfyhwecQXWhQ3wlJRhZ61FNTlaYJu1jUOGUblgwZW7NvAo0vnag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aiksBCubKJi/RHHY2Nh94ZbsWAmzZeoV8b2581cLT0Q=; b=HFd5mbDkEBRKVW1TSF2k+0UzPS
 DbbN/m2uayDQY2bcpW53Wm18HzRildEbpoHAaNGXpQ6pQP0+Zz4yJmurb4JcAkta1bcm5fM5meVt8
 hvCvKxrvcuq+sKho/SaLMeIiHNp4s+YoQIs2QNCn5/GC1luZiEEYjgc27ZjExujxgmGU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mOUJc-005SCT-9P
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 10 Sep 2021 00:22:48 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CC460FC0;
 Fri, 10 Sep 2021 00:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631233362;
 bh=27KzxcIMQDz5sNuB8NXHcHd7FYuE/tmxcEtRirkwwAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RuhQEvjElKIrI6xG+OYMNHFZerIGSrpvGCvnYVO/KT5S3Pc0DmEjWv/n+T4xRqgII
 ruIYFhoJ1J/xZcO/3JQXskcY8lpnEY9arXbiQaq4myoKvRB8Xy5S0aYOPHN6cdJjzo
 5DsXTBq5HpqcQRpSJd+d/nE0grwvRypGBXSluxLM/b8EftBTE9UJI7l7cmLIhYP6B9
 TTB897U8YUHBIXcxjM4OV63//QuAYhV62lLaerUBQ+L8uyAWJO9dMD7i30MmzKATxX
 Odkg5aAWm1rvC+uU8Re+kn/z2JHTYFoSz1s7MAecjKI6ia8eRXe8b5S2JhTWTaSvRA
 tdGuAvhIQoEEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Thu,  9 Sep 2021 20:22:14 -0400
Message-Id: <20210910002234.176125-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910002234.176125-1-sashal@kernel.org>
References: <20210910002234.176125-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1mOUJc-005SCT-9P
Subject: [f2fs-dev] [PATCH AUTOSEL 4.19 06/25] f2fs: fix to force keeping
 write barrier for strict fsync mode
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 2787991516468bfafafb9bf2b45a848e6b202e7c ]

[1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html

As [1] reported, if lower device doesn't support write barrier, in below
case:

- write page #0; persist
- overwrite page #0
- fsync
 - write data page #0 OPU into device's cache
 - write inode page into device's cache
 - issue flush

If SPO is triggered during flush command, inode page can be persisted
before data page #0, so that after recovery, inode page can be recovered
with new physical block address of data page #0, however there may
contains dummy data in new physical block address.

Then what user will see is: after overwrite & fsync + SPO, old data in
file was corrupted, if any user do care about such case, we can suggest
user to use STRICT fsync mode, in this mode, we will force to use atomic
write sematics to keep write order in between data/node and last node,
so that it avoids potential data corruption during fsync().

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 95330dfdbb1a..3b36ee3d915b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -253,6 +253,18 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
 			goto flush_out;
 		goto out;
+	} else {
+		/*
+		 * for OPU case, during fsync(), node can be persisted before
+		 * data when lower device doesn't support write barrier, result
+		 * in data corruption after SPO.
+		 * So for strict fsync mode, force to use atomic write sematics
+		 * to keep write order in between data/node and last node to
+		 * avoid potential data corruption.
+		 */
+		if (F2FS_OPTION(sbi).fsync_mode ==
+				FSYNC_MODE_STRICT && !atomic)
+			atomic = true;
 	}
 go_write:
 	/*
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
