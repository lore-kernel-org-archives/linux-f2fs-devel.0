Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B48C5B543
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Jun 2025 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NlAU26clH+8yTaYePmQPovFH8C4vTD/ydplJmEZSA8k=; b=WN66TYq9obqYsQezlzIEMelqgn
	5+/gUplq+Krd+KSbqTNlWofCIPuU7zjIyQw9v8SLxS7m3W6A4mPmOPgq14MToVNSCgEBP7U6dgGgW
	4rimS77u+T3owAUNUQZGiLpP/ieZKwtBZJcZLfEGaCEkAZoDhr36ybb4VNL/JrBJeUwE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uNnFV-0004Rr-Vf;
	Sat, 07 Jun 2025 06:41:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <shengyong2021@gmail.com>) id 1uNnFU-0004Ri-Lj
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 07 Jun 2025 06:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vxVWbtZN8gePoNauFqZ4180bYkI0rNzmnFEMncYejJU=; b=bLvhaIzyYqTNKTpKfLqZ2euIQA
 qh5tsXykXo+LcHk7nxwUhhtrvPJXGq+0Hfq+JcuLabu2TuVfcQCT5EpPXMxtbgltGnb+0RNKnrxS7
 3hd/Id9og1PQS9x2466mgUEYTIs2lzueC1oqV/Ht9ooUUUBF/qeO956eoewuY2yvYFUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vxVWbtZN8gePoNauFqZ4180bYkI0rNzmnFEMncYejJU=; b=c
 5OTbZfDZsSrOeJFnH9X5oT7wWpF8SygwN1zOld5TsrBnU2Drl8GHcA+qi0ZPZ7MYIUIIq6+tMljxj
 g7UxloWUOQcg7UOdYo3mGZZJxwLx5lqDhD7ruVtkATuZAAbopHkEKFcdrpU1bGl9G+AUqdAWaIvtY
 JD6mh/CAubfdIMKo=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uNnFU-0001Ed-BK for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 07 Jun 2025 06:41:48 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-235a3dd4f0dso20076285ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 06 Jun 2025 23:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749278497; x=1749883297; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vxVWbtZN8gePoNauFqZ4180bYkI0rNzmnFEMncYejJU=;
 b=nSODbj7Kp8FebXADsVJpZa+b9ZAkLZg2zfVq7hUjym9GlXN3/QPvrIz2kdTu/WYboq
 tdqKB5AGdwljJvjFQLYGCmddYUSMFWBKwMTD2I36yyR1ZIB1QaiKV7xXpMU8X+PyKZBf
 V6Ui8v1pUG48BapRE+4NgALOWypXvfZVMdCOkiFqZuIkAW4rGKwcJfk8eZtPXWvORqER
 lA+7X51MVOmbwZkr3S3b3weqlNTXB0Dmx5SLTRQXi0OYq0rdWcXcx6xpZJR0QBZgB6ym
 MnQ0l24Ko4B427WMQmD5czYGn9Cc+c+IIwIunILd/3Dhq9IecGNlZ/CsTxxPBUXlp5IJ
 +g1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749278497; x=1749883297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vxVWbtZN8gePoNauFqZ4180bYkI0rNzmnFEMncYejJU=;
 b=Sb6CVjPmoQJPxgVKJT7XxLGynLX1ZPzBHo7hxiTNQGYA8jZvPBA3Wxy28vRNNF2aaX
 U2AYMWK0yyooeeiMWMZAGEc+h0wYB0UqsDo81PrFKNb2mOkKwI2cQ1kfasYYvuj89dPi
 UclpDt5gRLFNcd7VOpChoTyZES6JyOKV8ddwSKmHjQkfKN6YRRwfVnYbsmTc1zC7LbyA
 19ASHnmCUzukqMqaLBHQQLZaYLgKTxt5Z14uDKZyvdZQtUIX7+cP6o97qnEaDZN6s/O+
 LRxojqjp8aYPvoTARzPs7Wfkznaqfza7qWi6jwIS6ot7RJUp36/046ZO9u0neSfZpl7D
 76iA==
