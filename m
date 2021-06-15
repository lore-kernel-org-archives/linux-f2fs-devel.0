Return-Path: <SRS0=n5IJ=LJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAD8C48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Jun 2021 03:44:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB84613DE;
	Tue, 15 Jun 2021 03:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB84613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lt004-00056Z-7d; Tue, 15 Jun 2021 03:44:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <hsiangkao@linux.alibaba.com>) id 1lt002-00056O-0B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Jun 2021 03:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ultJo9kXDnC9Q7DQNp1pABZ7RffBHAkctB1wJxO61K8=; b=nWM219Q35vejfWeCNBBUgvymfJ
 jkWNPXS+5bLVV64sjxLY5ZfhFgasWcULv8ywR5YKDN4JZHTX4+qLd7j1/nCR8Oxs/N4K0V4UnEd1q
 YWXFEKomrg1mmJy6tkYiDaIivl3KYcgORUu47JmCdx6pvuBydE6W0BAKIYgfh/AXele0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ultJo9kXDnC9Q7DQNp1pABZ7RffBHAkctB1wJxO61K8=; b=O/ET1O8bm57KUy3sF+nxf5vW3D
 TaGekCxz/6964GCTT0MwuYUXJKkXlf5zuWdOjuFhxEg4ncZpAJmIog1VV03tv+emMsDicy5mAdAY5
 1JCfKeBust4AP0ZbFNbM2sJeHTvUWfDIl+1hMqQAWtoj4jQP6qF3dmsF71aSafa0rm1k=;
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lszzt-00A2dI-Rn
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Jun 2021 03:44:27 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0UcTI4qF_1623728648; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UcTI4qF_1623728648) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 15 Jun 2021 11:44:09 +0800
Date: Tue, 15 Jun 2021 11:44:07 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: "wangxiaojun (N)" <wangxiaojun11@huawei.com>
Message-ID: <YMgiByFZh46+CEd5@B-P7TQMD6M-0146.local>
References: <20210615013509.4130329-1-wangxiaojun11@huawei.com>
 <YMgRBshqToatVwzP@B-P7TQMD6M-0146.local>
 <36670fed-569b-c553-6283-fb6ef950e89c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <36670fed-569b-c553-6283-fb6ef950e89c@huawei.com>
