Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558F3EB3659
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Mar 2026 03:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l6lope757wlLud0xnx7cs8+FnPr887EFk+Lg+oOmGdA=; b=eQ4t9dELFA+Jk+dAUS9ATXEnHv
	j9/U90fwkauzTxeUibPNiZ59J8XVYGS1CSAm6s8wKK/yN47XgCJUcxY5Ze41dEGlMMI5knEMSm4PV
	AejcmtQSCBo2BosGsjk0f4ujs2g6Iiev9aQXDC+E/GX49V9fwlq7p2SViwAj2Em96hrw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxG0s-0004c7-Mh;
	Tue, 03 Mar 2026 03:01:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wangqing7171@gmail.com>) id 1vxG0r-0004br-5B
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 03:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=49AvzyqvjUtt+GjtMf6/5Xn8CVn1PNyHLXPdHsLoQZk=; b=ZU3O+aBZomQI+9CA34LuUoReCU
 e7xqly5tdqM6ORCykJBWH9QKhzBu1LxEu9up603GvDl7BAQupVbZU7aM93ux4WFgJ1jmx+DluYBsf
 m5eplcjqqBus0btqZ/R7hRj6R8Rajk3NlVDr6ccblujGYD0n/Vs0KMqrN0VmF5Id4C40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=49AvzyqvjUtt+GjtMf6/5Xn8CVn1PNyHLXPdHsLoQZk=; b=TbtPaVPnEWsOz9/3MWhORODmeN
 4/HsrW2urLqg+rqTd7Lr7PMp/v6x9x++GWxaqezknGDxW3FXY2HpTlCpUqRAFQfSdc5/FBuZbMGrH
 G3KCNc0Iporf0q7nPH/fqFiWoZ65Gb/fluTbZbl0Vx7laFU0RU3yyAQAlRcZImJUTB6c=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxG0r-0004Lz-KC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 03:01:33 +0000
Received: by mail-pl1-f195.google.com with SMTP id
 d9443c01a7336-2aaf59c4f7cso23828325ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Mar 2026 19:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772506888; x=1773111688; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=49AvzyqvjUtt+GjtMf6/5Xn8CVn1PNyHLXPdHsLoQZk=;
 b=jesv5e08WRaSkIQk/I9a09Egm4pJHXWLC4tio7ODDqqCT+XzwnlKa1VNQrYVVSdHMw
 pDnu7QtzQYfFJzBAxRAaCQd7Ofc3ZD95WisOzk35jSHNOQcx4YThdX0zg8NbvCcy9r9o
 Skf5dbhXdyHuf2NdELjVKqBpShJnorYGr9pkUsyRH2ldoj+j24IMeQNckcCvjYtwx/BU
 dnGmLh+LlSTLtrqqnwHDNJVRiR0aAVO7nFH3E/smotMDrQjopGzkZkfiNh4oxjxPTAyY
 0vvx/IZ11oQczhtr3cBaNpBAocPEHiOjRjSYVhL1V/rnjdQOFhRyZ1Azuz/v6Ss30AhS
 crLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772506888; x=1773111688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=49AvzyqvjUtt+GjtMf6/5Xn8CVn1PNyHLXPdHsLoQZk=;
 b=hJxcmnoHD+/IhpsdKQnDfQm3R3nCrzExXsBzsRQaKKu2lH0WtrlAjfhIFtgRVn2lEk
 QoCSNRT50CtTM57lJEs94z08Ncntul8rYWaF3FBPmJvmXPqkWsgLEA5iFikN33SbXirx
 ku78e9y3m3abHScXxdI01RUhOTScQAphOGzhHilq5SqO7/e/DQrFzbe/nRIz/3S6xfho
 aKwWZSdU01SSaboMovr2nqDXLqIbQMdI7AzVHl8mm8xd3Ef0+Y4AkBv7L8yq+vs7lVcZ
 tqHGMwj7LeZLyX6jM5beRQ7nXd2FMnKn/299bF0m2VGuttpHpUfxp351Yq5x/6MvdQwN
 nbxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFckIhtTyAKBMbbEydD5fJW30zr0Bb2u1T7ISHWMK++jRweFfKJmu8Oy3RUIa9Eej7T9OS/ji+GwBXcdfVP8rr@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyptIgTqMseDt+6O/ujX0TAWZQ3m+ZoBz985KHFz8ubkmCw1Rf5
 t3LCMX1LEbo415VcdF7RjNL5Qcv5akHl6Oui35twpHJ17fedwPK4XKLL
X-Gm-Gg: ATEYQzxl4w1hxM564J+SPnd1JWgY5v2UP1n3CDr8JB3ozPYI5WJ+L+MvvvwRPaTMD3C
 xAx5xEV15mgY+8FsESK9kEMpnWhMNGlSQCHgSVTeM8+WxuJ9EfuIkHENzgqazjN+jQQOVKkg9SD
 SQ+TXBYYPA2S5IlrZpsSUBS1NNA1cLqUoZmmvpO3lCY8jiNbMBjp0ota0lZ7ASswxFRPBgD9hn0
 s4V6daCCtvpd+qNfDLnMk+ywN11ISUc/coAaAkVF9j55ag8HNwHbI7Y7tHNoaiPKroAEbIgJ2UI
 r0/vgTInZ6Dl+yzGATbx93Lz82ZufqDg3tX8lS6WypXEhD4Xt/FRBZwezhMHy2Kqdaf486osgUS
 RJKymtcMs2gY/UAYK7jBkAAKce1gCnNeuHaDWL/69HcMrcp5ipotiGDg8FaVXGZkcbLRp3No6Mu
 KRpANKRX//qzDZAEWEhwrB9vfHaChzuqRaApAV8JSXa1SoobJW4+tpJd0=
X-Received: by 2002:a17:903:1a06:b0:2ae:567f:fd8b with SMTP id
 d9443c01a7336-2ae56800204mr42534725ad.10.1772506887856; 
 Mon, 02 Mar 2026 19:01:27 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfab58c4asm163755395ad.0.2026.03.02.19.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 19:01:27 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+6e4cb1cac5efc96ea0ca@syzkaller.appspotmail.com
Date: Tue,  3 Mar 2026 11:01:21 +0800
Message-Id: <20260303030121.3626665-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <699a2e3f.050a0220.340abe.0d2a.GAE@google.com>
References: <699a2e3f.050a0220.340abe.0d2a.GAE@google.com>
MIME-Version: 1.0
X-Headers-End: 1vxG0r-0004Lz-KC
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] general protection fault in
 f2fs_in_warm_node_list
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
Cc: jaegeuk@kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

#syz test

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 338df7a2aea6..e2b751944c1d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -397,7 +397,7 @@ static void f2fs_write_end_io(struct bio *bio)
 				wq_has_sleeper(&sbi->cp_wait))
 			wake_up(&sbi->cp_wait);
 
-		if (f2fs_in_warm_node_list(sbi, folio))
+		if (sbi->node_inode && f2fs_in_warm_node_list(sbi, folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
