Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD7EC55179
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 11:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zR0U2rxG2SuLwXueJsTaEHOyvz31l8D2mCYH5hLEk0o=; b=OB47JF0vlai73zLIaCrsHpDVD5
	E/2pgr4ANjaIg6Mqk2ItbSSMPq5bSeZUyaID8QbKQiQiKRN9X1V9AXeDMZbkT8DF96x8Oi5YtyMyT
	2ZIFSv5VJ+GRYFKwYZ0IwSJNwfFQakaIUrc9X7uJawzkXsV3Tr603b6gOSQvcIOAGGbo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqqeO-0004lB-AW;
	Mon, 03 Aug 2026 11:16:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqqeN-0004l5-3U
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NgB5TGBTesYFZNXLGVN7ux4ODs8pJdqHMtJa/tUeS/0=; b=bR8MLDnQNf/10AYZKBRoc9Od97
 WEWUa3z5Ih2lOZyChyULp+l2AAO4jVwqPX6Ob13iAFQIt8H/uVRpeVAq93uODEwUoosQT6e7R4JTw
 4NP/35Tc0wKAIjMDwTWHfb4FVVDmaSagStqxpRXw/eGvosqhQEcECf4UcD6CwAbdwFAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NgB5TGBTesYFZNXLGVN7ux4ODs8pJdqHMtJa/tUeS/0=; b=NUOI3wjXgJ85hWp9P8NN0sZS0W
 RaMGH5BOZreeW+/vBH5n4fA8zgC6hnFaZFH1vQuYe9LmVTUsQEY5uH1V0PnKCVWtLzkLVdlpRKPKd
 3hvdvKxHk2uZ03rw7JyUEVSWkbw8q2KUjB8z7M/af+M+uj/p7WJQk5ZMFOyrU0NJbNQc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqqeM-0007X4-Dt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 11:16:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9227660A82;
 Mon,  3 Aug 2026 11:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501391F000E9;
 Mon,  3 Aug 2026 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785755760;
 bh=NgB5TGBTesYFZNXLGVN7ux4ODs8pJdqHMtJa/tUeS/0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ce9HFKFUo/vR07EQP+yiXWEN84iW0Do0EoFjoNd8CMsM0i0zTBSrAz5oWlmclbdEd
 tnkvC5Jb33EC6hGxVunlxhFxDu0RsyhnolKrWAfkvX8+7S/MT95OZj17XlVt8SWQzi
 /0D+7RzIkfTSAtSUhN5y57RkHuU3tRQxugl+gVTGSlwmdcy6hjGYlkHP02l4WpWkKf
 i3305s9YDL58ZE8hgw5CWMEOUEmuwdJ9WKTXEbM9uyJ978pj1W/X06wGUwFo6pmlly
 7uMFdu8/av5iEALqf3GNgGKVcoFewG/Pk1eu5cXIEiYbFzM3JdIRiZ9RJjGHqoYYdP
 q60U61Bt5TImw==
