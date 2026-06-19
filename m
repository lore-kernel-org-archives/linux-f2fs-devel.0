Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F24FCD98F2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 19 Jun 2026 16:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hLALk7GMzq/Znjr9vYf7c6LT3e1gjveZrnCTd9w94dM=; b=HUDt7vVTt4pctW6q3zIMP3wECF
	NqOTC6oxRaIzAWTPOhj3vnWOAhU9hr31ZqGHM14L45Q5x4Gs2JW7MKKZqXiO6viCUwibAPBPHcjBf
	+FkQnP9QLVgv5wB6FyJznCph5TKSMXR2HIdNAaOI97N64OqVSDl+N/FMwr2fwpO+grcA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wacW5-0003d9-0r;
	Fri, 19 Jun 2026 16:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wacW3-0003d3-8i
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 Jun 2026 16:56:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Pc+roecy0N9fcSZhZ72+qSw1o+IjhE+4/qpcF1Vmgk=; b=acE62MEWWGYGxkUS8UC++Igt3Z
 TtJ0e/EUxetU80DqGHpInWPaAGAdJitjnmoIajADNE06f3lmmQEsTi9SNXMH3VKPVuw2n+mTUu0Vt
 OhP1nJUwZ/Y+Sq/7AqQEpvhmvF++hFbfl5+f7/Fhf5s1dWL9BEZu5isz3DWTxBejGNa4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9Pc+roecy0N9fcSZhZ72+qSw1o+IjhE+4/qpcF1Vmgk=; b=Jw4OqRVmrlgIRfUKiYsxnOWiAy
 Ksfa4OckVNaMbs9eJ1f1Ogzo13A9c99d5ZATqDcBTvGvocBBiB1Ntmxb79vaAbD3vWRMnaG/AxeKX
 9nl0NUa4ent+1khl+OImaxYvPvkiHaZ9Xo9Uk0C80TehCMhPS3mm0h5OpiiEjxzMovDw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wacW2-0004yv-On for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 19 Jun 2026 16:56:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EA62601E1;
 Fri, 19 Jun 2026 16:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F0B1F000E9;
 Fri, 19 Jun 2026 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781888181;
 bh=9Pc+roecy0N9fcSZhZ72+qSw1o+IjhE+4/qpcF1Vmgk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Shn1glcirGu1wXLyw5SX0iBWhoHUNgPUYmU8oRgEF5R3UfunAR/3yR1wGLaOhqZl6
 MpE/n+QWAPWVxdK3LJ8/X2j33uGDZ0TvVuTjBkn7bpSkSlyuSrMWvO9ep3WkVTOO05
 mbhAU6MeJya50Kd3/vda+WFYnkAzPRZywQm3HkKzDDozrePtQdjbXWwifpBJuDTJeD
 6wh1fWSUDSDkVniWShwwXXFI74T7qKkPY8t422Qa6eciuECvWYLv0KFqR04t4BbFPL
 UQj8fLdwGxzyj9eiyahw7qYBlKUc/U8Bz+AvhujKQxITT/mvPTlAYM4cvpW45DlAjg
 Ra8kcktUx+xLg==
Date: Fri, 19 Jun 2026 09:54:48 -0700
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20260619165448.GB3223@sol>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260520123722.405752-4-aalbersh@kernel.org>
 <20260520190719.GB3424023@google.com>
 <CAOQ4uxh_hfiSwMw8ABhhrz7GguZWjHEiBmvb3eq16Wfqw0+ZrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh_hfiSwMw8ABhhrz7GguZWjHEiBmvb3eq16Wfqw0+ZrQ@mail.gmail.com>
