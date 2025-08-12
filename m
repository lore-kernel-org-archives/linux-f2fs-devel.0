Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA0CA0EC4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Aug 2025 06:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZoVsGhyxbt7hDPvXzoMXPJfl8JczeGSjB4qRj9zJgzg=; b=G5aXmL8MzMx04d7mAjzBhZ2ZpJ
	U8TjuR3DCFl6gJIwlqumNn0epu7qEHCoEbkqOYWPQAD2Bx5Rm+iutoVBQCUnvNZy96lDxHsHraPk/
	X15UD+D9hopQja0UMnQ/WLak5ybbFocLIcBNQec8lYzVZu3p8IVb3JNZ5CGbhn5rs3jE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ulig6-0000eU-SI;
	Tue, 12 Aug 2025 06:40:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ulig5-0000eO-Qi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Aug 2025 06:40:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m5W3/rWHwieTBJdjEZYH12Mzqk6/4IUHGbwA0mSp6kk=; b=CPw7ipwfPSCfkcmS8Z/SmfRpOL
 AAIrXXGvnzKFTnMJS6xZehFFMtIB6hlTl9mE35W06dLHIJxJ7XiVsz5T4rB6s+7Lsa5zbzbf8Hvnq
 bDd1Wft96SJAOGuu220dioZEZnz8L1jtE1LlN8QDoqVzEcPxGIGidbiqjxGUdbJpMj60=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m5W3/rWHwieTBJdjEZYH12Mzqk6/4IUHGbwA0mSp6kk=; b=IaEBAw1Eo9V6LkYE+sBPpMQ83U
 7SEzgA74XgVhXqGRlqzsmHtqKxEaTG8pXKu6/UhckTUlPMTqePC8DYR12yMtBpE1LlqROLc6x992N
 s68BuRIL6bmDHo6uFREiaC6HHXvGUZpf/VtpsFjkbI1gh6YvKFiP6rLXrh1slr+6UeJY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ulig4-0005tN-JH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Aug 2025 06:40:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 333E75C6665;
 Tue, 12 Aug 2025 06:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4B1C4CEF5;
 Tue, 12 Aug 2025 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754980802;
 bh=X+KxCS2Uhbsew3KgO4hOa0KHv118lmYhJfEXIpizQLA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=uGeUgAKqMGN0+X2IcvnNoBIjhaf/7kQ6km8AFYlefJxFOCmWfvaXIhAMN8NzRBM0L
 rnc2gcYwUNVARLgR45xTNlChn0mDazpPUAefuhVjB6m96DUmWWkP5PLu6IG29+D5Mz
 RqTtyvjz6xrBcw8ehMGyp82K6gQZFoJQsgH6odkTn44TJUxOeNLcCVX26Fo/7Tf8Vg
 RxxX+56f42ROpsPP34MyJHPI3cQBWweNbS1ydIzDnYxduxMhNG5jbmNMbHgumRELnK
 pXS/kAuDiDr8OjyjLcN92VFKzePQFtO1cBF+6DgxmGxViz987NCEgLEJdhxWar9w3K
 7t4w4Famri2HA==
Message-ID: <5c44c233-50ea-4cf2-9de9-b99c9e197bce@kernel.org>
Date: Tue, 12 Aug 2025 14:39:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@infradead.org>
References: <20250807034838.3829794-1-chao@kernel.org>
 <aJnLXmepVBD4V2QH@infradead.org>
 <7a2534f5-bf20-4d3c-afe7-afcb8f340929@acm.org>