X-Gm-Message-State: AOJu0YwQjxICneFUbOFRfSyUAWw5Aj+KAFlil+AgaDz3CI2WVqo34gW6
 e1y6OzLCZpnMjfLGf4jN3VuMeuGGl6xhtHWQ5xBIinFaan8/LgG1seQY
X-Gm-Gg: ASbGncsFmHWcjL9SAwO/fV3u/lnyDiWYJcCpYYBi3dreXsOraCxW7AldPnMf4uOvQny
 KYABQ1ixq2Z/VSlkQxaSGt1ILL9wd05YSlLWaJQ9ZpFC2TENE7gGqzeyJWbxF6XZPDD6xWm4w8/
 UVg2B4CMwQVTgwpVqnbN2sKG0ElxK/WbPJhWNzx13OAY66UxBxOEAsSKiL/PYU9rigRTP63Lgum
 TsDhtngSKbgC+fwa+nDHgckLTpE27kIkGSKfYPWAE/iGLL+lp4kzyUK9XK3xdUUqghj8WUGgLD0
 hj8iVb4O3jYRabxCmpCVRp9gvGHLPp/2+2VUZIZVhwEHmNEIan0+rmaRpA==
X-Google-Smtp-Source: AGHT+IGuGPffEQKdqaSPm55b1wP7pImzY+C+2AhhN6B1O18fxmwjop+wDZWuoMxkaRmomuASKfiK2Q==
X-Received: by 2002:a17:902:e88a:b0:235:779:edea with SMTP id
 d9443c01a7336-23601ec3841mr96019215ad.38.1749278497555; 
 Fri, 06 Jun 2025 23:41:37 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.249])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603405f30sm21762255ad.177.2025.06.06.23.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 23:41:37 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat,  7 Jun 2025 14:41:16 +0800
Message-ID: <20250607064116.2993239-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1uNnFU-0001Ed-BK
Subject: [f2fs-dev] [PATCH] f2fs: fix bio memleak when committing super block
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
Cc: Sheng Yong <shengyong1@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Sheng Yong <shengyong1@xiaomi.com>

When committing new super block, bio is allocated but not freed, and
kmemleak complains:

  unreferenced object 0xffff88801d185600 (size 192):
    comm "kworker/3:2", pid 128, jiffies 4298624992
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 80 67 c3 00 81 88 ff ff  .........g......
      01 08 06 00 00 00 00 00 00 00 00 00 01 00 00 00  ................
    backtrace (crc 650ecdb1):
      kmem_cache_alloc_noprof+0x3a9/0x460
      mempool_alloc_noprof+0x12f/0x310
      bio_alloc_bioset+0x1e2/0x7e0
      __f2fs_commit_super+0xe0/0x370
      f2fs_commit_super+0x4ed/0x8c0
      f2fs_record_error_work+0xc7/0x190
      process_one_work+0x7db/0x1970
      worker_thread+0x518/0xea0
      kthread+0x359/0x690
      ret_from_fork+0x34/0x70
      ret_from_fork_asm+0x1a/0x30

The issue can be reproduced by:

  mount /dev/vda /mnt
  i=0
  while :; do
      echo '[h]abc' > /sys/fs/f2fs/vda/extension_list
      echo '[h]!abc' > /sys/fs/f2fs/vda/extension_list
      echo scan > /sys/kernel/debug/kmemleak
      dmesg | grep "new suspected memory leaks"
      [ $? -eq 0 ] && break
      i=$((i + 1))
      echo "$i"
  done
  umount /mnt

Fixes: 5bcde4557862 ("f2fs: get rid of buffer_head use")
Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ebda6834ac2c..57adeff5ef25 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3701,6 +3701,7 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 		f2fs_bug_on(sbi, 1);
 
 	ret = submit_bio_wait(bio);
+	bio_put(bio);
 	folio_end_writeback(folio);
 
 	return ret;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
