Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99666CA5FF1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePAxaOWRZJZ1fEhTra4PfDmnEhOjKPtnqkxx9e2sVGw=; b=QTvC2DB8BMGbtlJS8Q4DhAl0Fh
	FpBskoyD7/W7xVPTtFizrALe/hlcXjpUGtEeLZLhL66h1b/jB14IpCQrPgThuwmlmGltu0d04I6T8
	zUywzZjirwbzANdveu3mXRbSdsGEzsPyeIYwN5z1SKI8RErBpwX/QCo7PDDPwJ0DOavY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xES2x-00079x-Vc;
	Wed, 07 Oct 2026 13:51:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xES2h-00079X-Cm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 13:50:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3UGhbs4zr6z/qCcIMYIoLlLWY2LlCY3/3Pv3DbDqvo4=; b=bTwA+k1e8za54yJRB9jGqyDHzn
 w5fl34ZsoTfnjcy0y/kgV9eY0WPM6ec4C6NH/OgNCTX1UcQC5THIUJAsMOBTSnWn3RSBbi0km2GOd
 N1/WLvHv3544zl5NSINquj4QqOxFfEMpSTunqFdcbLPhjXOH4MBUXn+8I3bxUk7jQE6c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3UGhbs4zr6z/qCcIMYIoLlLWY2LlCY3/3Pv3DbDqvo4=; b=XTHISq0F2rbBCTDHEtAzPTFHJ5
 +mm5Eo+7gm5Xd0wj60c3Wwk6p/VN5PXFWO5yUJxr0BdtHWd681u0e9GArAvmKRsCNWe5h04pzuoHp
 lEiDjfDrXyOXJlOUvpxcaKooVgUYDvLjcw2fdonjgUkbtWiIlrA+KwvwVCmi0YhkdoaM=;
