Return-Path: <SRS0=/SzK=74=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201BCC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:39:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE1812067B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2020 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JbkXYybq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aFqvsVEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE1812067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jkkeK-00047Y-I1; Mon, 15 Jun 2020 08:39:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yanaijie@huawei.com>) id 1jkkeC-00045m-Fx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 08:39:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RpMMNXdHyje8/Fl56wbS1tIR2g9Bwoow830hGY4QNPo=; b=JbkXYybqgQQDutB+xdFIsOSqQr
 Cncdv9pjtoePgF7KdVcfsvXh2GN1z+LYWnGckNzFk0zHh5udWbnVPRMb3XRioiQ71LesolKQr8aoW
 4/ONrZW/srQD4BRBqjmjTaeNgazJicDThnQRyuP2rZJRp/pgEC4xLzetARBxo11+hnIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RpMMNXdHyje8/Fl56wbS1tIR2g9Bwoow830hGY4QNPo=; b=aFqvsVEvuDQN91hY8TpSNXvW1j
 civuLe8Vol+4J/Nd/9a5fMoC3Uy83ZpxXR+DFq2CS2JdfqP+g2KpKN5FEaAuEz+QeFh94/peXRJ+E
 KFTHFjCiQADJF41RHYvBt5FQDe1+Own32bgXzMFqDLNctcG5+XCHo211jYRGOunXgpTE=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jkke9-003IpS-Sy
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 08:39:16 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BC13CC896FF6F3D15053;
 Mon, 15 Jun 2020 16:38:47 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 16:38:38 +0800
To: Chao Yu <yuchao0@huawei.com>, <jaegeuk@kernel.org>, <chao@kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
References: <20200615040212.3681503-1-yanaijie@huawei.com>
 <d1562b04-125f-c112-7272-d99ed1e38549@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <f40aa2cc-5675-b8a2-b14f-10edf63d748a@huawei.com>
Date: Mon, 15 Jun 2020 16:38:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <d1562b04-125f-c112-7272-d99ed1e38549@huawei.com>
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
X-Headers-End: 1jkke9-003IpS-Sy
Subject: Re: [f2fs-dev] [PATCH] f2fs: Eliminate usage of uninitialized_var()
 macro
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
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CuWcqCAyMDIwLzYvMTUgMTY6MjYsIENoYW8gWXUg5YaZ6YGTOgo+IE9uIDIwMjAvNi8xNSAxMjow
MiwgSmFzb24gWWFuIHdyb3RlOgo+PiBUaGlzIGlzIGFuIGVmZm9ydCB0byBlbGltaW5hdGUgdGhl
IHVuaW5pdGlhbGl6ZWRfdmFyKCkgbWFjcm9bMV0uCj4+Cj4+IFRoZSB1c2Ugb2YgdGhpcyBtYWNy
byBpcyB0aGUgd3Jvbmcgc29sdXRpb24gYmVjYXVzZSBpdCBmb3JjZXMgb2ZmIEFOWQo+PiBhbmFs
eXNpcyBieSB0aGUgY29tcGlsZXIgZm9yIGEgZ2l2ZW4gdmFyaWFibGUuIEl0IGV2ZW4gbWFza3Mg
InVudXNlZAo+PiB2YXJpYWJsZSIgd2FybmluZ3MuCj4+Cj4+IFF1b3RlZCBmcm9tIExpbnVzWzJd
Ogo+Pgo+PiAiSXQncyBhIGhvcnJpYmxlIHRoaW5nIHRvIHVzZSwgaW4gdGhhdCBpdCBhZGRzIGV4
dHJhIGNydWZ0IHRvIHRoZQo+PiBzb3VyY2UgY29kZSwgYW5kIHRoZW4gc2h1dHMgdXAgYSBjb21w
aWxlciB3YXJuaW5nIChldmVuIHRoZSBfcmVsaWFibGVfCj4+IHdhcm5pbmdzIGZyb20gZ2NjKS4i
Cj4+Cj4+IFRoZSBnY2Mgb3B0aW9uICItV21heWJlLXVuaW5pdGlhbGl6ZWQiIGhhcyBiZWVuIGRp
c2FibGVkIGFuZCB0aGlzIGNoYW5nZQo+PiB3aWxsIG5vdCBwcm9kdWNlIGFueSB3YXJubmluZ3Mg
ZXZlbiB3aXRoICJtYWtlIFc9MSIuCj4+Cj4+IFsxXSBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9s
aW51eC9pc3N1ZXMvODEKPj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0ErNTVh
RnoyNTAwV2ZiS1hBeDhzNjd3cm05PXlWSnU2NVRwTGdOX3liWU52MFZFT0tBQG1haWwuZ21haWwu
Y29tLwo+Pgo+PiBDYzogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+Cj4+IFNpZ25l
ZC1vZmYtYnk6IEphc29uIFlhbiA8eWFuYWlqaWVAaHVhd2VpLmNvbT4KPj4gLS0tCj4+ICAgZnMv
ZjJmcy9kYXRhLmMgfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2RhdGEuYyBiL2ZzL2YyZnMv
ZGF0YS5jCj4+IGluZGV4IDMyNmM2Mzg3OWRkYy4uZTZlYzYxMjc0ZDc2IDEwMDY0NAo+PiAtLS0g
YS9mcy9mMmZzL2RhdGEuYwo+PiArKysgYi9mcy9mMmZzL2RhdGEuYwo+PiBAQCAtMjg1Niw3ICsy
ODU2LDcgQEAgc3RhdGljIGludCBmMmZzX3dyaXRlX2NhY2hlX3BhZ2VzKHN0cnVjdCBhZGRyZXNz
X3NwYWNlICptYXBwaW5nLAo+PiAgIAl9Owo+PiAgICNlbmRpZgo+PiAgIAlpbnQgbnJfcGFnZXM7
Cj4+IC0JcGdvZmZfdCB1bmluaXRpYWxpemVkX3Zhcih3cml0ZWJhY2tfaW5kZXgpOwo+PiArCXBn
b2ZmX3Qgd3JpdGViYWNrX2luZGV4Owo+IAo+IEkgc3VnZ2VzdCB0byBkZWxldGUgdGhpcyB2YXJp
YWJsZSBkaXJlY3RseSwgYXMgd2UgZGlkIGZvciBtbSBpbgo+IGNvbW1pdCAyODY1OWNjOGNjODcg
KG1tL3BhZ2Utd3JpdGViYWNrLmM6IHJlbW92ZSB1bnVzZWQgdmFyaWFibGUpLgo+IAoKR29vZCBz
dWdnZXN0aW9uLCBJIHdpbGwgc2VuZCB2Mi4KClRoYW5rcywKSmFzb24KCj4gVGhhbmtzLAo+IAo+
PiAgIAlwZ29mZl90IGluZGV4Owo+PiAgIAlwZ29mZl90IGVuZDsJCS8qIEluY2x1c2l2ZSAqLwo+
PiAgIAlwZ29mZl90IGRvbmVfaW5kZXg7Cj4+Cj4gCj4gLgo+IAoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
