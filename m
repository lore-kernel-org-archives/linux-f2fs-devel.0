Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944EDC02194
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:45:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tfKAr-00034v-IG;
	Tue, 04 Feb 2025 14:45:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jyh429@gmail.com>) id 1tfKAq-00034o-Cu
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Feb 2025 14:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MSGeoKPogDK2+Dcry6JtEMxeM1/AHJMA9LHzIxtXejE=; b=NV+vGFK67m9xFu5e5/KI0vqDkS
 RrhLcXs9VE2KQeuBRcwQDSuemL3B8Y6xyMAzB0c5zhmLow/nG8qTbNOv0DaZBceGbjD3c8ZOOFF5b
 v/9LI1fY9ZNORtK3q7dnRRs9KgNywq9VdKUFoww4S26A6ycTIPVLpb7S7bFzR5QmUTxM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MSGeoKPogDK2+Dcry6JtEMxeM1/AHJMA9LHzIxtXejE=; b=k
 2z1oz11C6/u87krdJwicR/l8c5AF701LSuIn5m8jz2hiOxM0n/jTYg9RXVWOnbQdmdj1XsVIY59td
 5UEekmXuKyNJuzKuol6ar6Vv6q+cL5YC3FA/asBNDsrN43U4UzyG8DC6ly/ifOGy2BZA8jx7hETg/
 1BJaQv9kU+62d+zo=;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tfKAq-0000JT-Fr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Feb 2025 14:45:13 +0000
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2164b662090so110888025ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Feb 2025 06:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738680302; x=1739285102; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MSGeoKPogDK2+Dcry6JtEMxeM1/AHJMA9LHzIxtXejE=;
 b=Zv5I/gq0LnFKb5w+64Qad9rlMBdVkYr1LSKudc6ftQ5oj0K/NJqu/5cQLu9qmt3+1H
 6zwA/rnDxq32K+cnoqHIgn0ShH0RjtyDwfYPa6GxXb5pCrIEkOdqzML5UU77sNTWn5Wx
 RiqG6g/nreKpu+zfUsrD05T7CyPx3WNaDteZ1D5bCxDR+yDfDli3ftCwSnS38Z9+/hgW
 fWp9Av/vvnfT2reboCmmXQUE4b9XslFzrz61h0qQl2kS/QbuL7vCs9Hu5V/lBYxRUGR+
 FyMRsKveDwuJ4TsWNUyHDNWN3ilb+lEbyZEk5vBZJenVamQiML7GYLcf94Gcmx9Z7d5l
 ql6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680302; x=1739285102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MSGeoKPogDK2+Dcry6JtEMxeM1/AHJMA9LHzIxtXejE=;
 b=cxSzcL+JnSAnhJvVA4a9Kvix+1mFPAzaUHfta8hKyhjojw807UQ2TY7kfRGHIhvfRT
 YR4H+DUBqMRa47XjWHFBMhtMpOg/rfaXakXNN9vB6eOhcy4wzEPagYpWESHkx/Ncj0r0
 D8ChLjATBl/Qkb7CBHDdp+l0ou9ZY0+ISAsr/+b81hxdLGUnCmjPlu3m+StwA38TieIF
 CSn8TNQa/RkqBi5cqH+ZYyoTO9yGoZ2foJuqEQ7RsJVbNMOglJOPKnjMrRlflnL5Mx4G
 IdwOotkuni/ighX08tHEUYTssMk9FNrhjJv04OlM/OIkL7CD/AvahxONgHeiEPTYpXSt
 Hi+Q==
X-Gm-Message-State: AOJu0YymIQ/o1UmHF9JSEja68dWpoRlv2WnKyQcC84isGwcGeSd7axDa
 k9hyWGsWQYzKEDgcJdU4nHfg6MZ0cahzYjDfOSpATHSexrcOQpbP
X-Gm-Gg: ASbGncs79orglB6gxDrV7QIRBbHo2dIn+xNdEfga1BW1HiNrO3j/C55MItptxMmbsQd
 gphmyBK4XrCdP3a1DPd1I2eYQaXt4v8uljtv2/a9C0aDIi2e5LfNMlPfjdhwktI+aOfXtJbRH4T
 Z2rDIsycCkZ2MHZvfb8jbgaFmhyFB65ZufbxoZXaT8jvMY1qY4W6yePk7Jd+PW5/BCEJ4rhsaaU
 +sh3ChdqtZyggEiT+udU5Z9hJiyhSRJu2KD4IyA4GOfkk1AxqjuCCuAEODOFD/kAlFXcl4VaEy0
 Z4rZ7Vvgy/N70VNjDhz0cWEVY9SNCSp3SXWRk4So8VOw
X-Google-Smtp-Source: AGHT+IH49mXcq79A3PaAW55Foprl6imsisqBeFob8nMXBnLPq6AAz4svlOy2jJJqR2RlcNUdKrMcIA==
X-Received: by 2002:a17:902:ce09:b0:217:9172:2ce1 with SMTP id
 d9443c01a7336-21dd7d64c77mr460371755ad.22.1738680301702; 
 Tue, 04 Feb 2025 06:45:01 -0800 (PST)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f086ff35csm12607495ad.118.2025.02.04.06.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:45:01 -0800 (PST)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Date: Tue,  4 Feb 2025 23:44:52 +0900
Message-Id: <20250204144452.1333-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1tfKAq-0000JT-Fr
Subject: [f2fs-dev] [PATCH] f2fs: fix to ensure queued discard commands are
 properly issued
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

F2FS zone storage requires discard and reset zone for each conventional,
zoned device.
In the current configuration, Discard granularity is set to the zone
size but queuing is inserted into the pend list with a maximum size of the
segment size As a result queued commands cannot be issued.
so we are restorting discard granularity to its original state

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/segment.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c282e8a0a2ec..03ef835588cf 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2320,10 +2320,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
-		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);
+	dcc->discard_granularity = BLKS_PER_SEG(sbi);
 
 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
