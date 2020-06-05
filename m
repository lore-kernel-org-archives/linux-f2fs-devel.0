Return-Path: <SRS0=5W2J=7S=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D74C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:15:50 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3A4206A2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="T9DNt9Aw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HwWwRYOu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3A4206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jhGsf-0002Ld-EI; Fri, 05 Jun 2020 18:15:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yefremov.denis@gmail.com>) id 1jhGse-0002LX-PB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 18:15:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QLtVBAQHt79nrKp5l8gcbQoeTzLDxbZbAEut5UfqQPo=; b=T9DNt9Awy/eUO/KMk2ADBZLOIU
 tF83W5/3FrKIDFta0FQmQfAhudGdA3/S35U6+2gAAkDMp2RRjLzUc+fD/J1CW+QRNiiRuDNfCeEGq
 I/OXa9IibTUlJzWp0FlPAphePlT3/Vob9rHCauO6Sw0lBfG+2sXWFhWUFUyaI9sGfH4I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QLtVBAQHt79nrKp5l8gcbQoeTzLDxbZbAEut5UfqQPo=; b=H
 wWwRYOurozhawWwZI46o35uU8h+JMeTjv64Cz+aTjbwKZlKvL93P4Lneh+sDc34cvdn+iK1dw93dD
 ucpqNXB/akBHeGtMhY5zx7xR6aBTWwPQryFW1u1CdFW4LGJnqjNdMTv65Ptjq7hP8bjFwUGos0ZS0
 vFbDX+UCQX+ZLBkY=;
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jhGsd-00A7y4-LG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 18:15:48 +0000
Received: by mail-lf1-f65.google.com with SMTP id c21so6360169lfb.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2020 11:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QLtVBAQHt79nrKp5l8gcbQoeTzLDxbZbAEut5UfqQPo=;
 b=ku3xkIVp3Pa98YlDqdoxg7vcxQ2qp2aN3RSh2hCS7HwmMxkeswsldoIKKtO2X+9etW
 lLO7Aw3du6NHMBXJ4Gs1ZYG8mZ6ljgs0k0EMLt0/uZ6IxycWviazB4wBIstlLBoM3iwc
 w3aYltXts+/zsbRtSjm8HZdHY5feMG17o6/alZKsOmflft0sJW8j7ryQybWIF187g7BU
 VO+2GU7Svg8IczHmN1RyIEMCoaBlOjrraWt+zEUWlUINh25bd6M4+P4q4pTCHquIAob9
 EJjlVrZBhdlEG9Dxk5JXSd+jqjW40Cowd9fv2k+w1qOI+o7OT528linSe5qc3KC0zoUE
 6K9w==
X-Gm-Message-State: AOAM530Omma7v0euyp6e4FKTSMpyRW4PzOv5qOMUOaa1WMYLeONNZT8q
 FJSYgFaOwRbr7FJytQejLl8=
X-Google-Smtp-Source: ABdhPJzKHMsKE8ClyLyxqEZg6cRGaaIv7YE5pplZGmBmwx4+tTKTkQhw2OhUzUAPoKaz5kP4NqBFBA==
X-Received: by 2002:a19:642:: with SMTP id 63mr6064091lfg.173.1591380941170;
 Fri, 05 Jun 2020 11:15:41 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id x69sm1254625lff.19.2020.06.05.11.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 11:15:40 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri,  5 Jun 2020 21:15:32 +0300
Message-Id: <20200605181533.73113-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Headers-End: 1jhGsd-00A7y4-LG
Subject: [f2fs-dev] [PATCH 1/2] f2fs: use kfree() to free super in
 read_raw_super_block()
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
Cc: linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use kfree() instead of kvfree() to free super in
read_raw_super_block() because the memory is allocated with
kzalloc() in the function.

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8a9955902d84..9a3c8eba37e2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3130,7 +3130,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
 
 	/* No valid superblock */
 	if (!*raw_super)
-		kvfree(super);
+		kfree(super);
 	else
 		err = 0;
 
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
