Return-Path: <SRS0=cCFG=M3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F43C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Aug 2021 03:33:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8235560F56;
	Wed,  4 Aug 2021 03:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8235560F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mB7ek-0007Tl-3S; Wed, 04 Aug 2021 03:33:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mB7ej-0007TY-0i
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Aug 2021 03:33:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BtkNYftmu/wU0jTQuU56pcA94b/2ORJBNmcWCAWopEE=; b=TKN1nDoZkAHr6iEPpVf6MsupTk
 wsavUTimTK+UoDuQu4okxqE9wzUnAa6aKtNMn4Cdwb+YqPIt+TsQh0gqAKlddGpHx8I5ToioPfrmC
 ct4EInoRY0O9hY0WcJZ+0dFkgTmy+y44F7wAvp6F9eUh5PwmVnIdiME9mRgjXqZrHmts=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BtkNYftmu/wU0jTQuU56pcA94b/2ORJBNmcWCAWopEE=; b=X7FZzvhB4loqbnPFSPwzKvAeLJ
 vHyetiZMPKtcAjSIof6ccTAbEL9dxBvr2NcMm6nGo2h51QI3hETGNyRqnKvW2yPZ+dSTxrQw2Knmo
 48voXxhDEmm8hXadMLfs321ptymBnCay2ndTvMbxCpv7Tj0lYmYGRP2VDJdAVSAxELcc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mB7ea-0001kV-PJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 04 Aug 2021 03:33:20 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81E5D61037;
 Wed,  4 Aug 2021 03:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628047982;
 bh=L4lrzLbH/aV3W5MjROtpuPqG8ncWOO07RWA08kmI+ts=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=YFUuXXyxGoUyT/b0+YHP3RTRGNkE+kReB/vVxSbZ9sv/8Vuip8FzQgUGMK/AZrmnt
 QSVtIyrxIGicFU7jbEp6fBH+dXKLBhMtr0o12DNRs4d7RapJG/F7KveUqSJgm8NCCv
 Lvzcn6+28XC6Vc2F13mb5tu2I+4p8hHCdAyDYK9z5C4NBry6n3+hAhoGxLBcKC0zNc
 Mc+ziXtOOHrqwh9zBbeE4zZ2U9EB3dx4kxGR+sqL3Cq+68gLDq9Chf0ug8cEg2FzRJ
 q8+ebDbGgtLc6n75TobFfTL1rzI8YEzC6shta9zzjDbU/SM2i+3fKAVKOKwwl/LAnn
 r+3xLXV9TxERg==
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
References: <AJcAmwDXD1QzgUCoyu2cQKql.3.1626784315314.Hmail.frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <2c59c14b-008c-aee9-6775-13b47fbd252f@kernel.org>
Date: Wed, 4 Aug 2021 11:32:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <AJcAmwDXD1QzgUCoyu2cQKql.3.1626784315314.Hmail.frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mB7ea-0001kV-PJ
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: Reduce the scope of setting fsck
 tag when de->name_len is zero
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG8sIFlhbmd0YW8sCgpJIGRpZCBzb21lIGNsZWFudXAgaW4geW91ciBwYXRjaCwgYW5kIHJl
c2VuZCBmb3IgeW91LCBwbGVhc2UKbm90ZSB0aGF0LiA6KQoKVGhhbmtzLAoKT24gMjAyMS83LzIw
IDIwOjMxLCDmnY7miazpn6wgd3JvdGU6Cj4gSEkgQ2hhb++8jAo+IAo+IEZyb206IENoYW8gWXUg
PGNoYW9Aa2VybmVsLm9yZz4KPiBEYXRlOiAyMDIxLTA3LTIwIDE4OjIzOjE1Cj4gVG86ICBZYW5n
dGFvIExpIDxmcmFuay5saUB2aXZvLmNvbT4samFlZ2V1a0BrZXJuZWwub3JnCj4gQ2M6ICBsaW51
eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gZjJmczogUmVkdWNlIHRoZSBzY29wZSBv
ZiBzZXR0aW5nIGZzY2sgdGFnIHdoZW4gZGUtPm5hbWVfbGVuIGlzIHplcm8+T24gMjAyMS83LzIw
IDE1OjA2LCBZYW5ndGFvIExpIHdyb3RlOgo+Pj4gSSByZWNlbnRseSBmb3VuZCBhIGNhc2Ugd2hl
cmUgZGUtPm5hbWVfbGVuIGlzIDAgaW4gZjJmc19maWxsX2RlbnRyaWVzKCkgZWFzaWx5IHJlcHJv
ZHVjZWQsCj4+PiBhbmQgZmluYWxseSBzZXQgdGhlIGZzY2sgZmxhZy4KPj4+Cj4+PiBUaHJlYWQg
QQkJCQkJVGhyZWFkIEIKPj4+Cj4+PiBmMmZzX3JlYWRkaXIKPj4+IAlmMmZzX3JlYWRfaW5saW5l
X2Rpcgo+Pj4gCQljdHgtPnBvcyA9IGQubWF4Cj4+PiAJCQkJCQlmMmZzX2FkZF9kZW50cnkKPj4+
IAkJCQkJCQlmMmZzX2FkZF9pbmxpbmVfZW50cnkKPj4+IAkJCQkJCQkJZG9fY29udmVydF9pbmxp
bmVfZGlyCj4+PiAJCQkJCQkJZjJmc19hZGRfcmVndWxhcl9lbnRyeQo+Pj4gZjJmc19yZWFkZGly
Cj4+PiAJZjJmc19maWxsX2RlbnRyaWVzCj4+PiAJCXNldF9zYmlfZmxhZyhzYmksIFNCSV9ORUVE
X0ZTQ0spCj4+Pgo+Pj4gUHJvY2VzcyBBIG9wZW5zIHRoZSBmb2xkZXIsIGFuZCBoYXMgYmVlbiBy
ZWFkaW5nIHdpdGhvdXQgY2xvc2luZyBpdC4gRHVyaW5nIHRoaXMgcGVyaW9kLAo+Pj4gUHJvY2Vz
cyBCIGNyZWF0ZWQgYSBmaWxlIHVuZGVyIHRoZSBmb2xkZXIgKG9jY3VweWluZyBtdWx0aXBsZSBm
MmZzX2Rpcl9lbnRyeSwgZXhjZWVkaW5nCj4+PiB0aGUgZC5tYXggb2YgdGhlIGlubGluZSBkaXIp
LiBBZnRlciBjcmVhdGlvbiwgcHJvY2VzcyBBIHVzZXMgdGhlIGQubWF4IG9mIGlubGluZSBkaXIg
dG8KPj4+IHJlYWQgaXQgYWdhaW4sIGFuZCBpdCB3aWxsIHJlYWQgdGhhdCBkZS0+bmFtZV9sZW4g
aXMgMC4KPj4+Cj4+PiBBbmQgQ2hhbyBwb2ludGVkIG91dCB0aGF0IHcvbyBpbmxpbmUgY29udmVy
c2lvbiwgdGhlIHJhY2UgY29uZGl0aW9uIHN0aWxsIGNhbiBoYXBwZW4gYXMgYmVsb3cKPj4+Cj4+
PiBkaXJfZW50cnkxOiBBCj4+PiBkaXJfZW50cnkyOiBCCj4+PiBkaXJfZW50cnkzOiBDCj4+PiBm
cmVlIHNsb3Q6IF8KPj4+IGN0eC0+cG9zOiBeCj4+Pgo+Pj4gQmVmb3JlOgo+Pj4gQUFBQUJCQkJf
X18KPj4+IAkgXgo+Pgo+PiBwbGVhc2UgdXNlIGJsYW5rIGluc3RlYWQgb2YgdGFiIGJlZm9yZSAn
XicKPiAKPiBJIGRvbid0IGtub3cgZXhhY3RseSB3aGF0IGhhcHBlbmVkLiBJbiBmYWN0LCBpbiB2
Miwgc3BhY2VzIHdlcmUgdXNlZC4gVGhlbiBpdCB3YXMgY2hhbmdlZCB0byB0YWIgaW4gdjMuCj4g
Cj4+Cj4+PiBUaHJlYWQgQiBkZWxldGUgZGlyX2VudHJ5MiwgYW5kIGNyZWF0ZSBkaXJfZW50cnkz
Lgo+Pj4KPj4+IEFmdGVyOgo+Pj4gQUFBQUNDQ0NDX18KPj4+IAkgXgo+Pgo+PiBEaXR0bwo+Pgo+
Pj4KPj4+IEluIHRoZXNlIHNjZW5hcmlvcywgdGhlIGZpbGUgc3lzdGVtIGlzIG5vdCBkYW1hZ2Vk
LCBhbmQgaXQncyBoYXJkIHRvIGF2b2lkIGl0LiBCdXQgd2UgY2FuIGJ5cGFzcwo+Pj4gdGFnZ2lu
ZyBGU0NLIGZsYWcgaWY6Cj4+PiBhKSBiaXRfcG9zICg6PSBjdHgtPnBvcyAlIGQtPm1heCkgaXMg
bm9uLXplcm8gJiBiKSBiZWZvcmUgYml0X3BvcyBtb3ZlcyB0byBmaXJzdAo+Pj4gdmFsaWQgZGly
X2VudHJ5Lgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPGZyYW5rLmxpQHZpdm8u
Y29tPgo+Pj4gLS0tCj4+PiAgICBmcy9mMmZzL2Rpci5jIHwgMTQgKysrKysrKysrLS0tLS0KPj4+
ICAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZGlyLmMgYi9mcy9mMmZzL2Rpci5jCj4+PiBpbmRleCA0
NTY2NTE2ODJkYWYuLmJmZTk0MjczM2I1ZSAxMDA2NDQKPj4+IC0tLSBhL2ZzL2YyZnMvZGlyLmMK
Pj4+ICsrKyBiL2ZzL2YyZnMvZGlyLmMKPj4+IEBAIC0xMDAwLDYgKzEwMDAsNyBAQCBpbnQgZjJm
c19maWxsX2RlbnRyaWVzKHN0cnVjdCBkaXJfY29udGV4dCAqY3R4LCBzdHJ1Y3QgZjJmc19kZW50
cnlfcHRyICpkLAo+Pj4gICAgCXN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSA9IEYyRlNfSV9TQihk
LT5pbm9kZSk7Cj4+PiAgICAJc3RydWN0IGJsa19wbHVnIHBsdWc7Cj4+PiAgICAJYm9vbCByZWFk
ZGlyX3JhID0gc2JpLT5yZWFkZGlyX3JhID09IDE7Cj4+PiArCWJvb2wgZm91bmRfdmFsaWRfZGly
ZW50ICA9IGZhbHNlOwo+Pgo+PiBPbmUgbW9yZSBibGFuayBiZWZvcmUgJz0nLgo+Pgo+PiBib29s
IGZvdW5kX3ZhbGlkX2RpcmVudCA9IGZhbHNlOwo+Pgo+IAo+IE9LLgo+IAo+IFRoeO+8jAo+IAo+
IAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
