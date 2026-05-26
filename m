Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0875CD5BB1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 11:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lt3tYTIU6iG401IbaI6q5khMz4vfwbkHOZ4hVrq3Q9U=; b=dzI6yKZHy3TkHYE63HNesTdIRx
	S7+cWe6MxzlRGeEuF4HogxO0TPjTj6ENnG/R+5Q40b8kXngSSRrOAV9Dph/JagW4QGTSf5Ebgnd9J
	R36BdontHwyEj+irfwHOa1MXpkDxNHGGyQMbtyaiH3+rHs2U4uv+bGtqq8dDsbrtd++k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRpa0-0005K0-79;
	Tue, 26 May 2026 11:04:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wRpZy-0005Jt-FZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 11:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vAxUtDoM7RbTHTVpsx+YtE9nb7EE2N1eSnXuvU6KUtU=; b=XEwhHIKDADdNiTszgTS8Ofw5hu
 St3NQA1Z3wv6aPCgGz1ibEsfb46XTfkbI5y8H5UTdoOJQZJmLwFBNRRm0cv8NfT2KfY2CjDmRX370
 HJyK0A2C2tNTPYKbluF9huF1L/3dzdFrVRAZ8wM/0KtF+XNcb4oK785AgQBAMknE0z1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vAxUtDoM7RbTHTVpsx+YtE9nb7EE2N1eSnXuvU6KUtU=; b=EefDzOZ/th2IgSNItu468SQFJa
 lVgRh7JF3cP3kcMVsBLlilTnTXlAWeWh1arCpdvcq9zoTtOewzy61y3uJrXQ7lLbxCsrfq8tr9WyV
 WWAy4h33E95sHgtVZtIrZ3xvhLKgaFhrXhDMMxfwOSSy3Nr5DLENUR3EQVvoyEVkkBOA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRpZv-0002No-Q6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 11:04:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF3D7436FF;
 Tue, 26 May 2026 11:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349C91F000E9;
 Tue, 26 May 2026 11:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779793437;
 bh=vAxUtDoM7RbTHTVpsx+YtE9nb7EE2N1eSnXuvU6KUtU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oFt3gYc+pgLyzuSVtuQC+HQHbHlseaOtrKBvHh4yTcTgsL9smYx+vxh9Z8Tz7C1ca
 xzHwNJfxF3MU2trQZP6+rYwufLaibYRi2eUvW02LF+d7S9Muj0m6wvvk758CWI0Kq2
 HskH5WYILp2gXoq0NNHLU74vSeT19zqgnZh1AiS5Nst7DK9q7s/xLuhUDF/T91Ek2i
 cLSYmreZZmfoPK4Yf2Irj2f5MxQzGkDZE2Z2MP5croqYAudQ0HP84GggSpBoBh2FWR
 C3lI2zIP1Q9FrfMMW7TdHmTBjh6m+Zog3AGJKWK6k+0pa6xb2KVyO3e4lMjB3Nfaqm
 cBTmnddpuRNjQ==
Message-ID: <534bc0fc-bb0f-4741-9156-11a66d47f1c3@kernel.org>
Date: Tue, 26 May 2026 19:03:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260525114621.571845-1-qiwenjie@xiaomi.com>
 <86c2f79d-ee26-4009-8051-82d25abf6d7b@kernel.org>
 <CAGFpFsQimHFADZGKA2ezyz7eXRG1mMNFOFiJHbsQban_vjb5qQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGFpFsQimHFADZGKA2ezyz7eXRG1mMNFOFiJHbsQban_vjb5qQ@mail.gmail.com>
