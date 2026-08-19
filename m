Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5653EC5DF85
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jz+KC2lVifHjFmI/KHwet6ueG2WCNO3g6Acbtw29aKQ=; b=cLve6ocPhRTnKKdAnqmunOPMmj
	LcK2rENxJONML6cCEaXvplrg9b9soPcidGDglC1QhHVsCHmyO+NXsbRKVlbT2gK55fAhslALMkerd
	S+wY5zwSzUOZZmmOiXCOtoaZ7U/ftM+BHjdiGZrWcFSusQwwClTz33qdADnrMus4Uz3M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwkgn-0002ha-Sm;
	Wed, 19 Aug 2026 18:06:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wwkgm-0002hT-T8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 18:06:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8GIX06LK7ExT+q3Aigt+SM74hjeyo4GTr/pSIL5HQvw=; b=Dz+wb4ab8koAF4A7CTpXzJfGvv
 YNt5z80y4NFRb72s5JTeDrNnATg3XAg2kyy1KYZVgf3trfQfuzEe4n8/NG3BQU2AJ3FhNn5EK0PyP
 ipQYHFqlMQ8714MIdQm2S2KtihoYMeT+PEW1UDQkxZki6mwxnWOEssmhWMoYFyp1MDg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8GIX06LK7ExT+q3Aigt+SM74hjeyo4GTr/pSIL5HQvw=; b=B
 pVivYNPCqL75Q0HhYDYFYLj8MJn8xgyZElA7t0cYl1PXgJS9FrQ7xM5kploMJQbxGcXf2G3uEDL+0
 L86OuJX7I689zu1wvl4JW9iE5npG0rAkRF40y9jIu0P4VlVUSorOjgZI0fRnWZX3Trw94vy/d/wum
 pkuEdw5pa3iCKPlI=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwkgm-0001sE-Tq for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 18:06:58 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1185383a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787162812; x=1787767612; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8GIX06LK7ExT+q3Aigt+SM74hjeyo4GTr/pSIL5HQvw=;
 b=RTNQ7WHoDIQg8mO0Qxw5kqFqvslvc50UAMimejwXvDwUsNoibmM83k0jM7IE6u6UaQ
 oQA/fe3V+Ar9hCS8I8BXUWGFwGhIqAR1RfeP6lJFtjPz9vblPC7D00exbpIjR0/rsVvA
 mZUeMMiHE3u27WyPQPYAPZKzj7HhLv1gjfc8yFvcJG8sLcPuyqXunJzVU5BHdTaBzgmD
 wr5seAx20/VdYrUmzWIGPzQWXk7N6FN8uv+kbDe2OG0Tld1r3yce/Feeh3MXnzPZDDzx
 5on5T1nmBbg93hVD73XDXvH4/RdaBhoIHqucIsezkFOG9XanK7S4x12+UuhcmeExhAzy
 4GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787162812; x=1787767612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8GIX06LK7ExT+q3Aigt+SM74hjeyo4GTr/pSIL5HQvw=;
 b=SYQxMfxVm9og8cHLTK5PrNOU3eoFPsAqTlxrcXvaeJwc+HrxZRtrvwQ34ZLJ31PeCF
 F/Guk9YwiAbeeyeaDuIC/tiiT95Yp7A73B42MOIpCgsI/jf3AUZt6cv83ocWFT0/hbd4
 Q2BuC2dXpeh659LlTcF6+LA/KUlFOYHSMc6cNtM3bF1nOboGCdlQiZ0JW+ziBx7JTVDO
 13tXkNrgccDVmoj+RYEltI7uwHj7IOiGObHOSIx2LSYoZDFQMdxbsnzLIfwBv9icWs96
 5zsjb9ziucHpkdRZjlaMl8zpPmLN1r1Lln54UYwaCDSiMZYpYfi7FS5Fc3ArzFFKsFPs
 4KMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RobViXMfeU2/ubXeRU44q55VgNsDTdqcwy47U7zX0j+A/Nq8JlnlvT7i6WDK0ntT4mUMgsyk5IrZIU/o18HqYVL@lists.sourceforge.net
X-Gm-Message-State: AFuF++k+0jPJRYtc0PLWSoDZr1jTgWb+JQr2Ptwm4Z7ZmSyyHh4mcEmG
 n6Nyp5jWr8ysY4Ze+OFOCUqzzdgr5W3HWA2la2RP2pke2mViN9oAHJl3dAmOWA==
X-Gm-Gg: AR+sD126dAr23Sdlq/H1BxGlNMj5XH0YM0772ht6kmQ1Etv612hLxwsFQnEZPTTY3N+
 Muh75p93uTgE42HiSDkzG98kiu0CtY3alRyZaLWqnDychoac1win7kDSkYro5LwQmZB7HCFe/QK
 o9cYoegRfg8rP3DeFQOOUwjVJiBnhRAMhqFk5jeoBmZkNioIVQuCSwYpjvD0Jy9mkvERl+MQk87
 PgCI1nUW4BKaiGbgE9uEAowc+pZ13UxZ6g26MNMX0iPfq8DT7EYJ2dpYFaFubMYU9H9ZkOlarjY
 0NNmCk++yAc8SMxtt2NvnoZSmbh4b6OW2AvTd6RK3q7PMvAeXARG91B21+t03TvMUEyiokzYoyP
 tYYhndkV9PSykiX04evp6diVJaFoUDBc+2ANsn8VGH3U6azFdPqxgWQeWm6RaQ0TdFqoL1C+gJF
 UsEvyqYJB1HilFPJ4jqjMMEFWpj7ffETAOauoHpU81TVJgr7QMQ9mC9/oDrY5xfjG8FehlE0CnD
 qvGiDWKCXENb1IC4NeHgigraMQp9adsgyYIz880GJVoRjw4t8ZsRwxR69y4v5MLmGpQNp0nnjfe
 dJiieBOP73zm3JjUw8CEKa8=
X-Received: by 2002:a17:90b:5105:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-39581070da4mr12594675a91.15.1787162811435; 
 Wed, 19 Aug 2026 11:06:51 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:f24b:89c3:b14:d945])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef7a0easm10426663eec.12.2026.08.19.11.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:06:50 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Wed, 19 Aug 2026 11:06:35 -0700
Message-ID: <20260819180635.1165300-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
MIME-Version: 1.0
X-Headers-End: 1wwkgm-0001sE-Tq
Subject: [f2fs-dev] [PATCH] f2fs: fix to migrate all curseg types during
 free_segment_range
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

In free_segment_range(), the curseg evacuation loop only iterates up to
NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.

Even though these in-memory curseg types are not saved in the on-disk
checkpoint header, they still occupy active physical segments at runtime.
If an active in-memory curseg happens to be allocated within the segment
range being truncated during filesystem shrink, failing to evacuate it
will cause subsequent writes to the curseg attempting out-of-bounds I/O
on the truncated storage range.

Fix this by expanding the curseg evacuation loop upper bound to
NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
out of the target range.

Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ffaa7ba76a1b..192b16ac02f8 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2222,7 +2222,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	mutex_unlock(&DIRTY_I(sbi)->seglist_lock);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;
-- 
2.55.0.691.gc56d675ccc-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