Message-ID: <f7c20405-38bd-42f7-80de-c00ca184d153@kernel.org>
Date: Mon, 3 Aug 2026 19:15:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tomas Charvat <potvorapoletava@gmail.com>, jaegeuk@kernel.org
References: <CAGgHbmfx2RtXg81WH0SGs+=vpxJ4FaJCJewExdXtoNjfqLcExA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGgHbmfx2RtXg81WH0SGs+=vpxJ4FaJCJewExdXtoNjfqLcExA@mail.gmail.com>
X-Headers-End: 1wqqeM-0007X4-Dt
Subject: Re: [f2fs-dev] [BUG] F2FS memory leak in dentry and
 f2fs_extent_node caches under high-I/O workload
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgVG9tYXMsCgpUaGFua3MgZm9yIHRoZSByZXBvcnQuCgpPbiA3LzIwLzI2IDIwOjE0LCBUb21h
cyBDaGFydmF0IHdyb3RlOgo+IEhpIEphZWdldWsgYW5kIENoYW8sCj4gCj4gSSBhbSBleHBlcmll
bmNpbmcgYSBzZXZlcmUsIGxpbmVhciBtZW1vcnkgbGVhayB3aXRoaW4gdGhlIEYyRlMgc3Vic3lz
dGVtIHVuZGVyIGhlYXZ5IGRhdGFiYXNlIHdvcmtsb2FkIChNYXJpYURCKS4KPiAKPiBUaGUga2Vy
bmVsIFNsYWIgbWVtb3J5IChzcGVjaWZpY2FsbHkgS1JlY2xhaW1hYmxlKSBncm93cyBpbmRlZmlu
aXRlbHkgb3ZlciBhIGZldyBkYXlzIHVudGlsIHRoZSBzZXJ2ZXIgcnVucyBvdXQgb2YgbWVtb3J5
LCB1bmxlc3MgZm9yY2VkIHZpYSBgZWNobyAyID4gL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzYCwg
d2hpY2ggaW5zdGFudGx5IGRyb3BzIHRoZSBtZW1vcnkgYmFjayB0byBub3JtYWwuCj4gCj4gU3lt
cHRvbSBEZXRhaWxzCj4gVGhlIHNlcnZlciBhY3RzIGFzIGEgaGVhdnkgZGF0YWJhc2Ugbm9kZSwg
Y29uc3RhbnRseSByZXdyaXRpbmcgdHJhbnNhY3Rpb25hbCBsb2dzIGFuZCB0ZW1wb3JhcnkgZmls
ZXMuIE92ZXIgNC01IGRheXMsIHRoZSBLUmVjbGFpbWFibGUvU2xhYiBtZW1vcnkgc2NhbGVzIHVw
IHRvIH44MCBHaUIuCj4gCj4gQmVmb3JlIHJ1bm5pbmcgYGRyb3BfY2FjaGVzYCwgc2xhYnRvcCBy
ZXZlYWxzIGFuIGV4dHJlbWUgYWNjdW11bGF0aW9uIG9mIG92ZXIgMjMwIG1pbGxpb24gb2JqZWN0
cyBpbiBkZW50cnkgYW5kIGYyZnMgY2FjaGVzOgo+IAo+IEFjdGl2ZSAvIFRvdGFsIE9iamVjdHMg
KCUgdXNlZCkgwqAgwqA6IDI3MzU5MjEzNSAvIDI3NjUxNTAzMiAoOTguOSUpCj4gQWN0aXZlIC8g
VG90YWwgU2l6ZSAoJSB1c2VkKSDCoCDCoCDCoCA6IDQyNDUxODU5IC8gNDM2MjY1OTYgKDk3LjMl
KQo+IAo+ICDCoCDCoCBPQkpTIMKgIEFDVElWRSDCoFVTRSBPQkogU0laRSDCoFNMQUJTIE9CSi9T
TEFCIENBQ0hFIFNJWkUgTkFNRQo+IDExNjE0MDg3OCAxMTYxNDA4NTIgwqA5OSUgwqAgwqAwLjE5
SyAyNzY1MjU5IMKgIMKgIMKgIDQyIMKgIDIyMTIyMDcyIGRlbnRyeQo+IDExMzE1NzE4NCAxMTMx
Mjg1OTQgwqA5OSUgwqAgwqAwLjA3SyAyMDIwNjY0IMKgIMKgIMKgIDU2IMKgIMKgODA4MjY1NiBm
MmZzX2V4dGVudF9ub2RlCgpDYW4geW91IHBsZWFzZSBydW4gImNhdCAvc3lzL2tlcm5lbC9kZWJ1
Zy9mMmZzL3N0YXR1cyIgdG8gY2FwdHVyZSB1c2FnZQpvZiBleHRlbnQgY2FjaGU/Cgo+ICDCoDY1
NDAxOTYgwqA2NDk5NTU1IMKgOTklIMKgIMKgMS4wOEsgMjI1NTI0IMKgIMKgIMKgIDI5IMKgIMKg
NzIxNjc2OCBmMmZzX2lub2RlX2NhY2hlCj4gCj4gV29ya2Fyb3VuZCBJbXBhY3QKPiBSdW5uaW5n
IGBlY2hvIDIgPiAvcHJvYy9zeXMvdm0vZHJvcF9jYWNoZXNgIGltbWVkaWF0ZWx5IHB1cmdlcyB0
aGUgZGVhZCBvYmplY3RzLCBkcm9wcGluZyBmMmZzX2V4dGVudF9ub2RlIGRvd24gdG8gfjM1N2sg
b2JqZWN0cyAoMjUgTUIpIGFuZCBkZW50cnkgZG93biB0byAxNU0gb2JqZWN0cywgcmVjbGFpbWlu
ZyB+NTAgR2lCIG9mIFJBTS4gSXQgYXBwZWFycyB0aGF0IEYyRlMgZmFpbHMgdG8gZXZpY3QvcmVj
bGFpbSB0aGVzZSBleHRlbnQgbm9kZXMgYW5kIGRpcmVjdG9yeSBlbnRyaWVzIGF1dG9tYXRpY2Fs
bHkgd2hlbiBmaWxlcyBhcmUgaGVhdmlseSBtb2RpZmllZC9vdmVyd3JpdHRlbiBhbmQgcm90YXRl
ZCBieSB0aGUgZGF0YWJhc2UgYXBwbGljYXRpb24uCgpBcyB5b3UgbWVudGlvbmVkLCBvbmNlIHlv
dSBlY2hvIDIgdG8gZHJvcF9jYWNoZXMsIHRoZW4gZjJmc19leHRlbnRfbm9kZQpjYWNoZSBjYW4g
YmUgc2hydW5rLCB0aGlzIGlzIGJlY2F1c2UgZjJmcyBoYXMgY29ubmVjdGVkIHRvIG1lbW9yeSBt
YW5hZ2VtZW50CnNocmlua2VyIHcvIGludGVybmFsIGV4dGVudCBjYWNoZS4KCklNTywgd2UgY2Fu
IGludHJvZHVjZSBzeXNmcyBub2RlIHRvIDEpIGxpbWl0IHRvdGFsIGNvdW50IG9mIGV4dGVudCBu
b2RlPyBvcgoyKSBsaW1pdCBtaW5pbWFsIHNpemUgb2YgZXh0ZW50IG5vZGUsIHNvIHRoYXQgd2Ug
Y2FuIGF2b2lkIHN0b3JlIGZyYWdtZW50ZWQKZXh0ZW50IG5vZGUgaW4gY2FjaGUgYWZ0ZXIgaGVh
dnkgcnVuIG9mIGRiIGFwcGxpY2F0aW9uLgoKV2hpY2ggb25lIHdvdWxkIGJlIHVzZWZ1bCB0byB5
b3VyIHNjZW5hcmlvPyBsZXQgbWUga25vdy4KClRoYW5rcywKCj4gCj4gUGxlYXNlIGxldCBtZSBr
bm93IGlmIHlvdSBuZWVkIGZ1cnRoZXIgZGVidWcgb3V0cHV0cywgb3IgaWYgSSBzaG91bGQgdGVz
dCBhIHNwZWNpZmljIHBhdGNoLgo+IAo+IEJlc3QgcmVnYXJkcywKPiBUb21hcyBDaGFydmF0CgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
