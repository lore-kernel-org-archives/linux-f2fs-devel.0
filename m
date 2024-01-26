Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AECC47258
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jan 2024 01:27:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rTB09-00081y-5a;
	Fri, 26 Jan 2024 01:27:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rTB06-00081r-Ha
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jan 2024 01:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kvKi2SDqNdftuDsNKIb4FrCgkp+h3pXsxcM4SdmcGME=; b=MBB1fzXM1KfVEn9H3+pPfQx0nr
 UhgJ0Q8n36+gBweiXLjRBKMWadQ15ODxonrCrhkh3l6XHmklO4Skso+UCqm2XsXGsl/NO/od963PX
 jzJ1r6SIe1NXrlephjxYLKuvvSfh53TPtpidkQQh46MiDJUJgbp8EtAUzDgaPKxBdIjQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kvKi2SDqNdftuDsNKIb4FrCgkp+h3pXsxcM4SdmcGME=; b=BQUwXCNeR969cAvGHWp3qcOabW
 9zUig9Dz6Th1WOw/wdfT1V2JfbJsV3FIKCnlOK/gbDCTMLPdzQGbg9PvjdCDyuwVYF/lykfCZU0lt
 goiFUtVPqav8NkQpO7Yyjes07rDFjAMhzwlXivFUEg/l+OuJmypDuRW5OYTYiB32csOU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rTB05-0000Q1-4L for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jan 2024 01:27:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 65E8962367;
 Fri, 26 Jan 2024 01:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20EC433C7;
 Fri, 26 Jan 2024 01:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706232436;
 bh=GTtKobOQ217q5L9Z4HLE5gx1zWcNYGYQZI5Zm9HQ1u4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aHxRaxA9Vt8sN1cQQGlptLuXjn7khkCw8t1qI/IuGcR1xQ7mfh+DDYfVYSgKfLmRb
 +zyVSmk+bUVPGC8GG/QQuvDvEbAmGRkBryAXT0mCbOAEUa1t71SNeXPzctfU76Ic+V
 LQDltZQMLt99HC6C8s9cUFQ7w+Ff2KzGVLfjROFAhcuSGjzNbVwsZxKqhhjEean/SC
 LIV23rW0Lt+ipDrjv9E3r/l/yaud6hluKKJSCHPSUAxrsreFwDy5fBqD8VoI1MvV3h
 W3q7FopFr6zpDQGOs0vxtQp0khbpjXxyKFELf5xvflwEFBiP50TJoJj1F9V/Ub3s4Y
 8shvo7dlg076Q==
Message-ID: <b18c286a-cc72-439c-b373-98e0d6504618@kernel.org>
Date: Fri, 26 Jan 2024 09:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>
References: <20240117230032.2312067-1-daeho43@gmail.com>
 <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
 <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CACOAw_yjEuGSvo_qyoA13U0HwOr3gOzGtNf2Twhes01SNSGQeg@mail.gmail.com>
