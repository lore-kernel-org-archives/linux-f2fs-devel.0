Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B3606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=U7ubVZGi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mf73LSfY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pu2TnGoe;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PODESZ7W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive
	:List-Unsubscribe:List-Id:Subject:Date:References:In-Reply-To:To:Message-ID:
	Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=c8+hsXAPrr0l5iIFkbKzMsBpCiTNawXGGHJvP7JXwWI=; b=U7ubVZGiWGK1+7kvrFdecEozMm
	MHGY/zzZnEvYwHmXDZ9QNSK8GhP8L6i4pcPkst7k4c2lV43pFI9rgO6CoLd9h+ALxunK0OiKVsWp6
	Onmt9BpyRgaaRQQ5HzieQDtOKXDNdAJfWHfIjqFL8zD/1w59miFWRa/aJkwT2ToFi+2E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUALU-000000002LC-20Pm;
	Thu, 19 Nov 2026 22:11:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <sashiko-bot@kernel.org>) id 1xUALD-000000002Kf-4BPx
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 22:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Date:Content-Transfer-Encoding:Content-Type:
 References:In-Reply-To:Cc:To:Reply-To:Subject:From:Message-ID:Sender:
 MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=2893f17q7j2y4ovFQG0JLrEzRR5Vk7OnicXJj+XMXps=; b=mf73LSfYKQ3w
 +rZsmbyJqiObntthy0MoOZKGGYm80900vEHCvO8GwVyBzpyKnqkKKgm47Bd5IFOBnjwUXfV6KCELd
 WEL3tsAu7N437ct5gMMTF0sIdiCZ+zLBefS0lw6W23GBFZZvd4liogDczdLom5vWhaLAFwn4r9SNd
 142mY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Date:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:
 Reply-To:Subject:From:Message-ID:Sender:MIME-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2893f17q7j2y4ovFQG0JLrEzRR5Vk7OnicXJj+XMXps=; b=Pu2TnGoeAX5sf16Gl8fshpnrZl
 SkNVpcGtBsyAO+cOX+HiB5OlBPWPeeZPQn5annvfEpAo8t1qT4bGSJ0BCf7/eXp35Etq8vGCEu+2u
 StbC6i0PSqeCFxlTZSjMi1fy0My11RQBfwqm0cOeoUM+7C3rcp86MQe7gpQ0LF++3z44=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUALC-000000004yy-0wW2
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 22:10:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAB13435F9;
 Thu, 19 Nov 2026 22:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B1E1F000C0;
 Thu, 19 Nov 2026 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795126244;
 bh=2893f17q7j2y4ovFQG0JLrEzRR5Vk7OnicXJj+XMXps=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PODESZ7WTk6nIUdgV2PuXAr04of3KU2UOzqd6edjHtQ61qInYO+QNsFsj+Q1ytRY6
 RCw28uLHBCQON1HLIrO1FzNS+dxHWwpOop1gA+pCvEc72Dh+QI+0ibOi5QWgeP5jwn
 L0yGkM/NiHedYASO6Ucv1oLwuYn5Cgki7pvS4JcXmMJKSDjVGo/wtSYSukHVd1EAaU
 0SO0WszS1IwwQApI+XjVdgeN/M1lvreS3WhdRwCDMDjfDypkkOXL2ILt6YKBdGSIOI
 MZjGb7muGwYsLtRi8he6UJF9bLAKiYT0q14gKJrqjQkVOVl6oBWgo7QnTgNlsh7CW7
 1T97befAFl1xw==
Message-ID: <sashiko-outbox-224119@kernel.org>
To: "Sarthak Kukreti via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
In-Reply-To: <20261119214944.1480596-2-sarthakkukreti@google.com>
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
 <20261119214944.1480596-2-sarthakkukreti@google.com>
Date: Thu, 19 Nov 2026 22:10:44 +0000
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUALC-000000004yy-0wW2
Subject: Re: [f2fs-dev] [PATCH v2 1/3] libfs: reject casefolded names that
 fold to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: sashiko-bot--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBVbmljb2RlIG5vcm1hbGl6YXRpb24gYW5kIGNhc2Vmb2xkaW5nICh1dGY4X2Nhc2Vmb2xkKCkp
