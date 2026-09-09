Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B37C79FB5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HOI731OkTF3XQ8Gq+MLyb6+zD8IaG5BkWDWB538oMSQ=; b=e3NbzeGb/xbCNSiAM158umyMXV
	biX67+z5vO498oPSi7rpp/4D1HDOw10CqkYyZSpaceDt/l9NNHpkidApNJIX018kEdxq9FQgUiWSh
	TZ5fz02IeLbSzRBUrEssKRdI9ZUbUqwwVyKvrXfyihbgAEZBNsddR+BP4rIfqgcbrBv4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47nw-0003rg-DB;
	Wed, 09 Sep 2026 02:12:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x47np-0003rW-0G
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 02:12:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N5E+pwQE2jqWQwgSLgy05TkZ6xdQKNmZYdmm5S5Jaxo=; b=CvaQGafKRFGhwcq8BSgM46bKTV
 CseEB5yBIOw6/NRurRqWToO2KB5w/5CP2A3454Y+x970m3+6sbaleCJAZA3u9m79yVZrjwUuFIHDk
 MxHKjQBifwW+eZEM11nj5VxjDZXOUrJT+irFDiJZOPJuoycqHCWfhdnheCYqaRoSFc1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N5E+pwQE2jqWQwgSLgy05TkZ6xdQKNmZYdmm5S5Jaxo=; b=hxlHAyL8d3ZIFUN8sq3Q5ixAm1
 OFScOD3krnpKwDD0efjBOlM5wOQo4cJhagPJZ/zRML3+tGhg2KRZrZ9rpfh+L7ayNm3Pqo4iqGSOM
 a9oPMHwIa2JBgyV9UtO2gofOtQt2Bla+I+4Z56sklNxXEe6ZRWU0a7OyJCHo3uuoNFFM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x47nl-0007pJ-VC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 02:12:42 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482e1b55da8so482741f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 19:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788919955; cv=none;
 d=google.com; s=arc-20260327;
 b=FtKL3T97I55dvYPqc7bUEmQLJuWMKXY2lG9Ga1l1haMuJ9JWtlsC2DvnaXUOtrbbHr
 9vpcXIru64I0kxLxEOvEkeJ2o8Svgwx/ZwnXlRNMJip3+GQSz6jFQxJ5TZ5FETzXpWRt
 OL3Qg9atyhnPPPO5PLfvZq0a0gTBoe7VqiJOD4rzKcjlFBEXMwrLgCgdUrfVafQb8as2
 xRiBxGszt7EGAk/darUaxDKCMgqvoBlzOneCL1jz8n7P3czAuMXwgk7nCK0o7/QzVwY1
 X45sWVIQ8YEdvpJSD0VnHqINIySnmz6XRknA61+udCgVMBGztrDdwxnxYtBnJ2Xa/L7k
 sg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N5E+pwQE2jqWQwgSLgy05TkZ6xdQKNmZYdmm5S5Jaxo=;
 fh=Q95wBf24m1GcyagEIJCQxJj9XqeI/7uYa6uoWP2V1jo=;
 b=U14+eOpdee/ctRubvhM3xP6gjaluxfw/N8Nk1hggF6LUcgNVskb63w3IXtc0hDZVpn
 46n9+LHJrQhQ4X5KDhR/d8iBSZgYzKQKUeQ6FT12/j+KI/gWiSCHhCoQrxRAKUM1Rt5x
 WmNsYN2Azia+876hTC80Xt2cSg81RQSHgUj4DzrDq8X4NOs0JII7nv4owMe0hYFKsFSa
 xZBqB1bUPD+T+AK7MYmTltjHxCr2lWaP6Y6thb4gEu9+VjSImYRKf/OEkjT2IJVNmiN9
 l8uGi/Y7jziNWMUjbKpKAMenGTAD/TpBtBFeJgDhjkplOqqNA5NsXpm0ZnMY9TLqffar
 XxGA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788919955; x=1789524755; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N5E+pwQE2jqWQwgSLgy05TkZ6xdQKNmZYdmm5S5Jaxo=;
 b=I5/sqb/vjPSPLTW7NoYC1AXYG9Izak23Pzgyq9x1tDj9kv5BtCDbp+MXURF3QysGZh
 WEb4yQ5DSqCra06JTFhtySoPQAKHPmMSCsbcybwb4qMZvHcz5mojIRQyDwzMClgft9ns
 KFRujI810GtDnIczBQa3nU8DqWVNIaLdOjuAvSirn01keKC8EMy+JJQcZ33aWcC/cGaD
 lLsqmlLvAwaYGxInQt/Wz6dygJGNvVLFjGFwdHWGnHJKSiCq1riJjElRINoyQcESyL/q
 NqSwHUL35YURMNjBT0/naC3AmSGIvyylLxGcqHNCqnfFdOmPPPiLY3seqXNmG3HVFjna
 NDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788919955; x=1789524755;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N5E+pwQE2jqWQwgSLgy05TkZ6xdQKNmZYdmm5S5Jaxo=;
 b=HpUMMS1FKLcpAyKWgho/iZJ48rYqqZOqYVKCCNb0ZwMWXVNvVp27HLjOvlY7YcMk2G
 42UJFuBsBxRxLiTk53zJUACmtuRg2gHiqg+xlMVg/k0lsYZFgAoRCoLIQzhM/NVUS5pd
 /gyv3N3pNlQqpJy0KGLKTuGWo9p6vQiSC1HtkvxOE0oC6wIdlfFwjkJ315UDTSBjOFtK
 xZLz+HQcdTv6XDfN6ZUQ1j7xAG7OWWjuTLcerZkFVyVIOj4iXmtC9Fg592/RiNZSytip
 3Sn1c/X3CPKB5oZC0Y7IBPVHaGfU+1Y0nr4XaOdeGUUurZekym4sLHle8o7PUZOkCZis
 XwaQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzACCNfxRHK2P8Wh8s8ZhmXXslQIBblxlFlBKd/Xmy92yiaWGs3dhWMGNPWl+I/KmitDh+52goPEvEuiV9I2QJE@lists.sourceforge.net
