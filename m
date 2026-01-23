Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3705D6CFDC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rq1sezLNO2X2eqT/kpyM/kn47S4rGQ10RYcY8SHF7BI=; b=VwQI95yQSx/ILyozr0Oa/VFAkQ
	e1E21CDle4S0RoEmOA/BHE1J+MfehmO68MnRlHpaG/My3wM07U12lybKjmBx9Uteis3YTorzFEVVY
	cl3ryyJZ/AsKlw/Jx0ur+dp6x3e4XCawWIpwJy/M1aeHQIPY7dBZ559sGlSgaqL5vS2Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjAh4-0004Mm-9I;
	Fri, 23 Jan 2026 06:30:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vjAh3-0004Mc-Kk
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 06:30:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X0AUgm60OdLFgZKhC/GX3rR3b1y9H+0o5ZFYifDgKPk=; b=JKch6AKE6nMOUZ7V6MaQwTvOYc
 ryA+lykuV5EfHkCLlm1acnp24mIBPp0EUJ/mbzSEgoGYCu1vYj7ENajUMdKF60JCbQD9c/Vi1ImJM
 N+taQNd7IYELlglP7N9dbDd0laXpCt0BT1OTEZ6j3Nzl6sGd7XR5qOb03mcw2CKsRv8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X0AUgm60OdLFgZKhC/GX3rR3b1y9H+0o5ZFYifDgKPk=; b=HTlvNAGG1Mev0+9WjFUN0f3dON
 SSjIzklEqiLsVXSkO1z6OJ24s+P9cS7gZ1zZ/2PNO+L+7ubPghz/JbHiKechMp8JI/hl/UBNkdX67
 el4v7y7xxlDx2jKPz9icN4+XMlJdJuB97EgU2mEjJMC2lW38bScK02rzIy0J0WWqdpIM=;
Received: from m16.mail.126.com ([220.197.31.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vjAh3-0000cB-Iw for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 06:30:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=X0AUgm60OdLFgZKhC/GX3rR3b1y9H+0o5ZFYifDgKPk=; b=o
 NIksTyKYGJcUqWMfCXrQL+Cf0VW0dSlCwRxmfok3oVL1g65ahl+ym/g/uWTDPzir
 iSQ+0TXgpd4qDBXpEIbjBrF/Zq9E9J/z5d04NZ2Ac+rkgex9PxElb9JD2X08TxLM
 /SKxlIhiQbii/x80fsFvxItuxoMdAtqfh3ikUz9aGc=
Received: from nzzhao$126.com ( [212.135.214.5] ) by
 ajax-webmail-wmsvr-41-118 (Coremail) ; Fri, 23 Jan 2026 14:30:30 +0800
 (CST)
X-Originating-IP: [212.135.214.5]
Date: Fri, 23 Jan 2026 14:30:30 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <aXKuTRfZXE4z0j1_@google.com>
References: <20260109024716.12047-1-chao@kernel.org>
 <CAGsJ_4wjXMXk4YKsYebmtTa5dKVO21b91ieY=foYULWS+DyroQ@mail.gmail.com>
 <2cdd4281-7e37-4dd0-91b1-1ab16ef772aa@kernel.org>
 <CAGsJ_4weE5T1uBA1-JoJdbZY4E91eN_OL3hMdqixLcoKSrmuzw@mail.gmail.com>
 <8c13ca69-a08a-41c7-bbef-0a79a5f44f93@kernel.org>
 <83419982-77ba-4dac-880e-bf59669a006f@126.com>
 <aXKuTRfZXE4z0j1_@google.com>
X-NTES-SC: AL_Qu2dC/2ftkAo5iKZZukfmUgRgOw3XMSyu/oi2o9UO5FwjA/j6BI5XVxgElrb3umJJgCyoRW1cSZu+N1KY6J3eYcJMZRdQ6Y9ywNtus59zSd20A==
MIME-Version: 1.0
Message-ID: <43f34976.480b.19be98c144d.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dikvCgDHf72GFXNpar1KAA--.13341W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsAadbWlzFYYLFQAA3R
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1vjAh3-0000cB-Iw
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to prevent clearing immutable for
 large folio supported inode
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
Cc: Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Kim:
At 2026-01-23 07:10:05, "Jaegeuk Kim" <jaegeuk@kernel.org> wrote:

>
>Yes, I was hitting some issues when I convert the mapping while inode is alive.
>So, for now, we should set it in f2fs_iget() only.
>

What about using mapping_set_xxx functions in f2fs_new_inode  then?
It maybe be a bit odd to me that we create a immutable file but we can
only get large folios for this inode  when the inode is evicted and get
by f2fs_iget again, not get large folios by the first place.

Thanks,
Nanzhe Zhao
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
