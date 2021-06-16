Return-Path: <SRS0=P3Wg=LK=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF69C48BE5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Jun 2021 13:43:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D1161241;
	Wed, 16 Jun 2021 13:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D1161241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ltVpP-00078i-AQ; Wed, 16 Jun 2021 13:43:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1ltVpO-00078Y-NK
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Jun 2021 13:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:Cc:From:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tVt/hIwSK+uCrfiWKjo+xDjtQCmqGhMeT1zmNa3kcDE=; b=mNSFhzBzHXiE+vQqfPt7Jy4un2
 krc6yybSL6CdN9m6iIEmfPipARTT3Tj5/SPHiOTqr63sBInNmUOwZFw2R+4shhWOifpjJt82F6ioo
 A/07PpAOKR6mBYo/AGvUFtYz+lMOQ07Iyc4Z1o9uTSGlUrx3236ghXp9rLbXwIRTV5AE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:Cc:From:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tVt/hIwSK+uCrfiWKjo+xDjtQCmqGhMeT1zmNa3kcDE=; b=JLC5WcVkpttV5HqLIrtZNEzyB0
 5ZRjsWNmBFvGsL1V/SunoZGpeuaWsFN6UGKyvJMWW0w3RnefjPmhkC6r1iLnMuZuc8RPc0b4teFxf
 z3stpmQkacSG0MB3qzvrJae35ifcZwngXc1nSEtIYfX/E1Z03KtWDUVRDainQet4FVWA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1ltVpJ-0007HU-MZ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 16 Jun 2021 13:43:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA3A46100A;
 Wed, 16 Jun 2021 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623851000;
 bh=Rj3dRcfjtk6/OoUIlEbiBnXdcPY4Msj49PzbROb3PyQ=;
 h=Subject:To:References:From:Cc:Date:In-Reply-To:From;
 b=AfA6y4Ugyv5rC+LD6iEH/XO+qrLU3nXEal63XPHip0DocfwbcJJyzntFf9XQ5hXuW
 FuUHyhly5LMYy5cjPCQVXxZoBOiE9vTjScuVrtLlgNA/LS/W3dhfGjls6wCv8Zubn9
 +45TC6zmFpMbZF/abxqwmzPsPEEVDSy8fCfNNFMyzOtCV6BJoW8Tf0f8v/MiH9lPlJ
 KzDjXZJG9V8xyWppZ+1+trc4v+aQwCODR7Km5gFAlR0LsokdjWy4KIF/6Pa5sLq1J1
 4/ZNo7pRFOe1x5gSWj1fvAeIzqALJMfQPUUzF7GfIeS8fwKCk2qZAGySPMGBz/dXPV
 oB3kycVKF3WSA==
To: Sun Ke <sunke32@huawei.com>
References: <20210611112211.1408767-1-sunke32@huawei.com>
 <20210611112211.1408767-3-sunke32@huawei.com>
 <87024647-0ece-929d-8aa6-8dab9609159c@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <6362f24f-35d1-7e5b-c3cc-d6cbb18947fe@kernel.org>