X-Gm-Message-State: AFuF++k+PvnA+0gsjAy9jueiADbKiUzKygGz43Y4iWiGU7PP2GzTwQ1f
 fH2X99/3WkTjXe++8T3A7RJYX1jaIPfOVYLYDiPVAOHGRyyFPmw5nl1t3pcOLWmejg25B0W7qHZ
 /lTjRaG0DrZJY8d02+B2aGglW9aNu/Zg=
X-Gm-Gg: AYBFou32blBrz5/Gs2E5cM5zrabbFZQMSl6XIEQmaZNkydlQ7+PTYyNHu4mXAcw6sI2
 fQIf1P8GKPqzxKYz2w3BC7FieCrWxnNTbPlQatShshRke2wp11xRlwvJ61rOTCJmzH0CscVtmmq
 vQXm7c+3+XWxnHyXyMwEFwBC52s1fpbO72YT9BjSBiHrh1gopVHQ/FBwlvbw+xB5NxuUhIoxNRu
 /D17v2LW3TUpRdsOmo/nBGqdj1KcWGiKitLetq60ymFQ0r4E5IfpEI44Cam/LUC6MEoT8hsqQUn
 KwgI8hO+qapbdHJxm/AjfX8pVm7hmulTHcf7MtRb69FNUVUppXlJOTn7
X-Received: by 2002:adf:e181:0:b0:485:ac0a:e11 with SMTP id
 ffacd0b85a97d-485ac0a0f9amr2042121f8f.0.1788919955411; Tue, 08 Sep 2026
 19:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260824131729.3694378-1-chao@kernel.org>
 <CAHJ8P3+KBs1cQnDPsfpHOyjxNA+JNQ5DPCbrF_JqTLcmoyzB1w@mail.gmail.com>
 <c5d29b31-e764-4782-9639-be84b1b2bfc2@kernel.org>
In-Reply-To: <c5d29b31-e764-4782-9639-be84b1b2bfc2@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 9 Sep 2026 10:12:24 +0800
X-Gm-Features: AcwNN1XnP1pvNvot5K4bOpvCxDbaOt_96Kg8CNF6EYisuXeTE1UXjzTVfxL3__M
Message-ID: <CAHJ8P3K2fxeyiq_icgq365DhdO8=DpB3PFOt7yQyvRpbqUOCfQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x47nl-0007pJ-VC
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadloop in
 f2fs_fsync_node_pages()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiDkuo4yMDI25bm0OeaciDnml6XlkajkuIkgMTA6MDPl
