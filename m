Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069B3C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ylNn5fGSnJOqoUvhG0A9Rk/fpl+ifhKuoZx6FL3m2z0=; b=L0yd0hu1KSFAO2FOcsDJtx/cuN
	vJ3jp/aRxTzTLtF8Fz0RoMHJAsx0wMrGVtThTBwFE1rbsQ6NByHXvgFjsYWNCIwBhCcLV6AWzfo+O
	UQbpHBHQAXtnAKn0Xd/cHOVm8Z7+ynodlMUODyjHPscBt/9UYxXW2LDr+UPt694VyFHs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3Wk7-0007ce-At;
	Mon, 07 Sep 2026 10:38:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3Wk6-0007cT-8K
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:38:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jif7YOqws8v0iLETV8SqiVd/M0oatxoWs3V/aasBkPs=; b=B2vu17libiaqlNsOGQJ7qSaNe+
 5hORMKrHX8Im7IGfeNp52jPvxOdrz8Q+TTDeIgou4BBh0vp3OAqwBcHk20TvI+v0MENAFQsUQcnzf
 ALrPW73z5h/OXsn2FSP9BxFbNiphFTlY6+jDOkRK5k35w7a9r0FHAHqQReml+BFRCzSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jif7YOqws8v0iLETV8SqiVd/M0oatxoWs3V/aasBkPs=; b=IkNCkGOkLSsyDveDMKOk7uSLax
 0dy1L7z/4nXg20ySN2LMbIU+SVOYVipEW0H7jXZJP1DI5H0YN/Ps16qTbGjlgITYwkt/lC10KqR2i
 dqot31/v7zwkPdZDLgY6LwIJxsO9vMm3m5pYqCOL8TbUe7AW2qDmxpTuRegeFO3LKJp4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3Wk5-0001dY-LC for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:38:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F12B960D91;
 Mon,  7 Sep 2026 10:38:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8BD1F00A3A;
 Mon,  7 Sep 2026 10:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788777499;
 bh=jif7YOqws8v0iLETV8SqiVd/M0oatxoWs3V/aasBkPs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Lw3/jd395AQgBEku37pNfy8Wt8XO5RirSvUfWAmS7weBL2cU5qUeSVrrza1398KO/
 96lzw7Se/5+Jp9CbmomjU4ryxdLbbU255KbFf81aJQZaSsD836U1lFGWJgLSYy+Fa3
 hsj1RSLqv5CFhCew+a4iv7i2S0F+Q1nNkE1O8MSaxNk+FlgDBIBnfa2GdWZX9+qQST
 q+PNBShn5tp+0yJIecNfQD4/cplEdrKyWHcSv8alCV/fQANr4R48HGs78P57WwhR4J
 9Vub3+Q8qxGoCQyF1kSu+Od7jDQISn4rYjNXTyz55/Pewi9LPbnoezyiZPOdpFP23b
 lYHe6Joq0O0uQ==
Message-ID: <fca85496-5e0a-4cc8-b39f-127578bd2c02@kernel.org>
Date: Mon, 7 Sep 2026 18:38:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jiucheng Xu <jiucheng.xu@amlogic.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <5de3d9c8-e847-422f-a9e4-31ac2a1b5c2e@amlogic.com>
 <b90c9052-b44b-404a-85cc-8221249b63d7@kernel.org>
 <6e2adf29-e3a6-4033-80f8-e3ed672f47ac@amlogic.com>
Content-Language: en-US
In-Reply-To: <6e2adf29-e3a6-4033-80f8-e3ed672f47ac@amlogic.com>
X-Headers-End: 1x3Wk5-0001dY-LC
Subject: Re: [f2fs-dev] =?utf-8?q?=5BPING=5D=5BPATCH=5D_f2fs=3A_force_out?=
 =?utf-8?q?=E2=80=91place_update_for_all_writes_on_compressed_file?=
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

