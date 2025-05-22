Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04107C54E90
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 May 2025 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2zpxPgTDoFgdKHU5oUsHcXc4Mz0ZeXyyVgpA3YXnn4M=; b=jBJBcA01BfAO4HWDtJWcGG/tAC
	CX9TQj1rtssq/NCLY0o/elH2UzxM+u6A1ikY7f/WZbZr/tHCzG+l3F//bl0bwytgN1zJhlFuIp4RZ
	KbrvzsS55jLwr8EGpoUvudTOTxTA/TOqtVWXXfUwvzBnxgXb15/fWXQKD84wRaB7FY8c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uIAbI-0000f2-Nb;
	Thu, 22 May 2025 18:25:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1uIAbH-0000ev-Hb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 May 2025 18:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Gv5UL/mbvczA/AXhPs3M/C8hC0hgs1z+7M1Do9NPzY=; b=MxnS/1AvdGBCVng+cVIaDKB8+z
 vQGtP0CRjixGPgkahBvHA6XR+MKf7/nz2GCM4FW7Zhr0EHrnDzAJriPjKYQJ6E/WnNrt8cuehlOFi
 A8qG55lSb7g1dJbBndgJDwFr4QDwbA3WUwrH+eNSKiNpVKfmijn0xkhvyVtiaPmYpaC8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3Gv5UL/mbvczA/AXhPs3M/C8hC0hgs1z+7M1Do9NPzY=; b=R
 RGZ+W3XvetGPhXRrFbYGKcjc21NQ0dcG2tVdMZi0tQ9gbI8BPx4ubYbIRN30lWKVUXFxrVriXG7sT
 5lgdcc5PhxeRKbnb9R0GuB1k+xGbcVMFxXsjPfIZjZ6JC33lFTEFC9cWZFBoRCx+3YlwM7rgo83Rk
 QY3n+YD7ZrtS/L8k=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uIAbG-00048L-Sx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 May 2025 18:25:03 +0000
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so6790795b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 May 2025 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747938292; x=1748543092; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3Gv5UL/mbvczA/AXhPs3M/C8hC0hgs1z+7M1Do9NPzY=;
 b=Fl/7tdHNRB3ANIRkSuelC36yAqtxPDeBBl52kF6Yegt2JMjbMgBQhEn/H6N2GVg+5h
 S//1tpsohSoqkFJZ0xOG8c6FIGXNpTxIEAdtsEz0wyqAzLioGhkX468QgK/qyg4Yex2K
 J8VzlCLhRnLS4sUihoi+mLsh23PgSSUaJ7QqdrzGMpLtCO3q761C0RA8j8eYQbuddFDR
 qryufwbznLe73PJs7xYbrtE5eEk/D2v1HTsYi//qqlnh5cLtaaMHl56bm3KNZ4IjChPv
 xeFZDAUEuSwx6OnlD7fxv6dOuAqEMgvrCPbWX41iNpIF8/jy0giv3pH34LwinWrD8nK3
 qCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747938292; x=1748543092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Gv5UL/mbvczA/AXhPs3M/C8hC0hgs1z+7M1Do9NPzY=;
 b=iR4c3SzG/G1SqL67LmfWfjU7hLnhbQIUoXSOBlG7qfpFUV6Qu+jb7uqE2BeCvCl+US
 QHdoKvX8B85ywFEp8hY83POlRDVN0ak1vbLZhG83LUMmt1eowVJUzim2iG3CL1BnXdjc
 IthScb45DtxopLhdOBX5c3c8pS3s/XQ5cORwbRBAC5Ygl7yxHMR8Lanq8pG+r8jAZT75
 aPg/nd1B5j3fJUvAOd2anhPjKa2HVU3e9k9LkUePIPlD0p/4AaAbdjGcuZgR/KDAD1+s
 Xu4yNzWj4131iWExHEKXdBEEnzKovOwObCn5tOjHoRiq20UF5WvTUXHGiZHjjGhLvM5e
 2Vkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUvJY5JhMmsTXxD1E4tZODWu8okJF9js91hsbHqpto1xy/ikETTHlaTtjvZNWIfH4UjDd9R9qEkRUahvFPZzkE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw12ASsY0TkivlOhWVEfk8/x0s1cpZecd32yS2yiWNOSF/RZ4ex
 iGGomsvbxPUkDMPt3QR2JU2BmPv82nMezqwiA16QGOP00l8t7Lh12CfM
X-Gm-Gg: ASbGncs4OUdPhGH5RhcJRTtG0F4w9r0Z2f5Z2jVS61a88wbDeTZc+9cPZaJdnlPcFmc
 UsIN3v6FGEGCXTxLH+A7j/KNm+yELcg1nXv1q/ukbcY16VjlbOMbzEONCEw9x0+1IR0+ny2iFIT
 bdIc/3Fsu+KhslCIaxyOc3qY1AXdCAbXbCMw3uinP7mDR8R2obhaP3eHye2VuRK4FEFC5J7ax0q
 5MYiOhJr8a7qiR9coJ58DBbvlYF+09wKD+QTsU6xy6Q3Zv5WhrZAquG6JGvbWOS3cqfYl+bVyfy
 pNQlxwnJyz8cXJaoC/De/I9s9HBHaSRcatyhDUS6Lzo+NWiG7LGoSstmZCYkbvV4U8DTqmphqaf
 dK/r+qtNvvOOQuF9Sc5HkzW0cTbjGtYy5Zmf/xGsjlvY=
X-Google-Smtp-Source: AGHT+IFvRdwBSifmAKqQ8TmXZ1JkfWoJi0ru8I5kEIWTXq/3P88sy9AQ+SfOw8VDwlqMIxj4sugp7g==
X-Received: by 2002:a05:6a00:398f:b0:741:b3e2:635b with SMTP id
 d2e1a72fcca58-742a98de416mr40902566b3a.24.1747938292113; 
 Thu, 22 May 2025 11:24:52 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:8127:b563:a3a1:d465])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970c8a8sm11950732b3a.60.2025.05.22.11.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 11:24:51 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Thu, 22 May 2025 11:24:45 -0700
Message-ID: <20250522182445.2175742-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
MIME-Version: 1.0
X-Headers-End: 1uIAbG-00048L-Sx
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: ensure zone size is equal or bigger
 than segment size
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Otherwise, it doesn't work with a crash.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 lib/libf2fs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index d2579d7..396e22c 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -1346,6 +1346,11 @@ int f2fs_get_f2fs_info(void)
 				return -1;
 			}
 			c.zone_blocks = c.devices[i].zone_blocks;
+			if (c.zone_blocks < DEFAULT_BLOCKS_PER_SEGMENT) {
+				MSG(0, "\tError: zone size should not be less "
+					"than segment size\n");
+				return -1;
+			}
 		}
 
 		/*
-- 
2.49.0.1151.ga128411c76-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
