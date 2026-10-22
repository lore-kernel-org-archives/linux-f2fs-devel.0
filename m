Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75499606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PosIegUj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E8fepU46;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ba/YbrLo;
	dkim=neutral header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=bC8DYfqY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=oMMAyDWsvoQw9hTU+pvjRW6RoRQ/YJSsIhqpKfaNyts=; b=PosIegUjOlidh9MAmU5AW06kwi
	jb2OkumD7ZC0Gixa8ri/Tt/0EJALc1NnkviIIdxoSSel3B2CVEZ6/58NK0NO4sIleJcZ6XuBkthOZ
	fb4wyzZsY/Qbc9aPj7qsAw58IIKJsLByJu9mTle+0MJJNjUCwhW2rcW/iiPy2nMywPeM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJi4X-0000000022n-2QIT;
	Thu, 22 Oct 2026 01:58:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao@126.com>) id 1xJi4V-0000000022g-3VXY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 01:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=DnopcSwUb/bweHu3ihzSfCyHrSkeN2Q/wJyvQ9VQBXk=; b=E8fepU46aDDi
 TRyOkQST6LZEZ/d9BPPAFhAFY6REFwOyRNOTBmuUKQMISs6TlGO7yAK8JOflJv6LP16lznqjAnCsR
 eoCXVLY5o7OLED5D07/kQSnjDeMfOip7dGGUDAIUgX0B3Dg7zMQxzFGH5Ct8kIIyTJeYZSgt/KJoA
 YFhjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DnopcSwUb/bweHu3ihzSfCyHrSkeN2Q/wJyvQ9VQBXk=; b=Ba/YbrLonWo6ncmZvKx+7Yae4v
 1uC6wOZ0I9szD0a7WNMUHzbnrzCeJ1lJ/Jc1ZdbBAxlczyxWJvC1Xz1L1L30TgB7AXxzga7Ladkvx
 YFWO1GQr3WFey4BNWKutvVnQy1vUYRDOXf1MZvnz/KCIzedxPPuqiMjZDKlxtJeubQtE=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJi4U-000000008Oo-2ljJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 01:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=DnopcSwUb/bweHu3ihzSfCyHrSkeN2Q/wJyvQ9VQBXk=; b=b
 C8DYfqYw04fvBStFa7815FrakYjuFBfj9/vru51Z+g/B3XXMZH09u0/p79oyKltL
 FQSPY++ZuESVZa2gALz/IPtYE91cM1iSIiKFQxmP3nnfsRmBjkmbeKjI9j9HcZu4
 juA1XO5WFG19893617hQF9XmxNbaMWuul5iupu5EMk=
Date: Thu, 22 Oct 2026 09:57:45 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Chao Yu" <chao@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <36d24c53-25e0-45de-889b-f309ee6a0bdd@kernel.org>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <20261014064445.2835813-6-zhaonanzhe@xiaomi.com>
 <6be679d1-d8ab-41b3-9975-1f1bcd552579@kernel.org>
 <36d24c53-25e0-45de-889b-f309ee6a0bdd@kernel.org>
