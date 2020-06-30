Return-Path: <SRS0=3N/Z=AL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76488C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2020 20:44:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458AF206B6;
	Tue, 30 Jun 2020 20:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="i3ec0iJj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iZBGEqtZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cYNHBB3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458AF206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jqN7T-0002lO-75; Tue, 30 Jun 2020 20:44:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <rdunlap@infradead.org>) id 1jqN7Q-0002lB-Gt
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jun 2020 20:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kcuGVu3dWRulN2Ruib0VL7Gzj1OWqUiXn1HW3UNZi4c=; b=i3ec0iJjPszK/ZUiTp33AKlS4C
 JJgdCXjOiceckvIQsvlZuUy2gx7FxF8BKJnEKk2z9bevI2TB2G3aFlIdjXrPTptL7sToRZwbz+oWa
 m7Np0vCcQhKzrciJpcd8UoUyjAi9dZSTibQyeotoGmfvCl8yNrqYRuy3GewleUThyiM4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kcuGVu3dWRulN2Ruib0VL7Gzj1OWqUiXn1HW3UNZi4c=; b=iZBGEqtZbavrMtthWMhY9yQTo4
 XuPwNXgNwA/VzikhEV7GLRPy0iya10rGGhWOba51/66RF6mXE9Vnr0dRfmtC9mDZaXIncT1nhCkak
 Y4Pvy5j8gN9aIM6Nr43qkm7Z2TGPPME9gSIjEXMT3TYS0ZggP8qh8AKz0w6BvY0P9XuU=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jqN7L-006STB-Js
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 30 Jun 2020 20:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=kcuGVu3dWRulN2Ruib0VL7Gzj1OWqUiXn1HW3UNZi4c=; b=cYNHBB3ynDSnCOv1FdIYqJwIWR
 tBIXxNso2zMMvJsTi35L1OJlnixO2sqtzENpgeU131wNq+Apt0kKFx6BdUvasGIS29digHv51BzS9
 rACTN4hCtS2yyLyH0+Y6aU7zipOXLrhKm7bDDFnGeBtXoW6tCIR0+NAHm+GguJywAFcPCVCE2IccQ
 33EnFl1A0qxgL9IP02N15Vn5nvKh2RpF5R4t3c7e8iGI94BCC0i8KBFsDoMY41xb1eWomtshX71E6
 Kdu4BavDQj1LNiWdxcOVbKpadALrGiaqEqlhcseSoqgdefp5Rm0pkXmubxhoqLIRyX4dcphr6EKsz
 ya3enmPg==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqN7C-0006QA-8w; Tue, 30 Jun 2020 20:44:26 +0000
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <020937f3-2947-ca41-c18a-026782216711@infradead.org>
 <20200630202357.GA1396584@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1be18397-7fc6-703e-121b-e210e101357f@infradead.org>
Date: Tue, 30 Jun 2020 13:44:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630202357.GA1396584@google.com>
Content-Language: en-US
X-Headers-End: 1jqN7L-006STB-Js
Subject: Re: [f2fs-dev] [PATCH] f2fs: always expose label 'next_page'
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
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gNi8zMC8yMCAxOjIzIFBNLCBKYWVnZXVrIEtpbSB3cm90ZToKPiBPbiAwNi8zMCwgUmFuZHkg
RHVubGFwIHdyb3RlOgo+PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9y
Zz4KPj4KPj4gRml4IGJ1aWxkIGVycm9yIHdoZW4gRjJGU19GU19DT01QUkVTU0lPTiBpcyBub3Qg
c2V0L2VuYWJsZWQuCj4+IFRoaXMgbGFiZWwgaXMgbmVlZGVkIGluIGVpdGhlciBjYXNlLgo+Pgo+
PiAuLi9mcy9mMmZzL2RhdGEuYzogSW4gZnVuY3Rpb24g4oCYZjJmc19tcGFnZV9yZWFkcGFnZXPi
gJk6Cj4+IC4uL2ZzL2YyZnMvZGF0YS5jOjIzMjc6NTogZXJyb3I6IGxhYmVsIOKAmG5leHRfcGFn
ZeKAmSB1c2VkIGJ1dCBub3QgZGVmaW5lZAo+PiAgICAgIGdvdG8gbmV4dF9wYWdlOwo+IAo+IFRo
YW5rIHlvdSBmb3IgdGhlIGZpeC4gVGhpcyB3YXMgYWN0dWFsbHkgaW50cm9kdWNlZCBieSB0aGUg
cmVjZW50IHRlc3RpbmcgcGF0Y2guCj4gCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvamFlZ2V1ay9mMmZzLmdpdC9jb21taXQvP2g9ZGV2JmlkPWZmOTYz
YWQyYmY1NDQ2MDQzMWY1MTdiNWNhZTQ3Mzk5N2EyOWJmMmEKPiAKPiBJZiB5b3UgZG9uJ3QgbWlu
ZCwgcGxlYXNlIGxldCBtZSBpbnRlZ3JhdGUgdGhpcyBpbnRvIHRoZSBvcmlnaW5hbCBwYXRjaC4K
PiBMZXQgbWUga25vdy4KClN1cmUsIG5vIHByb2JsZW0uCgo+IFRoYW5rcywKPiAKPj4KPj4gU2ln
bmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4+IENjOiBK
YWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgo+PiBDYzogQ2hhbyBZdSA8eXVjaGFvMEBo
dWF3ZWkuY29tPgo+PiBDYzogbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
Pj4gLS0tCj4+ICBmcy9mMmZzL2RhdGEuYyB8ICAgIDIgLS0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAy
IGRlbGV0aW9ucygtKQo+Pgo+PiAtLS0gbGludXgtbmV4dC0yMDIwMDYzMC5vcmlnL2ZzL2YyZnMv
ZGF0YS5jCj4+ICsrKyBsaW51eC1uZXh0LTIwMjAwNjMwL2ZzL2YyZnMvZGF0YS5jCj4+IEBAIC0y
MzY2LDkgKzIzNjYsNyBAQCBzZXRfZXJyb3JfcGFnZToKPj4gIAkJCXplcm9fdXNlcl9zZWdtZW50
KHBhZ2UsIDAsIFBBR0VfU0laRSk7Cj4+ICAJCQl1bmxvY2tfcGFnZShwYWdlKTsKPj4gIAkJfQo+
PiAtI2lmZGVmIENPTkZJR19GMkZTX0ZTX0NPTVBSRVNTSU9OCj4+ICBuZXh0X3BhZ2U6Cj4+IC0j
ZW5kaWYKPj4gIAkJaWYgKHJhYykKPj4gIAkJCXB1dF9wYWdlKHBhZ2UpOwo+PiAgCgoKLS0gCn5S
YW5keQpSZXBvcnRlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+CgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJm
cy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5u
ZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJm
cy1kZXZlbAo=
