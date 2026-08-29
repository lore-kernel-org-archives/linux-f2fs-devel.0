Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB5CC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ae3dTxD87yp0LJR1TKyUx65zPcqyQNAPc3UpzQ723ds=; b=lnANvPsVJVJbhod83f68fhKfkN
	XnZhsxjBBgqIRvGWa7SpJLUz9jMZoga4ywc/bwOHmC5Ibp3mF3VrYyBadmI53H2o3lAHH2XmMrp38
	9ROClMLyFuvfzH1/rueHObxTrOZaNnbANHKoSyeiLxrdIjbo16FwXurFTI9syGNq2Cm4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x09b6-0002BI-5J;
	Sat, 29 Aug 2026 03:19:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x09aj-0002AW-Im
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 03:18:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fDRcPM5YI9tzjDCrA29/HrBa7jhW5uBaeCuSodJeNRg=; b=EdswrQPlEhVJeuteEz25P6yUjB
 UH2UsyXgzB+XnsklEpeXZqya9T1VnE38P5mRcG7imPymMzmNxnOZSVtcsVldczvy3wY5y5ZoCxgiy
 jDSAoIM2NR2RdjME0Ld6m8Cfm7hMQWOvzuvabgwanfl2H1/JThfRJmG4xbezCUxTw3ww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fDRcPM5YI9tzjDCrA29/HrBa7jhW5uBaeCuSodJeNRg=; b=fMJwANSq2tMhMKBIQzlqF0lQRJ
 ob1THU4KNgnpxAzMntNtDMVIRTQt1qTvPx44D/XUpTKZ2ZoSH0g7CM0lJoRbqhUXjAHR5ed1TxyDv
 0qjYixnZcarnluFgwq6rlPhPIqgF78ECI8UdfCJEMS09wtczuxPA94VbEQY6OeMq8+Co=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x09ac-0008By-Bk for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 03:18:42 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1530149a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 20:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787973516; x=1788578316; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fDRcPM5YI9tzjDCrA29/HrBa7jhW5uBaeCuSodJeNRg=;
 b=SvyGVTbanTRw/qXFUVBsbj8WgWtURjdrfMcwWuJEX94Hen0t3ALR6Mt04ZLLkeOUrF
 PUWSWEW8zuUjOlQyucc58Vf9/Kq5Zx8Pd5teR57X9o//lLWOsJLg9Q4mnSonmrwdO34G
 PwfZksUDKumky07SxOMVjbZcAPA3/bgfgu+hgVbu60hCjCrhZDmMrtfYc5X5N8XfQejZ
 NQJonQnmjF51seds2cl9ktaieAloV4pOqu33eYyfX64ihFmYX/QK5SrkU4HVkkQc3rxG
 zjTKfEOnb1UDcvIJ5Hw3sF0hg6pS1GHuYTC59ZDXOXBm+kUq5x1Nx8IXOIln5rf8wqeS
 IH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787973516; x=1788578316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fDRcPM5YI9tzjDCrA29/HrBa7jhW5uBaeCuSodJeNRg=;
 b=pH1l9UGdljCkFKbYjL+iHAA+WOjvGOKzBGMsq4o5qLH9eqe15tMSOEWfhNq1nMp8qZ
 16aYrnBdTreVjdVta2gL2yREPh27I2rnI+CPlfkjKMs+hNnS38upTUm/oyfykNgNTQiR
 mw2f/qE7HAwCdIPltlYQm3D02RfKKXXu/DTM9S08zfwv09ceHVQp1b0xfvGrBVz6FD9s
 heV1cl2kTxx1E5TDlh+i8l2lB61byThNztRUSiBU8rA/2Wu8J17bUXRR6GBrDu66eyfI
 km1spfRpjndfm7XblcFl+sOEfQiVGQeqwXXrFVGVJgk17KhXrYjhJlNIhf9onxnJOdH3
 HpFg==
X-Forwarded-Encrypted: i=1;
 AKwUvByzeHbOzGwHfTmZyvE0T6mfUIYNXZ7nzFa7mPL2KgSbZ6eTIkzdKz51zvFJyrydPltcBCaxHoduLG882rtKtajh@lists.sourceforge.net
X-Gm-Message-State: AFuF++n1dl8rmLossGaAni/0VL1Lri26oiDoFTApGHUhMS8awjCbm1Rv
 pCTx+rSn3dhK51SH9OBdCLwZc98MI8gHGHC8XT5gffFdCqRp6DZCcvZ/
X-Gm-Gg: AYBFou2H49SpiqPEgq8psFGNB3QQKP63L6wUELqPCCoK2TjMtn98E7eOvcq3sgbtIQo
 kXXG68A35cb4GKNSnc4P9Eytn+kC1NAwMQ7F8SNb352AQPI4Cl3ZJ+v3bBNPOYxj52xpgHpVqK6
 09DV2BbqA/2iekRlt/T6YAOEwoteJyzwzThBZ1YMTXwIGLLtXmWcJy07WsJDQDz0IgzbsRgE67V
 bOLUxCXKpnh5TyBE4L4x5cyWG8Jhr0ggg9Q05GXDfVWnxVCukS2WS2h8cm29jPjrGqMkwpyx6Ee
 mKpP/hC5y+dd11AZQXsNbUeTMBgKrlvxtMMnnN5oaNSq5si/GZxrP0LrGP2d0uHVGTXE6Hw+OOm
 H0HXwEfyQLDhJvv3L0J0mAmhkfI0pJZc/r1BCku/2h/r01cCX58u0mVNmYIOu/6VBLnoLYJWa7l
 GkPzkwfihd4bPtLTN9GwckQtlWkMUDxGyCyNGHpNblK+LO2PtDoXBahOziT9Auo4wfomePiMvqH
 6PbSTpW+ZWVs97uP31rti4Vsw==
X-Received: by 2002:a17:90b:4ad2:b0:383:f52b:d616 with SMTP id
 98e67ed59e1d1-396d0fd53afmr16634286a91.10.1787973516489; 
 Fri, 28 Aug 2026 20:18:36 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186803asm9642134a91.11.2026.08.28.20.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 20:18:36 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Sat, 29 Aug 2026 11:18:29 +0800
Message-ID: <20260829031829.2581587-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_x5wNWf6s7j9FBrC5P28c__UiN9kw6mDvqVGgZZCk-ruA@mail.gmail.com>
References: <20260828114125.637513-1-qiwenjie@xiaomi.com>
 <CACOAw_x5wNWf6s7j9FBrC5P28c__UiN9kw6mDvqVGgZZCk-ruA@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x09ac-0008By-Bk
Subject: Re: [f2fs-dev] [PATCH] f2fs: sync pending discards before reserving
 device alias
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Thanks for the review.

I agree that walking the range block by block is too expensive. I have
reworked v3 to walk overlapping discard commands, cancel prepared
intervals in bulk, and wait for each submitted command only once.

Regarding the synchronization point, my understanding of the documented
ownership model is:

- reserve: In-service to Aliased, handing the range to external use
- release: Aliased to In-service, returning the range to F2FS allocation

Therefore, external raw-device I/O should stop before release and start
again only after reserve succeeds. While the range is released and owned
by F2FS, normal block allocation already waits for a pending discard
before reusing each block.

Also, cleaning the range only after the release checkpoint would not
cover new discard commands generated while F2FS owns the range before a
later reserve. For that reason, v3 keeps the final range synchronization
under sentry_lock at the reserve boundary, before marking the range
valid.

I have sent v3 separately with the command-range implementation. Does
this match the intended ownership contract?

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
