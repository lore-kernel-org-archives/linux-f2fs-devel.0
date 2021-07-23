Return-Path: <SRS0=8t4+=MP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090A8C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jul 2021 02:32:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C10E960EB2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jul 2021 02:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C10E960EB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6kzb-0001kd-8u; Fri, 23 Jul 2021 02:32:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <changfengnan@vivo.com>) id 1m6kzY-0001kF-0I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Jul 2021 02:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9wg9ZhDCG4k0PGZ/RNneHgLViQdMS4spFp7CLUbg6e8=; b=ZQMNQudgDZA4uyEEHGCGz8ECnP
 Y7aWmBbhAEO8z7dnNYzSO8pRP++tqeCy8IA8pysaxrGEScW2ZETmCvwJ/ggSG5UVY2Mobh7ehft2O
 Rw2Q7aNYuZ62Q3C9Nk723wjfcDZ+hkqEUpEoUhWczeVXb671oc90XKxiSBNs2enUYg7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9wg9ZhDCG4k0PGZ/RNneHgLViQdMS4spFp7CLUbg6e8=; b=CCDKbuDze11bTnfMJZN39teE/I
 W9UPQ+DzhFcO6w2zhoWKo7vkmtR3Hb2MfFC4GmCDjpDa6ZTDJNyzZAA4Vg0CX4X7rpT7FM6u5zlix
 xcZKIK53yYAbeVO3RPhNW6ns/8J2SWDOD+ifEg3fG6iyuEoQT6vnKdY6C9S4L5jEDQsc=;
Received: from mail-m121144.qiye.163.com ([115.236.121.144])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6kzP-0000iP-VU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Jul 2021 02:32:47 +0000
DKIM-Signature: a=rsa-sha256;
 b=GI7VT4SiQugGuLypkbxZP6SQKJyeWrS+/W7wqKC7N4YQRNSnmcj08olZwp2FhTU32OkhNLMU/3kbMk49tfaDzfMX9xJm9vcmF9AZuiEnpZ19DJDSPKy8PPJCGDnv39T0vSGoHPfA3kpcdaRljD67Jowtusxp+A/cdkx3gbkyqgU=;
 c=relaxed/relaxed; s=default; d=vivo.com; v=1;
 bh=9wg9ZhDCG4k0PGZ/RNneHgLViQdMS4spFp7CLUbg6e8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.25.44.145] (unknown [58.250.176.229])
 by mail-m121144.qiye.163.com (Hmail) with ESMTPA id A9181AC021A;
 Fri, 23 Jul 2021 10:32:30 +0800 (CST)
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210702031138.156851-1-changfengnan@vivo.com>
 <2cc3c3c7-5c52-9b6e-5bb6-29a701351c04@kernel.org>
From: Fengnan Chang <changfengnan@vivo.com>
Message-ID: <fe9c9ccf-371c-3391-cc8e-160488330c26@vivo.com>
Date: Fri, 23 Jul 2021 10:32:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2cc3c3c7-5c52-9b6e-5bb6-29a701351c04@kernel.org>
Content-Language: en-US
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRlPGR1WSUoYQkpOSUMdTh
 9KVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRQ6KDo*OT9NNkkuKVEKIjxN
 MDoaCz1VSlVKTUlMS0tMTk5KS0NPVTMWGhIXVRgTGhUcHR4VHBUaFTsNEg0UVRgUFkVZV1kSC1lB
 WU5DVUlOS1VKTE1VSUlCWVdZCAFZQUlOSE03Bg++
X-HM-Tid: 0a7ad1350555b039kuuua9181ac021a
X-Headers-End: 1m6kzP-0000iP-VU
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: allow write compress
 released file after truncate to zero
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

VGhhbmtzIGZvciB5b3VyIGFkdmlzZSwgSSdsbCBzZW5kIG5ldyB2ZXJzaW9uIGxhdGVyLgoKCk9u
IDIwMjEvNy8yMiAyMToyNiwgQ2hhbyBZdSB3cm90ZToKPiBPbiAyMDIxLzcvMiAxMToxMSwgRmVu
Z25hbiBDaGFuZyB3cm90ZToKPj4gV2Ugc2hvdWxkIGFsbG93IHdyaXRlIGNvbXByZXNzIHJlbGVh
c2VkIGZpbGUgYWZ0ZXIgdHJ1bmNhdGUgdG8gemVyby4KPj4KPj4gU2lnbmVkLW9mZi1ieTogRmVu
Z25hbiBDaGFuZyA8Y2hhbmdmZW5nbmFuQHZpdm8uY29tPgo+PiAtLS0KPj4gwqAgZnMvZjJmcy9m
aWxlLmMgfCA3ICsrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+PiBpbmRl
eCA2YWZkNDU2MjMzNWYuLjY4NGZjMmU4ZDhhNCAxMDA2NDQKPj4gLS0tIGEvZnMvZjJmcy9maWxl
LmMKPj4gKysrIGIvZnMvZjJmcy9maWxlLmMKPj4gQEAgLTc0MCw2ICs3NDAsMTMgQEAgaW50IGYy
ZnNfdHJ1bmNhdGVfYmxvY2tzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHU2NCAKPj4gZnJvbSwgYm9v
bCBsb2NrKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4gwqAgI2lmZGVmIENP
TkZJR19GMkZTX0ZTX0NPTVBSRVNTSU9OCj4+ICvCoMKgwqAgLyoKPj4gK8KgwqDCoMKgICogV2Ug
c2hvdWxkIGFsbG93IHdyaXRlIGNvbXByZXNzIHJlbGVhc2VkIGZpbGUKPj4gK8KgwqDCoMKgICog
YWZ0ZXIgdHJ1bmNhdGUgdG8gemVyby4KPj4gK8KgwqDCoMKgICovCj4gCj4gUGxlYXNlIGRvY3Vt
ZW50IHRoZSBiZWhhdmlvci4KPiAKPj4gK8KgwqDCoCBpZiAoZjJmc19jb21wcmVzc2VkX2ZpbGUo
aW5vZGUpICYmICFmcmVlX2Zyb20pCj4gCj4gJiYgaXNfaW5vZGVfZmxhZ19zZXQoaW5vZGUsIEZJ
X0NPTVBSRVNTX1JFTEVBU0VEKQo+IAo+IFRoYW5rcywKPiAKPj4gK8KgwqDCoMKgwqDCoMKgIGNs
ZWFyX2lub2RlX2ZsYWcoaW5vZGUsIEZJX0NPTVBSRVNTX1JFTEVBU0VEKTsKPj4gKwo+PiDCoMKg
wqDCoMKgIGlmIChmcm9tICE9IGZyZWVfZnJvbSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJy
ID0gZjJmc190cnVuY2F0ZV9wYXJ0aWFsX2NsdXN0ZXIoaW5vZGUsIGZyb20sIGxvY2spOwo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVycikKPj4KPiAKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApM
aW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
