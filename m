Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF987606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h2FFtFF+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TM6rW2Mz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HWMHyowF;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OOLMAm4y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:References:To:MIME-Version:Date:Message-ID:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=RJf3a+meBTNqZcZGaYTGBNA+5IdlRKgkLSVueNQSS8Q=; b=h2FFtFF+gg4VoDCkKJuJuQXbhg
	g+2ojgWH+9CBmwkhE6mGcUVP2Nsc+bU9xmXUVDDC0azOTxSZ80nsH3gBIXP2XD0TPz5WD6bU8i1wR
	wnUXo/mBlgIoO5uO61/tw4r4btIga0YW7UT9H70Wr3eEMM+nlB1xUrhRYBHZWINftFT8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSv73-0000000042w-3B7b;
	Mon, 16 Nov 2026 11:43:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <huangz6756@gmail.com>) id 1xSv71-0000000042q-3YZP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAVS+080rf6STw++O+Ktz26PTMaNyuHuh8VnsXWcVTA=; b=TM6rW2Mz69BYB4gijDY5Q8NmZT
 qiovrNF+TVQNW7pU5Un7l0PKfaYCBRp+n6EMKDZKqedVHYvvaFEeTisZ8h0nEzSnS4D7MRvPV89Dm
 yTLMzLkL3j30Pui1RmyPoOTJw/3PBIv8dDA5nCmQfZE5/ND/T2ZnXlkDPH9CPS1j1oCo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DAVS+080rf6STw++O+Ktz26PTMaNyuHuh8VnsXWcVTA=; b=HWMHyowFIpYTmSMuWEB1Fr6OCj
 dOm/Gd++6DwgYpWvxH2BQflUNCIG7nWkxZowb/RTEplfsR0nJM2WFy4xknzbRo7s7rM9EPm+c6+R9
 rXUmEpnFyOY6eIUAsH2GSBQigGjULm53Nvhs5Ved24Rxn/4uuePfJrWZbuTwQ7tFSJtM=;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSv71-000000004s1-1GQE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:43:03 +0000
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8a070781f63so1133887b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794829377; x=1795434177; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DAVS+080rf6STw++O+Ktz26PTMaNyuHuh8VnsXWcVTA=;
 b=OOLMAm4yFQzoMofDEBoDH7O7bt+gGBeE3n/hm8oajkDsBXXiucq1pCo1yeQ7Dr/Hse
 6mm8tZX+TZJgcrUqbMh6+T9OexlyCU0B1IOKIJ89pmGoMWhNRZ/4j3U9vovPFPAEP6+r
 +j9sHDYSWTWamYRKB1p8OF0GkQ5ovyDCB1hmCSD/73tHvYEmJww30k/IuGT7gypcIPs1
 MUyq3a9sh+/a4D4ajOTDG0cmOuVxuGx11Xu5XtguLCvFKP99BN09h/DpFufEsB3SPXJ0
 7HX6JVzzJXQxsTtA+2IB1q8wHeeOyfjUY+lx9vnICvEE6ppGnnu/tZkWhiCy2PTcLiWJ
 JLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829377; x=1795434177;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DAVS+080rf6STw++O+Ktz26PTMaNyuHuh8VnsXWcVTA=;
 b=EAqjzuLw4EAKjQZ/BoDYhkP/GCsW8QReKkTWCum3tQWQ0cWothYuyrpQkAx5SHWc6H
 hSyVqcYBM9KbBte6QLEcdA9TmNTV37+e7zETAq/rZtoG0SxdgMkEhZDCjZs9bMul+TK8
 agbPbPspdkdx8MaZS30Q9CCwzfsJ9hscyybvPc5SLOYaBpZR1qf2HFp4EkAS4jd2WOwX
 tMTe+LwPmDHLxslA85Vk/J+CeRDSi3Q/e3BFrxYp+I00IOGLOWsxCZqXmbDzsjaeOGsU
 abUYK3I9+CLGmRhr2n1eMfa0iIGBYKP8103+xXNumsDG5sinw6yher32DaqUvkNtf5N8
 U/bw==
X-Gm-Message-State: APuU4Z/1B3VTc4O2UqAbtJ6Qzw65iWRA14pl2W32EvF3q1uHbOLRfa/x
 lvQGYqrVvzQbMuBCg+7ktXVa2N7JLKfk8Fp6DpKQ9NZQxSdwWB3Gz0dM