X-Headers-End: 1wRpZv-0002No-Q6
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate orphan inode entry count
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNS8yNi8yNiAxMzozOCwgV2VuamllIFFpIHdyb3RlOgo+IEFncmVlZCwgU0JJX05FRURfRlND
SyBtYXkgbm90IGJlIHBlcnNpc3RlZCBhdCB0aGlzIHN0YWdlLgo+IAo+ICAgSSBzZW50IHYyIHRv
IGFkZCBFUlJPUl9JTkNPTlNJU1RFTlRfT1JQSEFOIGFuZCBjYWxsIGYyZnNfaGFuZGxlX2Vycm9y
KCkgb24KPiAgIGludmFsaWQgb3JwaGFuIGVudHJ5X2NvdW50LCBzbyB0aGUgY29ycnVwdGlvbiBy
ZWFzb24gY2FuIGJlIHJlY29yZGVkIGluCj4gICBzX2Vycm9yc1tdIGFzIGEgcGVyc2lzdGVudCBo
aW50IGZvciBmc2NrLgoKU28sIGl0IG5lZWRzIGFub3RoZXIgcGF0Y2ggdG8gbGV0IGZzY2sgcmVj
b2duaXplIHRoZSBuZXcgZmxhZz8KClRoYW5rcywKCj4gCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtZjJmcy1kZXZlbC8yMDI2MDUyNjA1MzU1Ny4xMDk2MjI5LTEtcWl3ZW5qaWVAeGlh
b21pLmNvbS9ULyN1Cj4gCj4gT24gVHVlLCBNYXkgMjYsIDIwMjYgYXQgMTA6MTnigK9BTSBDaGFv
IFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBPbiA1LzI1LzI2IDE5OjQ2LCBXZW5q
aWUgUWkgd3JvdGU6Cj4+PiBmMmZzX3JlY292ZXJfb3JwaGFuX2lub2RlcygpIHRydXN0cyB0aGUg
b3JwaGFuIGJsb2NrIGVudHJ5X2NvdW50IHdoZW4KPj4+IHJlcGxheWluZyBvcnBoYW4gaW5vZGVz
IGZyb20gdGhlIGNoZWNrcG9pbnQgcGFjay4gIEEgY29ycnVwdGVkCj4+PiBlbnRyeV9jb3VudCBs
YXJnZXIgdGhhbiBGMkZTX09SUEhBTlNfUEVSX0JMT0NLIG1ha2VzIHRoZSByZWNvdmVyeSBsb29w
Cj4+PiByZWFkIHBhc3QgdGhlIGlub1tdIGFycmF5IGFuZCBpbnRlcnByZXQgZm9vdGVyIG9yIGZv
bGxvd2luZyBkYXRhIGFzCj4+PiBpbm9kZSBudW1iZXJzLgo+Pj4KPj4+IE9uIGEgY3JhZnRlZCBp
bWFnZSwgbW91bnRpbmcgYW4gdW5wYXRjaGVkIGtlcm5lbCBjYW4gZHJpdmUgb3JwaGFuCj4+PiBy
ZWNvdmVyeSBpbnRvIGYyZnNfYnVnX29uKCkgYW5kIHBhbmljIHRoZSBrZXJuZWwuICBWYWxpZGF0
ZSBlbnRyeV9jb3VudAo+Pj4gYmVmb3JlIGNvbnN1bWluZyBlbnRyaWVzIHNvIGNvcnJ1cHRlZCBj
aGVja3BvaW50IGRhdGEgZmFpbHMgdGhlIG1vdW50Cj4+PiB3aXRoIC1FRlNDT1JSVVBURUQgYW5k
IHJlcXVlc3RzIGZzY2sgaW5zdGVhZC4KPj4+Cj4+PiBGaXhlczogMTI3ZTY3MGFiZmE3ICgiZjJm
czogYWRkIGNoZWNrcG9pbnQgb3BlcmF0aW9ucyIpCj4+PiBDYzogc3RhYmxlQGtlcm5lbC5vcmcK
Pj4+IFNpZ25lZC1vZmYtYnk6IFdlbmppZSBRaSA8cWl3ZW5qaWVAeGlhb21pLmNvbT4KPj4+IC0t
LQo+Pj4gIGZzL2YyZnMvY2hlY2twb2ludC5jIHwgMTMgKysrKysrKysrKysrLQo+Pj4gIDEgZmls
ZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2ZzL2YyZnMvY2hlY2twb2ludC5jIGIvZnMvZjJmcy9jaGVja3BvaW50LmMKPj4+IGlu
ZGV4IGMwMGE2YjZlYmNiZC4uZmM3MmI2OWZmNzY5IDEwMDY0NAo+Pj4gLS0tIGEvZnMvZjJmcy9j
aGVja3BvaW50LmMKPj4+ICsrKyBiL2ZzL2YyZnMvY2hlY2twb2ludC5jCj4+PiBAQCAtOTQzLDYg
Kzk0Myw3IEBAIGludCBmMmZzX3JlY292ZXJfb3JwaGFuX2lub2RlcyhzdHJ1Y3QgZjJmc19zYl9p
bmZvICpzYmkpCj4+PiAgICAgICBmb3IgKGkgPSAwOyBpIDwgb3JwaGFuX2Jsb2NrczsgaSsrKSB7
Cj4+PiAgICAgICAgICAgICAgIHN0cnVjdCBmb2xpbyAqZm9saW87Cj4+PiAgICAgICAgICAgICAg
IHN0cnVjdCBmMmZzX29ycGhhbl9ibG9jayAqb3JwaGFuX2JsazsKPj4+ICsgICAgICAgICAgICAg
dW5zaWduZWQgaW50IGVudHJ5X2NvdW50Owo+Pj4KPj4+ICAgICAgICAgICAgICAgZm9saW8gPSBm
MmZzX2dldF9tZXRhX2ZvbGlvKHNiaSwgc3RhcnRfYmxrICsgaSk7Cj4+PiAgICAgICAgICAgICAg
IGlmIChJU19FUlIoZm9saW8pKSB7Cj4+PiBAQCAtOTUxLDcgKzk1MiwxNyBAQCBpbnQgZjJmc19y
ZWNvdmVyX29ycGhhbl9pbm9kZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+Pj4gICAgICAg
ICAgICAgICB9Cj4+Pgo+Pj4gICAgICAgICAgICAgICBvcnBoYW5fYmxrID0gZm9saW9fYWRkcmVz
cyhmb2xpbyk7Cj4+PiAtICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZTMyX3RvX2NwdShv
cnBoYW5fYmxrLT5lbnRyeV9jb3VudCk7IGorKykgewo+Pj4gKyAgICAgICAgICAgICBlbnRyeV9j
b3VudCA9IGxlMzJfdG9fY3B1KG9ycGhhbl9ibGstPmVudHJ5X2NvdW50KTsKPj4+ICsgICAgICAg
ICAgICAgaWYgKGVudHJ5X2NvdW50ID4gRjJGU19PUlBIQU5TX1BFUl9CTE9DSykgewo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgIGYyZnNfZXJyKHNiaSwgImludmFsaWQgb3JwaGFuIGlub2RlIGVu
dHJ5IGNvdW50ICV1IiwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnRyeV9j
b3VudCk7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgc2V0X3NiaV9mbGFnKHNiaSwgU0JJX05F
RURfRlNDSyk7Cj4+Cj4+IFdlbGwsIGF0IHRoaXMgc3RhZ2UsIEkgZ3Vlc3MgdGhlcmUgaXMgbm8g
Y2hhbmNlIHRvIHBlcnNpc3QgU0JJX05FRURfRlNDSyBmbGFnLAo+PiB3aGF0IGFib3V0IGludHJv
ZHVjZSBFUlJPUl9JTkNPTlNJU1RFTlRfT1JQSEFOIGluIGVudW0gZjJmc19lcnJvciwgc28gdGhh
dAo+PiB3ZSBjYW4gcGVyc2lzdCB0aGUgbmV3IGJpdCB0byBwcm92aWRlIGhpbnQgdG8gZnNjaz8K
Pj4KPj4gVGhhbmtzLAo+Pgo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGVyciA9IC1FRlNDT1JS
VVBURUQ7Cj4+PiArICAgICAgICAgICAgICAgICAgICAgZjJmc19mb2xpb19wdXQoZm9saW8sIHRy
dWUpOwo+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+Pj4gKyAgICAgICAgICAg
ICB9Cj4+PiArCj4+PiArICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBlbnRyeV9jb3VudDsg
aisrKSB7Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgbmlkX3QgaW5vID0gbGUzMl90b19jcHUo
b3JwaGFuX2Jsay0+aW5vW2pdKTsKPj4+Cj4+PiAgICAgICAgICAgICAgICAgICAgICAgZXJyID0g
cmVjb3Zlcl9vcnBoYW5faW5vZGUoc2JpLCBpbm8pOwo+PgoKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
