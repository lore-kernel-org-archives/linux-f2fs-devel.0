Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C0ECA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cB7tCBOIVGPrBW3g0h0rUaJIe0jYzMj3NWSNYiTd/sE=; b=KOS1IaIlzf18rhJ8MhtRlg/r66
	LEU3JynT0DRDbMRM2zalwW8wXP73IHTzrOrIoUzJvhilmTL4KD+k+MtVZdHmjJjhIraTGNBdLANOJ
	brllh8X6IfuS0JHnlPtb2tr2qLaJXATxygwvMur+o1mv3h3XprjyXpGr8dmFxXpsUwYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGChx-00046D-8Y;
	Mon, 12 Oct 2026 09:52:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xGChw-00045w-G1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vi1ALl7kg2UrCvpyRmaj8txmtK4YxEiunv813XtuRmM=; b=c+DjZHUa4oxSitunkHRmbJbA+U
 ZMt7V076WHFTmeP7Znuhmm2hk3Cm2S2seerbYH2Fr4cm4hIwdGvyDdurB6rnSeFNTdmUBBH00kER1
 BLxKlDAnvj5EBrCqBguOXWQfPkRo6ELqptkDJ0vkOtpefeBp8i7mu/vQf3tzXEBN3SA4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vi1ALl7kg2UrCvpyRmaj8txmtK4YxEiunv813XtuRmM=; b=d9nQToYiQzIutc/T5VS73NjaxP
 RrraviK5UVxygFv1Xfkg22kr4FDT5lTp5oVpua3JGEAO/574KPo1ksJaUEjYqfPLgNTBa9cFk4y+K
 wYZQ9hPFHc6H+qtfAr7SVj24Ou+fv3Moowf7Ys2u9ajmUmL3EwiwbJqQuqvnYQTAy94A=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGCht-0006IB-LN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:52:33 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2e831e86ebfso8729055ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791798748; x=1792403548; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vi1ALl7kg2UrCvpyRmaj8txmtK4YxEiunv813XtuRmM=;
 b=r+3DBaLw6NGHvV3cjK89OAE2f0OmWvVFgBR5ZLHpEklF6KaH+i3Qq7ipXrnVBvIKBl
 bd06/51qxk5x8wgTMzbrZFon50VkgDQKchvFSx/QnQShutZAODMRPMXTjhzEQwHqKafE
 qN9SePwaHB0LhJD2hubfEA5sqw6f52mUpZwrH0WRIC3G+IAHYhVdizTkdGCZiP8NAa3a
 +L2vvVWelypqhFoPtprJW+zRtX0Hy4ZHnUYpOXlcTLZHOk7KeCwReMW7hE1pvLFtz+tJ
 gVz+7qR/rSicVi+yl+XJ4iT21p5tKTDtkzpaC5IKI0XPZb6pH0km153B7J8G2OnFC1vt
 Gr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798748; x=1792403548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vi1ALl7kg2UrCvpyRmaj8txmtK4YxEiunv813XtuRmM=;
 b=zmORjHK2kD+G4WRZGAUJz8zpNcmk3kCD4T7uahZ+HZjbautwDgFVYDZrqBfkOmRzWg
 vEZkdY8RuBpqLWpHfEhd/E2Jt5pCrQC5rScYg5RXHtYp0EUfqLxjkhU48yW/UjSob8fp
 FQpOnJGMiYtzin1FxC8aNoPfgKw6R9zT55I06LQZkawmvrAd7U3moGz/QaX9u4Y8fkAL
 s94IS9aKxQiAfdPeBQAs1pA3yqGxVQDr6BNB3DO1FrvmnqQYzlhwT6lVeO6XMkmZE83S
 LwVcvNB1mW74cS7erz7IC1RuwVocPCGvkCj0maG0FIbO7E0sjcS/P2xPO6bNGkUejI8e
 9CPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtauOM6bVwNH80xcWDqTAsU9kgGtYQQcfcXSeMRc3ZipIzakEcF29omc9cUx9+IMoxKOQAXX7UQ9Tsht2ouFGU@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLtcDVkiGVDxCrJhDmeLnMaXDITbrcyTe/W/UOjvsflGc2pKzLd
 PlDtgiWGk4WIfjA6rxsHYscP/evgOZq3OewWkesfl2hmbVOcpOOUVO0Bwu1QJteN
X-Gm-Gg: AYBFou18tRkInOwLqBxtUFyE8sfO/YmWodegHHjD9659F/yqxNWH5//reNwm0K6+8wM
 JY2XXgaTnNMPoyOEr/XfZGN09W872RCSon5NUDKt3MAVy1QcTV6EiZZApuLPyerRABgYPnC6+To
 2wvRDcqlFgZjrYSSea2ctbdnX6UtQGr2U9G60PcA4ZLqSLRaUEgI2abQ6TyCqoUsTqA9nKnPQjT
 six2gfLlbcfPCunTx8rJL7prEpnRtOavjvR2sTQ9LKFDUPPBdrB81svss9het5ZyRQcXu+gU1oL
 5mA/03lwNQ8/Txb7xvRfMuNMfLb4rpGsl4j7q/B16gP3xi5ejBsfPiydFmfmp1H3GbdUSldraPf
 uuSHJ+z782rF9Agw/B6YlduekcjzQQrinU6eDlwsAxa15cCm0J0UaRhZKMTK6LQJ4949AjbfukE
 5EyDAHPxxYAeaaVTQ0lpeUH3SSASH4jGQVjGaOtNiA+UaxUbfjb7O8QYI9L0vtEhKXcoQ5UiP5a
 s1bHXs0Ljp8HTFXkwQ8ZgD3vBeZvZMlwfd2Mo+IHlNs4Q==
X-Received: by 2002:a17:902:e849:b0:2e8:4ef1:6fd8 with SMTP id
 d9443c01a7336-2e84ef177e6mr69032995ad.60.1791798747897; 
 Mon, 12 Oct 2026 02:52:27 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8419ff572sm41045275ad.2.2026.10.12.02.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 02:52:26 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon, 12 Oct 2026 17:52:17 +0800
Message-ID: <20261012095217.1744886-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012091737.308136-1-chao@kernel.org>
References: <20261012091737.308136-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xGCht-0006IB-LN
Subject: Re: [f2fs-dev] [PATCH v3 3/5] f2fs: cache: wake up f2fs_writeback
 when exceeding threshold
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> f2fs_writeback won't be woken up unless there are enough dirty caches for
> f2fs_write_{meta,node}_caches() to gather.

The collectable-cache check and no-progress throttling address my concerns.

Reviewed-by: Wenjie Qi <qiwenjie@xiaomi.com>

Best regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