X-Gm-Gg: AYBFou3y3mdOv65+wdLwOElI7/DLEfaOMDUtiPIqdQbx8fCEc8FU+8vQFr6W4cg8GZL
 Bt9bGjpIr/rHjXQTYjJmd+zCGA3MWOsYAcu4zU2vku9q26RxahLPqdU43hwSdbxN/pfbTFxZoVu
 3rnEcfy5omZxrKEKMhK5O3a+aTdDwP2s8WSwVi1QBaEvG3ExwWe9pn9BZB6KSTPzupkKGd+bOkl
 YPGH005swh6cAK1hEqBRYzkB+bUp4iqk1ONk14OXA92+ak6wrOogU2mHd8joKNkybyED3Hx55Qu
 c9iavK/obNtEFn/54OL1LZ6O0bd9JKOsfSzL/rshLPMyyKWgv3ufgbc0rhmNQGaPOqobEBRrIFp
 1qEyoOk/8Lr3/0XjXKTMXZicTIwwJ/ivnM8wc+F3y0aQ9VEgunrenISqAgR05rqaX1Xc4kUozEG
 K8iuuKWVXI2plKe/ThCc51k6uA0OFA2Xo4n9TGJTmmExLZmaH3P7VylN6A6n34ZDtDXOoHNrvV5
 RgxeoOfUdN82W8sBN8QrZ2RUqEvXp6icnMOvOlGTYl6Itr2mtOqfrmOqefJliX1hQ0vBBTMPfDr
 29L5wPWtB0PcpCA9JY9rJUHp0IQxk/SXeTCTsPeR3jsGyRYdxRi9TBtXzdzOFBAQ9GS4RvRnQA=
 =
X-Received: by 2002:a05:6a00:230a:b0:8b5:d6be:3ded with SMTP id
 d2e1a72fcca58-8beb53d9dc5mr9471317b3a.10.1794829377516; 
 Mon, 16 Nov 2026 03:42:57 -0800 (PST)