T24gOS83LzI2IDE2OjQ1LCBKaXVjaGVuZyBYdSB3cm90ZToKPiBPbiA5LzcvMjAyNiAzOjA4IFBN
LCBDaGFvIFl1IHdyb3RlOgo+PiBbIEVYVEVSTkFMIEVNQUlMIF0KPj4KPj4gT24gOS8yLzI2IDEx
OjE4LCBKaXVjaGVuZyBYdSB3cm90ZToKPj4KPj4gSml1Y2hlbmcsCj4+Cj4+IFNvcnJ5IGZvciBk
ZWxheSByZXBseS4KPj4KPj4KPj4gSSBkaWRuJ3QgZ2V0IGl0LCBjYW4geW91IHBsZWFzZSBkZXNj
cmliZSB0aGUgaXNzdWUgdy8gY2FsbCBzdGFjayBpbiByYWNlCj4+IGNvbmRpdGlvbj8KPj4KPiBI
aSBDaGFvLAo+IAo+IFRoYW5rcyBmb3IgeW91ciB0aW1lLCBUaGUgY2FsbCBzdGFjayBpcyBzaG93
biBhcyBiZWxvdzoKPiAKPiAtVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC0gVGhyZWFkIEIKPiAgIC0gZjJmc193cml0ZV9tdWx0aV9wYWdlcyAgICAgICAg
ICAgICAgICAgICAgICAgICAgLQo+IGYyZnNfZG93bl93cml0ZSgmc2JpLT5jcF9yd3NlbSk7Cj4g
ICAgLSBmMmZzX3dyaXRlX2NvbXByZXNzZWRfcGFnZXMgICAgICAgICAgICAgICAgICAgIC0gLi4u
Cj4gICAgIC0gZjJmc190cnlsb2NrX29wICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0g
Li4uCj4gICAgICAtIGYyZnNfZG93bl9yZWFkX3RyeWxvY2soJnNiaS0+Y3BfcndzZW0pOyAgICAg
IC0gLi4uCj4gICAgLSBmMmZzX3dyaXRlX3Jhd19wYWdlcyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0gLi4uCj4gCj4gVGhyZWFkIEIgYWNxdWlyZXMgdGhlIGxvY2sgZmlyc3QsIHdoaWNoIGNh
dXNlcyBUaHJlYWQgQSB0byBmYWlsIGxvY2sKPiBhY3F1aXNpdGlvbiBhbmQgZmFsbCBiYWNrIHRv
IHJhd+KAkWRhdGEgd3JpdGUuCj4gSVBVX0ZPUkNFIGlzIGVuYWJsZWQgb24gMTZHIGVNTUMgcGxh
dGZvcm1zLCBzbyBmMmZzX3dyaXRlX3Jhd19wYWdlcygpCj4gb3ZlcndyaXRlcyB0aGUgb3JpZ2lu
YWwgY29tcHJlc3NlZCBkYXRhIGlu4oCRcGxhY2UuCj4gVGhlIGlu4oCRbWVtb3J5IG5vZGUgaGFz
IGJlZW4gdXBkYXRlZCB3aXRoIHJhd+KAkWRhdGEgYWRkcmVzc2VzLCB3aGlsZSB0aGUKPiBub2Rl
IG1ldGFkYXRhIHN0b3JlZCBvbiBlTU1DIHN0aWxsIHJlbWFpbnMgaW4gY29tcHJlc3NlZCBzdGF0
ZS4KPiBJZiBhIHBvd2Vy4oCRY3V0IG9jY3VycyBiZWZvcmUgdGhlIG5vZGUgaXMgZmx1c2hlZCB0
byBkaXNrLCBvbuKAkWRpc2sKPiBpbmNvbnNpc3RlbmN5IGFyaXNlczogVGhlIGRhdGEgb24gZGlz
ayBpcyByYXcsIGJ1dCBtZXRhZGF0YQo+IHN0aWxsIHRyZWF0cyBpdCBhcyBhIGNvbXByZXNzZWQg
Y2x1c3RlciBhbmQgZGVjb21wcmVzc2lvbiB3aWxsIGZhaWwuCgpBaCwgbm93LCBJIHNlZSwgdGhh
bmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uLCBjYW4geW91IGFkZCBhYm92ZSBjYWxsc3RhY2sKaW4g
Y29tbWl0IG1lc3NhZ2UgYXMgd2VsbD8KClRoYW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApM
aW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
