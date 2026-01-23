Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9CED6CFBB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 04:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+tS5D2HDzHYDqL0gOJ5h1V71KlbkZSl2cU/bz7cek9M=; b=kMQNnNdy6UKNgTg6xneJeS1apb
	mw/MIHVycfQdw3EuxYgp5JdzIpW5vXHoifXyRP32eJbUNJKxqqJhYD6OLWjYpjRr/mhFs3gbSUvrD
	5rxkVaOlxpwu00MTCZpQIlk5cjC9+7xtH7tQLjVQZlzm98FoTCdN2Rjv5uiL1+8vOWuM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj8PE-00061H-SB;
	Fri, 23 Jan 2026 04:04:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vj8PD-00061A-Gx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 04:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ht5Iqhfl0HZRE9lt/accpC5Jorm3DKdYJst0XiPihlw=; b=Qo5jZgGpLkVIAEVlEXJwjX3HDS
 G9FKCI0vbz3ACEpl2O8ZkXPE4vg1vG2Tn6Rwu+R7yVHXj+N0C9SRJ5tOZCNCcBa6xHBykxUsXGy0/
 7kvHNFuf5XA7Q/w9EodutBj7YCvUI1o1jy5TaqODTO7APErnrD4zKRu9cJiDFR6KrnM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ht5Iqhfl0HZRE9lt/accpC5Jorm3DKdYJst0XiPihlw=; b=mB2sGO8oVds36DopWmx5Gbc5dT
 9XSS6YhZcgbfi1bYaB64dKFKOwf0krRWDXy7T63Rnml0tBwxWT4tshHvJKLs+qoPA4troym8S0NZF
 qtSbzfTLigepsS83raucM9RIQ/ggyZNw7GrQNqC217E/XnifUiOO1vwl4M4XEbMdDU3E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj8PC-0003aL-7K for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 04:04:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 137D8601EA;
 Fri, 23 Jan 2026 04:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3FEC4CEF1;
 Fri, 23 Jan 2026 04:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769141046;
 bh=fnP71bXuip4TbqjLM90QGyq1YAOJTk2KCtqIzNpoDD8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=JDTmwkdo4vAaL491EeOTY/qOXj9/MKu70ISzTxhaXT27Ab8bJsjnCxwrU5HOHNh4W
 wgtAT66jARIwMSSv1zyRGX2d+I98Y+ilDDBTQZLWyo9hIn/J7sT5oUyL82US1n8s7a
 C5nc7h1PVGOg38J06TlOw0xnZZyGExtJQ7YwwwsI6tjWP078CSI21DzWo2c/oOlCxP
 OJbRmp/RDUE4MSVhzONHDjGhTPeHalkJrz95UlDR/77PYqAnVd67OWEANpXR6nvHzU
 8/xQvHc2isS2RL5eeIveW5UkoDRHN5I+nXM8vl4n9n45YRvS6cx5pepSUROp7MWJTd
 /ZanQ0tqQkdiw==
Message-ID: <77f0a77f-532c-40f2-97c9-df1a064e4a89@kernel.org>
Date: Fri, 23 Jan 2026 12:04:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao@126.com>, Barry Song <21cnbao@gmail.com>
References: <20260109024716.12047-1-chao@kernel.org>
 <CAGsJ_4wjXMXk4YKsYebmtTa5dKVO21b91ieY=foYULWS+DyroQ@mail.gmail.com>
 <2cdd4281-7e37-4dd0-91b1-1ab16ef772aa@kernel.org>
 <CAGsJ_4weE5T1uBA1-JoJdbZY4E91eN_OL3hMdqixLcoKSrmuzw@mail.gmail.com>
 <8c13ca69-a08a-41c7-bbef-0a79a5f44f93@kernel.org>
 <83419982-77ba-4dac-880e-bf59669a006f@126.com>