Received: from mail-yx1-f46.google.com ([74.125.224.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xES2f-0003yH-SR for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 13:50:47 +0000
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-677bc4704cbso1982103d50.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 06:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791381040; cv=none;
 d=google.com; s=arc-20260327;
 b=la9D3616kWJwf1s2dxLBdnHjzlqo/L0cC/9YBtYU+SuIC0vLHRKpIe/KcfpN0dIMWY
 KtRS/L8pTAO3BJnZdCtKwtyCaBkEurM19oaD+JpW3EQGo/VsCurLHirmOV12uiGanv4b
 calf/TXbx/Z+E9Sy9n0fVZrJ0cidRNyyV3OLoiPDdJaOuSjE6By2fSIzzu6QSYXP220j
 THJ9ZukYLI8CXntRpMtFRN9YXB/u3pFDFkUyEnYsJakphGMq9FUnlxAXIC1s9HNrJfa8
 zjJ48bvvsGiZmkBQoSd5Srrqw9WRfgT1xoz5NJorgDk+LjtVeTX9l0Yuss3xH5ZofQFN
 aRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3UGhbs4zr6z/qCcIMYIoLlLWY2LlCY3/3Pv3DbDqvo4=;
 fh=PZv0uNfbV/I58NrfUqa8lyKMrwyaQm2gDsllxHqgTBY=;
 b=U3jhVNDA6sQ6GoQJLWWpxEjX0kgLMQuYvOGdc04Cyg9cRl/scmpkUF+G9diKk4FeAA
 AhXYVQYl3YzaQkxCAMjv56ohpLLFvZAcjhOtnvoH0FrhN00P2QeiV19iJT5idq/cngFr
 fW4gCYFxxUDzJl4XxhTpDlwyyX1LtkvFYqGVLbXuKdrsxsrWGyMhpK+OnY37LEr71hJs
 kJw52I+mU4Nddfex/5ldBXzBfIJCI2q9CbKfSktt5i1VfqLT5zas4qgQLflQ/JW1KT7R
 hOKBmOqGFY6VCPnh2H+dfn7mMcCv5sPI9eRTVjvaoFXO/T54ZN/EC1vo9Gc3apUAiBPL
 +2Ow==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791381040; x=1791985840; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3UGhbs4zr6z/qCcIMYIoLlLWY2LlCY3/3Pv3DbDqvo4=;
 b=H5mfTJ7ryahvrLlS26ixPChHNl1Mckm5EyHoK3IbmCM97f2lBH3sZnG7dBy/7BkuEo
 fl8ZF0v21IpI4BIF8GfcfrE71yytj3v8licil3oWyHmwVpSK38zo7kQVuVLqt+hfqIPq
 gR+c/a3BBDQ3448sADFoJKqD4ej4gjjrn3DQbkkjT1HZQp5tMC6xZNxa8qplup+fErbL
 QxvbTMJR8nMze3Ng/U3YhGCCzv8uW1KA9RZSYVv3Wrqs/5uRg3wYpxC1pCh6qUHD0Lsh
 Kqgq3cTqsU+/8hC3gqIgIJnlFadVA8KiXRI22tokhYHwcBIGg3neLiq7stUel9KglHCs
 A9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791381040; x=1791985840;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3UGhbs4zr6z/qCcIMYIoLlLWY2LlCY3/3Pv3DbDqvo4=;
 b=2cgIN/41j0UBpfIm+7BUPOH9EsNgN/341qBIQTYvIAgW857U09O8P26nTJN7aPRPKf
 dNweO8RZdSqRGj4a6o9YfCSXhRNZ/IXRnoKWpOjYKlgJCujN1J57goWjArBwIO+6oQsG
 3VTfSItKAdLGZdZ4vNkuu+TpTCzbuJWv7KwmrrVHGatUx70HYH1MiTa6fubQOaneSc1e
 q+I8WJrEbqyrpQdz5wz5XsfnloxCErUC/MY8c/AcJHwCEN4CqU2ueNjFy+NI/xQoPMzI
 7v18rfuJ0KmvfWQ3ogKzTHiyvBGTNQ2LkDSCiyPblEOABCBtsku0ZsygxEeJs81g0aCy
 aAcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxNWxXpbyEw8URP1fdEZJmURAwirwd7kU1jvdaRU/9pIXtGa8+v0J/J3dlYqRpjU2CgJxAPqMiE90k/o4rEcV1q@lists.sourceforge.net
X-Gm-Message-State: AFuF++kSTkitJj4Z8tntuIXjjXKB/3kdM8fheaCdnASL0IA0EAVabosd
 ZjdvQ7W/FvPskeWg0ZOvMDeoAXcBk0HHhUf+xF7GDJeggjIljF4/hnRR95pk3vzesE0mb4ToPSF
 P3HfmlFr3PKd5i9v3o3a9mRIRNE8ZMpA=
X-Gm-Gg: AYBFou3JOUKvL7qKWuNvUncSRK2UHgxPaFtFS3Is3qwQmHhtMvK5Erz0Faq2mkDIs+8
 Ld9+P1IIAzaVYDmukNFqJXXwG7yL06QOIs3mgbei/8ctsANugLsPMh4rFIsihrtLwWxICmlTsTy
 kcQhd9e8KMNyNj2AoLAF4EawsjPD4iv2z0wp8wRYcqrEBIk5Eql2I4dMYWojJre1ZV07BU0pW6P
 /WZelCdWKmVCfjMDOuVvJVd9dh/f+SHuDM1uukfmM9LVuYifX3zxfthp8ZLH48vlBcFUrJyPp7V
 Db97rPFLmdnaMEWf14VsbjmiZwD9V3rdxCb4IiCOxfuYWfnsOKXAp/Eo
X-Received: by 2002:a05:690e:43cf:b0:671:3036:42bf with SMTP id
 956f58d0204a3-6790a46d435mr920875d50.91.1791381040024; Wed, 07 Oct 2026
 06:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20261007101738.2348038-1-chao@kernel.org>
In-Reply-To: <20261007101738.2348038-1-chao@kernel.org>
From: Seongjae Jeong <jsjlee1020@gmail.com>
Date: Wed, 7 Oct 2026 22:50:26 +0900
X-Gm-Features: AclHuK8iLlp_mGHrnQ4QBr8yOqenUzJM8SlRn46iAkR23qTM5t0Rqo9YKwo6vvE
Message-ID: <CAPHXVrwF0cCtO8G4+bFUJFtM8ptC+5dNxPBx=CooiW6n-2LJGQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xES2f-0003yH-SR
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: skip node_change lock for
 inline data writes"
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Sorry I missed this case.
Thanks for catching this and for the detailed explanation.
I agree with the revert patch.

Thanks,
Seongjae


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