Date: Wed, 16 Jun 2021 21:43:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87024647-0ece-929d-8aa6-8dab9609159c@huawei.com>
Content-Language: en-US
X-Headers-End: 1ltVpJ-0007HU-MZ
Subject: Re: [f2fs-dev] [PATCH] generic/260: f2fs is also special
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
Cc: guan@eryu.me, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMS82LzE1IDExOjI5LCBTdW4gS2Ugd3JvdGU6Cj4gdG8gbGludXgtZjJmcy1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiAKPiDlnKggMjAyMS82LzExIDE5OjIyLCBTdW4gS2Ug5YaZ
6YGTOgo+PiBJdCBzZWVtIHRoYXQgZjJmcyBhbHNvIHNwZWNpYWwgbGlrZSBidHJmcy4KPj4KPj4g
wqAgWytdIERlZmF1bHQgbGVuZ3RoIHdpdGggc3RhcnQgc2V0IChzaG91bGQgc3VjY2VlZCkKPj4g
wqAgWytdIExlbmd0aCBiZXlvbmQgdGhlIGVuZCBvZiBmcyAoc2hvdWxkIHN1Y2NlZWQpCj4+IMKg
IFsrXSBMZW5ndGggYmV5b25kIHRoZSBlbmQgb2YgZnMgd2l0aCBzdGFydCBzZXQgKHNob3VsZCBz
dWNjZWVkKQo+PiArQWZ0ZXIgdGhlIGZ1bGwgZnMgZGlzY2FyZCAwIGJ5dGVzIHdlcmUgZGlzY2Fy
ZGVkIGhvd2V2ZXIgdGhlIGZpbGUgc3lzdGVtIGlzIDEyODgyODA0NzM2IGJ5dGVzIGxvbmcuCj4+
ICtJdCBzZWVtcyB0aGF0IGZzIGxvZ2ljIGhhbmRsaW5nIGxlbiBhcmd1bWVudCBvdmVyZmxvd3MK
CldlbGwsIHRoZSByb290IGNhdXNlIGlzIGYyZnMgY2FuIHRhZyBhIHNwZWNpYWwgZmxhZyBUUklN
TUVEX0ZMQUcgdG8KaW5kaWNhdGUgdGhlIHdob2xlIGZpbGVzeXN0ZW0gaXMgdHJpbW1lZCwgc28g
YWZ0ZXIgbWtmcy9mc3RyaW0oKSwKZm9sbG93aW5nIGZzdHJpbSgpIHdvbid0IHRyaW0gYW55IGJs
b2NrLgoKQ2FuIHlvdSBwbGVhc2UgdXBkYXRlIGNvbW1pdCBtZXNzYWdlIGFuZCBhZGQgY29tbWVu
dHMgaW4gc2NyaXB0PwoKVGhhbmtzLAoKPj4KPj4gU2lnbmVkLW9mZi1ieTogU3VuIEtlIDxzdW5r
ZTMyQGh1YXdlaS5jb20+Cj4+IC0tLQo+PiBJIGFtIG5vdCBzdXJlIGFib3V0IHRoYXQuIG8o4pWv
4pah4pWwKW8KPj4KPj4gwqAgdGVzdHMvZ2VuZXJpYy8yNjAgfCA0ICsrLS0KPj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdp
dCBhL3Rlc3RzL2dlbmVyaWMvMjYwIGIvdGVzdHMvZ2VuZXJpYy8yNjAKPj4gaW5kZXggODAyMWFh
NjguLjZiZDg2MWQyIDEwMDc1NQo+PiAtLS0gYS90ZXN0cy9nZW5lcmljLzI2MAo+PiArKysgYi90
ZXN0cy9nZW5lcmljLzI2MAo+PiBAQCAtMTAwLDcgKzEwMCw3IEBAIGZpCj4+IMKgICMgSXQgaXMg
YmVjYXVzZSBidHJmcyBkb2VzIG5vdCBoYXZlIG5vdC15ZXQtdXNlZCBwYXJ0cyBvZiB0aGUgZGV2
aWNlCj4+IMKgICMgbWFwcGVkIGFuZCBzaW5jZSB3ZSBnb3QgaGVyZSByaWdodCBhZnRlciB0aGUg
bWtmcywgdGhlcmUgaXMgbm90Cj4+IMKgICMgZW5vdWdoIGZyZWUgZXh0ZW50cyBpbiB0aGUgcm9v
dCB0cmVlLgo+PiAtaWYgWyAkYnl0ZXMgLWxlICQoX21hdGggIiRmc3NpemUqNTEyIikgXSAmJiBb
ICRGU1RZUCAhPSAiYnRyZnMiIF07IHRoZW4KPj4gK2lmIFsgJGJ5dGVzIC1sZSAkKF9tYXRoICIk
ZnNzaXplKjUxMiIpIF0gJiYgWyAkRlNUWVAgIT0gImJ0cmZzIiBdICYmIFsgJEZTVFlQICE9ICJm
MmZzIiBdOyB0aGVuCj4+IMKgwqDCoMKgwqAgc3RhdHVzPTEKPj4gwqDCoMKgwqDCoCBlY2hvICJB
ZnRlciB0aGUgZnVsbCBmcyBkaXNjYXJkICRieXRlcyBieXRlcyB3ZXJlIGRpc2NhcmRlZCJcCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgICJob3dldmVyIHRoZSBmaWxlIHN5c3RlbSBpcyAkKF9tYXRo
ICIkZnNzaXplKjEwMjQiKSBieXRlcyBsb25nLiIKPj4gQEAgLTE2MCw3ICsxNjAsNyBAQCBfc2Ny
YXRjaF9tb3VudAo+PiDCoCAjIG1hcHBlZCBhbmQgc2luY2Ugd2UgZ290IGhlcmUgcmlnaHQgYWZ0
ZXIgdGhlIG1rZnMsIHRoZXJlIGlzIG5vdAo+PiDCoCAjIGVub3VnaCBmcmVlIGV4dGVudHMgaW4g
dGhlIHJvb3QgdHJlZS4KPj4gwqAgYnl0ZXM9JCgkRlNUUklNX1BST0cgLXYgLWwkbGVuICRTQ1JB
VENIX01OVCB8IF9maWx0ZXJfZnN0cmltKQo+PiAtaWYgWyAkYnl0ZXMgLWxlICQoX21hdGggIiRm
c3NpemUqNTEyIikgXSAmJiBbICRGU1RZUCAhPSAiYnRyZnMiIF07IHRoZW4KPj4gK2lmIFsgJGJ5
dGVzIC1sZSAkKF9tYXRoICIkZnNzaXplKjUxMiIpIF0gJiYgWyAkRlNUWVAgIT0gImJ0cmZzIiBd
ICYmIFsgJEZTVFlQICE9ICJmMmZzIiBdOyB0aGVuCj4+IMKgwqDCoMKgwqAgc3RhdHVzPTEKPj4g
wqDCoMKgwqDCoCBlY2hvICJJdCBzZWVtcyB0aGF0IGZzIGxvZ2ljIGhhbmRsaW5nIGxlbiBhcmd1
bWVudCBvdmVyZmxvd3MiCj4+IMKgIGZpCj4+Cj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2
ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwK
