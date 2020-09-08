Return-Path: <SRS0=MrPr=CR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA08C433E2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2020 00:53:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049AD215A4;
	Tue,  8 Sep 2020 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ELX5RsnJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="diEoBh03";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDmuuQNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049AD215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kFRsg-00076U-J9; Tue, 08 Sep 2020 00:53:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kFRse-00076L-Nl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Sep 2020 00:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MJlVNrCNstUtdda6ypB07ourucFYcryptfV6RWsuRBk=; b=ELX5RsnJbNCHh4ip8BCtWfpEzd
 FBKMeBsbSKrD51Yb4FfdCajnGiCWj8hCu5H03H/AuOm9xn4cHGnxvg1/YT9fdj38sSuM4IKVy+4A3
 6scxIv663CtanJAI7g80R4C4NKt+lMC353z3dazHkGeHpvytUvk3IZl2zuuiZpz5FwC0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MJlVNrCNstUtdda6ypB07ourucFYcryptfV6RWsuRBk=; b=diEoBh03tbxPsCBRIKj/h3irmN
 xOmZz7BNqrlXgW9dJwFGXF8lNuc7m4oNrIvIOt0tqDaLBRzToE/F5FYJjWY7l/fMa5+lByxKBxYGV
 /InFwYeGVA1THrW8W47MDGo3Gf3Q5SYBLqWJJqltjX6rL9iAFhvGtM/3iLbWFJxb8LhQ=;
Received: from mail-lj1-f195.google.com ([209.85.208.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kFRsZ-00G6Un-Rt
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Sep 2020 00:53:04 +0000
Received: by mail-lj1-f195.google.com with SMTP id u4so16977349ljd.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2020 17:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MJlVNrCNstUtdda6ypB07ourucFYcryptfV6RWsuRBk=;
 b=SDmuuQNyPQ1Z77YHu/WNMd6NyUJiEr1vIsJBMUm+YIKG9II5MH7ufnp3hiSi3u1xGQ
 LPNo7+tCYKA45rmtIdO//wsPYUDynL++tfDwq3U7H3ecnHBW2Ia129y+vB/npP4hI44p
 i/iN+SsrlXjct+RQIqAYBsvEaOMf87/RmbrFA4JKsRYK+1E+B2EoqrkeM09dzr4gCCZJ
 BRf+/R/FPx4SjNFqmDiRjoIDWLj83VDZ2zTsKu9Dm6bZhfCg+sA9Qo1sVbA2zvVCokvx
 XUGsnLhQbWPilkUHFURtUHYntMjSNy2NouwP4p8HbWHrAi7AneVuZIcTW49+gTQm4dtb
 2s3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MJlVNrCNstUtdda6ypB07ourucFYcryptfV6RWsuRBk=;
 b=uZlY1H9Ea8x6YvKp8d7Oy88m+nnU6UvNoIEWM4uFg3gHaVebRwtFDtSN6/vC4KHt/f
 nfMukZ093MrstrqR8OfpO7FicaYaMMW1N499Mo1ummNBQ9mSNwzKUmmvu8mwsmDODxJU
 O9tsnV7zl2YXQx7DT6IoQ19QPhdGeLceSjhU7aEcubhpG8gm19YVJPq2xqrXedsjYfLz
 H/kyVFj8ihv2BxVE61DBeliHa9+Av87Kb+yWxjcUfH1JZ+liokOmvwpMxYDLjc9Vw7Oc
 AQBazF1Xy0Ej4f/KBs3IyvT+SCBGw6cbmc3oZVJ7Hzj2r/+xqVWkPIDX6KcNj3oWM3kC
 wgxQ==
X-Gm-Message-State: AOAM5320r+x/V5te97ZaQq8kMaVGnW59mfyH7+wDT+6hPjuO1hNdYb4u
 cnRlv2v84cHjOY3poYF3OY2RBIUfIs8jTKMoA7A=
X-Google-Smtp-Source: ABdhPJzaRXXOsXXHUA9+ruwzwH2Rg6Yhvnw4F/voRY10PMGzbfBRgUcm9gqEA+V98XDKjBisaeT5XjTdZLhE05QFDi0=
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr5318377ljn.335.1599526373128; 
 Mon, 07 Sep 2020 17:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200903024442.296703-1-daeho43@gmail.com>
 <4c5dcf19-4495-5181-1695-fddf05c3bf24@huawei.com>
 <CACOAw_xAjUEyVo0Jm4yPvg7KB4G=Mz=tSEQ_wz6OH-P+e_cP8Q@mail.gmail.com>
In-Reply-To: <CACOAw_xAjUEyVo0Jm4yPvg7KB4G=Mz=tSEQ_wz6OH-P+e_cP8Q@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 8 Sep 2020 09:52:42 +0900
Message-ID: <CACOAw_yXkCkZrDELqereZcyJpXHAmWOwS2Q2HiNGs3_63sYfQA@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1kFRsZ-00G6Un-Rt
Subject: Re: [f2fs-dev] [PATCH v2] f2fs_io: change fibmap to fiemap
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SSd2ZSB0aG91Z2h0IGFib3V0IHRoaXMuCldlIG5lZWQgdG8gc3VwcG9ydCB0aGlzIHRvb2wgZm9y
IGRpZmZlcmVudCBPUywgbm90IG9ubHkgZm9yIExpbnV4LgpTbywgaXMgaXQgb2sgdG8gaW5jbHVk
ZSBsaW51eC9maWVtYXAuaCBmb3IgdGhpcz8KQWN0dWFsbHksIHNpbmNlIEZJRU1BUCBhbmQgb3Ro
ZXIgc3R1ZmYgd2VyZSBkZWZpbmVkIGluIGYyZnNfaW8uYwpkaXJlY3RseSBiZWZvcmUsIEkgdGhv
dWdodCB0aGF0IHRoZXJlIHdhcyBzb21lIHJlYXNvbiBmb3IgZG9pbmcgdGhhdAphbmQgSSBmb2xs
b3dlZCB0aGUgY29udmVudGlvbi4KCldoYXQgZG8geW91IHRoaW5rPwoKMjAyMOuFhCA57JuUIDTs
nbwgKOq4iCkg7Jik7ZuEIDEyOjM5LCBEYWVobyBKZW9uZyA8ZGFlaG80M0BnbWFpbC5jb20+64uY
7J20IOyekeyEsToKPgo+IEl0J3Mgd2F5IGJldHRlcn4gOikKPgo+IDIwMjDrhYQgOeyblCA07J28
ICjquIgpIOyYpO2bhCAxMjoxMSwgQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPuuLmOydtCDs
npHshLE6Cj4+Cj4+Cj4+Cj4+IE9uIDIwMjAvOS8zIDEwOjQ0LCBEYWVobyBKZW9uZyB3cm90ZToK
Pj4gPiBGcm9tOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+PiA+Cj4+ID4g
Q3VycmVudGx5IHdlIHN1cHBvcnQgZmllbWFwIGNvbW1hbmQgdXNpbmcgZmlibWFwLiBJdCdzIHNp
bXBsZSBhbmQKPj4gPiBlYXN5IHRvIHVzZSwgYnV0IHdlIGNhbm5vdCB1c2UgdGhpcyBmb3IgY29t
cHJlc3NlZCBmaWxlLiBUbyBzdXBwb3J0Cj4+ID4gbW9yZSBkaWZmZXJlbnQgdHlwZXMgb2YgZmls
ZXMsIHdlIG5lZWQgdG8gY2hhbmdlIHRoaXMgdG8gdXNlIGZpZW1hcC4KPj4gPgo+PiA+IFNpZ25l
ZC1vZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4+ID4gLS0tCj4+
ID4gQ2hhbmdlcyBpbiB2MjoKPj4gPiAgIC0gTW92ZSBkZWNsYXJhdGlvbiB0byBoZWFkZXIgZmls
ZQo+PiA+IC0tLQo+PiA+ICAgdG9vbHMvZjJmc19pby9mMmZzX2lvLmMgfCAzNyArKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ID4gICB0b29scy9mMmZzX2lvL2YyZnNfaW8u
aCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4+ID4gICAyIGZpbGVzIGNoYW5nZWQs
IDQzIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQo+PiA+Cj4+ID4gZGlmZiAtLWdpdCBh
L3Rvb2xzL2YyZnNfaW8vZjJmc19pby5jIGIvdG9vbHMvZjJmc19pby9mMmZzX2lvLmMKPj4gPiBp
bmRleCBhYmI2NTVhLi45YTY1MWMwIDEwMDY0NAo+PiA+IC0tLSBhL3Rvb2xzL2YyZnNfaW8vZjJm
c19pby5jCj4+ID4gKysrIGIvdG9vbHMvZjJmc19pby9mMmZzX2lvLmMKPj4gPiBAQCAtNjMxLDI3
ICs2MzEsMTcgQEAgc3RhdGljIHZvaWQgZG9fcmFuZHJlYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2
LCBjb25zdCBzdHJ1Y3QgY21kX2Rlc2MgKmNtZCkKPj4gPiAgICAgICBleGl0KDApOwo+PiA+ICAg
fQo+PiA+Cj4+ID4gLXN0cnVjdCBmaWxlX2V4dCB7Cj4+ID4gLSAgICAgX191MzIgZl9wb3M7Cj4+
ID4gLSAgICAgX191MzIgc3RhcnRfYmxrOwo+PiA+IC0gICAgIF9fdTMyIGVuZF9ibGs7Cj4+ID4g
LSAgICAgX191MzIgYmxrX2NvdW50Owo+PiA+IC19Owo+PiA+IC0KPj4gPiAtI2lmbmRlZiBGSUJN
QVAKPj4gPiAtI2RlZmluZSBGSUJNQVAgICAgICAgICAgX0lPKDB4MDAsIDEpICAgIC8qIGJtYXAg
YWNjZXNzICovCj4+ID4gLSNlbmRpZgo+PiA+IC0KPj4gPiAgICNkZWZpbmUgZmllbWFwX2Rlc2Mg
ImdldCBibG9jayBhZGRyZXNzIGluIGZpbGUiCj4+ID4gICAjZGVmaW5lIGZpZW1hcF9oZWxwICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+PiA+ICAgImYyZnNfaW8gZmllbWFwIFtv
ZmZzZXQgaW4gNGtiXSBbY291bnRdIFtmaWxlX3BhdGhdXG5cbiJcCj4+ID4KPj4gPiAgIHN0YXRp
YyB2b2lkIGRvX2ZpZW1hcChpbnQgYXJnYywgY2hhciAqKmFyZ3YsIGNvbnN0IHN0cnVjdCBjbWRf
ZGVzYyAqY21kKQo+PiA+ICAgewo+PiA+IC0gICAgIHU2NCBvZmZzZXQ7Cj4+ID4gLSAgICAgdTMy
IGJsa251bTsKPj4gPiAgICAgICB1bnNpZ25lZCBjb3VudCwgaTsKPj4gPiAgICAgICBpbnQgZmQ7
Cj4+ID4gKyAgICAgX191NjQgcGh5X2FkZHI7Cj4+ID4gKyAgICAgc3RydWN0IGZpZW1hcCAqZm0g
PSB4bWFsbG9jKHNpemVvZihzdHJ1Y3QgZmllbWFwKSArCj4+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHNpemVvZihzdHJ1Y3QgZmllbWFwX2V4dGVudCkpOwo+PiA+Cj4+ID4gICAgICAgaWYgKGFy
Z2MgIT0gNCkgewo+PiA+ICAgICAgICAgICAgICAgZnB1dHMoIkV4Y2VzcyBhcmd1bWVudHNcblxu
Iiwgc3RkZXJyKTsKPj4gPiBAQCAtNjU5LDIxICs2NDksMjggQEAgc3RhdGljIHZvaWQgZG9fZmll
bWFwKGludCBhcmdjLCBjaGFyICoqYXJndiwgY29uc3Qgc3RydWN0IGNtZF9kZXNjICpjbWQpCj4+
ID4gICAgICAgICAgICAgICBleGl0KDEpOwo+PiA+ICAgICAgIH0KPj4gPgo+PiA+IC0gICAgIG9m
ZnNldCA9IGF0b2koYXJndlsxXSk7Cj4+ID4gKyAgICAgZm0tPmZtX3N0YXJ0ID0gYXRvaShhcmd2
WzFdKSAqIEYyRlNfQkxLU0laRTsKPj4gPiArICAgICBmbS0+Zm1fbGVuZ3RoID0gRjJGU19CTEtT
SVpFOwo+PiA+ICsgICAgIGZtLT5mbV9leHRlbnRfY291bnQgPSAxOwo+PiA+ICAgICAgIGNvdW50
ID0gYXRvaShhcmd2WzJdKTsKPj4gPgo+PiA+ICAgICAgIGZkID0geG9wZW4oYXJndlszXSwgT19S
RE9OTFkgfCBPX0xBUkdFRklMRSwgMCk7Cj4+ID4KPj4gPiAtICAgICBwcmludGYoIkZpZW1hcDog
b2Zmc2V0ID0gJTA4IlBSSXg2NCIgbGVuID0gJWRcbiIsIG9mZnNldCwgY291bnQpOwo+PiA+ICsg
ICAgIHByaW50ZigiRmllbWFwOiBvZmZzZXQgPSAlMDgiUFJJeDY0IiBsZW4gPSAlZFxuIiwKPj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZtLT5mbV9zdGFydCAvIEYy
RlNfQkxLU0laRSwgY291bnQpOwo+PiA+ICAgICAgIGZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsr
KSB7Cj4+ID4gLSAgICAgICAgICAgICBibGtudW0gPSBvZmZzZXQgKyBpOwo+PiA+IC0KPj4gPiAt
ICAgICAgICAgICAgIGlmIChpb2N0bChmZCwgRklCTUFQLCAmYmxrbnVtKSA8IDApCj4+ID4gLSAg
ICAgICAgICAgICAgICAgICAgIGRpZV9lcnJubygiRklCTUFQIGZhaWxlZCIpOwo+PiA+ICsgICAg
ICAgICAgICAgaWYgKGlvY3RsKGZkLCBGSUVNQVAsIGZtKSA8IDApCj4+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIGRpZV9lcnJubygiRklFTUFQIGZhaWxlZCIpOwo+PiA+Cj4+ID4gLSAgICAgICAg
ICAgICBwcmludGYoIiV1ICIsIGJsa251bSk7Cj4+ID4gKyAgICAgICAgICAgICBwaHlfYWRkciA9
IGZtLT5mbV9leHRlbnRbMF0uZmVfcGh5c2ljYWwgLyBGMkZTX0JMS1NJWkU7Cj4+ID4gKyAgICAg
ICAgICAgICBpZiAocGh5X2FkZHIgPT0gTkVXX0FERFIpCj4+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHByaW50ZigiTkVXX0FERFIgIik7Cj4+ID4gKyAgICAgICAgICAgICBlbHNlCj4+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIHByaW50ZigiJWxsdSAiLCBwaHlfYWRkcik7Cj4+ID4gKyAgICAg
ICAgICAgICBmbS0+Zm1fc3RhcnQgKz0gRjJGU19CTEtTSVpFOwo+PiA+ICAgICAgIH0KPj4gPiAg
ICAgICBwcmludGYoIlxuIik7Cj4+ID4gKyAgICAgZnJlZShmbSk7Cj4+ID4gICAgICAgZXhpdCgw
KTsKPj4gPiAgIH0KPj4gPgo+PiA+IGRpZmYgLS1naXQgYS90b29scy9mMmZzX2lvL2YyZnNfaW8u
aCBiL3Rvb2xzL2YyZnNfaW8vZjJmc19pby5oCj4+ID4gaW5kZXggYmQxOWZmOS4uNjJkNmU3YiAx
MDA2NDQKPj4gPiAtLS0gYS90b29scy9mMmZzX2lvL2YyZnNfaW8uaAo+PiA+ICsrKyBiL3Rvb2xz
L2YyZnNfaW8vZjJmc19pby5oCj4+ID4gQEAgLTM4LDYgKzM4LDkgQEAgdHlwZWRlZiB1MTYgX19i
ZTE2Owo+PiA+ICAgdHlwZWRlZiB1MzIgX19iZTMyOwo+PiA+ICAgI2VuZGlmCj4+ID4KPj4gPiAr
I2RlZmluZSBGMkZTX0JMS1NJWkUgNDA5Ngo+PiA+ICsjZGVmaW5lIE5FV19BRERSICAgICAweEZG
RkZGRkZGCj4+ID4gKwo+PiA+ICAgI2lmbmRlZiBGU19JT0NfR0VURkxBR1MKPj4gPiAgICNkZWZp
bmUgRlNfSU9DX0dFVEZMQUdTICAgICAgICAgICAgICAgICAgICAgX0lPUignZicsIDEsIGxvbmcp
Cj4+ID4gICAjZW5kaWYKPj4gPiBAQCAtMTMyLDYgKzEzNSwyOSBAQCB0eXBlZGVmIHUzMiAgICAg
IF9fYmUzMjsKPj4gPiAgICNkZWZpbmUgRlNfQ0FTRUZPTERfRkwgICAgICAgICAgICAgICAgICAg
ICAgMHg0MDAwMDAwMCAvKiBGb2xkZXIgaXMgY2FzZSBpbnNlbnNpdGl2ZSAqLwo+PiA+ICAgI2Vu
ZGlmCj4+ID4KPj4gPiArc3RydWN0IGZpZW1hcF9leHRlbnQgewo+PiA+ICsgICAgIHU2NCBmZV9s
b2dpY2FsOwo+PiA+ICsgICAgIHU2NCBmZV9waHlzaWNhbDsKPj4gPiArICAgICB1NjQgZmVfbGVu
Z3RoOwo+PiA+ICsgICAgIHU2NCBmZV9yZXNlcnZlZDY0WzJdOwo+PiA+ICsgICAgIHUzMiBmZV9m
bGFnczsKPj4gPiArICAgICB1MzIgZmVfcmVzZXJ2ZWRbM107Cj4+ID4gK307Cj4+ID4gKwo+PiA+
ICtzdHJ1Y3QgZmllbWFwIHsKPj4gPiArICAgICB1NjQgZm1fc3RhcnQ7Cj4+ID4gKyAgICAgdTY0
IGZtX2xlbmd0aDsKPj4gPiArICAgICB1MzIgZm1fZmxhZ3M7Cj4+ID4gKyAgICAgdTMyIGZtX21h
cHBlZF9leHRlbnRzOwo+PiA+ICsgICAgIHUzMiBmbV9leHRlbnRfY291bnQ7Cj4+ID4gKyAgICAg
dTMyIGZtX3Jlc2VydmVkOwo+PiA+ICsgICAgIHN0cnVjdCBmaWVtYXBfZXh0ZW50IGZtX2V4dGVu
dFswXTsKPj4gPiArfTsKPj4KPj4gV2UgZG9uJ3QgbmVlZCB0byBjb3B5ICYgcGFzdGUgZmllbWFw
IHJlbGF0ZWQgc3RydWN0dXJlIGhlcmUuCj4+Cj4+IExldCdzIGp1c3QgaW5jbHVkZSA8bGludXgv
ZmllbWFwLmg+IGluIGYyZnNfaW8uaAo+Pgo+PiBUaGFua3MsCj4+Cj4+ID4gKwo+PiA+ICsjaWZu
ZGVmIEZJRU1BUAo+PiA+ICsjZGVmaW5lIEZJRU1BUCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBfSU9XUignZicsIDExLCBzdHJ1Y3QgZmllbWFwKQo+PiA+ICsjZW5kaWYKPj4gPiArCj4+
ID4gICBzdHJ1Y3QgZjJmc19nY19yYW5nZSB7Cj4+ID4gICAgICAgdTMyIHN5bmM7Cj4+ID4gICAg
ICAgdTY0IHN0YXJ0Owo+PiA+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZl
bEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
