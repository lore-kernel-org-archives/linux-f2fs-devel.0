Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44223C0218F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  2 Feb 2025 15:05:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tebWw-00008Z-KO;
	Sun, 02 Feb 2025 15:05:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <Markus.Elfring@web.de>) id 1tebWv-00007o-4L
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 02 Feb 2025 15:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Subject:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I3GckS+Bmfn0RBXo0V9D7uiW+6F71KvgXL8u85A42Ww=; b=FK6F0uWkeDCsgTZwpgURM3YAXM
 CCp953xNjWp+EXgSnLFlfiRC5BAeqPG39yXrjy9/75mgzpfO5KvtW6JztiSw0DCZDFLf3jPBnpecS
 Z3CSAKX31gbM3bEHUGP3vcNF+oBTjkLoyYrAfwyp9eKreWL83vfilLdQqy4xb/zsQ55M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Subject:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I3GckS+Bmfn0RBXo0V9D7uiW+6F71KvgXL8u85A42Ww=; b=axN4VKnWar5gp6183QRGBvpcJr
 sYhCFjNbX/bQFToQbjzuTHMiXXJbBWB0xfK+prx8errs9Fzfkhh7Z+lbwnYLFg7XEDLAjQyKV1pO7
 nyz9JNGT9jumOIAIwRyQ06VF2JcS3y2jobwscXn+VhbyBuVB3jMpX2j/pxq1mqIsNdcs=;
Received: from mout.web.de ([212.227.17.11])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tebWt-0000qZ-Ir for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 02 Feb 2025 15:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1738508688; x=1739113488; i=markus.elfring@web.de;
 bh=I3GckS+Bmfn0RBXo0V9D7uiW+6F71KvgXL8u85A42Ww=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=PCmGJCidNphod8rEJzr4B00d5bwlsfnJ0MhtrDQp05yCMIY37DjtZJ/RU0bQ9eFT
 bHw6WQzLSvvuo/wnzESQUzBFBC73QTlCqnVvjxP3Eu0JjdUHz0Z5R+nrcUGU0SLiT
 R71hyWh0D993S7M8RQPm/vMpzfJSPO5oUtMph0npJ5/1I+VtwGOhiUxSHDwMOuZNI
 C5nL2H3VA8n63YUyS/mEEhd3qa9MCG3HISeXbx0mxvbHJN+SMdvKxc0ioW2BzHLwo
 BiaZS4/7jM8K4FMO0eWb7ktdTA+RvG8ljiHAP3WOHA9SC5tU2ItKlsXQ482A2qPzI
 LWemRu3nACKNwmYWQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.26]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPaIK-1trL9t29cA-00Nnjb; Sun, 02
 Feb 2025 15:58:59 +0100
Message-ID: <82b65a27-8e7a-49b6-b7b0-a4721ce0282c@web.de>
Date: Sun, 2 Feb 2025 15:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20250131222457.1634039-1-jaegeuk@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250131222457.1634039-1-jaegeuk@kernel.org>
X-Provags-ID: V03:K1:XJAqUxI1M8FQjColY8RxoBsqzXl3zDmWMHbpsMwu1tWuZScnYdd
 nbeOtIvJUafwAqApMraOiAn6h2GpcmWeKnQetXgC5QsdHSkpgZXpbJwaIREMbGq4lLxZnj1
 x12i3FSgu2g5I83gjHznFO0Z6Xk0Wlj+dF6wsrktNAxKx/KOfOp7v6NfVAnyVadLfMZRv/I
 /Vd3KtzGdQF99EzEETh4Q==
