Return-Path: <SRS0=mQF5=BC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB1AC433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Jul 2020 19:49:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E735420792;
	Thu, 23 Jul 2020 19:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kL47Yx+1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LzjhAug6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E735420792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=znettelecom.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jyhDZ-0003iw-WA; Thu, 23 Jul 2020 19:49:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <alan@znettelecom.net>) id 1jyhDG-0003hA-Sh
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jul 2020 19:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Reply-To:Date:From:To:Subject:
 Content-Description:Content-Transfer-Encoding:MIME-Version:Content-Type:
 Sender:Cc:Content-ID:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9tIMcEygfbOkXX3UIRIrIuxLq956c/H+fUD3r1Mbpqk=; b=kL47Yx+1BP34PM+KbIdKC/p3LN
 hY+Zx/DO/9itvxmjQzeKAINwsOBIzLkRHyxOqa7eqazqR11kCcSLVoXwSdmslH6Umm94SBklL0qZg
 0b0eYoyIB+95hYQqI/1RVu1MEl3dpJlV19t2Zdwbm240GxghOswqcZBX+galBisDj0L8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Reply-To:Date:From:To:Subject:Content-Description:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Cc:Content-ID:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9tIMcEygfbOkXX3UIRIrIuxLq956c/H+fUD3r1Mbpqk=; b=LzjhAug6JviYcVLLTZrnRy2wdq
 bElNyraVm/MRgZF0u9LZVU998p+1BQmIXyqnY2vO17paSy38lPBVYkdFtC4v8m3DpQOIl9q5Lm6oa
 RJA6UKQZvuC8usZZ6uTzFjzRMsa4+GiU3okgz2dNmT8ans26yjw2CZC0bnRByqP9QNY0=;
Received: from [187.0.30.10] (helo=srv01.znettelecom.net)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jyhDF-006gWQ-PO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jul 2020 19:49:06 +0000
Received: from 131.205.136.77.rev.sfr.net ([77.136.205.131] helo=[172.20.10.2])
 by srv01.znettelecom.net with esmtpa (Exim 4.92.2)
 (envelope-from <alan@znettelecom.net>) id 1jyhD9-0008SY-14
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 23 Jul 2020 16:48:59 -0300
MIME-Version: 1.0
Content-Description: Mail message body
To: linux-f2fs-devel@lists.sourceforge.net
From: "Steve lenka" <alan@znettelecom.net>
Date: Thu, 23 Jul 2020 21:48:56 +0200
X-Antivirus: Avast (VPS 200723-2, 23/07/2020), Outbound message
X-Antivirus-Status: Clean
Message-Id: <E1jyhD9-0008SY-14@srv01.znettelecom.net>
X-Headers-End: 1jyhDF-006gWQ-PO
Subject: [f2fs-dev] DONATION OFFER
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
Reply-To: stevelenkathomson12@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello, Donation of 1,000,000.00 GBP given to you by Steve & Lenka Thomson, =
This is to help fight against Corona Virus and help the poor people off the=
 streets. send email for more details: stevelenkathomson12@gmail.com
Steve & Lenka Thomson

-- =

L'absence de virus dans ce courrier =E9lectronique a =E9t=E9 v=E9rifi=E9e p=
ar le logiciel antivirus Avast.
https://www.avast.com/antivirus



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
