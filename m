Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B57CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 01:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HX1CFX5Q2KFwZhKGbqnh5R9kT0qs6pXoCMd2jt7gA50=; b=IH/WZr7PqiOstY4Y7oBjW0127u
	R9Aj5vyV85pNkzI+nmoOGJKzXByPk1suqPaatpwHCBQvWHjKw74xMG/aHgQzdpoLA+k+Y/mZjBa8W
	p8xHk+xITEeH+ra3oN03klx9cQLRyoua37NQVYmXjXNvkOJ8kCLIOvFZAxlkkznC1a10=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZIv5-0003VQ-3W;
	Tue, 16 Jun 2026 01:48:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wZIuv-0003VE-5O
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 01:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kg+t2f0uBlNFg5duAcjefLpMEBJKzXoZ3vbi19q9Wp4=; b=is4J11iM15LZiuqw3puNvm6MiO
 y1KiB9SJO59UhdkcLVEeQtzzp4iepel0M/F2fivmM4PT/AK+02N+EYYuhH2G8gK8y/HT3XcqLnouK
 08wyjQzaOVkoWDGani6WUvyXl+1964ZCUFngTkiDrtIqUD5Yk+/z07ZwBU4w9Jm3fyTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kg+t2f0uBlNFg5duAcjefLpMEBJKzXoZ3vbi19q9Wp4=; b=D
 ApxmvPJnPThpphrJueENAG2tpKBf1yJt7X6JVFM6PUSk7XP9hOLQpWSp+qh/0W7RRlyZyrSJDXTJx
 fyZik6kbok+lvCAHi/iB7CDuLdfg/lewO6JWTjntuZlc649oPyMPa8yGaz9BFx/m3MLdTgWsp3+h7
 1yOMV0KbD2P8pdbM=;
Received: from mail-dy1-f173.google.com ([74.125.82.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZIur-0000lM-Mm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 01:48:38 +0000
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-304d8362a58so2985526eec.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781574508; x=1782179308; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kg+t2f0uBlNFg5duAcjefLpMEBJKzXoZ3vbi19q9Wp4=;
 b=cNI3VqviMyroiRwzBnVu/68G/M5xlraMxVmxZcSYa+uGWMHoV1nz+ukwG9lRchbJid
 dZ7BxqxI32Zi7+MV/8Sv2omsvtZdAYX/n/Ik72GravaTsH+Mls2uVjysPZlo9oTqHXE9
 +l5wJwiCO/fzt2TBRowOWPgxIWY1uq7l+XyP83RuA43l1YGhh0+amsSBq04BcsCYk45G
 3JhTox1k+lYXo81l+YLOUYbpqCiwUf8+ALh/Bmyb45SVI2RjITTjQ0uOg9GwnGoZxVJl
 qEXJ001f6VuWx0niZMpCZdGxzptFxIewHbNk99Q4aonNznPcKIc6x8cdisNaGvGbj0YO
 9tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781574508; x=1782179308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg+t2f0uBlNFg5duAcjefLpMEBJKzXoZ3vbi19q9Wp4=;
 b=tZNmboD9D1V6X+/gBhD594yA6ZHn4rRaYRzbZs+Yo7Q5HJ73XpDl8qB6RgxuNP8T5G
 ThUk0gDuEL8McaBYHEKs4eb/YnMkPw3xjhWBKDkhSeqrkFWDHQUUxTaiLWfdl0qYAxhI
 uFfydA1fUEIVq1yITtwj9S5xxFYWfq0FK7ap/ptNg+K9HGZ/JjYXQYWKbKG4AchmhSqT
 UwGS8JKUsPCmIG/rCBq59/rFcbM1R8HnTKC8g58SnVfFj0XhwINNZTwGS4RkvfrqxKsz
 CZHUBY8+5aHyjdJUAWlyWt0FgKdGRDqZr81v+kBKtcaYWFAKzeHF0OIXhX2bYPSSlOOz
 xTIw==
X-Forwarded-Encrypted: i=1;
 AFNElJ916mvBmh5uaZUAnyIeb2iPci0eKvrUk/h6DJ8DiO0Y5+agwCxa2a54V3XQtFFZ7o8g+/bVi7Qwpb6uGoquGlaB@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyS9KUVvxghWQJxBsjEt2kIlmdynfEvoVXVbTjFpkvrgH+l4HSC
 AGDbCPsTYurhXGmbETmGGAipEpSpnRHtFQe/XtkzY5gWfvof/jD7qpFV
X-Gm-Gg: Acq92OG0XOd5AX3M5oJVzFrFTSbp2i31tDEakIwf5v9JoKZ6NuEBKoSOYnautvNm4HU
 l+RKk78ead8HEcZqgV5wHdoiEMS2rD9W9Hkk+tpLNxVzDUCKeyUDVwRtDyhaY8gpWM7AS/Ig1wY
 OaLvMUFjD5xWBg9pUCdLr8MoMkHidX/PqmTEGASD9HADi+CeePPHHFBg0y9E6FfeaAN9LPm0LIU
 ZFGq6uEYpupmfynlXsVyR1aM/zKT6jQDEtwrWssWhqFUZs1qNTMT5DZ4Ob/n21yHkVH85RfauFe
 JHsA6XlMnYQ6TbrSldBaOjLznpzG6QejFt5X7eIlQ9pZYqBsjcj1Q3eS7pIJb5yfeyYJzCYRY0u
 IZkzdRUyb9gn+DEiHLHmNqXZ5Gqo2t8VjEMCAGs1KlM2hrJc3MW4GkjxBok13XwueCQZvuC6x0d
 ilx/yLqLqLowcTye/rBAqsy8xO5Fo2b4fvSm7mvC+cnMjMjvcVWwGWSFsvMyc=
X-Received: by 2002:a05:7300:8816:b0:304:56fc:775 with SMTP id
 5a478bee46e88-30ba3ad2d0dmr734693eec.21.1781574507451; 
 Mon, 15 Jun 2026 18:48:27 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91fb97sm17826593eec.14.2026.06.15.18.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 18:48:26 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 16 Jun 2026 09:47:42 +0800
Message-ID: <20260616014742.67236-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wZIur-0000lM-Mm
Subject: [f2fs-dev] [PATCH v3] f2fs: use post-decrement count for cp_wait
 wakeup
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, geoo115@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_write_end_io() decrements the writeback page counter and then
reads it again with get_pages() to decide whether the last
F2FS_WB_CP_DATA completion should wake cp_wait.

Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
decision is made from the value produced by the decrement itself. Keep
the existing dec_page_count() path for other writeback counters.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes in v3:
- Drop the waitqueue protocol change from v2.
- Use atomic_dec_return() directly for F2FS_WB_CP_DATA and wake cp_wait
  when the returned count reaches zero.

 fs/f2fs/data.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..58d23eb74ec2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-		dec_page_count(sbi, type);
-
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
-				wq_has_sleeper(&sbi->cp_wait))
-			wake_up(&sbi->cp_wait);
+		if (type == F2FS_WB_CP_DATA) {
+			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
+			    wq_has_sleeper(&sbi->cp_wait))
+				wake_up(&sbi->cp_wait);
+		} else {
+			dec_page_count(sbi, type);
+		}
 
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
