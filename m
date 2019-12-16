Return-Path: <SRS0=UACW=2G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D24C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:24:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F01206CB;
	Mon, 16 Dec 2019 13:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UWNEvPB4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Vt+XmeeL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7AJRz+H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F01206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1igqMf-0004l2-6x; Mon, 16 Dec 2019 13:24:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1igqMd-0004kh-HQ
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Dec 2019 13:24:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HTbwKTwyHtlfPhjrz1y10VoXKxAwv82Kc8Q0MPzJSw0=; b=UWNEvPB4WTZNsN4ZmF64hizEFp
 pRbvUecVptaA5EkydkD0BjWOaA+8RvAquDCB6s7RMiTUo7aItGiuD1FGH5ikrPCAthwYBCmSh7ecl
 i5W79kug/8kg7gnMbdNmMUMfzuRRFaif/34V5iHVEDsGK1+CADE9wfiQVzyUgdp6+hOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HTbwKTwyHtlfPhjrz1y10VoXKxAwv82Kc8Q0MPzJSw0=; b=Vt+XmeeLCFbYz3UQChK+NZwpYb
 OqG5roPsdqYnifBct8Xl08AAYHHoFj+bJbmECaKvqRxFlfoupW95UQRcd4rUYnn14HMC0cP2THakx
 iJF8rvfNje5TxTBFCp2jFFUg2p8DMZlo/N2UmDcxEYFtHFy+JqqhS7qTnvaCd13Cj9CA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1igqMc-006gCu-7g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Dec 2019 13:24:43 +0000
Received: from [192.168.0.114] (unknown [58.212.132.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 12214206CB;
 Mon, 16 Dec 2019 13:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576502671;
 bh=sO+1csfL+rYIgxzSfCDi9aMrtpcShiJGeaFwuQB9DyQ=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=N7AJRz+H6lX1XsWIhoqKRICOBi1fEcPJ2g8h6xveE/XA/75uj8I+JZLgivmpheGnW
 at3PW2Zervh5vOpiR5f8Qqy5dB8zhqFyP6HKCEhbiRMUYUndrELUBg1o0KW5yn0H3g
 cJGlC6R2EA0vnKLsNARVa+58iVR0OLUW+l+e97kk=
To: Markus Elfring <Markus.Elfring@web.de>, Chao Yu <yuchao0@huawei.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <594c3b59-b6f0-0e87-6acb-04161e555d7e@web.de>
From: Chao Yu <chao@kernel.org>
Message-ID: <a50e477f-3bc0-d975-e8ff-ffb51704d91f@kernel.org>
Date: Mon, 16 Dec 2019 21:24:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <594c3b59-b6f0-0e87-6acb-04161e555d7e@web.de>
X-Headers-End: 1igqMc-006gCu-7g
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAxOS0xMi0xNiAxOTozMiwgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4g4oCmCj4+ICsrKyBi
L2ZzL2YyZnMvY29tcHJlc3MuYwo+PiBAQCAtMCwwICsxLDExMzkgQEAKPiDigKYKPj4gK2Jvb2wg
ZjJmc19pc19jb21wcmVzc2VkX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpCj4+ICt7Cj4+ICsJaWYg
KCFQYWdlUHJpdmF0ZShwYWdlKSkKPj4gKwkJcmV0dXJuIGZhbHNlOwo+PiArCWlmICghcGFnZV9w
cml2YXRlKHBhZ2UpKQo+PiArCQlyZXR1cm4gZmFsc2U7Cj4+ICsJaWYgKElTX0FUT01JQ19XUklU
VEVOX1BBR0UocGFnZSkgfHwgSVNfRFVNTVlfV1JJVFRFTl9QQUdFKHBhZ2UpKQo+PiArCQlyZXR1
cm4gZmFsc2U7Cj4g4oCmCj4KPiBIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGNvbWJpbmUgY29u
ZGl0aW9uIGNoZWNrcyBsaWtlIHRoZSBmb2xsb3dpbmc/Cj4KPiArCWlmICghUGFnZVByaXZhdGUo
cGFnZSkgfHwgIXBhZ2VfcHJpdmF0ZShwYWdlKSB8fAo+ICsJICAgIElTX0FUT01JQ19XUklUVEVO
X1BBR0UocGFnZSkgfHwgSVNfRFVNTVlfV1JJVFRFTl9QQUdFKHBhZ2UpKQo+ICsJCXJldHVybiBm
YWxzZTsKClRoYXQncyBmMmZzIGNvZGluZyBzdHlsZSwgSSBndWVzcyBpdCB3aWxsIGEgbGl0dGxl
IGJpdCBlYXNpbGVyIHRvIHVuZGVyc3RhbmQgb25lIApzaW5nbGUgY29uZGl0aW9uIHRoYW4gdW5k
ZXJzdGFuZGluZyBjb21iaW5lZCBvbmUuCgpUaGFua3MsCgo+Cj4KPiBXb3VsZCB5b3UgbGlrZSB0
byBhcHBseSBzaW1pbGFyIHRyYW5zZm9ybWF0aW9ucyBhdCBvdGhlciBzb3VyY2UgY29kZSBwbGFj
ZXM/Cj4KPiBSZWdhcmRzLAo+IE1hcmt1cwo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4g
TGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCj4KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVs
IG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVs
Cg==
