Return-Path: <SRS0=xc4u=BJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_40,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A03DC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:20:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAED220829;
	Thu, 30 Jul 2020 19:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="m4KkTyss";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="boQBLaVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAED220829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirdoraghi.ir
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k1E6K-0003dE-1J; Thu, 30 Jul 2020 19:20:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sm@mirdoraghi.ir>) id 1k1E6J-0003d7-2a
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jul 2020 19:20:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Reply-To:Date:From:To:Subject:Content-Description:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Message-ID:Cc:
 Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:
 Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2sUyHyMlYiY+SqcgExGcb1cT8rLtpfsXc+JnPDKJmQ=; b=m4KkTyssizlF9Velre5/+sI9pl
 yun/ZiAxLRt3qDFb1rRz5H48RufQg4BNktwDeQBlXUDVfmwv+dqXKmqOUr+phVa/UWbPVnH4AGDBJ
 5DakrP9dX6vlHQz8pkCl222ool6U4VzP5XkO21XYugMQfOqQh0FKeStRH0HiVN6G9bVc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Reply-To:Date:From:To:Subject:Content-Description:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Message-ID:Cc:
 Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:
 Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x2sUyHyMlYiY+SqcgExGcb1cT8rLtpfsXc+JnPDKJmQ=; b=boQBLaVj2FDhRiEKRNpRc6KQZa
 DkwWgXn4dWTOE9PGflvboMhQbyC3OlToicGhWlFQffRp5sKX0YjUgn/dpKF6tIo5M4Dy2x2WEc2ir
 Uqc38QAoKGAFcj4aXmK2BQwlfm+0rGUl7N4eAIA8BuzTbHBgR2dMgtM0JRpb/grd+azI=;
Received: from static.76.64.203.116.clients.your-server.de ([116.203.64.76]
 helo=mirdoraghi.ir) by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k1E6H-00F4mN-PG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Jul 2020 19:20:23 +0000
Received: from [172.20.10.3] (128.80.136.77.rev.sfr.net [77.136.80.128])
 by mirdoraghi.ir (Postfix) with ESMTPA id D59BDAB9CF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2020 20:42:29 +0200 (CEST)
MIME-Version: 1.0
Content-Description: Mail message body
To: linux-f2fs-devel@lists.sourceforge.net
From: "James kenneth" <sm@mirdoraghi.ir>
Date: Thu, 30 Jul 2020 20:42:29 +0200
X-Antivirus: Avast (VPS 200730-2, 30/07/2020), Outbound message
X-Antivirus-Status: Clean
X-Headers-End: 1k1E6H-00F4mN-PG
Subject: [f2fs-dev] BUSINESS PROPOSAL
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
Reply-To: trustfinance1994@outlook.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-Id: <E1k1E6K-0003dE-1J@sfs-ml-1.v29.lw.sourceforge.com>

Hello, =

     Apply for a loan, at a 3% interest rate.

    Do you need a personal loan?
    Do you need a business loan?
    Do you need a consolidation loan? =

    Do you need a secure loan?
    Do you need an unsecured loan?
    Do you need a mortgage loan?
    Do you need a pay off debt loan?
    Do you need a project loan?
    Do you need a student loan?
       =

Whatever loan that you are looking for, kindly send us a mail:  (trustfinan=
ce1994@outlook.com)

Mr. James kenneth
Managing Director

-- =

L'absence de virus dans ce courrier =E9lectronique a =E9t=E9 v=E9rifi=E9e p=
ar le logiciel antivirus Avast.
https://www.avast.com/antivirus



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
