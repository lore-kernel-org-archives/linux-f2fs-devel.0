Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4955DCA5FCE
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  4 Oct 2026 06:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rCNwfnO7pruizlxsGkybr8O17wv2ta3aBKTTfDndBoM=; b=gPS1N0yZ5CEcqwahennogy7X3x
	D0ipegPvEZsqo2pg+Azl5qNEMbrCAJOj8R22xPpkCVkfh2CxF7QSfvSoOtGJiUkQ3zP6F+j9jHJ2o
	loOEcNZzyp/m/kAldoRpPoO7nEHH0ib8tbYwG8VrHNMLNV6IEXUlr+fbhdIRuan5oQ3M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDFQb-0004qZ-UK;
	Sun, 04 Oct 2026 06:10:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xDFQa-0004qP-CV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 06:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=04hTsdUrWnp+GI0S5nrnWDa1XwZ/YzaTtTKcCpafa/Y=; b=Pmp1lVEZCoZ0TK6w6HF/RpiKzy
 fnoumvJhWgTQ5IPDpwHwHaaTvy1STBznQKycnyBtCF3oxOR1iot+CqQ0Zvh1t9MfW07IKMa1kF0Yg
 gIMeqBItEAqGWZ3PYkZ/VFji5zCJ4eAhgwsJtfIVv/O7LEEdK9MgpfImthb3bXPXaKHk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=04hTsdUrWnp+GI0S5nrnWDa1XwZ/YzaTtTKcCpafa/Y=; b=P
 bQAWlZk4mkkyIoJrvTAESpYHcdQ9+Q7d8oMX9xnr1++I2URGUA//U7HUMYqQTk9N8tLfiNVLlZWrE
 WVmV1twG0Sv5t5zCaZYVoG6t+DhcDR2Ry3CdRljx3NVnB0uiQgG6YlfjZS0n4NvPOCzhVUe+H92Hd
 Lvp4kwSzD2ulUS74=;
Received: from mail-pz2-f37.google.com ([74.125.228.37])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDFQZ-00060J-70 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 06:10:28 +0000
Received: by mail-pz2-f37.google.com with SMTP id
 41be03b00d2f7-cc7cadbe09dso244759a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791094221; x=1791699021; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=04hTsdUrWnp+GI0S5nrnWDa1XwZ/YzaTtTKcCpafa/Y=;
 b=GfU96s1Zw5krb5XYs3AF206rkBP4PZAYgzHvA2x8IQcJ4Giq8yIoPgfXLJKD0YioMT
 wCejSl66gWpFGgaBNQqz8kMr/1noLXAPt4ReTNiBG/+0Y1dnbGs1BySQJDpw7TaahPEK
 tXzPCLpplMarnWuOMy+gkbLqkJhwhSkFiR6sBgIhKYYNYRotlNOCyDveZQbSXANLUb6t
 xTNeHdeFCwTcOWhcadyqHo1VNrDvx+CXakm1pHEW/eMxS0dx6bzN3/m5N6dQiX9wv/ee
 b3jkoXsg3eMU5f1Qwr14MUWBDMX+g5XTtTx8eLIt4UahIj1wWxO4o7clf5bDNTU+EJ6j
 2U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791094221; x=1791699021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=04hTsdUrWnp+GI0S5nrnWDa1XwZ/YzaTtTKcCpafa/Y=;
 b=ovI3hZwgV0KWDSgrSgXhF3St6oryjKxreHHNUfkckzUS7eUIOR/5SZ9EEI+SU+a2+i
 hFZwn8WAXlVzY6fQzDC11nwrqb+bSjDXVHKG1VeKN8M8mwz83S5IBZzbygdx45bV03/v
 hBJBkaeMWRgZJ3MVaySLYFGrpQvCqY+MIS6Wz8Rh4WIxDhKj/zo/4ZFlyaXp2wB/x3AF
 Yd9I0X2Y+WAN2JH51/92tDCdHtwGmPQ+jxYErtoKXY1/DWsiGv6eTlDPBjX+48tJZUEo
 5MBcuK8AZJgPbkfkPgbEvDBBoYZhst7XAfV1edDy907U2lXA68DZc5jyBtjR68Dpm88P
 m3DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlx/PVG9ETxFyfEd5BpoUubGu62G8KvuoolYWsqrrJyXT/BuuZ8T8gi7QW1EWfqKnQfmbWLChG0Wqb3CTfBXaS@lists.sourceforge.net
