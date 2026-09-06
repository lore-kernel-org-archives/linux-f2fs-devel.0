Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34BFC79F85
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  6 Sep 2026 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WPgttYVL9Qb0RMY98/1G3wa+FJWjrpOqF5VKNFEV7W8=; b=Yjq4ujsqOpU9sVPiBlutRdTTjH
	xbGSQ5DxhkCLpYNr/6vkMdHhL+Tz1i24QORxKk3XzDyR+Zr9fSMxgd9r1yByEzWmy7bKAPFrqlaxs
	tr7zZqFHfVMrOPOi5/vBbgPO5zny+R3nE7ACmaS6wUXHwAltRicWB/fphMiwhm86+rog=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3EIt-00028g-Ae;
	Sun, 06 Sep 2026 14:57:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1x3EIs-00028a-BU
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 14:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VWy32RDFiEUCikk0m6EE/IPIz7mmLrlqMEWJVUxd4S8=; b=fA9/TdImXhtsoX+NP+4zETU0Dc
 uYuoeXkM72fNPGj24pjU2g+FKLsVr5zO032HnKFUAqn/osu7wLjG27ZS7gxqpTG5/NX1bnSRnNyXC
 DDzoE5licbrI1SdlYH5+LvnpoA1xQgir/Xu9CpwUX/tBZaUaSes5flb27DPyjUpfuosM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VWy32RDFiEUCikk0m6EE/IPIz7mmLrlqMEWJVUxd4S8=; b=X
 qYygphFYEmMqqv8g/O0gQSIKbRxbtmxnumts4lgZkBumYVaxMv6WmO6xhU10PiTVAFhFPK7AB+og9
 5eO3RltqntfE+1pa1hu4pM5JpPhqmIRI52dE/39nxcfGXWzND22myIXQpnuGGQQJkDbzPlaREF49b
 E6LbJS5mUsCh7YyA=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3EIp-0005Ab-FE for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 06 Sep 2026 14:57:03 +0000
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d71ae3455aso36835715ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Sep 2026 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788706618; x=1789311418; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VWy32RDFiEUCikk0m6EE/IPIz7mmLrlqMEWJVUxd4S8=;
 b=e1w8qFyWBRf/c9/5p1nIBLf8QqqBMJvUORcJmBgQF46flgRiWnfuSiMo+j+NIgvATW
 8eTjSLUQ0GI5gbi+C/7BcE+K3SOYf5E9E1ovk8nHfUITf60dXlKL6OoB2/QvtRAdPKfj
 Y80K843dN78P8EWbs//jSEpxv5/5SjmtcrOLy19w+4nI4oSQvQHneuptYPg9w0ym5nO2
 Rb9qTLw99+54YLTRo0m4eWbAAtirYToOxnaBEfD+z6u8VmXLcJ00avUwEMCMppeZ8BIt
 bjKxUU0hhwJdmctcLDrG6N1Yv0XULIkrrtzHGl0Evj9QsdSwO59EikLHb94DnBC/i1iG
 khBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788706618; x=1789311418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VWy32RDFiEUCikk0m6EE/IPIz7mmLrlqMEWJVUxd4S8=;
 b=n8DVPayA58yNwLypE46IgwsjvyhOdlaIi+9We9/tKOHmZj7M1ca2WosoBNb1NSqzDK
 O3VNMAsIAxXaBy1VL8W05C51nnrIZeiYMCMbYrkkNFU8XmkrKyC8gE+ObJt3rQ0a2My5
 hEh7/0muKsY1J3AtFzQXtLW4AiZ1HqB5k4/ek16NII0eWgZwaC83qwqnEgH0hMywRDUm
 r0NyRBV+BVPgNnBwr78nzsYNx4OMdQNbcG4zHtrgR1U1eneb08GSXAKQX132ajDWMHyr
 cTJA6cUPY15s14N+0HHXlmrm6zMoKc4boeLm61JVTovKnbDVVEurj8p9sjV18fZu8XZU
 yLJg==
