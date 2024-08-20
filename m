Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43715C5320E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Aug 2024 06:58:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sgIot-0004BF-Lt;
	Tue, 20 Aug 2024 06:58:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sgIos-0004B9-8M
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 06:58:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cxJhbTneFfRe2+wYh+05cGdtp4H7MpjIi5VIFQNqJ8E=; b=akhJx0+6tDX0dZzlnb6P0ddJGi
 b+yl9rPHbyrOHCK13cGqyNH36hclRTOUwYJvMMb9A5QNlU1KYDQ4wKkMnKGCMf9BlUxPGHKbANgpL
 ejHTtRCsfDAl4jOYeJLf6p+PJLz/i+XEiDyc7ODqg+UP8XpQh52MtQ6K7YXmboM4k53Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cxJhbTneFfRe2+wYh+05cGdtp4H7MpjIi5VIFQNqJ8E=; b=GLLM/ODAydoEw9VjraMfGCtr4X
 6ZjgQKT6NdS7CW08yLd28hhnv8pZnQdDiNIyZCOfbXC7aG8uIUWXLlk7iEi8GHFGTdv3h5JY25+jP
 ypEF6dX6GlYIv+Kwqvcv8qNCh78jFAAX0xIFxynVv2wglq3B6ATJiwbRY3eZ10CdtJAo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sgIor-00008K-K7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Aug 2024 06:58:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 429A560DD0;
 Tue, 20 Aug 2024 06:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B452BC4AF09;
 Tue, 20 Aug 2024 06:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724137092;
 bh=5VzK0arXNZWe9Hr1ikvzK31iRl9Dw1JLNtUWg6K4hyI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CB5tA0U8kuG192fxvt+AW67nbj1stAk9GvEOkwglk2KqSm0mJVjGZkDKDgAEAfQA9
 bTSO2p8r6VYUL38g/BuWJkHZ2tHJbM2LqYOL1WPFgbsRQQpfuKNkMW3bW6XW6NggnS
 c1RcPNiQj3LUJbR2fC1AhQPrpWOUFEjq4vF6Eqob2XVitqzrim4BpqBtCW7/VPpvqk
 WYyeMr1TJI65l428DLfxvsz9dtK9WkDNE3Q+JzTN2pqi8D9IEUj86Cq8Df81farabU
 lY2AFmLyaw23+lVlxBHKjr1hC6UKx6gGY52CRgS8+N8xGF9QsjyuIa6+YIzE/Gd8qL
 8lSLxG9X0TMVA==
Message-ID: <a16d5083-5e24-43e1-b245-12152cac5947@kernel.org>
Date: Tue, 20 Aug 2024 14:58:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Zetao <lizetao1@huawei.com>, jaegeuk@kernel.org
References: <20240820034654.698236-1-chao@kernel.org>
 <a36db618-e7df-4c15-ad6f-876d8cc2bde5@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <a36db618-e7df-4c15-ad6f-876d8cc2bde5@huawei.com>
X-Headers-End: 1sgIor-00008K-K7
Subject: Re: [f2fs-dev] [PATCH v2 1/8] f2fs: convert f2fs_write_begin() to
 use folio
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
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyNC84LzIwIDEyOjM4LCBMaSBaZXRhbyB3cm90ZToKPj4gSSB3YW50IHRvIGFwcGx5IHlv
dXIgcGF0Y2ggc2V0IGZvciB0ZXN0aW5nLCBidXQgdGhlcmUgaXMgYSBjb25mbGljdCBvbiAKPiB0
aGUgbWFzdGVyIGJyYW5jaCBvZiBsaW51eC1uZXh0LiBNYXliZSBpdCBkZXBlbmRzIG9uIGEgY2Vy
dGFpbiBwcmUtcGF0Y2guIFBsZWFzZSBsZXQgbWUga25vdywgdGhhbmsgeW91Lgo+IAo+ICDCoCBB
cHBseWluZzogZjJmczogY29udmVydCBmMmZzX3dyaXRlX2JlZ2luKCkgdG8gdXNlIGZvbGlvCj4g
IMKgIGVycm9yOiBwYXRjaCBmYWlsZWQ6IGZzL2YyZnMvZGF0YS5jOjM1NjYKPiAgwqAgZXJyb3I6
IGZzL2YyZnMvZGF0YS5jOiBwYXRjaCBkb2VzIG5vdCBhcHBseQo+ICDCoCBQYXRjaCBmYWlsZWQg
YXQgMDAwMSBmMmZzOiBjb252ZXJ0IGYyZnNfd3JpdGVfYmVnaW4oKSB0byB1c2UgZm9saW8KCldl
IHNob3VsZCBhcHBseSB0aGlzIHBhdGNoc2V0IG9uIHRvcCBvZiBkZXYtdGVzdCBicmFuY2g/Cgpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qYWVnZXVrL2Yy
ZnMuZ2l0L2xvZy8/aD1kZXYtdGVzdAoKVGhhbmtzLAoKPiAKPiBUaGFua3MsCj4gTGkgWmV0YW8u
CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
