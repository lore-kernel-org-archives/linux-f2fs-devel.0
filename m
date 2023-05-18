Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1E9C77B7D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 May 2023 07:54:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pzYSZ-0003nK-81;
	Thu, 18 May 2023 07:54:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pzYST-0003n3-N5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 07:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2zX9hpV3B1p6fNqa/5cvfqfmPm31636JQ00+pzb9V+M=; b=kyPUEFsBdtdYOBWHTUCrv6luNA
 TNIYTbb4e7yiYD9gDzQbs5I/oCUfrxfGvlszth7CnhclMaDzmosmGspT/u/nRrqwVAQ7erCtERLgf
 o08NKXmrjfhU7d1isxV9QYwjdI69UvuSwuyINf4m32LCBP4MOdaJP8tR18bxL3qnr/Wg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2zX9hpV3B1p6fNqa/5cvfqfmPm31636JQ00+pzb9V+M=; b=ddnLfSBhyEdPoQowq/WNr7gHta
 X2PNtVG0b5qvq9YVOT+j2LcURvIRLffQKaK0av1vMi920LGx3c6/lBjD1YQmQs8UAeNOL+GEy2LSS
 i1X0pS+3iVOpesHmRmW4BTnnwsfCK1Ldr02Uj9FZQnPN7UKZmTsQN9Po49LfdgvT7YkI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pzYSS-00C53r-T9 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 18 May 2023 07:53:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8607A608D5;
 Thu, 18 May 2023 07:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F85C4339B;
 Thu, 18 May 2023 07:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684396431;
 bh=5kuRe+pDTesM2QQF32v7tchS1XlHr6RfShCzacszbug=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=mVO8zG2dG6GgEtesKY3hYNq1fkgvLyCHGpjEhHLfOI6dQn57b7MSqf32xCw4T3uZg
 VGmWE8ixtb1XOA9NsZjGuS1xS2kdpUiheQ3pbeuLibkA/YcmSoc0cy9BE/XTJiCV19
 NHvZO0ZawXhg4KNA2AmRlqB+9F3GTkvI7dNIFdT0fudbHR2qxR/7YL7osstwmUhAPk
 mNBanlfTwzsRtTlnb40+dnNAZ0LBPq0rAxBNZaDK/31ZBYSELLugX+IGTEFMjKgNAx
 jYD5Yh4oU1aJaL01fQkZ7CQVrv4LF+fNg2/oSkvjzmyx09vTNCBQ2F0yXv0MspFlRI
 /0WGsUOcht1Og==
Message-ID: <c7f5350c-c13f-5079-9b1d-cc04ef04e246@kernel.org>
Date: Thu, 18 May 2023 15:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Juhyung Park <qkrwngud825@gmail.com>
References: <CAD14+f3z=kS9E+NTKH7t1J2xL1PpLOVMNx=CabD_t2K6U=T9uQ@mail.gmail.com>
 <b03137d3-cf73-60f7-3c0c-33c9beb9b209@kernel.org>
 <CAD14+f0xZguG9NG5anRzabgKrhvMeWO+kKrzXnL1MuM2gZ_yxA@mail.gmail.com>
 <68037247-6206-4419-fd87-52ee26c6df80@kernel.org>
 <CAD14+f3J_ReeS4VvqBZnLs04i=iXN36MJRWc_Pa95tftnZrtRg@mail.gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAD14+f3J_ReeS4VvqBZnLs04i=iXN36MJRWc_Pa95tftnZrtRg@mail.gmail.com>