Content-Language: en-US
In-Reply-To: <83419982-77ba-4dac-880e-bf59669a006f@126.com>
X-Headers-End: 1vj8PC-0003aL-7K
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to prevent clearing immutable for
 large folio supported inode
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMS8yMi8yMDI2IDEwOjAyIEFNLCBOYW56aGUgWmhhbyB3cm90ZToKPiBIaSBhbGw6Cj4gCj4g
5ZyoIDIwMjYvMS85IDE2OjQ0LCBDaGFvIFl1IHZpYSBMaW51eC1mMmZzLWRldmVsIOWGmemBkzoK
PiAKPj4gdy8gYWJvdmUgbG9ja3MsIGl0IHNlZW1zIHRoZXJlIGlzIHN0aWxsIGEgcmFjZSBjb25k
aXRpb24gYXMgYmVsb3c6Cj4+Cj4+IGYyZnNfZmlsZWF0dHJfc2V0wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJlYWQKPj4gICDCoC0gZjJmc19zZXRmbGFnc19jb21tb24KPj4gICDCoCAt
IHRydW5jYXRlX3BhZ2VjYWNoZQo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLSBmMmZzX3JlYWRfZGF0YV9sYXJnZV9mb2xpbwo+PiAgIMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgOiByZWFkIGxhcmdlIGZvbGlv
cwo+PiAgIMKgIC0gbWFwcGluZ19zZXRfZm9saW9fb3JkZXJfcmFuZ2UKPj4KPj4gVGhhbmtzLAo+
IAo+IEkgbm90aWNlZCB0aGF0IHRoZSBjb21tZW50IGZvciBgbWFwcGluZ19zZXRfZm9saW9fb3Jk
ZXJfcmFuZ2UoKWAgc2F5czoKPiAKPj4gIkNvbnRleHQ6IFRoaXMgc2hvdWxkIG5vdCBiZSBjYWxs
ZWQgd2hpbGUgdGhlIGlub2RlIGlzIGFjdGl2ZSBhcyBpdCBpcyBub24tYXRvbWljLiIKPiAKPiBJ
J20gbm90IHN1cmUgd2hldGhlciBjYXNlcyBsaWtlIGYyZnNfZmlsZWF0dHJfc2V0IGZhbGxzIGlu
dG8gdGhlIGlub2RlCj4gYWN0aXZlIGNhc2UuCj4gCj4+Pgo+Pj4KPj4+IElmIGNsZWFyaW5nIGlt
bXV0YWJsZSBpcyBpbmRlZWQgcmFyZSwgd2UgbWF5IGxlYXZlIHRoaXMgYXMgaXMsIHNpbmNlCj4+
PiB3cml0ZXMgYXJlIG5vdCBzdXBwb3J0ZWQgdW50aWwgdGhlIHBhZ2UgY2FjaGUgaXMgZnVsbHkg
ZHJvcHBlZC4KPj4+IEV2ZW50dWFsbHksIHdlIHdpbGwgc3VwcG9ydCBsYXJnZSBmb2xpb3Mgb24g
bm9uLWltbXV0YWJsZSBmaWxlcy4KPj4+Cj4+PiBUaGFua3MKPj4+IEJhcnJ5Cj4gCj4gQWxzbywg
SSBjb3VsZG7igJl0IGZpbmQgYW55IEFQSSBpbiBgaW5jbHVkZS9saW51eC9wYWdlbWFwLmhgIHRo
YXQgY2FuCj4gYXRvbWljYWxseSBzZXQgdGhlCj4gZm9saW8gb3JkZXIgcmFuZ2UuIEhvd2V2ZXIs
IEkgdGhpbmsgZHluYW1pY2FsbHkgc2V0dGluZyBsYXJnZSBmb2xpbwo+IG9yZGVyIHdoaWxlIGFu
IGlub2RlCj4gaXMgYWN0aXZlIGlzIGEgcmVhc29uYWJsZSByZXF1aXJlbWVudC4gSW4gbXkgbm9u
IGltbXV0YWJsZSBmaWxlIGxhcmdlCj4gZm9saW8gd3JpdGUgd29yaywgSSBuZWVkIHRvIGVuYWJs
ZSBsYXJnZSBmb2xpbyBzdXBwb3J0IGZvciBhIGZpbGUgd2hlbgo+IGl0IGlzIGNvbnZlcnRlZCBm
cm9tIGFuIGlubGluZSBmaWxlIHRvIGEgbm9uLWlubGluZSBmaWxlLiBUaGUgbGFjayBvZiBhbgo+
IGF0b21pYyBBUEkgc2VlbXMgdG8gYmUgYSBibG9ja2VyIGZvciBtb3ZpbmcgbGFyZ2UgZm9saW8g
d3JpdGUgZm9yd2FyZC4KPiBBbnkgaWRlYSBvbiB0aGF0PwoKSUlVQywgb3VyIGNvbmNlcm4gaGVy
ZSBpcyB0byBhdm9pZCAiZWNobyAzID4gZHJvcF9jYWNoZXMiLCByaWdodD8KCklmIHNvLCBjYW4g
d2UgdHJ5IHRoaXMgaW4gbmV3IGlvY3RsPwotIGtlcm5fcGF0aCh0YXJnZXRfZmlsZV9wYXRoKQot
IGRfaW52YWxpZGF0ZShwYXRoLT5kZW50cnkpCi0gcGF0aF9wdXQKCj4gCj4gVGhhbmtzLAo+IE5h
bnpoZSBaaGFvCj4gCj4gCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
