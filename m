Return-Path: <SRS0=Qhk5=7L=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA9C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 29 May 2020 13:02:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954162077D;
	Fri, 29 May 2020 13:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Mb4o/IiS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ddyy/eCc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VPm0BQLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954162077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jeef4-0007KZ-Bz; Fri, 29 May 2020 13:02:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <glqhw@qq.com>) id 1jeees-0007IF-5i
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 13:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Date:Content-Transfer-Encoding:
 Content-Type:Mime-Version:Subject:Cc:To:From:References:In-Reply-To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sq0o1mDteowSUKiIVfl/47rUbVaRt3zsm5afYz2ylk0=; b=Mb4o/IiSXyqkDMSpzpyxmSFUGf
 Zw8VFwU+ON73pTknpp3g7bnpEz+3HNwbULiRZQroeEjHwAEQ3zVP/OrjmtT7Fr0wkJNt6fgwOP19G
 Az+knRfl5OxiqEdz73XHwZzcPBS47IzSTm9WTL6cdcUEOW2+uIKWH/lDxkh4bP6U9Krg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Date:Content-Transfer-Encoding:Content-Type:Mime-Version:
 Subject:Cc:To:From:References:In-Reply-To:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Sq0o1mDteowSUKiIVfl/47rUbVaRt3zsm5afYz2ylk0=; b=ddyy/eCc1Kxli+TzQRMhSIXJVI
 VTQGN6S664zW9oTtSsfhu8+tk4Hj0QX4M6FVYqyuOZEPZqjr4e/Yc9Q/SZ1V3yRRPBlRSkH2KEtpq
 E4hga4QeQHSh+3X32kVLfR61RgmE1A5vNjnxeFeHxML/QNjZN/w06rg9Bm/LubsF1iFM=;
Received: from smtpbgbr2.qq.com ([54.207.22.56])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jeeei-00CHkR-HI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 May 2020 13:02:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1590757343; bh=Sq0o1mDteowSUKiIVfl/47rUbVaRt3zsm5afYz2ylk0=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=VPm0BQLmtjGms58XW1SI30oSvmSl+tBCQNpG9apnC/h0wanYKw9NeqNZjxp0GWatk
 nP0yy7WKnduuDXslVBAGl1ROqalrTjUBupRrw0icCuw0uBOrMBiA8WOKwNSHgEOety
 fDfIwxgSnyYx/GYxSRbDaNIkwF8S9wy9OrVT/9XA=
X-QQ-FEAT: EUGmOqWjSYKUah83G8iYmmQRheHW2NhwA2KpwhP44dryceHTPVbaSN+4m0iu6
 U0LEG6NQeX5JvfD360KGi4R+h3rIsgnG5P905CQ5dxEk0TsTtxoINe4hm+rWgoR3fLQheH3
 IA2vedRAwyw7Nu7utHbkMNt7OxcW5Q3lO8rN9LLwie/I5vTKuJ/cW5Z2Bz0YuQW6UPXj5Ab
 Rw4zTT685+VbYNzEIuVvBEpQYfOfISSh7NKqHcbN3JtGlOLcXX8Z9SWeWdy+8ECUfvFE1Oq
 OSSuLk9Z/xDX/Fp+G2DMusjso=
X-QQ-SSF: 00010000000000F000000000000000Z
X-QQ-XMAILINFO: OdPydMBEtEqDUpVkGr6pvBo6gkD+gtCXtenOkA6hXmILpbPltT6/cP/yZkgPWX
 WQPnd7LHMbr+xPWCGT9PoSeP4Dr7Nyzsl+/jh1OyEfrkru66K5GFXwq2I9TIwKJK1cBYgUE4ncMLj
 hK8E5YELsgDZyDO9ZODr+9Wz2kdHIpD6CV+O/x1MFV8FxTEqLLAqXiEbxF/UxCVmcQmfwOrwQ90kv
 7nIT4NLEJESHUIqAXsCwNtNwu9UBs+3J5MEjpIigTJees9A0/KUD9t/fgNee+K82mcdmutIstfyXr
 X7AUEDK1mCT9C/sri/fcP+hjfvpXowOUs91u2n4sSgp5TXrZH9QFbKbjLjHOpUMacsZaFkIh52mPx
 JW77uRT0R7jXtyshej7PGpzaRzRb445MEyWkq3FymKhWv/FtAzVC9RH4v/z9KrUjJK9xtvpKhwszB
 cdtIlfC0gDoPolwIY5whcW5GTRMuRs+xycl29sgW5/sqaKmldMhX1dXjAxzShm42wGU3/dhjR4ehA
 UTQwIWaIV+NDNqiPM03bUZe7iSWRNT0vBkKsA3MbHEgKeKw7UA37Pu2x6hFS0b2Tgkm1Da1pRlkND
 TF90g+EPtfZNhgqF/Qp5/liCATEbEtktaPhgZFiHYmdOLSE/htHo1xcWLxc46tO/fqm/WR8/FhC3c
 5zjr3wnzA9AKSs7YhLkCO8ooVohv7kFBs3orty
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 117.152.160.234
In-Reply-To: <20200528172606.GA153385@google.com>
References: <tencent_DCCAEE9137D2150CB266BD2CF3EDF98A970A@qq.com>
 <20200528172606.GA153385@google.com>
X-QQ-STYLE: 
X-QQ-mid: webmail804t1590757341t8233387
From: "=?ISO-8859-1?B?SG9uZ3dlaQ==?=" <glqhw@qq.com>
To: "=?ISO-8859-1?B?SmFlZ2V1ayBLaW0=?=" <jaegeuk@kernel.org>
Mime-Version: 1.0
Date: Fri, 29 May 2020 21:02:21 +0800
X-Priority: 3
Message-ID: <tencent_2E2E902BD0A10D8A67C92DE7EC6D887BCB0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 2082101295
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 29 May 2020 21:02:22 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
X-Headers-End: 1jeeei-00CHkR-HI
Subject: Re: [f2fs-dev] Can F2FS roll forward after fdatasync()?
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
Cc: =?ISO-8859-1?B?bGludXgtZjJmcy1kZXZlbA==?=
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,
>On 05/28, Hongwei wrote:
>> Hi F2FS experts,
>> As written in f2fs_do_sync_file():
>> "Both of fdatasync() and fsync() are able to be recovered from sudden-power-off."
>>
>> Please consider this workflow:
>> 1. Start atomic write
>> 2. Multiple file writes
>> 3. Commit atomic write
>> 4. fdatasync()
>> 5. Powerloss.
>>
>> In the 4th step, the fdatasync() doesn't wait for node writeback.
>> So we may loss node blocks after powerloss.
>>
>> If the data blocks are persisted but node blocks aren't, can the recovery program recover the transaction?
>
>#3 will guarantee the blocks written by #2. So, if there's no written between #3
>and #4, I think we have nothing to recover.
>Does this make sense to you?

Thanks for your reply. Please consider this:
f2fs_do_sync_file() doesn't wait for node writeback if atomic==1. So it is possible that after #3, node is still writing back.
#4 fdatasync() doesn't wait for node write back either.
Considering node writeback BIO is flagged with PREFLUSH and FUA, it may take a long time to complete.
Therefore, when #5 power failure happens, it is possible that the node block is not persisted?
If I was correct about this, can the recovery program recover the transaction?

>
>>
>> Thanks!
>>
>> Hongwei
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