X-Gm-Message-State: AFuF++mj/BpiU7AQCXWGXgRasPfj0pkO00t2mpyuYr8+62RCIGz1idVX
 UgiyC2CHR+gN9FItwB9Ui+20P5hH7s5YNVxzhDszlOp6bg4/ex97OcV7
X-Gm-Gg: AYBFou3orP1eruL2Kxf4Sy75fFRo9M0Pnt5jI+U8/w8Ea4GndRAwLE5rIXrUVz4GM9C
 WIoONVsjTFkDpkgCDh7KeJH/5DzSfMlq+ryft3B/ItS+mUeIIoXfZ6r4Gevu7dtYY8buEYe8SO5
 AW/GvFGnFlhlCD5Zs+tT9tWXN1OHzBMnMZxjdKx/IOirgBMlsiT4/3AWK9fRH374dsS2NL11O8d
 cKffelkapzKadoAFH2OVwRjdQvCX5bgIJQSDj1SDkVaOvYdWnDjBhY1YPxWL3vrD4dm6arnYUeQ
 uc07mgbNSUtmCZ4gBtXZuQT53Yh4yYM+yKtlQnSxWPKKllPsXA6SYfi/5Mo3SqvjUPOzBufIVH/
 wWFLMYon4dcRfrgM+fHZjNCwmIoSku2fxEUePdVBADcxmSo2TZ6vddfKszZRAmRWCh3DQJwHp/9
 hfCTxaXCGbSOZNKnBvtuyyrOZ4lvtWT+TbqdFxYkqNqfZQOFPhMbwc3fG2mQfFqDseqDGV7IuWH
 +nLnY7l/twbn1qwDQSRem0+bUZKqLboNAesjhuVqmNZMxVai9tYG6Xoaf7Ba2g5/ygs/GET3JY=
X-Received: by 2002:a17:902:f70f:b0:2bf:dd0:c8b1 with SMTP id
 d9443c01a7336-2db1225b297mr265306895ad.0.1788706617566; 
 Sun, 06 Sep 2026 07:56:57 -0700 (PDT)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([207.46.224.87]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1495a0b2sm32845425ad.28.2026.09.06.07.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 07:56:57 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun,  6 Sep 2026 14:56:11 +0000
Message-ID: <20260906145614.2749-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1x3EIp-0005Ab-FE
Subject: [f2fs-dev] [PATCH] f2fs: skip node_change lock for inline data
 writes
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

The node_change lock serializes block reservation in the PRE_AIO path
against checkpoint preparation, since block reservation can create
dirty node pages and update checkpoint accounting.

However, writes that remain within the inline data area return before
the block reservation path. Thus, they do not call
inc_valid_block_count(), change a node mapping from NULL_ADDR to
NEW_ADDR, or create a dirty node page as a result of block reservation.
They also do not update total_valid_block_count or
alloc_valid_block_count.

The inline path only copies the existing inline data to the data folio,
sets FI_DATA_EXIST, and marks the inode folio for deferred inline data
flushing. FI_DATA_EXIST can dirty inode metadata, but it does not
reserve a block or update the node mapping and checkpoint accounting
that node_change is intended to serialize.

Skip f2fs_map_lock() for writes that fit within MAX_INLINE_DATA. Keep
the existing locking for inline conversion, which can update filesystem
metadata and requires checkpoint serialization.

Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/data.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 21f396ebe22c..f2fb5ef3cb7a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3690,10 +3690,11 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 
 	/* f2fs_lock_op avoids race between write CP and convert_inline_page */
 	if (f2fs_has_inline_data(inode)) {
-		if (pos + len > MAX_INLINE_DATA(inode))
+		if (pos + len > MAX_INLINE_DATA(inode)) {
 			flag = F2FS_GET_BLOCK_DEFAULT;
-		f2fs_map_lock(sbi, &lc, flag);
-		locked = true;
+			f2fs_map_lock(sbi, &lc, flag);
+			locked = true;
+		}
 	} else if ((pos & PAGE_MASK) >= i_size_read(inode)) {
 		f2fs_map_lock(sbi, &lc, flag);
 		locked = true;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
