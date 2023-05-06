Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DE7C77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  6 May 2023 14:13:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pvIfJ-0006Ho-GR;
	Sat, 06 May 2023 14:13:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1pvIfI-0006Hi-6q
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 May 2023 14:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TBdQEF81l2nq+2j3jCyjruKKwsIfsnL8xmxfoM/hWZw=; b=EtHf8hPJQ3QCeRhW23aAO4VWKz
 uziVilcKd6WAnzNfHe06LPag9MxRgKgQQ/DOZrsjEMphhjNCYP9A66dHDfjs+uR4lXAXa9/BSkuXV
 GhIqOnbRbAsQ4PkQaIySQkg6YoSmx0wa+kuRDQ7dqM/Xv2GhLQMEd1NbNuE5vmbPdq4Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TBdQEF81l2nq+2j3jCyjruKKwsIfsnL8xmxfoM/hWZw=; b=dvhMneDx9x2WaAJnU0HiHZQSy6
 w6NCLMJhQf0VUwkv13jZYhfgmIF5CFJGg4P/lu9I8yV6zf10CbvzINgUzVUGDdZ7ovSXe+H5mGmdX
 CcQCWQDL9NXlgVwAto6QKTutmVDx7O+HPmhwr8f7EyymTKLAaGowu+CPOnYViSgcwvKU=;
Received: from smtp-14.smtpout.orange.fr ([80.12.242.14]
 helo=smtp.smtpout.orange.fr)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pvIfC-0002Rd-U5 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 May 2023 14:13:36 +0000
Received: from [192.168.1.18] ([86.243.2.178]) by smtp.orange.fr with ESMTPA
 id vIf5pACTtunMHvIf6p93Sx; Sat, 06 May 2023 16:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1683382404;
 bh=TBdQEF81l2nq+2j3jCyjruKKwsIfsnL8xmxfoM/hWZw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=pcQOv4YU7ViB9jbXJSOhZQodkzuBNeNoudsrx1aUwzWMxwYs9ShCZwlZxnUCtx0Rl
 958YQ/zX/N2CrXt5L4pLAxI/QjacFEoeoQcNzfWO0cbFbFv3eohDegbGTkHo6RNIOU
 eO8+bn8qS5ehwXBu4l9sZns0hoSxySL9xzeQxoipfxlFs/chr8kN+4UQl2wy3cnPMu
 g8gDXEUBjEcRCwLoZsOm9AuKnclEFmT69jzgDssdSp9reKCW5GjoQyiCjA9JWYt3XJ
 yM+3WxwSCq9qoLkrbV/HVnhnpKKfwTi+gtYyuAlH3CsTEhUU+SxRZvpHc4GNrUzpEQ
 ScyvtCGt7JOeQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 06 May 2023 16:13:24 +0200
X-ME-IP: 86.243.2.178
Message-ID: <d0da5b97-682d-9fef-3fb0-1381ead79667@wanadoo.fr>
Date: Sat, 6 May 2023 16:13:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20230506113914.23419-1-frank.li@vivo.com>
Content-Language: fr
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230506113914.23419-1-frank.li@vivo.com>
X-Headers-End: 1pvIfC-0002Rd-U5
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: move the conditional statement
 after holding the inode lock in f2fs_move_file_range()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

TGUgMDYvMDUvMjAyMyDDoCAxMzozOSwgWWFuZ3RhbyBMaSBhIMOpY3JpdMKgOgo+IEZvciBqdWRn
aW5nIHRoZSBpbm9kZSBmbGFnIHN0YXRlLCB0aGUgaW5vZGUgbG9jayBtdXN0IGJlIGhlbGQuCj4g
QlRXLCBhZGQgY29tcHJlc3NkIGZpbGUgY2hlY2sgYW5kIHRvIGF2b2lkICdpZicgbmVzdGluZy4K
PiAKPiBGaXhlczogNGRkNmY5NzdmYzc3ICgiZjJmczogc3VwcG9ydCBhbiBpb2N0bCB0byBtb3Zl
IGEgcmFuZ2Ugb2YgZGF0YSBibG9ja3MiKQo+IFNpZ25lZC1vZmYtYnk6IFlhbmd0YW8gTGkgPGZy
YW5rLmxpQHZpdm8uY29tPgo+IC0tLQo+ICAgZnMvZjJmcy9maWxlLmMgfCAxNCArKysrKysrKy0t
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkK
PiAKPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9maWxlLmMgYi9mcy9mMmZzL2ZpbGUuYwo+IGluZGV4
IDc4YWE4Y2ZmNGI0MS4uODUwZTc0NWVjZjg4IDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZmlsZS5j
Cj4gKysrIGIvZnMvZjJmcy9maWxlLmMKPiBAQCAtMjc5MCw5ICsyNzkwLDYgQEAgc3RhdGljIGlu
dCBmMmZzX21vdmVfZmlsZV9yYW5nZShzdHJ1Y3QgZmlsZSAqZmlsZV9pbiwgbG9mZl90IHBvc19p
biwKPiAgIAlpZiAoIVNfSVNSRUcoc3JjLT5pX21vZGUpIHx8ICFTX0lTUkVHKGRzdC0+aV9tb2Rl
KSkKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAKPiAtCWlmIChJU19FTkNSWVBURUQoc3JjKSB8
fCBJU19FTkNSWVBURUQoZHN0KSkKPiAtCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gLQo+ICAgCWlm
IChwb3Nfb3V0IDwgMCB8fCBwb3NfaW4gPCAwKQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+
IEBAIC0yODA0LDEyICsyODAxLDE3IEBAIHN0YXRpYyBpbnQgZjJmc19tb3ZlX2ZpbGVfcmFuZ2Uo
c3RydWN0IGZpbGUgKmZpbGVfaW4sIGxvZmZfdCBwb3NfaW4sCj4gICAJfQo+ICAgCj4gICAJaW5v
ZGVfbG9jayhzcmMpOwo+IC0JaWYgKHNyYyAhPSBkc3QpIHsKPiArCWlmIChzcmMgIT0gZHN0ICYm
ICFpbm9kZV90cnlsb2NrKGRzdCkpIHsKPiAgIAkJcmV0ID0gLUVCVVNZOwo+IC0JCWlmICghaW5v
ZGVfdHJ5bG9jayhkc3QpKQo+IC0JCQlnb3RvIG91dDsKPiArCQlnb3RvIG91dDsKPiAgIAl9Cj4g
ICAKPiArCWlmIChJU19FTkNSWVBURUQoc3JjKSB8fCBJU19FTkNSWVBURUQoZHN0KSkKPiArCQly
ZXR1cm4gLUVPUE5PVFNVUFA7CgpyZXQgPSAtRU9QTk9UU1VQUDsKZ290byBvdXRfdW5sb2NrOwoK
PwoKPiArCj4gKwlpZiAoZjJmc19jb21wcmVzc2VkX2ZpbGUoc3JjKSB8fCBmMmZzX2NvbXByZXNz
ZWRfZmlsZShkc3QpKQo+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsKClNhbWUKCkNKCgo+ICsKPiAg
IAlyZXQgPSAtRUlOVkFMOwo+ICAgCWlmIChwb3NfaW4gKyBsZW4gPiBzcmMtPmlfc2l6ZSB8fCBw
b3NfaW4gKyBsZW4gPCBwb3NfaW4pCj4gICAJCWdvdG8gb3V0X3VubG9jazsKCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