X-Gm-Message-State: AFuF++m7YlUmQvq25mONmtV2/pi6b5STAXEGw9nQSpwvG1jjE+1omRd7
 J3DboISYuLPJ5/r4zrYJxQY2ruagvelY6+BXIuk9A6jt2v+bciNo3mgV
X-Gm-Gg: AYBFou0ix86yduzrw5OVzM70fZM5qiNalV1RPxWMCGZifoO/tt051amfxu8IlIL+wVf
 l8w74n86uQ7ffwkbd3Zx+LCqRDM/AXuuFFEyJPp6btfHrQuX+9cOC2jXUPZyezZtiHu+hREfUMZ
 JL6zr/ERzMtnXbXkPeUawQDoDjJxMvf1z+fBhxc10Yz38TXVU3ra628H84TMRsitrsJpHZKfLfg
 Udv+KYlbm9WQuPKx4LDlEMJlvvbSBlsoSoFRseV9rAuJ/MSHh2oy4gIpMY7ZJdEBrzo4u4Fb1LD
 C+D+fgCAsKeNsnwTF/IyLb3uJs0kCelPRR2i55jgB8bGccOydUIUnxZpb927XHLxy7pKZfGxev7
 V4mBv7GEDwCJFPPmjECs6Ug51DE12/2b+KbI8MQ2O9Umliw04VwoL8fmtFSqSIPq4O4Dw42Ce0x
 v1/4djU6HeSt5Uj8lmszv/6GeT9A58wiomcMSJNduyjls4YLsyPSi2gR9lNwAkfpyEOhTmWEAnX
 jZVlkXYEl9EH4iqKzbPXyVmDS1B2688H3jwsZPZGeCleKTli8MoKTw/Oll0+63LftvW1YhH
X-Received: by 2002:a05:6a00:8d5:b0:880:f278:6b0b with SMTP id
 d2e1a72fcca58-88af3cc62bcmr6165889b3a.4.1791094221281; 
 Sat, 03 Oct 2026 23:10:21 -0700 (PDT)
Received: from
 codespaces-2362ac.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.112]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0b8f5b79sm2427955b3a.15.2026.10.03.23.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 23:10:20 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun,  4 Oct 2026 06:10:07 +0000
Message-ID: <20261004061007.7433-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xDFQZ-00060J-70
Subject: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
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
Cc: linux-kernel@vger.kernel.org, yi.sun@unisoc.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When update_sit_entry_for_release() encounters a block whose bit is
already cleared in cur_valid_map, it reports the inconsistency and
corrects se->valid_blocks and del. However, it still proceeds with
the discard bitmap and checkpoint accounting updates.

This can clear the discard bit unnecessarily and incorrectly decrement
the segment and section ckpt_valid_blocks counters when the block is
not marked in ckpt_valid_map.

Continue to the next block after correcting se->valid_blocks and del,
so that an already invalidated block does not trigger further discard
bitmap or checkpoint counter updates.

Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/segment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 51858f64e43e..fc2f0fd8e318 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2560,7 +2560,10 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 			f2fs_bug_on(sbi, 1);
 			se->valid_blocks++;
 			del += 1;
-		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			continue;
+		}
+
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
 			/*
 			 * If checkpoints are off, we must not reuse data that
 			 * was used in the previous checkpoint. If it was used
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
