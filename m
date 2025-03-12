Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B41DC28B28
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 15:43:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsOFQ-0006Tu-Ar;
	Wed, 12 Mar 2025 15:43:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jyh429@gmail.com>) id 1tsOFO-0006Ti-AN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 15:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jSwDKAAj0pO9DLdE+iZ6p68KGUCERNcDNq7Ff/vTm8I=; b=CH1Zucv/2n92UnNXgXP0KBuSUZ
 sTi/5xpuu1RcJLiCAu42k2bFzhrCtidD9ObDfFXLJeZBNOBFl75vWcyZDjzufwp51iBT/+CrJsL0y
 o6b0QCR5i+RAsd7YDx22pKUbz62395+U8Bsmyq5y51kH1s2HHlHvDNl/whYhJgf0Ln8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jSwDKAAj0pO9DLdE+iZ6p68KGUCERNcDNq7Ff/vTm8I=; b=G
 FU5fbSqIvcwF8MjExlztwZcruxncKzDhHhHoOWh1YAA7KfAIQgvLJhq0FydtlYWNlgQpxc+sNtH2N
 MVsO5RrljiMrjsqetFQ4aMV/uQU2bU7D3vvLKMH6VM9+DfFXtRFzVXm8FAoEX9S1b+Sbv43Mv4Q1r
 i6O/y2c5KXIuOMMA=;
Received: from mail-io1-f51.google.com ([209.85.166.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tsOFO-0008Su-7O for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 15:43:54 +0000
Received: by mail-io1-f51.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so69370739f.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 12 Mar 2025 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741794223; x=1742399023; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jSwDKAAj0pO9DLdE+iZ6p68KGUCERNcDNq7Ff/vTm8I=;
 b=IqD+kpreeyCXVdO5e6kRa4p6slC/1zyZ4WXY7JZDk5EXuvPTfyv2f2Vj2c7qSlYLLn
 JoMxeBwZdNKwSVYTyta75sJHBoFtF9q9ohl2HvHJE2bbr9+kvF6Kf8+WYi8e2UCa5Z4B
 F2YRezpAVqqBIZ7iPQzAiKA8nbW3UX7QF4GAH+DNBfDB79ckn/higlmRu5Xhr8nOBrQI
 JAvZzOLJSSJMnVVYjCmMikluc0l9YfEC7SiN3yLLdF0kTeWlGtDr5hXLzpLqcmXIp4XF
 U+2UdJWLdHFkgFZA1d8/755HAF9JDEWUyYOcvmUyT2gDtoFHqr1k0FFHD9TGlFld4/sO
 YwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741794223; x=1742399023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSwDKAAj0pO9DLdE+iZ6p68KGUCERNcDNq7Ff/vTm8I=;
 b=iavyvakgH3zF6GwHadEeYq+0B9M3hPQle3jyO6jZ0FIPyQa7jMYej+OxdwueiBa3Ew
 OwijqdVCmjhH0tx1vWHCYKNrDNmCNcgIRmQ8566Tdtu97juFpiq9yDrI3aB+qBoM6DHU
 bd6uOeHRSyJ6fbDqoT5oFAukM4nRVDu/Q1y963emZ1lcJa0hfCqyDfFOhbDxIfrz/K6q
 vuThxB9VZQmFexfgJa76813J5/nAYJKSUqbt+wCT2zgepkQMegakKOAu/+4YN9eIVWII
 ObRIYT+72D836ct7E6wIHQzOHq8KT4+++VDuK/tWNS5bDUMg7xxWds6VV2rFZt38OXr1
 xaLA==
X-Gm-Message-State: AOJu0YwdDYLVFnAmqScv16HSZsMZdFuEdqmfxtEE/QtxZW50uWvNi1hY
 5TkQ9kXYIfMvVfDHmrMy2YlUYK6WKwRBhXacz4FDR18GuqBIhljyre6i+QQr
X-Gm-Gg: ASbGncs64Nzz8a/QdVaMpAnd+f/nxtgjV6mlt1cQKEy061AxaY5vP+Up0rIL/89swAp
 /QCgtVeCArOF7A3BkIqP4hJjzpU6CzJHQt3kK1H/QcphpU1SUCJw9VlWzwQ9bU1hf11oUZiYkZ9
 RKD8pppYv5IcTqrzKWuD0gFiCI03igEPC9afLQS69aWCOELLO7b2xsZDw0XI4TLog6BHjC1N3qB
 5UUwcb40yPvBq77IOiPjGA8g6WwfXcY57vKrzroFRHhEDPlccSEeUHFvqIGgIdt7zFKsepiFToQ
 bIPNjeClSL+Tq4vPt/3Nmi1NwKEUVl1pOilNWkCuUe11dhoQo2wxXOYrKB4eS69seTnyMtbJNA=
 =
X-Google-Smtp-Source: AGHT+IGIq/cWnHt3emJsrqyh44YzFU/yOq7HRAOXl+9E6iIw03sZKbZ0/BJgI36js0tMzooij4tuWg==
X-Received: by 2002:a17:903:2308:b0:220:ce37:e31f with SMTP id
 d9443c01a7336-22592e2cb8emr105011415ad.17.1741787291606; 
 Wed, 12 Mar 2025 06:48:11 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a7f9e0sm115591195ad.113.2025.03.12.06.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 06:48:11 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Date: Wed, 12 Mar 2025 22:48:05 +0900
Message-Id: <20250312134805.362-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1tsOFO-0008Su-7O
Subject: [f2fs-dev] [PATCH v1] f2fs: optimize f2fs DIO overwrites
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

this is unnecessary when we know we are overwriting already allocated
blocks and the overhead of starting a transaction can be significant
especially for multithreaded workloads doing small writes.

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d872f785a996..b55d253f7be9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4181,7 +4181,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = f2fs_rw_hint_to_seg_type(F2FS_I_SB(inode),
 						inode->i_write_hint);
-	if (flags & IOMAP_WRITE)
+	if ((flags & IOMAP_WRITE) &&
+		!f2fs_overwrite_io(inode, offset, length))
 		map.m_may_create = true;
 
 	err = f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DIO);
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