X-Headers-End: 1wacW2-0004yv-On
Subject: Re: [f2fs-dev] [PATCH v10 03/22] ovl: use core fsverity ensure info
 interface
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 djwong@kernel.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBKdW4gMTksIDIwMjYgYXQgMDk6Mjg6MzFBTSArMDIwMCwgQW1pciBHb2xkc3RlaW4g
d3JvdGU6Cj4gT24gV2VkLCBNYXkgMjAsIDIwMjYgYXQgOTowN+KAr1BNIEVyaWMgQmlnZ2VycyA8
ZWJpZ2dlcnNAa2VybmVsLm9yZz4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBNYXkgMjAsIDIwMjYg
YXQgMDI6Mzc6MDFQTSArMDIwMCwgQW5kcmV5IEFsYmVyc2h0ZXluIHdyb3RlOgo+ID4gPiBmc3Zl
cml0eSBub3cgZXhwb3NlcyBmc3Zlcml0eV9lbnN1cmVfdmVyaXR5X2luZm8oKSB3aGljaCBjb3Vs
ZCBiZSB1c2VkCj4gPiA+IGluc3RlYWQgb2Ygb3BlbmluZyBmaWxlIHRvIGVuc3VyZSB0aGF0IGZz
dmVyaXR5IGluZm8gaXMgbG9hZGVkIGFuZAo+ID4gPiBhdHRhY2hlZCB0byBpbm9kZS4KPiA+ID4K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmV5IEFsYmVyc2h0ZXluIDxhYWxiZXJzaEBrZXJuZWwu
b3JnPgo+ID4gPiBBY2tlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4K
PiA+ID4gLS0tCj4gPiA+ICBmcy9vdmVybGF5ZnMvdXRpbC5jIHwgMTQgKysrLS0tLS0tLS0tLS0K
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+
ID4KPiA+IFJldmlld2VkLWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+Cj4g
Pgo+ID4gSSdtIHN0aWxsIGNvbmZ1c2VkIGJ5IHRoZSBuZXcgaW1wbGVtZW50YXRpb24gb2YgZnN2
ZXJpdHlfYWN0aXZlKCkgdGhhdAo+ID4gZ290IGludHJvZHVjZWQgYnkgImZzdmVyaXR5OiB1c2Ug
YSBoYXNodGFibGUgdG8gZmluZCB0aGUgZnN2ZXJpdHlfaW5mbyIsCj4gPiB0aG91Z2guICBJIHNo
b3VsZCBoYXZlIGNhdWdodCB0aGlzIGR1cmluZyByZXZpZXcgb2YgdGhhdCBjb21taXQuICBGb3IK
PiA+IG9uZSBpdHMgY29tbWVudCBpcyBvdXRkYXRlZCwgYnV0IGFsc28gdGhlIG1lbW9yeSBiYXJy
aWVyIHNlZW1zIHRvIGJlCj4gPiBzcGVjaWZpYyB0byB0aGUgZnN2ZXJpdHlfZ2V0X2luZm8oKSBj
YWxsZXIgYW5kIHByb2JhYmx5IHNob3VsZCBiZSBtb3ZlZAo+ID4gdG8gdGhlcmUuICBBbnl3YXks
IHRoYXQncyBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoLgo+IAo+IEVyaWMsIEFu
ZHJleSwKPiAKPiBEaWQgeW91IHNlZSB0aGUgU2FzaGlrbyByZXZpZXcgZm9yIHRoaXMgcGF0Y2gg
YW5kIG90aGVycyBpbiB0aGlzIHNlcmllcz8KPiAKPiBodHRwczovL3Nhc2hpa28uZGV2LyMvcGF0
Y2hzZXQvMjAyNjA1MjAxMjM3MjIuNDA1NzUyLTEtYWFsYmVyc2glNDBrZXJuZWwub3JnCj4gCj4g
SXQgYW5ub3RhdGVkIHNvbWUgcmV2aWV3IGNvbW1lbnRzIGFzIGhpZ2ggYW5kIGNyaXRpY2FsLgo+
IEZvciB0aGlzIHBhdGNoIGl0IGlzIGFib3V0IGludGVyYWN0aW9uIHdpdGggZnNjcnlwdC4KPiAK
PiBQbGVhc2UgdGFrZSBhIGxvb2sgYW5kIHNheSBpZiB0aGlzIGlzIGNvbmNlcm5pbmcgb3IgZmFs
c2UgcG9zaXRpdmUuCgpZZXMsIHRoaXMgcGF0Y2ggaXMgYnJva2VuIGFuZCBzaG91bGQgYmUgZHJv
cHBlZC4gIEkgbmVlZCB0byByZW1lbWJlciB0bwpsb29rIGF0IHRoZSBTYXNoaWtvIHJldmlld3Mg
Zm9yIG90aGVyIHBlb3BsZSdzIHBhdGNoZXMgYW5kIG5vdCBqdXN0CnRydXN0IHRoYXQgdGhlIHN1
Ym1pdHRlciB3aWxsLiAgRm9ydHVuYXRlbHkgdGhpcyBvbmUgd2Fzbid0IGFwcGxpZWQgeWV0LgoK
SSBwb2ludGVkIG91dCB0aGUgSElHSE1FTSBwZXJmb3JtYW5jZSBidWcgaW4KImZzdmVyaXR5OiBn
ZW5lcmF0ZSBhbmQgc3RvcmUgemVyby1ibG9jayBoYXNoIiBlYXJsaWVyCihodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjYwNDAxMjIyNzE3LkdIMjQ2NkBxdWFyay8pLiAg
SQphc3N1bWUgaXQgd2FzIGRlY2lkZWQgdGhhdCBubyBvbmUgd2lsbCBjYXJlIGFib3V0IHRoZSBj
b21iaW5hdGlvbiBvZiBYRlMKJiYgZnN2ZXJpdHkgJiYgSElHSE1FTS4gIEJ1dCB0aGUgWEZTIGZv
bGtzIHNob3VsZCBkb3VibGUtY2hlY2sgdGhhdC4KCkFuZHJleSwgY291bGQgeW91IGNoZWNrIHRo
ZSBTYXNoaWtvIHJldmlld3MgZm9yIHRoZSBvdGhlciBwYXRjaGVzIHRvbz8KCi0gRXJpYwoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
