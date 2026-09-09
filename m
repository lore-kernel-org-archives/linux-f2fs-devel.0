Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA58C79F82
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 02:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HW/cWID6ftNMFI7JTFF968kUDg+d8ph/C+7jHPa1V9k=; b=SsF50FjiM0bG3jqiOBdE1m0U20
	xtp4GDlsyL1eqCMOBXo+uLBTKoBmGmEHu0WjbxvjL3Zxsp2rDEivReNTQlrlTHTDmI0K9o8KImBjF
	Um8oJWv4GcyM5ttcvCY9+XYSzqD1uMr9ZFv9iD6ZtGzyQXPZysHbE6D6pFSM2K9vb2Kk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x47fd-0003eT-Ps;
	Wed, 09 Sep 2026 02:04:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x47fO-0003dg-0D
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 02:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iPPijrSAEf6GC7mT3EoUKryESek5TYWN+vDTDROlKhQ=; b=RqninodZTkL5lQiCcUHga0C22g
 qzhT6Eh6I6yFmUWbzrukxBNBAVjW4sGGNdtZL2pG5jNYMs6f4mAFtWJ6ZOQe3ifGEhjDvYJ1Q+dr3
 2nNdmWlUie6+/2/VH6uWECU+iXsvR5/OieMcafFfc/kjyDkKbAJlHKP8QeDZffF/jkyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iPPijrSAEf6GC7mT3EoUKryESek5TYWN+vDTDROlKhQ=; b=CmD/dObfNI9t8+I3L6xuS9YXIr
 sUy4q3hbdbndXQRa6tY25BM3TQvs8lBlgzq5SXrqSbOrpwTzFAqnhfSOX2SSxE18LCsIOSq0c8vuA
 i0SxfJwIYzc9S87SV6Z9dPdW4zjoUtVCZk74jjlXL79DSBzvrC1JWxNqR2TXUAHHug8E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x47fK-0007eP-Rp for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 02:03:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4F8C1601FB;
 Wed,  9 Sep 2026 02:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD4C1F00A3A;
 Wed,  9 Sep 2026 02:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788919433;
 bh=iPPijrSAEf6GC7mT3EoUKryESek5TYWN+vDTDROlKhQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VYkQ2X/vI7dLQ0twmWOT67G8W6ceML31Wc8XfnLg4liLyBb0VU+sy+nj5uVRU8K77
 U3aACHvERUx6A/7nSEb6JEKZpWpScl3bp7KTekr5HXRt7cfvBlz/YBdAD53+mtY42d
 vG2hPNfGq0Yxvd4KDexj/MMGwuMR37IcQuDssppNpbjimSqn+jRgkf9Bwj6tmT4FeD
 YATF9XIsR3/2Ej+pbOycR0mkTFg9kXzRGMR0TCsccroV/00XdIvAAii+BYt+Vk1RFd
 8Ilye4FCvOp7wjlVa3Gt0c3Xztl7xNmYfBdHGtd8nN1Q2fIS34/u9Bclx7BXZ28bDD
 JCS5PFuiNRkZg==
Message-ID: <c5d29b31-e764-4782-9639-be84b1b2bfc2@kernel.org>
Date: Wed, 9 Sep 2026 10:03:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <niuzhiguo84@gmail.com>
References: <20260824131729.3694378-1-chao@kernel.org>
 <CAHJ8P3+KBs1cQnDPsfpHOyjxNA+JNQ5DPCbrF_JqTLcmoyzB1w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHJ8P3+KBs1cQnDPsfpHOyjxNA+JNQ5DPCbrF_JqTLcmoyzB1w@mail.gmail.com>
