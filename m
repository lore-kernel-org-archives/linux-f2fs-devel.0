Return-Path: <SRS0=GQ8L=Y7=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F055C5DF60
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:08:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E401E207FA;
	Thu,  7 Nov 2019 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="d/gLnlUX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="HeCbjDYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E401E207FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isd.co.kr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iSjP3-00034X-2z; Thu, 07 Nov 2019 15:08:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <choimj@isd.co.kr>) id 1iSjP1-00034O-CN
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Nov 2019 15:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:Message-ID:To:Reply-To:From:Date:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CjFBLg4feocA67R7Snn9hTAVTjuyOGDS6JZdh5yPjk4=; b=d/gLnlUXBpX8s21lzRJOCWLfe0
 oOv/9PADgEX+PLmLtJXsBmlB64yYrC0i+SztV0b9Q/S6FgfjgAw8JEJPhVWX0Tc0WTRLMwcoj11Ni
 AkfvcrTRn/H/mfB0ypNVqB+6C9pdodGuJ634YE5AaF1faw9iX8uXeTgdajtrgrJttnIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Message-ID:To
 :Reply-To:From:Date:Sender:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CjFBLg4feocA67R7Snn9hTAVTjuyOGDS6JZdh5yPjk4=; b=H
 eCbjDYmpkbPEZiVqYXvSf7ij4kUL6MqjIKJBlVHQY2KSr7zB8gneHGgsagA4dB7KMWoy8lc4kTam4
 nO9nhcgZZZihnVLoTuwDYahV24vuyRbwpgETsPUmiWNKVkoE8jrU8OF4S3cfYdMHhHV5KBDQVj+36
 m3gYrzrQHzfR/Mqc=;
Received: from [211.53.128.215] (helo=MAIL.isd.co.kr)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1:ECDHE-RSA-AES256-SHA:256) (Exim 4.92.2) id 1iSjP0-003rTL-3x
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Nov 2019 15:08:51 +0000
Received: from 192.168.1.3 (217.217.179.17) by MAIL.isd.co.kr (10.10.10.22)
 with Microsoft SMTP Server id 14.3.123.3; Fri, 8 Nov 2019 00:08:15 +0900
Date: Thu, 7 Nov 2019 16:08:14 +0100
From: Peter Wong <choimj@isd.co.kr>
To: <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <18651058.22534.1573139296110.JavaMail.cash@211.53.128.215>
MIME-Version: 1.0
X-Originating-IP: [217.217.179.17]
X-Headers-End: 1iSjP0-003rTL-3x
Subject: [f2fs-dev] Investment opportunity
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
Reply-To: Peter Wong <pw178483@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Greetings,

Find attached email very confidential. reply for more details

Thanks.
Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
