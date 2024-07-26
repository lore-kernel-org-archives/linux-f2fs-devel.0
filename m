Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E9AC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 27 Jul 2024 00:14:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sXV56-0002fq-Jw;
	Sat, 27 Jul 2024 00:14:41 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3KySkZgMKEEAreeiqqing.eqonkpwz-h4hu-fgxgnnkuvu.uqwteghqtig.pgv@flex--pcc.bounces.google.com>)
 id 1sXV54-0002fg-Vd for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Jul 2024 00:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UxEbXk8sjYfJnszBYV/U6tD0PeIchNjCPKOCbBglaT4=; b=lBZ+2+5GGGQMTJmH++Oy9xOA8C
 QTDPCe1qcFYwRCxLwygaa1ez8cwl3uAsyRN/fo1jGFKTgPDu7Lvz94+n0rszKzIIICE/qlccI9TzZ
 +iX8ceHaEKBuf7RG5u07hrcYK+7WLsKbZIxMigoNAsMJClrC1bvA0IsSvADc2pUnQUdw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UxEbXk8sjYfJnszBYV/U6tD0PeIchNjCPKOCbBglaT4=; b=H
 FIUJsbW+A6a9ufoScuvN7/8O9lj8BNNijdIohKAdpSkaJ3kchpe/kXs+ir/Dt54K+x1pG5MEWl+13
 yrco0Ly2ZQFFXMyh+NfImWZ4e4KItHEKDx9JGqUAsfYjuyHJFclKCIt++oxO97WiAI4aQrLna54hq
 5axUMM+oYhbguAiw=;
Received: from mail-pl1-f202.google.com ([209.85.214.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sXV55-0000Qt-2D for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 27 Jul 2024 00:14:39 +0000
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-1fd8677380dso10238595ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 26 Jul 2024 17:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722039268; x=1722644068;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UxEbXk8sjYfJnszBYV/U6tD0PeIchNjCPKOCbBglaT4=;
 b=YpASitkmQSW84wYkgZgYEE34mRzfihZ1yAKx6hSacl0l7QiFspm9H9yEPGHIXMWadW
 +VsrmIQsV7mtywxFkKvCGm/t20qmtDU3BdwTk4ANDPqhYfdBp5TxEwhR+6hMvJnVGIEo
 GJJgzq2mXy8zYPXt1rBZYj1niz9/qvRHDCjiMVgEiOaMqg8dJlnFbL9zhFsgOqE7cTRw
 xwyXiJ1UtcO7sdFjUgnv+ZcA5xou/P3ijH6+qoOIRqHuUt0wORr94432z0D5yy75HHvQ
 cvpWYqjoXekkAfOlpiGs6FKwjRb3g+H9qg6lkuSr1UciJi4mG6QFjQBqkYplpAs0+GNl
 Yszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722039268; x=1722644068;
 h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UxEbXk8sjYfJnszBYV/U6tD0PeIchNjCPKOCbBglaT4=;
 b=XL6tAu46gWxy+pDT7kNu2A3WO7w755qWaxejWPA3X1pcY5DPf5KkQxeh+Nf/Z5XEzV
 ZsneJVzvAcHYjCzgCHElnQSE1Qa6sI2tixWSxyNKMbJMEPnR+JrB5vE5J/PbnMAqtRAr
 O0mD0eYKD4Nm3ar0pT4jCm0JZp3EX3wBxeQ6IRrK9Eyis3SizfOKBb20+Quc9ijiUjYL
 LzTksHN5zAD+msZ4ZKAiCpRyucEe9wq3+x52wvRUGEijsqzm+mJhT3i8FbMBUjqNqjM0
 FxFyC6ODWNU1B4YzVdvz3HhXPAlkvHUpJakUUNkCcfS381tZK0NHPxek25UhAHKUnq3z
 DCmQ==
X-Gm-Message-State: AOJu0Yyv7o77P5kg6wK2ORHPsjsGNoYnzts7GooSq2buoHZ4xjoaNer4
 On3IkBa5yb+PdsAbNGAm2WN9T3RKB4uQR6I49iDtsR0PRYET5o5FVj2il10GGrE/qw==
X-Google-Smtp-Source: AGHT+IGDTpp651+Ae+mAPWXKUcL4AvGkhvxlzhCl/W+3VowgNjRkKPd5HaIzcMKI6Cno4jqokg1nve4=
X-Received: from pcc-desktop.svl.corp.google.com
 ([2620:15c:2d3:205:4799:26a1:4da2:c60f])
 (user=pcc job=sendgmr) by 2002:a81:ff12:0:b0:66b:fb2f:1c2 with SMTP id
 00721157ae682-67a09b6f148mr354947b3.7.1722033195698; Fri, 26 Jul 2024
 15:33:15 -0700 (PDT)
Date: Fri, 26 Jul 2024 15:33:09 -0700
Message-Id: <20240726223309.2102788-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1sXV55-0000Qt-2D
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: Fix out-of-bounds read in
 f2fs_prepare_super_block
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
From: Peter Collingbourne via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Peter Collingbourne <pcc@google.com>
Cc: Peter Collingbourne <pcc@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The path field in c.devices[i] is a pointer and is normally filled
in using strdup. This makes it invalid to copy MAX_PATH_LEN bytes
from it because the string may be shorter than that. Therefore,
fix the code to use strncpy to copy the string instead.

Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 mkfs/f2fs_format.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c9d335a..b053685 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -316,7 +316,7 @@ static int f2fs_prepare_super_block(void)
 					c.blks_per_seg - 1;
 		}
 		if (c.ndevs > 1) {
-			memcpy(sb->devs[i].path, c.devices[i].path, MAX_PATH_LEN);
+			strncpy((char *)sb->devs[i].path, c.devices[i].path, MAX_PATH_LEN);
 			sb->devs[i].total_segments =
 					cpu_to_le32(c.devices[i].total_segments);
 		}
-- 
2.46.0.rc1.232.g9752f9e123-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