X-Headers-End: 1x47fK-0007eP-Rp
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gOS85LzI2IDA5OjEyLCBaaGlndW8gTml1IHdyb3RlOgo+IENoYW8gWXUgdmlhIExpbnV4LWYy
ZnMtZGV2ZWwgPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Pgo+IOS6jjIw
MjblubQ45pyIMjTml6XlkajkuIAgMjE6MTnlhpnpgZPvvJoKPj4KPj4gVGhlcmUgaXMgcG90ZW50
aWFsIGRlYWRsb29wIGluIHJhY2UgY29uZGl0aW9uOgo+Pgo+PiBUaHJlYWQgQSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVGhyZWFkIEIKPj4gLSBmc3luYwo+PiAgLSBmMmZzX2RvX3N5
bmNfZmlsZQo+PiAgIC0gZjJmc19mc3luY19ub2RlX3BhZ2VzCj4+ICAgIC0gbGFzdF9mc3luY19k
bm9kZQo+PiAgICAgLSBmb2xpb19nZXQobGFzdF9mb2xpbykKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc19zZXRhdHRyCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLSBmMmZzX3RydW5jYXRlCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc190cnVuY2F0ZV9ibG9ja3MKPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc19kb190cnVuY2F0
ZV9ibG9ja3MKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAt
IGYyZnNfdHJ1bmNhdGVfaW5vZGVfYmxvY2tzCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0gdHJ1bmNhdGVfZG5vZGUKPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gdHJ1bmNhdGVfbm9kZQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gaW52YWxpZGF0ZV9tYXBwaW5n
X3BhZ2VzCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0gZm9saW8tPm1hcHBpbmcgPSBOVUxMCj4+ICAgIC0gaXNfbm9kZV9mb2xpbyBhbHdhc3kgcmV0
dXJuIGZhbHNlCj4+ICAgIC0gYXRvbWljICYmICFtYXJrZWQgaXMgYWx3YXlzIHRydWUsCj4+ICAg
ICAgdGhlbiBnb3RvIHJldHJ5Cj4+Cj4+IENjOiBzdGFibGVAa2VybmVsLm9yZwo+PiBGaXhlczog
NjA4NTE0ZGViYTM4ICgiZjJmczogc2V0IGZzeW5jIG1hcmsgb25seSBmb3IgdGhlIGxhc3QgZG5v
ZGUiKQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4+IC0tLQo+
PiAgZnMvZjJmcy9ub2RlLmMgfCA1ICsrKysrCj4+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRp
b25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9mcy9mMmZzL25vZGUuYyBiL2ZzL2YyZnMvbm9kZS5j
Cj4+IGluZGV4IDk2OGU1ZWQzODgxNi4uODZjMmU2N2U0M2I2IDEwMDY0NAo+PiAtLS0gYS9mcy9m
MmZzL25vZGUuYwo+PiArKysgYi9mcy9mMmZzL25vZGUuYwo+PiBAQCAtMjAxNiw2ICsyMDE2LDEx
IEBAIGludCBmMmZzX2ZzeW5jX25vZGVfcGFnZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpLCBz
dHJ1Y3QgaW5vZGUgKmlub2RlLAo+PiAgICAgICAgICAgICAgICAgZjJmc19kZWJ1ZyhzYmksICJS
ZXRyeSB0byB3cml0ZSBmc3luYyBtYXJrOiBpbm89JXUsIGlkeD0lbHgiLAo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpbm8sIGxhc3RfZm9saW8tPmluZGV4KTsKPj4gICAgICAgICAgICAg
ICAgIGZvbGlvX2xvY2sobGFzdF9mb2xpbyk7Cj4+ICsgICAgICAgICAgICAgICBpZiAodW5saWtl
bHkoIWlzX25vZGVfZm9saW8obGFzdF9mb2xpbykpKSB7Cj4gSGkgQ2hhbywKPiBpc19ub2RlX2Zv
bGlvLT5OT0RFX01BUFBJTkcoRjJGU19GX1NCKGZvbGlvKSktPkYyRlNfTV9TQihmb2xpby0+bWFw
cHBpbmcpLT5GMkZTX0lfU0IobWFwcGluZy0+aG9zdCkKPiBpZiBtYXBwaW5nPT1OVUxMLCBwYW5p
YyB3aWxsIG9jY3VyIGhlcmU/Cj4ganVzdCBsaWtlICBjb21taXQgbXNnIGluICBtYWk6ICJmMmZz
OiBwYXJhbWV0ZXJpemUgbm9kZSBoZWxwZXJzIGFuZCBtYWNyb3MiCgpIaSBaaGlndW8sCgpBaCwg
c2VlbXMgd2UgbmVlZCB0byByZXZlcnQgKCJmMmZzOiBpbnRyb2R1Y2UgaXNfe21ldGEsbm9kZX1f
Zm9saW8iKSB3aGljaAppbnRyb2R1Y2UgdGhpcyBidWc/IElJVUMuCgpUaGFua3MsCgo+IHRoYW5r
c++8gQo+IAo+PiArICAgICAgICAgICAgICAgICAgICAgICBmMmZzX2ZvbGlvX3B1dChsYXN0X2Zv
bGlvLCB0cnVlKTsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVBR0FJTjsKPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4+ICsgICAgICAgICAgICAgICB9Cj4+
ICAgICAgICAgICAgICAgICBmMmZzX2ZvbGlvX3dhaXRfd3JpdGViYWNrKGxhc3RfZm9saW8sIE5P
REUsIHRydWUsIHRydWUpOwo+PiAgICAgICAgICAgICAgICAgZm9saW9fbWFya19kaXJ0eShsYXN0
X2ZvbGlvKTsKPj4gICAgICAgICAgICAgICAgIGZvbGlvX3VubG9jayhsYXN0X2ZvbGlvKTsKPj4g
LS0KPj4gMi40OS4wCj4+Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Cj4+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4+IGh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwKCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