hpnpgZPvvJoKPgo+IE9uIDkvOS8yNiAwOToxMiwgWmhpZ3VvIE5pdSB3cm90ZToKPiA+IENoYW8g
WXUgdmlhIExpbnV4LWYyZnMtZGV2ZWwgPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Pgo+ID4g5LqOMjAyNuW5tDjmnIgyNOaXpeWRqOS4gCAyMToxOeWGmemBk++8mgo+ID4+
Cj4gPj4gVGhlcmUgaXMgcG90ZW50aWFsIGRlYWRsb29wIGluIHJhY2UgY29uZGl0aW9uOgo+ID4+
Cj4gPj4gVGhyZWFkIEEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRocmVhZCBCCj4g
Pj4gLSBmc3luYwo+ID4+ICAtIGYyZnNfZG9fc3luY19maWxlCj4gPj4gICAtIGYyZnNfZnN5bmNf
bm9kZV9wYWdlcwo+ID4+ICAgIC0gbGFzdF9mc3luY19kbm9kZQo+ID4+ICAgICAtIGZvbGlvX2dl
dChsYXN0X2ZvbGlvKQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtIGYyZnNfc2V0YXR0cgo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLSBmMmZzX3RydW5jYXRlCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLSBmMmZzX3RydW5jYXRlX2Jsb2Nrcwo+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtIGYyZnNfZG9fdHJ1bmNhdGVfYmxvY2tzCj4gPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGYyZnNfdHJ1bmNh
dGVfaW5vZGVfYmxvY2tzCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLSB0cnVuY2F0ZV9kbm9kZQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtIHRydW5jYXRlX25vZGUKPiA+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gaW52YWxpZGF0ZV9tYXBwaW5nX3BhZ2Vz
Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBm
b2xpby0+bWFwcGluZyA9IE5VTEwKPiA+PiAgICAtIGlzX25vZGVfZm9saW8gYWx3YXN5IHJldHVy
biBmYWxzZQo+ID4+ICAgIC0gYXRvbWljICYmICFtYXJrZWQgaXMgYWx3YXlzIHRydWUsCj4gPj4g
ICAgICB0aGVuIGdvdG8gcmV0cnkKPiA+Pgo+ID4+IENjOiBzdGFibGVAa2VybmVsLm9yZwo+ID4+
IEZpeGVzOiA2MDg1MTRkZWJhMzggKCJmMmZzOiBzZXQgZnN5bmMgbWFyayBvbmx5IGZvciB0aGUg
bGFzdCBkbm9kZSIpCj4gPj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
Pgo+ID4+IC0tLQo+ID4+ICBmcy9mMmZzL25vZGUuYyB8IDUgKysrKysKPiA+PiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvbm9k
ZS5jIGIvZnMvZjJmcy9ub2RlLmMKPiA+PiBpbmRleCA5NjhlNWVkMzg4MTYuLjg2YzJlNjdlNDNi
NiAxMDA2NDQKPiA+PiAtLS0gYS9mcy9mMmZzL25vZGUuYwo+ID4+ICsrKyBiL2ZzL2YyZnMvbm9k
ZS5jCj4gPj4gQEAgLTIwMTYsNiArMjAxNiwxMSBAQCBpbnQgZjJmc19mc3luY19ub2RlX3BhZ2Vz
KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwgc3RydWN0IGlub2RlICppbm9kZSwKPiA+PiAgICAg
ICAgICAgICAgICAgZjJmc19kZWJ1ZyhzYmksICJSZXRyeSB0byB3cml0ZSBmc3luYyBtYXJrOiBp
bm89JXUsIGlkeD0lbHgiLAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlubywgbGFz
dF9mb2xpby0+aW5kZXgpOwo+ID4+ICAgICAgICAgICAgICAgICBmb2xpb19sb2NrKGxhc3RfZm9s
aW8pOwo+ID4+ICsgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIWlzX25vZGVfZm9saW8obGFz
dF9mb2xpbykpKSB7Cj4gPiBIaSBDaGFvLAo+ID4gaXNfbm9kZV9mb2xpby0+Tk9ERV9NQVBQSU5H
KEYyRlNfRl9TQihmb2xpbykpLT5GMkZTX01fU0IoZm9saW8tPm1hcHBwaW5nKS0+RjJGU19JX1NC
KG1hcHBpbmctPmhvc3QpCj4gPiBpZiBtYXBwaW5nPT1OVUxMLCBwYW5pYyB3aWxsIG9jY3VyIGhl
cmU/Cj4gPiBqdXN0IGxpa2UgIGNvbW1pdCBtc2cgaW4gIG1haTogImYyZnM6IHBhcmFtZXRlcml6
ZSBub2RlIGhlbHBlcnMgYW5kIG1hY3JvcyIKPgo+IEhpIFpoaWd1bywKPgo+IEFoLCBzZWVtcyB3
ZSBuZWVkIHRvIHJldmVydCAoImYyZnM6IGludHJvZHVjZSBpc197bWV0YSxub2RlfV9mb2xpbyIp
IHdoaWNoCj4gaW50cm9kdWNlIHRoaXMgYnVnPyBJSVVDLgpIaSBDaGFvLApzZWVtcyB5ZXMsICB3
ZSBjYW4gdXNlIHNiaSBkaXJlY3RseS4KdGhhbmtz77yBCj4KPiBUaGFua3MsCj4KPiA+IHRoYW5r
c++8gQo+ID4KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBmMmZzX2ZvbGlvX3B1dChsYXN0
X2ZvbGlvLCB0cnVlKTsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRUFHQUlO
Owo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ID4+ICsgICAgICAgICAg
ICAgICB9Cj4gPj4gICAgICAgICAgICAgICAgIGYyZnNfZm9saW9fd2FpdF93cml0ZWJhY2sobGFz
dF9mb2xpbywgTk9ERSwgdHJ1ZSwgdHJ1ZSk7Cj4gPj4gICAgICAgICAgICAgICAgIGZvbGlvX21h
cmtfZGlydHkobGFzdF9mb2xpbyk7Cj4gPj4gICAgICAgICAgICAgICAgIGZvbGlvX3VubG9jayhs
YXN0X2ZvbGlvKTsKPiA+PiAtLQo+ID4+IDIuNDkuMAo+ID4+Cj4gPj4KPiA+Pgo+ID4+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPj4gTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKPiA+PiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldAo+ID4+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
