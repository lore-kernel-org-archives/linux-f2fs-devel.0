Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B40C3600C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Apr 2025 02:26:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzRKw-0006TU-IA;
	Tue, 01 Apr 2025 02:26:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tzRKu-0006TM-JS
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Apr 2025 02:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ybQGJUJ/MJKeEUBQTnLi68JYeb41fsulEihlo/dxgM=; b=O8Bi8OPcLqoU8nKW5Ae5QZBTcb
 3jr20yYH0LXs43xbDOfsyMtbpB1SbWnMdl1ytDqb7W38j4PpNLdgt/C+oa4no8yUytd38DFjo4cMS
 WNbkjMv+pT7wrT3yvDQlLyXPE1Gwt7W2JIpiZfT+Ar9cHQmgETUrSyE1OZWTkQVkDdhc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5ybQGJUJ/MJKeEUBQTnLi68JYeb41fsulEihlo/dxgM=; b=bkJrsec21eEWf3FT6e3mr02CSC
 T+gLwOZOwLyTQe8xmLrwTNCPI+fUJdSSJtaPBItbqweTejWZZMHgGfl9GUWRebjG5hPmANKjoPwD9
 ibOAg20157vkz1zAcn8MjNn7wdfiV6ogtH5IMIj0LmnnzAOeTxGMxbZi77l8knIxIW+c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tzRKf-0002ks-CB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Apr 2025 02:26:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 729765C5AAC;
 Tue,  1 Apr 2025 02:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E3C4CEE3;
 Tue,  1 Apr 2025 02:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743474377;
 bh=Qj5lRgKTdGVfDGyxGKzeQq0unXZcpKgG0YcOfqK6vrQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=gB+HeFwyTOh+oKJ9dfNd+W+hC4erRDVvseaTFn0+CSq9PopU2DnSPvV3qViiOyTWT
 9psSxkMAui3T+dUmk5xR/KjE2a+8WlY1rpB4pg97rIL2lOkhPnIrNwKlWNdOUclmpC
 PjU4dpYKcz4juTPYP1YlAlL1NShAgMP3o4bf7ol+id3rnr07KCm9rYv0taF01lTfYE
 0ERaeYxWJD/aBaw4RhBeDM9XK6Cf2kr2PsDWt9pqCUE6tH8IuVT1I05gntx+GMsnec
 WxYJBVe7fjNXMXGd9MF+ge/yU3QPyYjR/dkZpjJ/N9K5Fu3Xhwg3BGqI8IYb8bhpeG
 DwasRrKvPidug==
Message-ID: <bef1588f-9c76-44a7-9b33-72ec307ae79d@kernel.org>
Date: Tue, 1 Apr 2025 10:26:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Lee <chullee@google.com>
References: <20250331025416.478380-1-chao@kernel.org>
 <CALBjLoDnzALdShsEzii6pK+fxgbeNVh8weKVtb=PyFJ3XgS1NA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALBjLoDnzALdShsEzii6pK+fxgbeNVh8weKVtb=PyFJ3XgS1NA@mail.gmail.com>