Received: from ?IPV6:2408:8607:1b00:8:401e:3331:e6b7:ac3a?
 ([2408:8607:1b00:8:401e:3331:e6b7:ac3a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8bececcce6bsm3527392b3a.1.2026.11.16.03.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 03:42:57 -0800 (PST)
From: huangzheng <huangz6756@gmail.com>
X-Google-Original-From: huangzheng <huangzheng1@xiaomi.com>
Message-ID: <d9ba27e6-45f8-47a4-b0bc-c9ccdbfd3c14@xiaomi.com>
Date: Mon, 16 Nov 2026 19:42:50 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, huang zheng <huangzheng9869@gmail.com>,
 jaegeuk@kernel.org
References: <20261103091215.180531-1-huangzheng9869@gmail.com>
 <b2253246-48ba-4c48-899c-9f568fa2df71@kernel.org>
Content-Language: en-US
In-Reply-To: <b2253246-48ba-4c48-899c-9f568fa2df71@kernel.org>
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xSv71-000000004s1-1GQE
Subject: Re: [f2fs-dev] [PATCH] f2fs: add checkpoint step timing statistics
 to debugfs
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

5ZyoIDIwMjYvMTEvMTEgMTY6MTksIENoYW8gWXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwg5YaZ6YGT
Ogo+IE9uIDExLzMvMjYgMTc6MTIsIGh1YW5nIHpoZW5nIHdyb3RlOgo+PiBGcm9tOiBIdWFuZyBa
aGVuZyA8aHVhbmd6aGVuZzk4NjlAZ21haWwuY29tPgo+Pgo+PiBUaGlzIHBhdGNoIGFkZHMgZGV0
YWlsZWQgdGltaW5nIHN0YXRpc3RpY3MgZm9yIGVhY2ggY2hlY2twb2ludCBzdGVwCj4+IHRvIHRo
ZSBkZWJ1Z2ZzIHN0YXRfc2hvdyBpbnRlcmZhY2UuIEl0IGRpc3BsYXlzIHRoZSB0aW1lIHRha2Vu
IGJ5Cj4+IGVhY2ggcGhhc2Ugb2YgdGhlIGNoZWNrcG9pbnQgcHJvY2VzcywgaW5jbHVkaW5nOgo+
Pgo+PiAtIGxvY2sgYWNxdWlzaXRpb24KPj4gLSBibG9jayBvcGVyYXRpb25zCj4+IC0gZmx1c2hp
bmcgZGF0YS9ub2RlL21ldGEgcGFnZXMKPj4gLSBmbHVzaGluZyBOQVQvU0lUCj4+IC0gc3luY2lu
ZyBtZXRhZGF0YQo+PiAtIHdhaXRpbmcgZm9yIGRpcnR5IG1ldGEvY2hlY2twb2ludCBkYXRhCj4+
IC0gZGV2aWNlIGZsdXNoaW5nCj4+IC0gd2FpdGluZyBmb3IgbGFzdCBjaGVja3BvaW50Cj4gCj4g
V2VsbCwgYWxsIHNwb3QgdGltZXMgc2hvdWxkIGJlIGNvbnNpc3RlbnQgb25seSBhZnRlciBjaGVj
a3BvaW50KCksIGlmIHN0YXRfc2hvdygpCj4gY2FwdHVyZXMgdGltZXMgZHVyaW5nIGNoZWNrcG9p
bnQsIHRoZSB0aW1lcyBjb3VsZCBiZSBpbmNvbnNpc3RlbnQuCkZpeCBieSB2MiBwYXRjaD4KPj4K
Pj4gVGhpcyBpbmZvcm1hdGlvbiBpcyB2YWx1YWJsZSBmb3IgZGVidWdnaW5nIGNoZWNrcG9pbnQg
cGVyZm9ybWFuY2UKPj4gaXNzdWVzIGFuZCBpZGVudGlmeWluZyB3aGljaCBzdGVwcyBhcmUgdGFr
aW5nIHRoZSBtb3N0IHRpbWUgZHVyaW5nCj4+IHRoZSBjaGVja3BvaW50IHByb2Nlc3MuCj4+Cj4+
IFRoZSBzdGF0aXN0aWNzIHNob3cgdGhlIGxvbmdlc3QgcmVjb3JkZWQgdGltZSBmb3IgZWFjaCBz
dGVwLCBoZWxwaW5nCj4gCj4gSXQgZGlkbid0LCBpdCByZWNvcmQgdGhlIHRpbWUgZXZlcnkgdGlt
ZSwgYnV0IG9ubHkgcHJpbnRpbmcgdGhlIHN0YXRzIGluCj4ga21zZyBpZiB0aGUgdG90YWwgdGlt
ZSBleGNlZWRzIHRoZSB0aHJlc2hvbGQgKDVzZWMpLgpJIHdhbnQgdG8gY2hlY2sgYGNhdCAvc3lz
L2tlcm5lbC9kZWJ1Zy9mMmZzL3N0YXR1c2AgdG8gZ2V0IHRoZSBsb25nZXN0IAp0aW1lIGFuZCBz
ZWUgdGhlIGVsYXBzZWQgdGltZSBvZiBlYWNoIHN0ZXDvvIwgYXMgZm9sbG93OgpDUCBzdGVwcyAo
bG9uZ2VzdCk6CiAgIC0gVG90YWwgOiA1MjQobXMpCiAgIC0gbG9jayA6IDAobXMpCiAgIC0gYmxv
Y2tfb3BlcmF0aW9uIDogMTMobXMpCiAgIC0gZmx1c2hfZGF0YV9ub2RlX21ldGEgOiAwKG1zKQog
ICAtIGZsdXNoX25hdCA6IDkzKG1zKQogICAtIGZsdXNoX3NpdCA6IDU2KG1zKQogICAtIHN5bmNf
bWV0YSA6IDMyKG1zKQogICAtIHN5bmNfY3BfbWV0YSA6IDAobXMpCiAgIC0gd2FpdF9kaXJ0eV9t
ZXRhIDogMChtcykKICAgLSB3YWl0X2NwX2RhdGEgOiAwKG1zKQogICAtIGZsdXNoX2RldmljZSA6
IDAobXMpCiAgIC0gd2FpdF9sYXN0X2NwIDogMChtcykKICAgLSB1bmJsb2NrX29wZXJhdGlvbiA6
IDMyNyhtcykKCj4gCj4gVGhhbmtzLAo+IAo+PiBkZXZlbG9wZXJzIGFuZCB1c2VycyB1bmRlcnN0
YW5kIHdoZXJlIGNoZWNrcG9pbnQgYm90dGxlbmVja3Mgb2NjdXIuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IEh1YW5nIFpoZW5nIDxodWFuZ3poZW5nMUB4aWFvbWkuY29tPgo+PiAtLS0KPj4gICBmcy9m
MmZzL2RlYnVnLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysKPj4gICAxIGZpbGUgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kZWJ1Zy5j
IGIvZnMvZjJmcy9kZWJ1Zy5jCj4+IGluZGV4IDZmZTYwNmUyYzcwZC4uOGZkNzZhNjlkY2FkIDEw
MDY0NAo+PiAtLS0gYS9mcy9mMmZzL2RlYnVnLmMKPj4gKysrIGIvZnMvZjJmcy9kZWJ1Zy5jCj4+
IEBAIC00NDUsNiArNDQ1LDIyIEBAIHN0YXRpYyBjb25zdCBjaGFyICppcHVfbW9kZV9uYW1lc1tG
MkZTX0lQVV9NQVhdID0gewo+PiAgIAlbRjJGU19JUFVfSE9OT1JfT1BVX1dSSVRFXQk9ICJIT05P
Ul9PUFVfV1JJVEUiLAo+PiAgIH07Cj4+ICAgCj4+ICtzdGF0aWMgY29uc3QgY2hhciAqY3BfdGlt
ZV9uYW1lc1tDUF9USU1FX01BWF0gPSB7Cj4+ICsJW0NQX1RJTUVfU1RBUlRdCQk9ICJiZWdpbiIs
Cj4+ICsJW0NQX1RJTUVfTE9DS10JCT0gImxvY2siLAo+PiArCVtDUF9USU1FX09QX0xPQ0tdCT0g
ImJsb2NrX29wZXJhdGlvbiIsCj4+ICsJW0NQX1RJTUVfTUVSR0VfV1JJVEVdCT0gImZsdXNoX2Rh
dGFfbm9kZV9tZXRhIiwKPj4gKwlbQ1BfVElNRV9GTFVTSF9OQVRdCT0gImZsdXNoX25hdCIsCj4+
ICsJW0NQX1RJTUVfRkxVU0hfU0lUXQk9ICJmbHVzaF9zaXQiLAo+PiArCVtDUF9USU1FX1NZTkNf
TUVUQV0JPSAic3luY19tZXRhIiwKPj4gKwlbQ1BfVElNRV9TWU5DX0NQX01FVEFdCT0gInN5bmNf
Y3BfbWV0YSIsCj4+ICsJW0NQX1RJTUVfV0FJVF9ESVJUWV9NRVRBXSA9ICJ3YWl0X2RpcnR5X21l
dGEiLAo+PiArCVtDUF9USU1FX1dBSVRfQ1BfREFUQV0JPSAid2FpdF9jcF9kYXRhIiwKPj4gKwlb
Q1BfVElNRV9GTFVTSF9ERVZJQ0VdCT0gImZsdXNoX2RldmljZSIsCj4+ICsJW0NQX1RJTUVfV0FJ
VF9MQVNUX0NQXQk9ICJ3YWl0X2xhc3RfY3AiLAo+PiArCVtDUF9USU1FX0VORF0JCT0gInVuYmxv
Y2tfb3BlcmF0aW9uIiwKPj4gK307Cj4+ICsKPj4gICBzdGF0aWMgaW50IHN0YXRfc2hvdyhzdHJ1
Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKnYpCj4+ICAgewo+PiAgIAlzdHJ1Y3QgZjJmc19zdGF0X2lu
Zm8gKnNpOwo+PiBAQCAtNjMxLDYgKzY0NywxNCBAQCBzdGF0aWMgaW50IHN0YXRfc2hvdyhzdHJ1
Y3Qgc2VxX2ZpbGUgKnMsIHZvaWQgKnYpCj4+ICAgCQlzZXFfcHJpbnRmKHMsICIgIC0gVG90YWwg
OiAlNGRcbiIsIHNpLT5ucl90b3RhbF9ja3B0KTsKPj4gICAJCXNlcV9wcmludGYocywgIiAgLSBD
dXIgdGltZSA6ICU0ZChtcylcbiIsIHNpLT5jdXJfY2twdF90aW1lKTsKPj4gICAJCXNlcV9wcmlu
dGYocywgIiAgLSBQZWFrIHRpbWUgOiAlNGQobXMpXG4iLCBzaS0+cGVha19ja3B0X3RpbWUpOwo+
PiArCQlzZXFfcHV0cyhzLCAiQ1Agc3RlcHMgKGxvbmdlc3QpOlxuIik7Cj4+ICsJCXNlcV9wcmlu
dGYocywgIiAgLSBUb3RhbCA6ICVsbHUobXMpXG4iLAo+PiArCQkJICAgKHU2NClrdGltZV9tc19k
ZWx0YShzYmktPmNwX3N0YXRzLnRpbWVzW0NQX1RJTUVfRU5EXSwKPj4gKwkJCQkJc2JpLT5jcF9z
dGF0cy50aW1lc1tDUF9USU1FX1NUQVJUXSkpOwo+PiArCQlmb3IgKGogPSAwOyBqIDwgQ1BfVElN
RV9NQVggLSAxOyBqKyspCj4+ICsJCQlzZXFfcHJpbnRmKHMsICIgIC0gJXMgOiAlbGx1KG1zKVxu
IiwgY3BfdGltZV9uYW1lc1tqICsgMV0sCj4+ICsJCQkJICAgKHU2NClrdGltZV9tc19kZWx0YShz
YmktPmNwX3N0YXRzLnRpbWVzW2ogKyAxXSwKPj4gKwkJCQkJc2JpLT5jcF9zdGF0cy50aW1lc1tq
XSkpOwo+PiAgIAkJc2VxX3ByaW50ZihzLCAiR0MgY2FsbHM6ICVkIChnY190aHJlYWQ6ICVkKVxu
IiwKPj4gICAJCQkgICBzaS0+Z2NfY2FsbF9jb3VudFtCQUNLR1JPVU5EXSArCj4+ICAgCQkJICAg
c2ktPmdjX2NhbGxfY291bnRbRk9SRUdST1VORF0sCj4gCj4gCj4gCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoK
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1m
MmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1m
MmZzLWRldmVsCg==