Content-Language: en-US
In-Reply-To: <7a2534f5-bf20-4d3c-afe7-afcb8f340929@acm.org>
X-Headers-End: 1ulig4-0005tN-JH
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce flush_policy sysfs entry
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
Cc: linux-block@vger.kernel.org, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOC8xMS8yNSAyMTo0NCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDgvMTEvMjUgMzo1
MiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIFRodSwgQXVnIDA3LCAyMDI1IGF0
IDExOjQ4OjM4QU0gKzA4MDAsIENoYW8gWXUgd3JvdGU6Cj4+PiBUaGlzIHBhdGNoIGludHJvZHVj
ZXMgYSBuZXcgc3lzZnMgZW50cnkgL3N5cy9mcy9mMmZzLzxkaXNrPi9mbHVzaF9wb2xpY3kKPj4+
IGluIG9yZGVyIHRvIHR1bmUgcGVyZm9ybWFuY2Ugb2YgZjJmcyBkYXRhIGZsdXNoIGZsb3cuCj4+
Pgo+Pj4gRm9yIGV4YW1wbGUsIGNoZWNrcG9pbnQgd2lsbCB1c2UgUkVRX0ZVQSB0byBwZXJzaXN0
IENQIG1ldGFkYXRhLCBob3dldmVyLAo+Pj4gc29tZSBraW5kIGRldmljZSBoYXMgYmFkIHBlcmZv
cm1hbmNlIG9uIFJFUV9GVUEgY29tbWFuZCwgcmVzdWx0IGluIHRoYXQKPj4+IGNoZWNrcG9pbnQg
YmVpbmcgYmxvY2tlZCBmb3IgbG9uZyB0aW1lLCB3LyB0aGlzIHN5c2ZzIGVudHJ5LCB3ZSBjYW4g
Z2l2ZQo+Pj4gYW4gb3B0aW9uIHRvIHVzZSBSRVFfUFJFRkxVU0ggY29tbWFuZCBpbnN0ZWFkIG9m
IFJFUV9GVUEgZHVyaW5nIGNoZWNrcG9pbnQsCj4+PiBpdCBjYW4gaGVscCB0byBtaXRpZ2F0ZSBs
b25nIGxhdGVuY3kgb2YgY2hlY2twb2ludC4KPj4KPj4gVGhhdCdzIGFuZCBvZGQgcGxhY2UgdG8g
ZGVhbCB3aXRoIHRoaXMuwqAgSWYgdGhhdCdzIGEgcmVhbCBpc3N1ZSBpdAo+PiBzaG91bGQgYmUg
YSBibG9jayBsYXllciB0d2VhayB0byBkaXNhYmxlIEZVQSwgcG90ZW50aWFsbHkgd2l0aCBhIHF1
aXJrCj4+IGVudHJ5IGluIHRoZSBkcml2ZXIgdG8gZGlzYWJsZSBpdCByYXRoZXIgdGhhbiBoYXZp
bmcgdG8gdG91Y2ggYSBmaWxlCj4+IHN5c3RlbSBzeXNmcyBhdHRyaWJ1dGUuCj4gCj4gQ2hhbywg
dHdvIHllYXJzIGFnbyBDaHJpc3RvcGggYWxyZWFkeSBzdWdnZXN0ZWQgdG8gaW50ZWdyYXRlIHRo
aXMKPiBmdW5jdGlvbmFsaXR5IGluIHRoZSBVRlMgZHJpdmVyLiBGcm9tCj4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtc2NzaS9ZK05DRHp2dUxKWUd3eWhDQGluZnJhZGVhZC5vcmcvOgo+
ICJQbGVhc2UgYWRkIHF1aXJrcyBmb3IgdGhlIGFjdHVhbGx5IGFmZmVjdGVkIGRldmljZXMsIGFu
ZCBkbyBub3QKPiBibG9jayBmdWEgZm9yIGFuIGVudGlyZSB0cmFuc3BvcnQuIgo+IAo+IFNlZSBh
bHNvIHRoZSB1ZnNfZml4dXBzW10gYXJyYXkgaW4gZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYy4K
CkJhcnQsIHRoYW5rIHlvdSBmb3IgbGV0dGluZyBtZSBrbm93IHRoZSBoaXN0b3J5IGFuZCBkZWNp
c2lvbiB0aGVyZS4gSSBoYWQgYQpxZW11IG9wdGlvbiBoZXJlIHRvIHJlc29sdmUgbXkgY3VycmVu
dCBpc3N1ZSwgdGhhbmtzLgoKVGhhbmtzLAoKPiAKPiBCYXJ0LgoKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcg
bGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3Rz
LnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
