Return-Path: <SRS0=YONb=7K=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A440EC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2020 15:34:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9666120776;
	Thu, 28 May 2020 15:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="mfrJM+uc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MwkkiX0V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.b="slVLy3j+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9666120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jeKYP-0007VV-6y; Thu, 28 May 2020 15:34:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <glqhw@qq.com>) id 1jeKYN-0007VI-Kj
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 May 2020 15:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Date:Content-Transfer-Encoding:
 Content-Type:Mime-Version:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QN4GUziKMg6agPJKvYEJWUnBP+U+e/opFXSXN5a0Uxs=; b=mfrJM+ucPqILv9QaZ9L4pFR4UP
 uEnOP35nTidJGgcxxAvi3vFIg/JK0J5UzVMqBKy3iYmzDuqmNPqUCdgYNaFKM1D3OCl4tJJbzdR+c
 aA/MPN2zUsdtJ3tNvPLGLrcM+rPJVw1MVxse2g/V9n7HjYu+wgofIF1pR1HZvN6DY4TY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Date:Content-Transfer-Encoding:Content-Type:Mime-Version:
 Subject:To:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QN4GUziKMg6agPJKvYEJWUnBP+U+e/opFXSXN5a0Uxs=; b=M
 wkkiX0VFaE/xg9nvSmpxO04el3p9DSnAJwvQ7OdHtlHEdTv5DR0kvmqSoDPXaQ/dwYBH65fC5epy1
 JBQyworKp4jDWP6AYi+6reP/xGmZcnpgUmuWJ3EOS3BSOuEQbx3pxYnLEMhlDBJi8hVOYDdNG57FL
 na8bLP6Hagt1W+ow=;
Received: from smtpbguseast2.qq.com ([54.204.34.130])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jeKYA-00GDJd-FW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 28 May 2020 15:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1590680042; bh=QN4GUziKMg6agPJKvYEJWUnBP+U+e/opFXSXN5a0Uxs=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=slVLy3j+6qAP1r29ugXFKE9+yvapNretNyKIDs1nHpjR/XbLEafTJ9IvD09nLI/81
 aZYSmJzcZzDtp+9REfzM0yZ3DWIZMhI7A0Oy3lsheITKBHeA8aKn9YKNHBw5HqBqo0
 xFSpKFaGLvqSdE3sQ95/f93tnDCAExBgmM5gjm6s=
X-QQ-FEAT: Tubeh+4qKFSPBW7qheSZuz84ApSR6cVzU8OWr0fCVAqWEYnKk0qM+wajGG9Du
 lo+2ilYXsIDB9stVEOVslBMr+SERfcOwJabklSodjnXpBL06Q5PlSn3MRmnBikaR/eOvZSA
 TIthpIBt7MRgK5xoedmuMevcNCwPQlz1fnLQ4hEH37XLILcWwV3LRrMfw6hA1hR3MPgIHYN
 aO20alTNkzy+i4dEVDzCgA2vTatpsBnAG88o+znxfoQj8/PXeQLyLmZJ8auC2eLFN/Ih82V
 hMwwlj+DTgOs94
X-QQ-SSF: 00010000000000F000000000000000Z
X-QQ-XMAILINFO: MinHX6eHWi89Btov4prD7baQc3znDtOkONym4UYvdOqMlC+NU1LrHI+GLzljoZ
 299wh4ZnLFeLQEnbuN4/guJBkTrTkSdZTrSWDVxvaWtCs4uhQI9NJ1KlY3F+56qe2HE1AZmQyxt2w
 vrERizyOnBE6FU896umXlwA4L3ihMfahcHhQssrCbacjUvG0fQkJma+jR2Xe5/P9jwr1rE4Dsgscp
 hDXo0X/0a75uK7Yqw4M1p20UVP9QyoblshSJZMFdYlSbq+YbV4njjV7/EVSYCU2uPzz0+nk+k+EXT
 KNN0eosmlZ/AYJXGgZCAWglzRFN9BS3ErJCQA22AnuhxldwICU9D5XrA6NjdHeJZ2Eukt0zV3+wRJ
 UdSKnydfZXrX2xenV994wLj4Mpu8LPMhRjTGK3hRPaer3s1sLkim574MzCMn3X6hsMhSZ87FfVGPI
 KGJT007ckKz/YmFKFEwyXnwyZXZHsdta0hUIiGpUBLP9pz7RWRoYVn/s22sHraOF3e9FePqqjlwLa
 nFCH4eP0uFfrQ9zmKDXU8bM26Ia8pOUawdczoFD3Cde90iiV1jHGZ1H+eSdyUY91ml21bmwSiuwWE
 ry461aevQCPNif9628dKTf5acfsJXNOFYro6XTv8CvJhojNfUQy+cjNvwMxrjYvzZGzawoe+LNfSq
 5VQigU
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 117.152.35.38
X-QQ-STYLE: 
X-QQ-mid: webmail804t1590680040t9452429
From: "=?ISO-8859-1?B?SG9uZ3dlaQ==?=" <glqhw@qq.com>
To: "=?ISO-8859-1?B?bGludXgtZjJmcy1kZXZlbA==?="
 <linux-f2fs-devel@lists.sourceforge.net>
Mime-Version: 1.0
Date: Thu, 28 May 2020 23:34:00 +0800
X-Priority: 3
Message-ID: <tencent_DCCAEE9137D2150CB266BD2CF3EDF98A970A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Thu, 28 May 2020 23:34:01 +0800 (CST)
Feedback-ID: webmail:qq.com:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
X-Headers-End: 1jeKYA-00GDJd-FW
Subject: [f2fs-dev] Can F2FS roll forward after fdatasync()?
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi F2FS experts,
As written in f2fs_do_sync_file():
"Both of fdatasync() and fsync() are able to be recovered from sudden-power-off."

Please consider this workflow:
1. Start atomic write
2. Multiple file writes
3. Commit atomic write
4. fdatasync()
5. Powerloss.

In the 4th step, the fdatasync() doesn't wait for node writeback.
So we may loss node blocks after powerloss.

If the data blocks are persisted but node blocks aren't, can the recovery program recover the transaction?

Thanks!

Hongwei
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
