Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05328C83F27
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Jul 2025 01:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=22E/Y+85KDtyD+R8MZlB2PzIPUTt4jmhbJxY8NvF+Qo=; b=lvY+PsVqUYUpFF6TvNKgJCsqRN
	3Z33wkO773krHwYVe1fKWvUbq1DnDmOc3k+VZKUO9qIa5Naco++OE7Is0ILiulD08JNowL6B6XDXF
	tKg8wJ0eSzMnyOjsRiS8cTtQFTOdDnUo+titwW5odRvHwIsprxFQ6qMUqSI81PgKnD2A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ubql5-0000CN-Rl;
	Wed, 16 Jul 2025 01:16:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hsiangkao@linux.alibaba.com>) id 1ubql4-0000C7-FU
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Jul 2025 01:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kNCZo6e03bIhaM3yJ6Z7GsBUCWM2xE3LHwyTmkn0gfM=; b=Lvt9ubbxeFopv70X1ewS7swjzl
 4bD2Elz95WciVcNBXOL6vnfEXx7e5rOr4CR1luG/4gI27foIDgqwf/mJKFIxDeC7GIL1LLvsZ3eBb
 jh27+iqjiwJzZ92sbzoBwfYzEaOhdNrkrt5QOVpxyQsHMZcvMSh9Zdv+EvHl5OGeLWs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kNCZo6e03bIhaM3yJ6Z7GsBUCWM2xE3LHwyTmkn0gfM=; b=idDfWLYFP8IKYg2tNhv7ibon/G
 pFrkMDHyMcRLb8CdQNmErHqGeIhq28iLkRZozfY+8KROxm9kUBag4DiyBgT8acdT0ztm9fkb7Otsl
 ov4epmLKnYZvBrUtoePQpNqw0xb9WWGnHO8fXU+euqQCXucUuXZEPyyyFrf2AQgQvYGo=;
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ubql4-0005dP-H7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Jul 2025 01:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1752628578; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=kNCZo6e03bIhaM3yJ6Z7GsBUCWM2xE3LHwyTmkn0gfM=;
 b=qS4/mHlwIqEA0JMGrsn+FxIKH2bTQHBxfJIh+GUsuSFKiNDLBWVcAhGVpGGemAqXuVoEJDjAaoWouNhPr8g7J4iFgja2HRlWQDkiPSJyo58AUjNX8U6FuKy430h5LFJKy7/bkYGgn9OXo+0jhuA4dTYI0v8CIUKs9yKRms5uL6Q=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Wj1sJXu_1752628575 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 16 Jul 2025 09:16:17 +0800
Message-ID: <eeee0704-9e76-4152-bb8e-b5a0e096ec18@linux.alibaba.com>
Date: Wed, 16 Jul 2025 09:16:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Qu Wenruo <wqu@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>,
 linux-mtd@lists.infradead.org, David Howells <dhowells@redhat.com>,
 netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>,
 linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2806a1f3-3861-49df-afd4-f7ac0beae43c@suse.com>
X-Headers-End: 1ubql4-0005dP-H7
Subject: Re: [f2fs-dev] Compressed files & the page cache
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