X-Headers-End: 1pzYSS-00C53r-T9
Subject: Re: [f2fs-dev] [DISCUSSION] f2fs for desktop
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Koskovich <akoskovich@pm.me>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMy80LzIxIDE6MjYsIEp1aHl1bmcgUGFyayB3cm90ZToKPiBIaSBDaGFvLAo+IAo+IE9u
IEZyaSwgQXByIDIxLCAyMDIzIGF0IDE6MTnigK9BTSBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+
IHdyb3RlOgo+Pgo+PiBIaSBKdUh5dW5nLAo+Pgo+PiBTb3JyeSBmb3IgZGVsYXkgcmVwbHkuCj4+
Cj4+IE9uIDIwMjMvNC8xMSAxOjAzLCBKdWh5dW5nIFBhcmsgd3JvdGU6Cj4+PiBIaSBDaGFvLAo+
Pj4KPj4+IE9uIFR1ZSwgQXByIDExLCAyMDIzIGF0IDEyOjQ04oCvQU0gQ2hhbyBZdSA8Y2hhb0Br
ZXJuZWwub3JnPiB3cm90ZToKPj4+Pgo+Pj4+IEhpIEp1aHl1bmcsCj4+Pj4KPj4+PiBPbiAyMDIz
LzQvNCAxNTozNiwgSnVoeXVuZyBQYXJrIHdyb3RlOgo+Pj4+PiBIaSBldmVyeW9uZSwKPj4+Pj4K
Pj4+Pj4gSSB3YW50IHRvIHN0YXJ0IGEgZGlzY3Vzc2lvbiBvbiB1c2luZyBmMmZzIGZvciByZWd1
bGFyIGRlc2t0b3BzL3dvcmtzdGF0aW9ucy4KPj4+Pj4KPj4+Pj4gVGhlcmUgYXJlIGdyb3dpbmcg
bnVtYmVyIG9mIGludGVyZXN0cyBpbiB1c2luZyBmMmZzIGFzIHRoZSBnZW5lcmFsCj4+Pj4+IHJv
b3QgZmlsZS1zeXN0ZW06Cj4+Pj4+IDIwMTg6IGh0dHBzOi8vd3d3LnBob3Jvbml4LmNvbS9uZXdz
L0dSVUItTm93LVN1cHBvcnRzLUYyRlMKPj4+Pj4gMjAyMDogaHR0cHM6Ly93d3cucGhvcm9uaXgu
Y29tL25ld3MvQ2xlYXItTGludXgtRjJGUy1Sb290LU9wdGlvbgo+Pj4+PiAyMDIzOiBodHRwczov
L2NvZGUubGF1bmNocGFkLm5ldC9+bmV4dXNwcmlzbS9jdXJ0aW4vK2dpdC9jdXJ0aW4vK21lcmdl
LzQzOTg4MAo+Pj4+PiAyMDIzOiBodHRwczovL2NvZGUubGF1bmNocGFkLm5ldC9+bmV4dXNwcmlz
bS9ncnViLytnaXQvdWJ1bnR1LyttZXJnZS80NDAxOTMKPj4+Pj4KPj4+Pj4gSSd2ZSBiZWVuIHBl
cnNvbmFsbHkgcnVubmluZyBmMmZzIG9uIGFsbCBvZiBteSB4ODYgTGludXggYm94ZXMgc2luY2UK
Pj4+Pj4gMjAxNSwgYW5kIEkgaGF2ZSBzZXZlcmFsIGNvbmNlcm5zIHRoYXQgSSB0aGluayB3ZSBu
ZWVkIHRvIGNvbGxlY3RpdmVseQo+Pj4+PiBhZGRyZXNzIGZvciByZWd1bGFyIG5vbi1BbmRyb2lk
IG5vcm1pZXMgdG8gdXNlIGYyZnM6Cj4+Pj4+Cj4+Pj4+IEEuIEJvb3Rsb2FkZXIgYW5kIGluc3Rh
bGxlciBzdXBwb3J0Cj4+Pj4+IEIuIEhvc3Qtc2lkZSBHQwo+Pj4+PiBDLiBFeHRlbmRlZCBub2Rl
IGJpdG1hcAo+Pj4+Pgo+Pj4+PiBJJ2xsIGdvIHRocm91Z2ggZWFjaCBvbmUuCj4+Pj4+Cj4+Pj4+
ID09PSBBLiBCb290bG9hZGVyIGFuZCBpbnN0YWxsZXIgc3VwcG9ydCA9PT0KPj4+Pj4KPj4+Pj4g
SXQgc2VlbXMgdGhhdCBib3RoIEdSVUIgYW5kIHN5c3RlbWQtYm9vdCBzdXBwb3J0cyBmMmZzIHdp
dGhvdXQgdGhlCj4+Pj4+IG5lZWQgZm9yIGEgc2VwYXJhdGUgZXh0NC1mb3JtYXR0ZWQgL2Jvb3Qg
cGFydGl0aW9uLgo+Pj4+PiBTb21lIGRpc3Ryb3MgYXJlIHNlZW1pbmdseSBkaXNhYmxpbmcgZjJm
cyBtb2R1bGUgZm9yIEdSVUIgdGhvdWdoIGZvcgo+Pj4+PiBzZWN1cml0eSByZWFzb25zOgo+Pj4+
PiBodHRwczovL2J1Z3MubGF1bmNocGFkLm5ldC91YnVudHUvK3NvdXJjZS9ncnViMi8rYnVnLzE4
Njg2NjQKPj4+Pj4KPj4+Pj4gSXQncyB1bHRpbWF0ZWx5IHVwIHRvIHRoZSBkaXN0cm8gZm9sa3Mg
dG8gZW5hYmxlIHRoaXMsIGFuZCBzdGlsbCBpbgo+Pj4+PiB0aGUgd29yc3QtY2FzZSBzY2VuYXJp
bywgdGhleSBjYW4gc3BlY2lmeSBhIHNlcGFyYXRlIC9ib290IHBhcnRpdGlvbgo+Pj4+PiBhbmQg
Zm9ybWF0IGl0IHRvIGV4dDQgdXBvbiBpbnN0YWxsYXRpb24uCj4+Pj4+Cj4+Pj4+IFRoZSBpbnN0
YWxsZXIgaXRzZWxmIHRvIHNob3cgZjJmcyBhbmQgY2FsbCBta2ZzLmYyZnMgaXMgYmVpbmcgd29y
a2VkCj4+Pj4+IG9uIGN1cnJlbnRseSBvbiBVYnVudHUuIFNlZSB0aGUgMjAyMyBsaW5rcyBhYm92
ZS4KPj4+Pj4KPj4+Pj4gTm90aGluZyBmMmZzIG1haW5saW5lIGRldmVsb3BlcnMgc2hvdWxkIGRv
IGhlcmUsIGltby4KPj4+Pj4KPj4+Pj4gPT09IEIuIEhvc3Qtc2lkZSBHQyA9PT0KPj4+Pj4KPj4+
Pj4gZjJmcyByZWxpZXZlcyBtb3N0IG9mIHRoZSBkZXZpY2Utc2lkZSBHQyBidXQgaW50cm9kdWNl
cyBhIG5ldwo+Pj4+PiBob3N0LXNpZGUgR0MuIFRoaXMgaXMgZXh0cmVtZWx5IGNvbmZ1c2luZyBm
b3IgcGVvcGxlIHdobyBoYXZlIG5vCj4+Pj4+IGJhY2tncm91bmQgaW4gU1NEcyBhbmQgZmxhc2gg
c3RvcmFnZSB0byB1bmRlcnN0YW5kLCBsZXQgYWxvbmUKPj4+Pj4gZGlzY2FyZC90cmltL2VyYXNl
IGNvbXBsaWNhdGlvbnMuCj4+Pj4+Cj4+Pj4+IEluIG1vc3QgY29uc3VtZXItZ3JhZGUgYmxhY2ti
b3ggU1NEcywgZGV2aWNlLXNpZGUgR0NzIGFyZSBoYW5kbGVkCj4+Pj4+IGF1dG9tYXRpY2FsbHkg
Zm9yIHZhcmlvdXMgd29ya2xvYWRzLiBmMmZzLCBob3dldmVyLCBsZWF2ZXMgdGhhdAo+Pj4+PiBy
ZXNwb25zaWJpbGl0eSB0byB0aGUgdXNlcnNwYWNlIHdpdGggY29uc2VydmF0aXZlIHR1bmluZyBv
biB0aGUKPj4+Pgo+Pj4+IFdlJ3ZlIHByb3Bvc2VkIGEgZjJmcyBmZWF0dXJlIG5hbWVkICJzcGFj
ZSBhd2FyZWQgZ2FyYmFnZSBjb2xsZWN0aW9uIgo+Pj4+IGFuZCBzaGlwcGVkIGl0IGluIGh1YXdl
aS9ob25vcidzIGRldmljZXMsIGJ1dCBmb3Jnb3QgdG8gdHJ5IHVwc3RyZWFtaW5nCj4+Pj4gaXQu
IDotUAo+Pj4+Cj4+Pj4gSW4gdGhpcyBmZWF0dXJlLCB3ZSBpbnRyb2R1Y2VkIHRocmVlIG1vZGU6
Cj4+Pj4gLSBwZXJmb3JtYW5jZSBtb2RlOiBzb21ldGhpbmcgbGlrZSB3cml0ZS1nYyBpbiBmdGws
IGl0IGNhbiB0cmlnZ2VyCj4+Pj4gYmFja2dyb3VuZCBnYyBtb3JlIGZyZXF1ZW50bHkgYW5kIHR1
bmUgaXRzIHNwZWVkIGFjY29yZGluZyB0byBmcmVlCj4+Pj4gc2VncyBhbmQgcmVjbGFpbWFibGUg
YmxrcyByYXRpby4KPj4+PiAtIGxpZmV0aW1lIG1vZGU6IHNsb3cgZG93biBiYWNrZ3JvdW5kIGdj
IHRvIGF2b2lkIGhpZ2ggd2FmIGlmIHRoZXJlCj4+Pj4gaXMgbGVzcyBmcmVlIHNwYWNlLgo+Pj4+
IC0gYmFsYW5jZSBtb2RlOiBiZWhhdmUgYXMgdXN1YWwuCj4+Pj4KPj4+PiBJIGd1ZXNzIHRoaXMg
bWF5IGJlIGhlbHBmdWwgZm9yIExpbnV4IGRlc2t0b3AgZGlzdHJvcyBzaW5jZSB0aGVyZSBpcwo+
Pj4+IG5vIHN1Y2ggc3RvcmFnZSBzZXJ2aWNlIHRyaWdnZXIgZ2NfdXJnZW50Lgo+Pj4+Cj4+Pgo+
Pj4gVGhhdCBpbmRlZWQgc291bmRzIGludGVyZXN0aW5nLgo+Pj4KPj4+IElmIHlvdSBuZWVkIG1l
IHRvIHRlc3Qgc29tZXRoaW5nIG91dCwgZmVlbCBmcmVlIHRvIGFzay4KPj4KPj4gVGhhbmtzIGEg
bG90IGZvciB0aGF0LiA6KQo+Pgo+PiBJJ20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgYSBwYXRjaC4u
LgoKSnVoeXVuZywKCkFyZSB5b3UgaW50ZXJlc3RpbmcgdG8gdHJ5IHRoaXMgcGF0Y2ggaW4gZGlz
dHJvcz8KCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2No
YW8vbGludXguZ2l0L2NvbW1pdC8/aD1kZXYtdGVzdCZpZD00NzM2ZTU1YmM5NjdlOTFjZjhhMjc1
YjY3ODczOWIwMDZjMjYxN2YwCgpUaGVyZSBhcmUgc29tZSB0dW5hYmxlIHBhcmFtZXRlcnMsIEkg
Y2FuIGV4cG9ydCB0aGVtIHZpYSBzeXNmcyBlbnRyeSwKbGV0IG1lIHVwZGF0ZSBsYXRlci4KClRo
YW5rcywKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
aW51eC1mMmZzLWRldmVsCg==