X-Headers-End: 1tzRKf-0002ks-CB
Subject: Re: [f2fs-dev] [PATCH] f2fs: support to disable linear lookup
 fallback
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
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNC8xLzI1IDAwOjMxLCBEYW5pZWwgTGVlIHdyb3RlOgo+IE9uIFN1biwgTWFyIDMwLCAyMDI1
IGF0IDc6NTTigK9QTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pgo+PiBBZnRl
ciBjb21taXQgOTFiNTg3YmE3OWUxICgiZjJmczogSW50cm9kdWNlIGxpbmVhciBzZWFyY2ggZm9y
Cj4+IGRlbnRyaWVzIiksIGYyZnMgZm9yY2VkIHRvIHVzZSBsaW5lYXIgbG9va3VwIHdoZW5ldmVy
IGEgaGFzaC1iYXNlZAo+PiBsb29rdXAgZmFpbHMgb24gY2FzZWZvbGRlZCBkaXJlY3RvcnksIGl0
IG1heSBhZmZlY3QgcGVyZm9ybWFuY2UKPj4gZm9yIHNjZW5hcmlvczogYSkgY3JlYXRlIGEgbmV3
IGZpbGUgdy8gZmlsZW5hbWUgaXQgZG9lc24ndCBleGlzdAo+PiBpbiBkaXJlY3RvcnksIGIpIGxv
b2t1cCBhIGZpbGUgd2hpY2ggbWF5IGJlIHJlbW92ZWQuCj4+Cj4+IFRoaXMgcGF0Y2ggc3VwcG9y
dHMgdG8gZGlzYWJsZSBsaW5lYXIgbG9va3VwIGZhbGxiYWNrLCBzbywgb25jZSB0aGVyZQo+PiBp
cyBhIHNvbHV0aW9uIGZvciBjb21taXQgNWMyNmQyZjFkM2Y1ICgidW5pY29kZTogRG9uJ3Qgc3Bl
Y2lhbCBjYXNlCj4+IGlnbm9yYWJsZSBjb2RlIHBvaW50cyIpIHRvIGZpeCByZWQgaGVhcnQgdW5p
Y29kZSBpc3N1ZSwgdGhlbiB3ZSBjYW4KPj4gc2V0IGFuIGVuY29kZWluZyBmbGFnIHRvIGRpc2Fi
bGUgdGhlIGZhbGxiYWNrIGZvciBwZXJmb3JtYW5jZSByZWNvdmVyeS4KPj4KPj4gVGhlIHdheSBp
cyBrZXB0IGluIGxpbmUgdy8gZXh0NCwgcmVmZXIgdG8gY29tbWl0IDllMjgwNTlkNTY2NCAoImV4
dDQ6Cj4+IGludHJvZHVjZSBsaW5lYXIgc2VhcmNoIGZvciBkZW50cmllcyIpLgo+Pgo+PiBDYzog
RGFuaWVsIExlZSA8Y2h1bGxlZUBnb29nbGUuY29tPgo+PiBDYzogR2FicmllbCBLcmlzbWFuIEJl
cnRhemkgPGtyaXNtYW5Ac3VzZS5kZT4KPj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0Br
ZXJuZWwub3JnPgo+PiAtLS0KPj4gIGZzL2YyZnMvZGlyLmMgfCAzICsrLQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEv
ZnMvZjJmcy9kaXIuYyBiL2ZzL2YyZnMvZGlyLmMKPj4gaW5kZXggNWE2M2ZmMGRmMDNiLi5lMTI0
NDVhZmI5NWEgMTAwNjQ0Cj4+IC0tLSBhL2ZzL2YyZnMvZGlyLmMKPj4gKysrIGIvZnMvZjJmcy9k
aXIuYwo+PiBAQCAtMzY2LDcgKzM2Niw4IEBAIHN0cnVjdCBmMmZzX2Rpcl9lbnRyeSAqX19mMmZz
X2ZpbmRfZW50cnkoc3RydWN0IGlub2RlICpkaXIsCj4+Cj4+ICBvdXQ6Cj4+ICAjaWYgSVNfRU5B
QkxFRChDT05GSUdfVU5JQ09ERSkKPj4gLSAgICAgICBpZiAoSVNfQ0FTRUZPTERFRChkaXIpICYm
ICFkZSAmJiB1c2VfaGFzaCkgewo+PiArICAgICAgIGlmIChJU19DQVNFRk9MREVEKGRpcikgJiYg
IWRlICYmIHVzZV9oYXNoICYmCj4+ICsgICAgICAgICAgICAgICAhc2Jfbm9fY2FzZWZvbGRfY29t
cGF0X2ZhbGxiYWNrKGRpci0+aV9zYikpIHsKPiAKPiAKPiBXb3VsZCBpdCBiZSBiZW5lZmljaWFs
IHRvIGV2YWx1YXRlCj4gIXNiX25vX2Nhc2Vmb2xkX2NvbXBhdF9mYWxsYmFjayhkaXItPmlfc2Ip
IGZpcnN0IGZvciBzaG9ydC1jaXJjdWl0aW5nPwoKWWVhaCwgSSBndWVzcyBpdCB3aWxsIHdoZW4g
d2UgZGlzYWJsZSB0aGUgZmFsbGJhY2sgYnkgZGVmYXVsdCwgd2lsbCB1cGRhdGUgdjIsCnRoYW5r
IHlvdSEKClRoYW5rcywKCj4gCj4gCj4+Cj4+ICAgICAgICAgICAgICAgICB1c2VfaGFzaCA9IGZh
bHNlOwo+PiAgICAgICAgICAgICAgICAgZ290byBzdGFydF9maW5kX2VudHJ5Owo+PiAgICAgICAg
IH0KPj4gLS0KPj4gMi40OS4wCj4+CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