Li4uCgo+IAo+Pgo+PiBUaGVyZSdzIHNvbWUgZGlzY3JlcGFuY3kgYmV0d2VlbiBmaWxlc3lzdGVt
cyB3aGV0aGVyIHlvdSBuZWVkIHNjcmF0Y2gKPj4gc3BhY2UgZm9yIGRlY29tcHJlc3Npb24uwqAg
U29tZSBmaWxlc3lzdGVtcyByZWFkIHRoZSBjb21wcmVzc2VkIGRhdGEgaW50bwo+PiB0aGUgcGFn
ZWNhY2hlIGFuZCBkZWNvbXByZXNzIGluLXBsYWNlLCB3aGlsZSBvdGhlciBmaWxlc3lzdGVtcyBy
ZWFkIHRoZQo+PiBjb21wcmVzc2VkIGRhdGEgaW50byBzY3JhdGNoIHBhZ2VzIGFuZCBkZWNvbXBy
ZXNzIGludG8gdGhlIHBhZ2UgY2FjaGUuCj4gCj4gQnRyZnMgZ29lcyB0aGUgc2NyYXRjaCBwYWdl
cyB3YXkuIERlY29tcHJlc3Npb24gaW4tcGxhY2UgbG9va3MgYSBsaXR0bGUgdHJpY2t5IHRvIG1l
LiBFLmcuIHdoYXQgaWYgdGhlcmUgaXMgb25seSBvbmUgY29tcHJlc3NlZCBwYWdlLCBhbmQgaXQg
ZGVjb21wcmVzc2VkIHRvIDQgcGFnZXMuCgpEZWNvbXByZXNzaW9uIGluLXBsYWNlIG1haW5seSBv
cHRpbWl6ZXMgZnVsbCBkZWNvbXByZXNzaW9uIChzbyB0aGF0IENQVQpjYWNoZSBsaW5lIHdvbid0
IGJlIHBvbGx1dGVkIGJ5IHRlbXBvcmFyeSBidWZmZXJzIGVpdGhlciksIGluIGZhY3QsCkVST0ZT
IHN1cHBvcnRzIHRoZSBoeWJpcmQgd2F5LgoKPiAKPiBXb24ndCB0aGUgcGxhaW50ZXh0IG92ZXIt
d3JpdGUgdGhlIGNvbXByZXNzZWQgZGF0YSBoYWxmd2F5PwoKUGVyc29uYWxseSBJJ20gdmVyeSBm
YW1pbGlhciB3aXRoIExaNCwgTFpNQSwgYW5kIERFRkxBVEUKYWxnb3JpdGhtIGludGVybmFscywg
YW5kIEkgYWxzbyBoYXZlIGV4cGVyaWVuY2UgdG8gYnVpbGQgTFpNQSwKREVGTEFURSBjb21wcmVz
c29ycy4KCkl0J3MgdG90YWxseSB3b3JrYWJsZSBmb3IgTFo0LCBpbiBzaG9ydCBpdCB3aWxsIHJl
YWQgdGhlIGNvbXByZXNzZWQKZGF0YSBhdCB0aGUgZW5kIG9mIHRoZSBkZWNvbXByZXNzZWQgYnVm
ZmVycywgYW5kIHRoZSBwcm9wZXIgbWFyZ2luCmNhbiBtYWtlIHRoaXMgYWxtb3N0IGFsd2F5cyBz
dWNjZWVkLiAgSW4gcHJhY3RpY2UsIG1hbnkgQW5kcm9pZApkZXZpY2VzIGFscmVhZHkgdXNlIEVS
T0ZTIGZvciBhbG1vc3QgNyB5ZWFycyBhbmQgaXQgd29ya3MgdmVyeSB3ZWxsCnRvIHJlZHVjZSBl
eHRyYSBtZW1vcnkgb3ZlcmhlYWQgYW5kIGhlbHAgb3ZlcmFsbCBydW50aW1lIHBlcmZvcm1hbmNl
LgoKSW4gc2hvcnQsIEkgZG9uJ3QgdGhpbmsgRVJPRlMgd2lsbCBjaGFuZ2Ugc2luY2UgaXQncyBh
bHJlYWR5Cm9wdGltYWwgYW5kIGdhaW5pbmcgbW9yZSBhbmQgbW9yZSB1c2Vycy4KCj4gCj4+Cj4+
IFRoZXJlIGFsc28gc2VlbXMgdG8gYmUgc29tZSBkaXNjcmVwYW5jeSBiZXR3ZWVuIGZpbGVzeXN0
ZW1zIHdoZXRoZXIgdGhlCj4+IGRlY29tcHJlc3Npb24gaW52b2x2ZXMgdm1hcCgpIG9mIGFsbCB0
aGUgbWVtb3J5IGFsbG9jYXRlZCBvciB3aGV0aGVyIHRoZQo+PiBkZWNvbXByZXNzaW9uIHJvdXRp
bmVzIGNhbiBoYW5kbGUgZG9pbmcga21hcF9sb2NhbCgpIG9uIGluZGl2aWR1YWwgcGFnZXMuCj4g
Cj4gQnRyZnMgaXMgdGhlIGxhdGVyIGNhc2UuCj4gCj4gQWxsIHRoZSBkZWNvbXByZXNzaW9uL2Nv
bXByZXNzaW9uIHJvdXRpbmVzIGFsbCBzdXBwb3J0IHN3YXBwaW5nIGlucHV0L291dHB1dCBidWZm
ZXIgd2hlbiBvbmUgb2YgdGhlbSBpcyBmdWxsLgo+IFNvIGttYXBfbG9jYWwoKSBpcyBjb21wbGV0
ZWx5IGZlYXNpYmxlLgoKSSB0aGluayBvbmUgb2YgdGhlIGJ0cmZzIHN1cHBvcnRlZCBhbGdvcml0
aG0gTFpPIGlzIG5vdCwgYmVjYXVzZSB0aGUKZmFzdGVzdCBMWjc3LWZhbWlseSBhbGdvcml0aG1z
IGxpa2UgTFo0LCBMWk8ganVzdCBvcGVyYXRlcyBvbiB2aXJ0dWFsCmNvbnNlY3V0aXZlIGJ1ZmZl
cnMgYW5kIHRyZWF0IHRoZSBkZWNvbXByZXNzZWQgYnVmZmVyIGFzIExaNzcgc2xpZGluZwp3aW5k
b3cuCgpTbyB0aGF0IGVpdGhlciB5b3UgbmVlZCB0byBhbGxvY2F0ZSBhbm90aGVyIHRlbXBvcmFy
eSBjb25zZWN1dGl2ZQpidWZmZXIgKEkgYmVsaWV2ZSB0aGF0IGlzIHdoYXQgYnRyZnMgZG9lcykg
b3IgdXNlIHZtYXAoKSBhcHByb2FjaCwKRVJPRlMgaXMgaW50ZXJlc3RlZCBpbiB0aGUgdm1hcCgp
IG9uZS4KClRoYW5rcywKR2FvIFhpYW5nCgo+IAo+IFRoYW5rcywKPiBRdQo+IAo+Pgo+PiBTbywg
bXkgcHJvcG9zYWwgaXMgdGhhdCBmaWxlc3lzdGVtcyB0ZWxsIHRoZSBwYWdlIGNhY2hlIHRoYXQg
dGhlaXIgbWluaW11bQo+PiBmb2xpbyBzaXplIGlzIHRoZSBjb21wcmVzc2lvbiBibG9jayBzaXpl
LsKgIFRoYXQgc2VlbXMgdG8gYmUgYXJvdW5kIDY0aywKPj4gc28gbm90IGFuIHVucmVhc29uYWJs
ZSBtaW5pbXVtIGFsbG9jYXRpb24gc2l6ZS7CoCBUaGF0IHJlbW92ZXMgYWxsIHRoZQo+PiBleHRy
YSBjb2RlIGluIGZpbGVzeXN0ZW1zIHRvIGFsbG9jYXRlIGV4dHJhIG1lbW9yeSBpbiB0aGUgcGFn
ZSBjYWNoZS4KPj4gSXQgbWVhbnMgd2UgZG9uJ3QgYXR0ZW1wdCB0byB0cmFjayBkaXJ0aW5lc3Mg
YXQgYSBzdWItZm9saW8gZ3JhbnVsYXJpdHkKPj4gKHRoZXJlJ3Mgbm8gcG9pbnQsIHdlIGhhdmUg
dG8gd3JpdGUgYmFjayB0aGUgZW50aXJlIGNvbXByZXNzZWQgYm9jawo+PiBhdCBvbmNlKS7CoCBX
ZSBhbHNvIGdldCBhIHNpbmdsZSB2aXJ0dWFsbHkgY29udGlndW91cyBibG9jayAuLi4gaWYgeW91
J3JlCj4+IHdpbGxpbmcgdG8gZGl0Y2ggSElHSE1FTSBzdXBwb3J0LsKgIE9yIHRoZXJlJ3MgYSBw
cm9wb3NhbCB0byBpbnRyb2R1Y2UgYQo+PiB2bWFwX2ZpbGUoKSB3aGljaCB3b3VsZCBnaXZlIHVz
IGEgdmlydHVhbGx5IGNvbnRpZ3VvdXMgY2h1bmsgb2YgbWVtb3J5Cj4+IChhbmQgY291bGQgYmUg
dHJpdmlhbGx5IHR1cm5lZCBpbnRvIGEgbm9vcCBmb3IgdGhlIGNhc2Ugb2YgdHJ5aW5nIHRvCj4+
IHZtYXAgYSBzaW5nbGUgbGFyZ2UgZm9saW8pLgo+Pgo+PgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