X-Headers-End: 1lszzt-00A2dI-Rn
Subject: Re: [f2fs-dev] [PATCH] f2fs: replace ERANGE with ENAMETOOLONG in
 file name length check
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgpPbiBUdWUsIEp1biAxNSwgMjAyMSBhdCAxMToxOToyNEFNICswODAwLCB3YW5neGlhb2p1biAo
Tikgd3JvdGU6Cj4gCj4g5ZyoIDIwMjEvNi8xNSAxMDozMSwgR2FvIFhpYW5nIOWGmemBkzoKPiA+
IE9uIFR1ZSwgSnVuIDE1LCAyMDIxIGF0IDA5OjM1OjA5QU0gKzA4MDAsIFdhbmcgWGlhb2p1biB3
cm90ZToKPiA+ID4gRVJBTkdFIGluZGljYXRlcyB0aGF0IHRoZSBtYXRoIHJlc3VsdCBpcyBub3Qg
cmVwcmVzZW50YXRpdmUuIEhlcmUsCj4gPiA+IEVOQU1FVE9PTE9ORyBpcyB1c2VkIHRvIHJlcGxh
Y2UgRVJBTkdFLgo+ID4gPiAKPiA+ID4gU2lnbmVkLW9mZi1ieTogV2FuZyBYaWFvanVuIDx3YW5n
eGlhb2p1bjExQGh1YXdlaS5jb20+Cj4gPiBJIGRvbid0IHRoaW5rIEVOQU1FVE9PTE9ORyBpcyBh
IHZhbGlkIHJldHVybiBjb2RlIGZvciB7ZyxzfWV0eGF0dHIuCj4gPiBodHRwczovL21hbjcub3Jn
L2xpbnV4L21hbi1wYWdlcy9tYW4yL2dldHhhdHRyLjIuaHRtbAo+ID4gaHR0cHM6Ly9tYW43Lm9y
Zy9saW51eC9tYW4tcGFnZXMvbWFuMi9zZXR4YXR0ci4yLmh0bWwKPiA+IGluc3RlYWQgb2YgRVJB
TkdFLgo+ID4gCj4gPiBwbGVhc2UgYWxzbyBzZWUgZXh0NCAvIHhmcyBpbXBsZW1lbnRhdGlvbnMu
Cj4gPiAKPiA+IFRoYW5rcywKPiA+IEdhbyBYaWFuZwo+IAo+IEhpIFhpYW5nLCBZb3UncmUgcmln
aHQuIFRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4KCkhpIFhpYW9qdW4sCgpZZWFoLCBjdXJyZW50
bHkgRU5BTUVUT09MT05HIGlzIHN0cmljdGx5IHNwZWNpZmljIGZvciBwYXRobmFtZS4gSWYgd2UK
Y2hhbmdlIGxpa2UgdGhpcywgSSdtIG5vdCBzdXJlIGlmIGl0IGNvdWxkIGJyZWFrIHNvbWUgZXhp
c3QgdXNlcgpwcm9ncmFtcy4KCklPVywgaXQgc2hvdWxkIGJlIGEgd2lkZSBkaXNjdXNzaW9uIG9y
IG1vZGlmaWNhdGlvbiBhdCBsZWFzdC4KClRoYW5rcywKR2FvIFhpYW5nCgo+IAo+ID4gCj4gPiA+
IC0tLQo+ID4gPiAgIGZzL2YyZnMveGF0dHIuYyB8IDQgKystLQo+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0t
Z2l0IGEvZnMvZjJmcy94YXR0ci5jIGIvZnMvZjJmcy94YXR0ci5jCj4gPiA+IGluZGV4IGM4ZjM0
ZGVjYmY4ZS4uZWI4MjdjMTBlOTcwIDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9mMmZzL3hhdHRyLmMK
PiA+ID4gKysrIGIvZnMvZjJmcy94YXR0ci5jCj4gPiA+IEBAIC01MjksNyArNTI5LDcgQEAgaW50
IGYyZnNfZ2V0eGF0dHIoc3RydWN0IGlub2RlICppbm9kZSwgaW50IGluZGV4LCBjb25zdCBjaGFy
ICpuYW1lLAo+ID4gPiAgIAlsZW4gPSBzdHJsZW4obmFtZSk7Cj4gPiA+ICAgCWlmIChsZW4gPiBG
MkZTX05BTUVfTEVOKQo+ID4gPiAtCQlyZXR1cm4gLUVSQU5HRTsKPiA+ID4gKwkJcmV0dXJuIC1F
TkFNRVRPT0xPTkc7Cj4gPiA+ICAgCWRvd25fcmVhZCgmRjJGU19JKGlub2RlKS0+aV94YXR0cl9z
ZW0pOwo+ID4gPiAgIAllcnJvciA9IGxvb2t1cF9hbGxfeGF0dHJzKGlub2RlLCBpcGFnZSwgaW5k
ZXgsIGxlbiwgbmFtZSwKPiA+ID4gQEAgLTY0Niw3ICs2NDYsNyBAQCBzdGF0aWMgaW50IF9fZjJm
c19zZXR4YXR0cihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBpbnQgaW5kZXgsCj4gPiA+ICAgCWxlbiA9
IHN0cmxlbihuYW1lKTsKPiA+ID4gICAJaWYgKGxlbiA+IEYyRlNfTkFNRV9MRU4pCj4gPiA+IC0J
CXJldHVybiAtRVJBTkdFOwo+ID4gPiArCQlyZXR1cm4gLUVOQU1FVE9PTE9ORzsKPiA+ID4gICAJ
aWYgKHNpemUgPiBNQVhfVkFMVUVfTEVOKGlub2RlKSkKPiA+ID4gICAJCXJldHVybiAtRTJCSUc7
Cj4gPiA+IC0tIAo+ID4gPiAyLjI1LjQKPiA+ID4gCj4gPiA+IAo+ID4gPiAKPiA+ID4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+ID4gTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKPiA+ID4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKPiA+ID4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbGludXgtZjJmcy1kZXZlbAo+ID4gLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