UI-OutboundReport: notjunk:1;M01:P0:yz2xNDN0OaY=;q5ZuErU5Ur/nn/Z2KZnYcPiv5zu
 6tAs8Z3ZMyxj7rLw/HBVnjFia11oEtcKMZMy3ZBITj1zb26YCYgsb3E8EHGgPBngJEzCTQZbH
 Py05xde6fALo1H0Iy3MRYIj7rpEjVnrDGlwvlovug1eHOJqJNsKn22k5ExqrU7LrWy/sCx2LT
 afLyKOxIskmnREmheOmWAY/bzKQ4xLJlF62suTkF5vo59qpqOrT7W0xKpqfuO64jRwTAgc/f2
 SOrHzECsyX0sV5emH8Bk67vZz1q92QWCsdlvZXS1YQVaVKWYiuFhuGDLU8n99aOf5dKModZ7N
 hZ/TzNFQicb73Fu8xaVZGsisWuAZuu8I+oTCBGbwb81g56nN/oYyErcTntulQpwxtbwGMb0QE
 iQlKUlPAbKGh5O5a2uNW1czT6ymtDPYWEjRhoxg23OFRfaSJ7Qi2cGhlgMMvETc1XWK3pTUDr
 kRS4+3fOJom94/a37czlKGYFDPZw8jF39GD6Q8t0wSH+mdAvVYo8LZPnuGZbBYtXIFPtkoNEV
 e/gvGUDAGNdqlYxmP214XSseUp/M7N+Qu2IpCNHGYkjtbYOpwUgVRS4frpEomn2sOrdr+34ed
 5DA79vwR7mP5t8fsaHlMIT2jqa57tiaL+P3D9RtEyjnoFEmqR1FS2FL/9AzCCnQlMX5WoeQZV
 3XKnN4ik5j3RRAA/RNYhqEOQw/L2pLyFBAsGeZVqEZr4OnuPb0dlhp7EThPz8W05ApD+B4xyU
 7An6yvAy/8Koaro79ZDqHNErRqvXMV7zSWb8b0mBL8mQ0KzJdI8BWAzk+767Z/yo6q9tOKfd/
 02SP7r8TdULy6XK7Xt1sCFXHoOAAVA+V16lG3zDV5mCaEgyM5cHLwrC4FuqaF3zGFSSsdkwef
 SZ/iOhkIq0mfDD307QPPLYinUN0KktxVwQZGAoPbkwESHqcUfQr06NCcXkESJeoj0awRDtRTk
 rxUf3WIj1QT3aKBKV658L85yZtjCWMxOvAerTLAcOB3WzDDXRiKX/crFV7EqEkyqAx4NV3diF
 LFmwiDfTXWvNVPIbHISlwFHaiTvEsOfcz1XeqQMFk9L4Yr4WN5Ipt4rWGxGEwwzcafXtO+bRO
 YyFn5dJXjeJMFHQgvQ3f+06HWNNyObK7y+I1J5TUZN2WCzCAaMd1hyGMGTwslhDjB0FueGo/+
 gHd3LEb/9tm83i2z1orbYhEYxSK2ohGhghLGPWk/z9q7Tqk1PeGM2dLMHNphTWP6xac+lPQf/
 q+2C96G8x2g3PchSte/7aIwms5/5LicRcYGxcG3QTt/7YuMcPG+haOUoEOz0QwfVbBO5X3ZyU
 nchP5RZ3AUZMYm0QXLdi+Wl3sXoMUzba6u3lsK7qjQ+xKHxFTGCv+71jJYsj5SWp0AU
X-Headers-End: 1tebWt-0000qZ-Ir
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't kobject_put in the error case
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
From: Markus Elfring via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

PiBGaXggYSB3cm9uZyBrb2JqZWN0X3B1dCBpbiB0aGUgZXJyb3IgcGF0aC4KCiogSG93IGRvIHlv
dSB0aGluayBhYm91dCB0byBhZGQgYW55IHRhZ3MgKGxpa2Ug4oCcRml4ZXPigJ0gYW5kIOKAnENj
4oCdKSBhY2NvcmRpbmdseT8KCiogV2lsbCBjb3ZlciBsZXR0ZXJzIGJlIHVzdWFsbHkgaGVscGZ1
bCBmb3Igc3VjaCBwYXRjaCBzZXJpZXM/CgoKUmVnYXJkcywKTWFya3VzCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