IHN0cmlwcyBjb2RlCj4gcG9pbnRzIHdpdGggdGhlIERlZmF1bHRfSWdub3JhYmxlX0NvZGVfUG9p
bnQgcHJvcGVydHkuIEFzIGEgcmVzdWx0Ogo+IAo+IDEuIEEgZmlsZW5hbWUgY29uc2lzdGluZyBv
ZiAiLiIgb3IgIi4uIiBmb2xsb3dlZCBieSBpZ25vcmFibGUgY2hhcmFjdGVycwo+ICAgIChlLmcu
ICIuXHhlMlx4ODBceGFlIiBvciAiLi5ceGUyXHg4MFx4YWUiKSBieXBhc3NlcyBWRlMgc3BlY2lh
bC1lbnRyeQo+ICAgIGhhbmRsaW5nIGR1cmluZyBwYXRoIHdhbGssIGJ1dCBjYXNlZm9sZHMgdG8g
Ii4iIG9yICIuLiIuCj4gMi4gQSBmaWxlbmFtZSBjb25zaXN0aW5nIHNvbGVseSBvZiBpZ25vcmFi
bGUgY2hhcmFjdGVycyAoZS5nLgo+ICAgICJceGUyXHg4MFx4YWUiKSBjYXNlZm9sZHMgdG8gdGhl
IGVtcHR5IHN0cmluZyAiIiAobGVuZ3RoIDApLCBjYXVzaW5nCj4gICAgYW55IHR3byBkaXN0aW5j
dCBpZ25vcmFibGUtb25seSBmaWxlbmFtZXMgdG8gY29tcGFyZSBhbmQgaGFzaCBhcwo+ICAgIGVx
dWFsLgo+IAo+IFVwZGF0ZSBnZW5lcmljX2NpX2RfaGFzaCgpLCBnZW5lcmljX2NpX21hdGNoKCks
IGFuZAo+IGdlbmVyaWNfY2lfdmFsaWRhdGVfc3RyaWN0X25hbWUoKSB0byByZWplY3QgY2FzZS1p
bnNlbnNpdGl2ZSBoYXNoaW5nLAo+IG1hdGNoaW5nLCBhbmQgY3JlYXRpb24gb2YgZmlsZW5hbWVz
IHRoYXQgY2FzZWZvbGQgdG8gIiIsICIuIiwgb3IgIi4uIiwKPiB3aGlsZSBwcmVzZXJ2aW5nIGV4
YWN0IGJ5dGUtZXF1YWxpdHkgbWF0Y2hlcyAoc3VjaCBhcyBORlMgZXhwb3J0IGxvb2t1cHMKPiBv
ZiBsaXRlcmFsICIuLiIpLiBVc2luZyBhIDMtYnl0ZSBzdGFjayBidWZmZXIgd2l0aCB1dGY4X2Nh
c2Vmb2xkKCkKPiBkZXRlY3RzIGFsbCB0aHJlZSBjYXNlcyBpbiBPKDEpIHNwYWNlIHdpdGhvdXQg
aGVhcCBhbGxvY2F0aW9ucy4KPiAKPiBGaXhlczogYjg4NmVlM2U3NzhlICgiZXh0NDogU3VwcG9y
dCBjYXNlLWluc2Vuc2l0aXZlIGZpbGUgbmFtZSBsb29rdXBzIikKPiBGaXhlczogMmMyZWI3YTMw
MGNkICgiZjJmczogU3VwcG9ydCBjYXNlLWluc2Vuc2l0aXZlIGZpbGUgbmFtZSBsb29rdXBzIikK
PiBGaXhlczogYzg0Mzg0M2U3MTRjICgiZnM6IEFkZCBzdGFuZGFyZCBjYXNlZm9sZGluZyBzdXBw
b3J0IikKPiBDby1kZXZlbG9wZWQtYnk6IERtaXRyeSBUb3Jva2hvdiA8ZHRvckBnb29nbGUuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBUb3Jva2hvdiA8ZHRvckBnb29nbGUuY29tPgo+IFNp
Z25lZC1vZmYtYnk6IFNhcnRoYWsgS3VrcmV0aSA8c2FydGhha2t1a3JldGlAZ29vZ2xlLmNvbT4K
ClNhc2hpa28gaGFzIHJldmlld2VkIHRoaXMgcGF0Y2ggYW5kIGZvdW5kIG5vIGlzc3Vlcy4KCi0t
IApTYXNoaWtvIEFJIHJldmlldyDCtyBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0Y2hzZXQvMjAy
NjExMTkyMTQ5NDQuMTQ4MDU5Ni0xLXNhcnRoYWtrdWtyZXRpQGdvb2dsZS5jb20/cGFydD0xCgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
