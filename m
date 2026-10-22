Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CFB606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RLu7zxpj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g4glNYqD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l1fd+Z2y;
	dkim=neutral header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=YprDm0M7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=cpH/j5Hha6l8Xc/UobEZKU4Cba3EUcMYuaN03MJU8ns=; b=RLu7zxpjpoCfCPkrqyRPw6shXn
	8x4mdFE0aH5KLdWI4lgA6QmYpV1E+hYWuMlUUho7FRCUflR6J8WJQCzmfZfBxFaYeOCsgX8YzKPIp
	MDJJJh+qlAIutE6XUhaGa/MLDhL5aGUWNr80w6XBkzyumKfheIOn/3net78cVqBnXyhw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJlOb-0000000049F-0XzN;
	Thu, 22 Oct 2026 05:31:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao@126.com>) id 1xJlOY-00000000496-1eR3
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 05:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=G9kPqGb8yTwic8AFEFdkSNrD228AcoyDeb4bve6kiw4=; b=g4glNYqD1W4D
 tSWwiazBMUlk34NLwLDKxaVErYVi0B/nTAuYBqpekpArvNSxve6n9iSjOWal3dTWfawmtk3pGJGeP
 QREDA0a5HBZtcFON0Ld+30l43HSuOQ9dhHq7uM4oA5wfxPXP6wqpMPfZVnzKmrKx0B+59D1L+H64o
 KFSpk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G9kPqGb8yTwic8AFEFdkSNrD228AcoyDeb4bve6kiw4=; b=l1fd+Z2yd9+ySuz59Dsw9IbdNn
 Fzrs7XfRJ/KbYjWsEGFosaiEfj2zqdpzZgxwpvWWaxLkNeAbi/XiRIHDiQcaIFj2Gp2VMc0Q4zriV
 NaOZHsF/on/20tscyhYjLp3K17iqOGoye/wBdlVNSgOwzRZ0R5XcY216It8MC1gBOeak=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJlOT-000000001NJ-3bgO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 05:31:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=G9kPqGb8yTwic8AFEFdkSNrD228AcoyDeb4bve6kiw4=; b=Y
 prDm0M7rdKhb7lWolggVpMnhha0YcKwIcrLRnC6Nk99k/hAculb/uGCHQxBQkPGq
 JQI/fAqksmyj0j4fX5aWCePYAk/KzfKW/XXU/mBifqD2ueAaypaWTBy1Y1Zu79VN
 jRNWUfOKlenTHVL3hxfGA/iUUl/iPzf0GCvp+JFJVY=
Date: Thu, 22 Oct 2026 13:30:42 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <atY1gNfX9Lhg3zC6@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
 <63e416aa.2fb2.1a13d9f3491.Coremail.nzzhao@126.com>
 <atD9Csw1-lj5_SR_@google.com> <atFFXafuVyyimmUk@google.com>
 <15373a26.1e3d.1a1494e8d1a.Coremail.nzzhao@126.com>
 <atY1gNfX9Lhg3zC6@google.com>
X-NTES-SC: AL_Qu2SAPqfuEgv5CCeY+kdmEoVj+o8Xsaxs/8g2YJSc8gOtgfUwzsQWHZeElbTwO69ABq9sQGSYCZS08NTWLJT60AsczzUxNuhu9GFt67lOg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <36f5c73d.3a87.1a162171418.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cSkvCgD3H76Cn9lqbzZUAA--.58994W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowIZ6GrZn4JAFgAA3o
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJlOT-000000001NJ-3bgO
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>
>I'm testing the kernel on my primary phone. After applying the latest ones
>again, I haven't hit the panic yet. So, could you please send v6? Then, I'll
>reapply all and keep testing.
>

I  have just fetched newest dev-test branch and dev branch, I see on dev-test branch
you have already applied my v5 patches, so should I send a complete v6 patches
to a different branch. or I send the changes to patch v5 on dev-test?

Thanks,
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