X-NTES-SC: AL_Qu2SAPqYu0ot4yeQZekdmEoVj+o8Xsaxs/8g2YJSc8gOtgfUwzsQWHZeElbTwO69ABq9sQGSYCZS08NTWLJTKWLh3xKMeYpfjV5kmQOYJQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <12edc14a.1662.1a1615420ba.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cSkvCgDnj8CZbdlqaQRUAA--.33309W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxmSYmrZbZksiQAA3o
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJi4U-000000008Oo-2ljJ
Subject: Re: [f2fs-dev] [PATCH v5 05/16] f2fs: support large folio writeback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cj4+PiArb3V0Ogo+Pj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAq
IENsZWFyIHRoZSBkaXJ0eSBzdGF0ZSBvZiB0aGUgc3VicmFuZ2VzIHRoYXQgd2VyZSB3cml0dGVu
IGJhY2suCj4+PiArwqDCoMKgwqDCoMKgwqDCoCAqIElmIHNvbWUgc3VicmFuZ2VzIGFyZSBzdGls
bCBkaXJ0eSAoZS5nLiB0aGUgZm9saW8gd2FzIG9ubHkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
cGFydGlhbGx5IHdyaXR0ZW4gYmFjayksIHRoZSBmb2xpbyBtdXN0IHN0YXkgZGlydHkgc28gdGhh
dAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB0aGUgcmVtYWluaW5nIHN1YnJhbmdlcyBhcmUgd3Jp
dHRlbiBiYWNrIGxhdGVyLgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqDCoMKg
wqDCoCBpZiAoZjJmc19mZnNfY2xlYXJfc3VicmFuZ2VfZGlydHlfYW5kX3Rlc3QoZm9saW8sIDAs
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGVyciA/IHBvcyA6
IGVuZF9wb3MpIC0gZm9saW9fcG9zKGZvbGlvKSkpCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBmb2xpb19yZWRpcnR5X2Zvcl93cml0ZXBhZ2Uod2JjLCBmb2xpbyk7Cj4KPkZvciBmb2xpbyBv
cmRlci0wLCBpZiBmMmZzX3dyaXRlX2ZvbGlvX2RpcnR5X3JhbmdlKCkgZmFpbGVkLCB3ZSBuZWVk
IHRvIHJlZGlydHkKPmZvbGlvIGFueXdheSwgcmlnaHQ/IHNvIGl0J3MgbmVlZCB0byBjaGVjayBl
cnIgYXMgd2VsbD8KPgo+VGhhbmtzLAo+CgpJbiBmMmZzOiBoYW5kbGUgcGFydGlhbCB0cnVuY2F0
ZSBvZiBsYXJnZSBmb2xpbyBkaXJ0eSBzdWJwYWdlcyBJIGhhdmUgdGhlIGZvbGxvd2luZyBodW5r
CkBAIC00NTE0LDkgKzQ1OTAsOSBAQCBzdGF0aWMgaW50IGYyZnNfd3JpdGVfY2FjaGVfZm9saW9z
KHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAogCQkgKiBSZWRpcnR5IHRoZSBmb2xpbyBp
ZiBkaXJ0eSBzdWJyYW5nZXMgcmVtYWluIGluIGEgbGFyZ2UKIAkJICogZm9saW8sIG9yIGlmIG9y
ZGVyLTAgd3JpdGViYWNrIGZhaWxzIGR1ZSB0byBhbiBlcnJvci4KIAkJICovCi0JCWlmIChmMmZz
X2Zmc19jbGVhcl9zdWJyYW5nZV9kaXJ0eV9hbmRfdGVzdChmb2xpbywgMCwKLQkJCQkJKGVyciA/
IHBvcyA6IGVuZF9wb3MpIC0gZm9saW9fcG9zKGZvbGlvKSkgfHwKLQkJCQkJZXJyKQorCQlkaXJ0
eSA9IGYyZnNfZmZzX2NsZWFyX3N1YnJhbmdlX2RpcnR5X2FuZF90ZXN0KGZvbGlvLCAwLAorCQkJ
CQkoZXJyID8gcG9zIDogZW5kX3BvcykgLSBmb2xpb19wb3MoZm9saW8pKTsKKwkJaWYgKGRpcnR5
IHx8IGVycikKIAkJCWZvbGlvX3JlZGlydHlfZm9yX3dyaXRlcGFnZSh3YmMsIGZvbGlvKTsKIAkJ
ZWxzZSBpZiAoIWYyZnNfZm9saW9faGFzX2Zmcyhmb2xpbykpCiAJCQlpbm9kZV9kZWNfZGlydHlf
YmxvY2soaW5vZGUpOwp0byBzb2x2ZSB0aGlzIHByb2JsZW0uIEJ1dCBpdCBzZWVtcyBJIGhhdmUg
cHV0IHRoaXMgaHVuayBpbiBhIHdyb25nIHBsYWNlLgpJdCBzaG91bGQgYmUgaW50cm9kdWNlZCBp
biB0aGlzIHBhdGNoIEkgdGhpbmsuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
