Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EA8CC6B34
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jxByfuCGfd/BC7viQqlnxSiGLMPDOhr1mkhK1UCkK3w=; b=CCkAv46CS7PYt+/sVfHV+1Zfvk
	uyRBv3lAGqi1KISEcZu01Wwk/n7gNb7LnMerQ1dxH+DRQEynWA0k2QV+DqrD9a7BidRjC25kbxBda
	Ser8wEbw4EktokvWSO6HP5/MhGrDBj76SVckPY8BJWZkO1MpY4ptv5hp6oue+YONCRL8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHGwP-0007hV-5W;
	Thu, 15 Oct 2026 08:35:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xHGwA-0007h2-UC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=; b=cZFs1BV0CBtJcEPe8orDXGizdX
 RWEpUPILtvGthzILz25WRvt3VQzAVwXeI50edVPGoC9W4Ac12sR34UKKp8wxr3ET84PhYlyn6zTF3
 hzOrAue7p/P6VvJX6N0wxHQ5eZJg8tpKhBOBrj4WiC/tSrMu/HI3Y/41o9gXk4ZPcDgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=; b=CQmAW/6Ng8YPyZfz24LQSB5yHh
 lfguLM3FZh7CNe4Gw8ImNNCf1PhBKy+RAJ6l/8eoCRANbBFkJcBE0L4V0MMvFKakFBvAGqrAG4Hn2
 tOWhH+kxr+FhCSOe1Ezl7yQZZDxJ7cm8PMf4Xpl1jUPQv93DIY1+Sk1+kYT7J6N7uG9I=;
Received: from mail-dy1-f175.google.com ([74.125.82.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHGw1-00005A-3L for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:35:34 +0000
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3535bf8b3e0so2840921eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 01:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792053327; x=1792658127; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=;
 b=ZfAeBDvQQnCREXmMqvTZYjL+mGWA82e//3BT5IhnjUG1wYjuAgJVzoZiVeR96qNR7c
 yoy61rHB07LSNRW7KJahViID3FCejDQlD7vwOzP5b6taI17flciQWGn2BaaiuLLCKmKU
 qjP1ipCKUXaeNE6KJsIgAVUZ9Q2F3a/IPN5frbnWeSZJwiP9wHAX9mg5JEoRnS7uViG5
 N9iTK1Il3QCVV732dcI1VrgNA0CAqh2XqgAPjtb/WFj/rvD64mePehCjF+Zr0z54ctEN
 pAOLp6CVpr4MEk8zQ6QYR8FMgKQs/LDaBGlGc2yKWTtu4/AAoksxtoJlvhQZgFsw1IuF
 oGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053327; x=1792658127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/HZc3zEH3FMgTce9H4OKnvH8oJPDGjZDpCmpbazH/g=;
 b=HT8zZpzX/ZVK02I4QyhRZFSoevuqfp6jWVf516CairfTL5aE1kVs5LnyadiwGyIcCA
 O3BgacO3Wsp4tl8i43ny92MH/CsmAzt7FhDxWIzFdgIhTGpuOlNgJR6sbKjOU/4o/4v2
 KQMbXn5GmL4oWvJ26IaEXU5ArZe4qoLMlxc0Ejhs3+7omrYVwMLoxoiciaD5l1ypxAmk
 A57XmB788SVZfzV9ClbY1ruDLP9miCRZ0OSOoorV6uaOcnCX35nVz+3rypzXNKbisfQJ
 t27CmYBQUNcdUSKSLL9gaqeX3LObWDVioBmbcAMCphXXtIA0QnaC+dOQN7sE6MGuX5BH
 dW+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVV2YuR6iQGFVbxZCLQdFbbuHrPSVlUbCGYTXP6zyBet4oCKdgKqIotPmaxATM7eqSZqqo9ZgoPFXBUIU+g9GK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLr6mcIu+ygRsuaELfGPksvXZ1Wxp0cgv8BQ3QWdYW/Cvyw3BzH
 /vFfZRmpdZ53/hAZVMikVailunbQGYtbe3cpFmt2GSqetbFrA4Peq/0s
X-Gm-Gg: AYBFou03hnGsZBouzpyDMvIViLMN5Lz8SVZHfmYtF5SS2ChWK8yllV/mGI4UItWon2R
 zP/iAeX0DohXVAAe9tWregNrxJVOdMkHfs70S6ItBCc/Dq+XHTB03SWstUv1w+SjsLGyx5OyiMe
 UE8y0IOxJjbUi8tsxH9vARiwMCn9L58DEmDVFEQ1piXDSpb9Suyl7qRlsaUN8zkoj2XAOPOHU8G
 QQ5FFfx90yi8BzPhY0NHKrdISvpkYeFy7gmgZqkT7fwUVU/0N2blp2veI54xp6hQsvd1xgEEmK4
 e8clYZI7b/xDsV1wBUaWe7AvMDxDGMtNdY27LK995e7UFUwTwYuNL5lAOXCZmK5F9DEm3wxKaE7
 Lp75Rxk2lKQIQn02aoykDaUh2MpXIM/0KBXfByvAonaT+x1LlH+E/epKKWwt1ctwovFTEwLwLVw
 RHDWKvYQ0zOWf7HjKzXdQtUnBKqzS22IkkcwnFUb6qWk0C9MR2nkQWoMtm18T+ZQwkbBc7xSyLD
 ZM/qv24eRz8dc4BqY53/ecNcbinrJJpApE=
X-Received: by 2002:a05:7301:797:b0:353:7e28:9c58 with SMTP id
 5a478bee46e88-3537e289d93mr23036589eec.41.1792053327341; 
 Thu, 15 Oct 2026 01:35:27 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca6d20dsm64539101eec.12.2026.10.15.01.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:35:26 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 16:35:09 +0800
Message-ID: <7884c62cae6e4b1ad516a9ac351c2604e57d5cc5.1792050467.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792050467.git.qiwenjie@xiaomi.com>
References: <cover.1792050467.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xHGw1-00005A-3L
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: flush SIT journal during filesystem
 resize
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
Cc: Daeho Jeong <daehojeong@google.com>, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, Qiuyang Sun <sunqiuyang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

During a filesystem resize, SBI_IS_RESIZEFS prevents new SIT entries
from being added to the journal and forces existing entries to the SIT
area. However, f2fs_flush_sit_entries() returns early when there are no
new dirty sentries, leaving existing journal entries behind.

After the main area shrinks, a later checkpoint can access a journal
entry whose segment number is outside the new geometry and trigger
f2fs_bug_on().

Only take the zero-dirty fast path when entries may be written back to
the journal. This lets resize drain existing entries through
remove_sits_in_journal() even when there are no new dirty sentries.

Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 25785b7626bb9..bf8d07fcce331 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4893,7 +4893,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	down_write(&sit_i->sentry_lock);
 
-	if (!sit_i->dirty_sentries)
+	if (!sit_i->dirty_sentries && to_journal)
 		goto out;
 
 	/*
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
