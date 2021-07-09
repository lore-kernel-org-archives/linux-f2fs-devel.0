Return-Path: <SRS0=XZbR=MB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63ED6C07E99
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Jul 2021 03:49:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27F2B613B2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Jul 2021 03:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F2B613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m1hWV-000161-Jz; Fri, 09 Jul 2021 03:49:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <wangxiaojun11@huawei.com>) id 1m1hWU-00015u-2Z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Jul 2021 03:49:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/oUSs0L2Kb7VfwyWkAnTXJObshLqcuWB8xr/6H5hQ+M=; b=ddpfMsYFBKU63sKdnHCcxxiMBJ
 ud33jjABKjtbZAXmIVjPj21adVXC2RvXVGddVsKZiYl8mBnvik3gPyqK+KgjGBscJmsDZfaH4/xzg
 OEuYbFPjrLLjS4wQ/YkO/JITQkPWjip2xISzJJip+q6aNztEbEuhYyWNzeOpal0GXlPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/oUSs0L2Kb7VfwyWkAnTXJObshLqcuWB8xr/6H5hQ+M=; b=kaRfNrovvJl3+ToI5H+T/OuoSb
 i2+Beik/DtnAojknsydyHJmTPbgI5r3dVT1kqEROe/7KvgKnIDKJ5X6UNdqNqWdYQwQG52NijcKq9
 dWN8H/1ZdwXw4JwHJLCZVAuiEGmRtYanTbk/GeCIUzXwq02bNNP+HwIhq7xj7XGh4omI=;
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m1hWJ-000RYb-OS
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Jul 2021 03:49:54 +0000
Received: from dggeml756-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLfGP4q9mzcbHm;
 Fri,  9 Jul 2021 11:46:21 +0800 (CST)
Received: from [10.174.177.8] (10.174.177.8) by dggeml756-chm.china.huawei.com
 (10.1.199.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 9 Jul
 2021 11:49:34 +0800
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
References: <20210709020559.3885430-1-wangxiaojun11@huawei.com>
 <0b0ae666-e020-2e1d-c893-e8180a7f1225@kernel.org>
From: "wangxiaojun (N)" <wangxiaojun11@huawei.com>
Message-ID: <86d53291-428e-cb99-ccb8-2f1211ab1cec@huawei.com>
Date: Fri, 9 Jul 2021 11:49:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0b0ae666-e020-2e1d-c893-e8180a7f1225@kernel.org>
X-Originating-IP: [10.174.177.8]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeml756-chm.china.huawei.com (10.1.199.158)
X-CFilter-Loop: Reflected
X-Headers-End: 1m1hWJ-000RYb-OS
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid to create an empty string as the
 extension_list
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CuWcqCAyMDIxLzcvOSAxMToyMSwgQ2hhbyBZdSDlhpnpgZM6Cj4gT24gMjAyMS83LzkgMTA6MDUs
IFdhbmcgWGlhb2p1biB3cm90ZToKPj4gV2hlbiBjcmVhdGluZyBhIGZpbGUsIHdlIG5lZWQgdG8g
c2V0IHRoZSB0ZW1wZXJhdHVyZSBiYXNlZCBvbgo+PiBleHRlbnNpb25fbGlzdC4gSWYgdGhlIGVt
cHR5IHN0cmluZyBpcyBhIHZhbGlkIGV4dGVuc2lvbl9saXN0LAo+PiB0aGUgaXNfZXh0ZW5zaW9u
X2V4aXN0IHdpbGwgYWx3YXlzIHJldHVybnMgdHJ1ZSwKPj4gd2hpY2ggYWZmZWN0cyB0aGUgc2Vw
YXJhdGlvbiBvZiBob3QgYW5kIGNvbGQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFdhbmcgWGlhb2p1
biA8d2FuZ3hpYW9qdW4xMUBodWF3ZWkuY29tPgo+PiAtLS0KPj4gwqAgZnMvZjJmcy9uYW1laS5j
IHwgMiArKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYg
LS1naXQgYS9mcy9mMmZzL25hbWVpLmMgYi9mcy9mMmZzL25hbWVpLmMKPj4gaW5kZXggYTljZDlj
Zjk3MjI5Li4zNDM0MWQzZWRiOGQgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2YyZnMvbmFtZWkuYwo+PiAr
KysgYi9mcy9mMmZzL25hbWVpLmMKPj4gQEAgLTIxOSw2ICsyMTksOCBAQCBpbnQgZjJmc191cGRh
dGVfZXh0ZW5zaW9uX2xpc3Qoc3RydWN0IAo+PiBmMmZzX3NiX2luZm8gKnNiaSwgY29uc3QgY2hh
ciAqbmFtZSwKPj4gwqDCoMKgwqDCoCBpbnQgc3RhcnQsIGNvdW50Owo+PiDCoMKgwqDCoMKgIGlu
dCBpOwo+PiDCoCArwqDCoMKgIGlmICghc3RybGVuKG5hbWUpKQo+PiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FSU5WQUw7Cj4KPiBIb3cgYWJvdXQgYWRkaW5nIHRoaXMgaW4gX19zYmlfc3RvcmUo
KT8gbGlrZToKPgo+IGlmICghc3RybGVuKG5hbWUpIHx8IHN0cmxlbihuYW1lKSA+PSBGMkZTX0VY
VEVOU0lPTl9MRU4pCj4gwqDCoMKgwqByZXR1cm4gLUVJTlZBTDsKPgo+IE90aGVyd2lzZSwgaXQg
bG9va3MgZ29vZCB0byBtZS4KClRoaXMgaXMgYW4gYWx0ZXJuYXRpdmUgbW9kaWZpY2F0aW9uLiBF
eGNlcHRpb24gY2hlY2sgaXMgbW9yZSBjb21wYWN0IGhlcmUuCgpCdXQgaWYgdGhlIGYyZnNfdXBk
YXRlX2V4dGVuc2lvbl9saXN0IGZ1bmN0aW9uIGlzIGNhbGxlZCBlbHNld2hlcmUgaW4gCnRoZSBm
dXR1cmUsCgpjaGVja2luZyBpbnNpZGUgdGhlIGZ1bmN0aW9uIGNhbiBhdm9pZCB0aGlzIHByb2Js
ZW0uCgpJIHdhcyBhbHNvIGEgbGl0dGxlIHVuc3VyZSwgYW5kIGZpbmFsbHkgY2hvc2UgdGhpcyBt
b2RpZmljYXRpb24uCgo+Cj4gUmV2aWV3ZWQtYnk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4K
Pgo+IFRoYW5rcywKPgo+PiDCoMKgwqDCoMKgIGlmIChzZXQpIHsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICh0b3RhbF9jb3VudCA9PSBGMkZTX01BWF9FWFRFTlNJT04pCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pgo+IC4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
