Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B7C83F01
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 22:44:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZfXU-0002Kr-Pu;
	Fri, 25 Aug 2023 22:44:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3wS7pZAYKAPAVjgkWfYggYdW.Uge@flex--drosen.bounces.google.com>)
 id 1qZfXT-0002Kl-74 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 22:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BcNR9QJ6HdeHoDPjKmDv4X+fDGIBkuMGGFic4LhLUyk=; b=mf0MlAPNZ6TFwlXitJaYUmmxT0
 bV/YdfaWSH26YI0IDiG0YHhXKHj8dncVtGRlcSbzQtijOP4HLLb+kchq/+xGT1hPYydyHGGS5LKeB
 KZvgFfSFL24EU4omvV7H1ZTYOzzHk7CBUEHrdaajDKQ9AKXc2piINj4xlP3HiqlvmVXA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BcNR9QJ6HdeHoDPjKmDv4X+fDGIBkuMGGFic4LhLUyk=; b=AWdDiWddws++5pZS4EFzIZ2/5C
 UYPZyM4FVh1JQ7vnugjA3G/l7qyjsAiCy/mKq/4aa6UqAjNuc+UY2hwdNDh9tGX4ob2bi9CKgBID2
 Qz4dwUvqy6VlLSlJzl6OXPvuY23SmRZNa7mXyXh6Fz+nly4clh9JkJCm3D81to/XFovA=;