X-Headers-End: 1rTB05-0000Q1-4L
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC8xLzI2IDA6MjUsIERhZWhvIEplb25nIHdyb3RlOgo+IE9uIFdlZCwgSmFuIDI0LCAy
MDI0IGF0IDc6MzTigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiAr
Q2MgWW9uZ3BlbmcgWWFuZwo+Pgo+PiBEYWVobywKPj4KPj4gWW9uZ3BlbmcgcmVwb3J0cyBhIHBv
dGVudGlhbCBpc3N1ZTogaWYgYy5kZXZpY2VzWzBdLnRvdGFsX3NlZ21lbnRzIGlzCj4+IGxhcmdl
ciB0aGFuIHNlZ21lbnRzIG9mIG1haW5hcmVhLCBjLmN1cl9zZWdbQ1VSU0VHX0hPVF9OT0RFXSB3
aWxsIGV4Y2VlZAo+PiBlbmQgYm91bmRhcnkgb2YgbWFpbmFyZWEuIENvdWxkIHlvdSBwbGVhc2Ug
Y2hlY2sgdGhhdD8gdGhvdWdoIGl0J3MgYSBjb3JuZXIKPj4gY2FzZS4KPiAKPiBDYW4geW91IGVs
YWJvcmF0ZSBtb3JlPwoKU2luY2UgYy5jdXJfc2VnW0NVUlNFR19IT1RfTk9ERV0gaXMgYW4gb2Zm
c2V0IHN0YXJ0ZWQgZnJvbSBtYWluX2Jsa2FkZHIuCklmIGMuY3VyX3NlZ1tDVVJTRUdfSE9UX05P
REVdIHdhcyBhc3NpZ25lZCB3LyBjLmRldmljZXNbMF0udG90YWxfc2VnbWVudHMsCmFuZCBjLmRl
dmljZXNbMF0udG90YWxfc2VnbWVudHMgaXMgbGFyZ2VyIHRoYW4gc2VnbWVudHMgb2YgbWFpbmFy
ZSwKYy5jdXJfc2VnW0NVUlNFR19IT1RfTk9ERV0gd2lsbCBleGNlZWQgdGhlIGVuZCBib3VuZGFy
eSBvZiBtYWluYXJlYS4KCgljLmN1cl9zZWdbQ1VSU0VHX0hPVF9OT0RFXSA9IGMuem9uZWRfbW9k
ZWwgPT0gRjJGU19aT05FRF9ITSA/CgkJCWMuZGV2aWNlc1swXS50b3RhbF9zZWdtZW50cyA6IDA7
Cgo+IEluIHRoZSBjYXNlIG9mIEYyRlNfWk9ORURfSE0sIHdlIGhhdmUgdGhlIGRldmljZXNbMV0u
Cj4gRG8geW91IG1lYW4gdGhlIGNhc2Ugd2UgZm9ybWF0IHRoZSBmaWxlc3lzdGVtIGludGVudGlv
bmFsbHkgc21hbGxlcgo+IHRoYW4gd2hhdCBkZXZpY2VzIGhhdmU/CgpJIG1lYW4gYmxldyBjYXNl
OgpkZXZpY2VbMF06IGNvbnZlbnRpb25hbCBkZXZpY2Ugc2l6ZSA9IDEwMjQwIE1CCmRldmljZVsx
XTogem9uZSBkZXZpY2Ugc2l6ZSA9IDIgTUIKClRoYW5rcywKCj4gCj4+Cj4+IE9uIDIwMjQvMS8x
OCA3OjAwLCBEYWVobyBKZW9uZyB3cm90ZToKPj4+IEZyb206IERhZWhvIEplb25nIDxkYWVob2pl
b25nQGdvb2dsZS5jb20+Cj4+Pgo+Pj4gTWFrZSB0byBhbGxvY2F0ZSBsb2dzIGFmdGVyIGNvbnZl
bnRpb25hbCBhcmVhIGZvciBITSB6b25lZCBkZXZpY2VzIHRvCj4+PiBzcGFyZSB0aGVtIGZvciBm
aWxlIHBpbm5pbmcgc3VwcG9ydC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8
ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+Pj4gLS0tCj4+PiAgICBta2ZzL2YyZnNfZm9ybWF0LmMg
fCAzICsrLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9ta2ZzL2YyZnNfZm9ybWF0LmMgYi9ta2ZzL2YyZnNf
Zm9ybWF0LmMKPj4+IGluZGV4IGYyODQwYzguLjkxYTdmNGIgMTAwNjQ0Cj4+PiAtLS0gYS9ta2Zz
L2YyZnNfZm9ybWF0LmMKPj4+ICsrKyBiL21rZnMvZjJmc19mb3JtYXQuYwo+Pj4gQEAgLTU1Nyw3
ICs1NTcsOCBAQCBzdGF0aWMgaW50IGYyZnNfcHJlcGFyZV9zdXBlcl9ibG9jayh2b2lkKQo+Pj4g
ICAgICAgICAgICAgICAgYy5jdXJfc2VnW0NVUlNFR19DT0xEX0RBVEFdID0gMDsKPj4+ICAgICAg
ICAgICAgICAgIGMuY3VyX3NlZ1tDVVJTRUdfV0FSTV9EQVRBXSA9IG5leHRfem9uZShDVVJTRUdf
Q09MRF9EQVRBKTsKPj4+ICAgICAgICB9IGVsc2UgaWYgKGMuem9uZWRfbW9kZSkgewo+Pj4gLSAg
ICAgICAgICAgICBjLmN1cl9zZWdbQ1VSU0VHX0hPVF9OT0RFXSA9IDA7Cj4+PiArICAgICAgICAg
ICAgIGMuY3VyX3NlZ1tDVVJTRUdfSE9UX05PREVdID0gYy56b25lZF9tb2RlbCA9PSBGMkZTX1pP
TkVEX0hNID8KPj4+ICsgICAgICAgICAgICAgICAgICAgICBjLmRldmljZXNbMF0udG90YWxfc2Vn
bWVudHMgOiAwOwo+Pj4gICAgICAgICAgICAgICAgYy5jdXJfc2VnW0NVUlNFR19XQVJNX05PREVd
ID0gbmV4dF96b25lKENVUlNFR19IT1RfTk9ERSk7Cj4+PiAgICAgICAgICAgICAgICBjLmN1cl9z
ZWdbQ1VSU0VHX0NPTERfTk9ERV0gPSBuZXh0X3pvbmUoQ1VSU0VHX1dBUk1fTk9ERSk7Cj4+PiAg
ICAgICAgICAgICAgICBjLmN1cl9zZWdbQ1VSU0VHX0hPVF9EQVRBXSA9IG5leHRfem9uZShDVVJT
RUdfQ09MRF9OT0RFKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