Received: from mail-yw1-f202.google.com ([209.85.128.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qZfXT-00FcAx-1c for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 22:44:23 +0000
Received: by mail-yw1-f202.google.com with SMTP id
 00721157ae682-58f9db8bc1dso21098027b3.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 25 Aug 2023 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693003457; x=1693608257;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BcNR9QJ6HdeHoDPjKmDv4X+fDGIBkuMGGFic4LhLUyk=;
 b=XVtLKkvta/lOqZRbqT/LmfssQwIladMaijZpNT43dpPCr9zI5kg8aynQuRdLmlyWwz
 wdoBOFXsdNnJtv4hnk8R+meIQ8Mh33V8i3Swx2rxzoOffH4wgBnx8k8I6ih2KNbtHfi3
 514PBtEZoWyakNwf6F1jLwyX+dP/Mjr1lr4vZ2vIOdQxg9RFhmdC6WoNlkmLaiHpl65c
 9q6Ldk8KdI8Z+e/bs1fpLfN4/aJYZG+XajrcofntM+S8BrJ5nP3fM36QGsuEexCBN9zv
 e/4RVkMGYz6/4WRb/WXCaho1JWO8Eshg3/8cN1nFsLGgsoW5AyErHvmGJapXJHrsZzzS
 eNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693003457; x=1693608257;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BcNR9QJ6HdeHoDPjKmDv4X+fDGIBkuMGGFic4LhLUyk=;
 b=Yr+DZfwb0+hPc2ahamEqqG8NMhbTmEJ6rzAXC/c8bhNoqdKGw3BTdRkg+BPRNgGHFr
 uUxPHKqNS50iPrq2OkZEOJDXPnFxvhOp+cbewx5Nq02/JftLGn0L9Ze2ANRXzVsfd8HP
 PqiAcjDgunGH93Gi6Tb8gjmwu+N1212UrmgdgDQoYBI4MGvMcZoeX4kV/++AF9aB8/JM
 JvlvBDsBuknWJPF0SXp0WoOKgJ0T7ulwrCQdtK4s50kNuA/5cIdaalF1GqjuijQNIguD
 YlVfOO7sQ5yr5mclq5Khtrmf+XJJ4Glnu+dA0jnKDVh27ak3RXh5tt573qhEl91tJnk0
 r8Kg==
X-Gm-Message-State: AOJu0YwD2+JpbVU1YETtsg55yu6WcoIGga4cpsu3a1lXy88iO2aUZV/F
 lOjcAKwpfhFoITvu0XGMYg0NavKEMs0FlSltko7Hh+WWmqb76RAzr5gwop+VKads41SJIIv+Xxp
 tMphjp8gL3+qqFVdJ7gLofPuNa+2o97x9/lkxMM0KIl6ntSREHROFc6g7hPM/WlB9msfxp7UGoJ
 xF41Obfx0=
X-Google-Smtp-Source: AGHT+IFEiaqFa5Nmp+CuSwe8DLHr4uTzPy5L1/96mNb532st4ab1NpOwY1B2EaiJXxriUAYgcd8Vi8FnBe8=
X-Received: from drosen.mtv.corp.google.com
 ([2620:15c:211:201:ad1d:adc4:c021:b463])
 (user=drosen job=sendgmr) by 2002:a25:a2cc:0:b0:d13:856b:c10a with SMTP id
 c12-20020a25a2cc000000b00d13856bc10amr524189ybn.3.1693003457380; Fri, 25 Aug
 2023 15:44:17 -0700 (PDT)
Date: Fri, 25 Aug 2023 15:43:57 -0700
In-Reply-To: <20230825224400.2206278-1-drosen@google.com>
Mime-Version: 1.0
References: <20230825224400.2206278-1-drosen@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230825224400.2206278-5-drosen@google.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1qZfXT-00FcAx-1c
Subject: [f2fs-dev] [PATCH v2 4/7] f2fs-tools: Refactor SIT/NAT block structs
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
 Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This converts f2fs_nat_block and f2fs_sit_block to be variable length
arrays. This does not change the way they are accessed, but removes a
misleading statment that these sizes are fixed, as opposed to deriving
from F2FS_BLKSIZE

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/f2fs_fs.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 13a1c14..b2d479f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1119,11 +1119,9 @@ struct f2fs_nat_entry {
 static_assert(sizeof(struct f2fs_nat_entry) == 9, "");
 
 struct f2fs_nat_block {
-	struct f2fs_nat_entry entries[NAT_ENTRY_PER_BLOCK];
+	struct f2fs_nat_entry entries[0]; /* NAT_ENTRY_PER_BLOCK */
 };
 
-static_assert(sizeof(struct f2fs_nat_block) == F2FS_BLKSIZE - (F2FS_BLKSIZE % 9), "");
-
 /*
  * For SIT entries
  *
@@ -1169,12 +1167,14 @@ struct f2fs_sit_entry {
 
 static_assert(sizeof(struct f2fs_sit_entry) == 74, "");
 
+/*
+ * On disk layout is:
+ * struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+ */
 struct f2fs_sit_block {
-	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+	struct f2fs_sit_entry entries[0];
 };
 
-static_assert(sizeof(struct f2fs_sit_block) == F2FS_BLKSIZE - (F2FS_BLKSIZE % 74), "");
-
 /*
  * For segment summary
  *
@@ -1995,6 +1995,14 @@ static inline void check_block_struct_sizes(void)
 
 	/* Check Indirect Block Size */
 	assert(NIDS_PER_BLOCK * sizeof(__le32) + sizeof(struct node_footer) == F2FS_BLKSIZE);
+
+	/* Check NAT Block Size */
+	assert((NAT_ENTRY_PER_BLOCK + 1) * sizeof(struct f2fs_nat_entry) > F2FS_BLKSIZE);
+	assert(NAT_ENTRY_PER_BLOCK * sizeof(struct f2fs_nat_entry) <= F2FS_BLKSIZE);
+
+	/* Check SIT Block Size */
+	assert((SIT_ENTRY_PER_BLOCK + 1) * sizeof(struct f2fs_nat_entry) > F2FS_BLKSIZE);
+	assert(SIT_ENTRY_PER_BLOCK * sizeof(struct f2fs_sit_entry) <= F2FS_BLKSIZE);
 }
 
 #endif	/*__F2FS_FS_H */
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
