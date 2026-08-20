Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9559CC5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3mrwluNJ6vDziuu3jAxZ2Gx+G7kiGRZc2jeOI13H6Hs=; b=MQbYOMDfCofdUOy9Q/Qn+5YQL9
	zl987e8/gkqdS3cDMiRM0/186GhISoVMfbN3bo8LZY/1UPlbGhVoXThnC65G1BvCbIJL75H4LeeE4
	IrZui+T8aNe2D8rZHjkLF2TJ5vAKgUhYIxB/9ZRw/mje8ZOcuanTdDskO8CaoDCWoN0Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx5PS-0007h2-1J;
	Thu, 20 Aug 2026 16:14:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wx5PQ-0007gu-4M
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 16:14:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bpQsmenmTRWPToVNJTi8+gMZWCPSKZWF7zxrrfcYX2Y=; b=dm94P3VWGY5Y848Vng88kWhf9q
 rIgcppvgahk8wxtvAkW471AuXhsvehPWVCXeNPPxiS++gk5btKSDBEkHh5PeL7O2rmADJ/sdQF9yc
 4TrVMry1fZp3aUbOyDQM0doLFjDfFFsa1pv3t83WtiRd4/m7qfyVQEmB+tTpbYSXqjOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bpQsmenmTRWPToVNJTi8+gMZWCPSKZWF7zxrrfcYX2Y=; b=PoU3sbRrPz+/TKY48scOH1f56E
 KQmeg/QZvKdx5jah9tBXXVg0O0YfV4sDWG2SOkvfi/muetxUy5kE/gGgVAD90gwe8UMVj/keuHjmA
 rDbC8bCnMbaABc/Y2CTOXmrv74tMgVq4JkgFsdynVygPeO7/Zk/g6/EtJhxbHX5NtqpI=;
Received: from mail-lj1-f171.google.com ([209.85.208.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx5PP-00017n-CK for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 16:14:28 +0000
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39c9a3acd40so678161fa.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 09:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787242461; cv=none;
 d=google.com; s=arc-20260327;
 b=cCW3UxlLQcbEPS7r4JpDc90HyMXH0b8ZVNY/+tpJj68Dnv0cf/VNyZgaF3L8stISRn
 NgutcHK3fp0A/0tpAn5viFlTLdBIwvjazSbDcdPMZRIbisLEP/AVT1vaoursT3bBRuRO
 5R76CuGN6JtkKabq1i8x1wGpLaU9QrBtgoJeoFso7FnohO1UYIRmZpsPQuRHTRRWuEhp
 dqW64YGarXjENzSJZnM4wRXnbNQkTU6eopxZ7ke7Utfc3beZmItH3sj6vSnWPmvjjoji
 qLh6rUDQLFZWLXtzZcnkAfmmgjwjiUB7JEG7DCqfj0V72NdoLI9nyPZqUlmcPZGU1Q9U
 0zqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bpQsmenmTRWPToVNJTi8+gMZWCPSKZWF7zxrrfcYX2Y=;
 fh=gOUkOPVNRvH3hKxYFirwKY2VdXiNYoSWxTMz7MkuS3s=;
 b=Q7xgOFFh5Obt1PBLgv1MPvqpshmRfnDisphx6mKg40ay78lrswWqU9kfdAX3uEKGWQ
 RAzIVvCTJBRziZhdoktajmLSpHpQLl7v8TwWHGm9mEa1YjyM2ekt8EdTb0o2EuGM3NAu
 NDGzihMz+/J07P+kH3D8n2luBDQzTH1HtetfP01/HgWg8zrhbltBTT0neu1T+AqMPy4W
 amS6Eg3V3Efe6XPJR/VgCDQm91ULoZe6/HhzUfiMhHZNFt+O0Ml/4ag/8oq9yJ50krbk
 8oeyZhDozHDUbkB7I4M/NNAZtWNGCDlYetIIQPZxqyMkXxF88GBb6qSPix86mwCp63kk
 L8bQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787242461; x=1787847261; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bpQsmenmTRWPToVNJTi8+gMZWCPSKZWF7zxrrfcYX2Y=;
 b=h8c9cIEYPrzvzvZIh9ssbNVT+M3aRy+HJtFHy+g8EbKNy7xAQXErd/mYwS83Qc+yrL
 cSlJSqFjmXkC4sUVIcXrCHWOYaPqhriTYPbEnQKhafmlwTxz2OechhdqtT9F9Ax2J2AK
 hYMEEIC3LHQdR1HWZ4QsXg3k8CknwHWQmFzHRXzKSq+fwVb+o3MU3q1y7e9zYqrxgm1G
 8rU7WTY9pn6kHs0SjK6iBqQzFNvLdSJBsa2i0lFuYcVlQtUaPXBNIfcO8dLIZLGft90g
 PWLlpp+0weDGHnn0piX5QWqwiwJt9Mtc7R+P6vkZFjWQroLqVeOM4kb3ZEG1y1/Mr3S6
 C3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787242461; x=1787847261;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bpQsmenmTRWPToVNJTi8+gMZWCPSKZWF7zxrrfcYX2Y=;
 b=hyMBRcFm44robQmFRbTznRFFYP8ZQnW9+zuQtTXMBaJux9xPV3Scai7Atk4F2AmMBC
 nmvA9pnpaA0jWKSZBpLDtGTrkvPuRU/rqEzQQFoMxfjHcNvnEHcqPfGXBDic0hz8v9iZ
 qjR2KLyitv7SZxPW363wej5DFyVtGTaLtn0B2YXGcoEZWjXcR9wOaZ3yyskPHfhR23d4
 8iRK5Hi8rkCN1yW2qV+bpdj+GaN7B8fJewXeEHe1U8AAzPGLWR4/LSH05jqO7ux9gwTD
 zw7824XI6mIrq+n83qAjji7EsXFFlLzLumrQPFC9IicxIxNuKJV8/3F6LJZhJaKsDc9C
 FeAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMa32VbGUVA18OnmKQq3c4yVHW59QgsClBTzPFOYkoGXpQCkYW4GTwQM+Yd7Oxj5CnDRYwNS6GWJojZAvuzzqq@lists.sourceforge.net
X-Gm-Message-State: AFuF++nFKvWI788EGRuBECfQyrdQPEEQMvCu40wcRyLw59sbnqni+/OK
 NcSx8aoHwyrTRozn2luYLpeynr1i8VTd6gIg98xqTb+u1zv77/UO1l9YQGOE6gjw0lbuNM/3RNC
 MBUs0aeqtpJPSWtbV6HP8amAciGLMJFo=
X-Gm-Gg: AR+sD12kHDiMWP39+/MewJyh/lqN6hZqySyLYrs/PET9cUJk3IrjZttYOfpwX5WMMYs
 UW+QyiMUFgS6LZcadUB6f5+sYmLI9tYBcdpY47Ud+2YFHA5PnF5zE4BjA9yZmCaF6EGsHtfvCTa
 MiQyd1h4ZSiHoyCiFC4NMbWDJbzgTb5PdUKUfYDX6H6/Bn9bxapGprsNaVuslVHyI9tJcPJx55D
 i7I6Pz009lcGKvIpc1KvS46M7XEyQNXqyAvrN6neoiz1mdobbi0CPQ2iOOjiCHBkIuR3tJ5hb86
 rURIlyk2e5QS1yXCv+E70zZM2RR91aupo2gKj4UC8mdkOJVjwSq8AZL4Y17/6g/pjw/DPkGBhQW
 tAHcwDAaOHOgCsymVue90jK5RvKvmDTk=
X-Received: by 2002:a05:651c:511:b0:39c:6d3a:2dd9 with SMTP id
 38308e7fff4ca-3a1899ffdebmr31560931fa.12.1787242460311; Thu, 20 Aug 2026
 09:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260818170535.3190869-1-daeho43@gmail.com>
 <6b55a4e9-e4a0-421c-9bb6-98ffc2c915c9@kernel.org>
 <CACOAw_xSS78P_c8ZWXGDadxa+xFAVWWN0kAx1QMrujVuruBYsQ@mail.gmail.com>
 <746c8f52-cf7c-4f63-b2e1-36e0cad940a1@kernel.org>
 <CABdZyexzNgVLcdSFRkt=AZnkgW5Q40m3Hf8JFk63WuTGhQ0S7w@mail.gmail.com>
In-Reply-To: <CABdZyexzNgVLcdSFRkt=AZnkgW5Q40m3Hf8JFk63WuTGhQ0S7w@mail.gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 20 Aug 2026 09:14:07 -0700
X-Gm-Features: AcwNN1XexO0FhugLEKL_TB2J_vP51zl3KqGa9_4oaGAwHEFajnutUHw50D6bRdM
Message-ID: <CACOAw_wq3UDos43X49hcufaKRaGsMYcQmYujuy1x256+L2a--w@mail.gmail.com>
To: Daeho Jeong <daehojeong@google.com>
X-Headers-End: 1wx5PP-00017n-CK
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid setting SBI_NEED_FSCK on
 transient resize failure with -EAGAIN
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBBdWcgMjAsIDIwMjYgYXQgODo0N+KAr0FNIERhZWhvIEplb25nIDxkYWVob2plb25n
QGdvb2dsZS5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIFRodSwgQXVnIDIwLCAyMDI2IGF0IDEyOjIw
4oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPiB3cm90ZToKPj4KPj4gT24gOC8yMC8yNiAw
MjoyMSwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4+ID4gT24gVHVlLCBBdWcgMTgsIDIwMjYgYXQgNzoz
NOKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4gd3JvdGU6Cj4+ID4+Cj4+ID4+IE9uIDgv
MTkvMjYgMDE6MDUsIERhZWhvIEplb25nIHdyb3RlOgo+PiA+Pj4gRnJvbTogRGFlaG8gSmVvbmcg
PGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPj4gPj4+Cj4+ID4+PiBXaGVuIGYyZnNfcmVzaXplX2Zz
KCkgZmFpbHMgZHVlIHRvIHRyYW5zaWVudCBsb2NrIGNvbnRlbnRpb24gb3IgcmV0cnlhYmxlCj4+
ID4+PiBHQyBmYWlsdXJlIGluIGZyZWVfc2VnbWVudF9yYW5nZSgpIHJldHVybmluZyAtRUFHQUlO
LCBubyBmaWxlc3lzdGVtCj4+ID4+PiBtZXRhZGF0YSBoYXMgYmVlbiBtb2RpZmllZCBvbi1kaXNr
IHlldC4gVGhlIGZpbGVzeXN0ZW0gcmVtYWlucyBjb21wbGV0ZWx5Cj4+ID4+PiBjb25zaXN0ZW50
IGFuZCBjbGVhbi4KPj4gPj4KPj4gPj4gQW55IHdheSB0byBtYWtlIHN1cmUgRUFHQUlOIGlzIGZy
b20gZnJlZV9zZWdtZW50X3JhbmdlKCksIGluIGNhc2Ugd2UgcmV0dXJuCj4+ID4+IEVBR0FJTiBm
cm9tIDEpIGFueSBvdGhlciBwbGFjZXMgdGhhdCB3ZSBtYXkgbWlzcyB0byBjaGVjayBub3cgb3Ig
Mikgd2UgY2hhbmdlZAo+PiA+PiB0aGUgY29kZSB0byByZXR1cm4gRUFHQUlOIGluIGZ1dHVyZS4K
Pj4gPgo+PiA+IE1ha2VzIHNlbnNlLgo+PiA+Cj4+ID4gSW4gZmFjdCwgaWYgZnJlZV9zZWdtZW50
X3JhbmdlKCkgZmFpbHMgd2l0aCBBTlkgZXJyb3IgKGUuZy4sIC1FQUdBSU4sCj4+ID4gLUVOT01F
TSwgLUVSRVNUQVJUU1lTLCBldGMuKSwgbm8gb24tZGlzayBzdXBlcmJsb2NrIG9yIGZpbGVzeXN0
ZW0gbWV0YWRhdGEKPj4gPiBoYXMgYmVlbiBtb2RpZmllZCB5ZXQsIGFuZCBmcmVlX3NlZ21lbnRf
cmFuZ2UoKSBzYWZlbHkgcmVzdG9yZXMgYWxsIGluLW1lbW9yeQo+PiA+IGNvdW50ZXJzIChNQUlO
X1NFQ1MsIGZyZWVfc2VjdGlvbnMpIGJlZm9yZSByZXR1cm5pbmcuIFRoZXJlZm9yZSwgc2V0dGlu
Zwo+PiA+IFNCSV9ORUVEX0ZTQ0sgaXMgbm90IG5lZWRlZCBmb3IgYWxsIGVycm9ycyBvY2N1cnJp
bmcgaW4gZnJlZV9zZWdtZW50X3JhbmdlKCkuCj4+Cj4+IFllYWgsIGJldHRlci4KPj4KPj4gPgo+
PiA+IFRvIG1ha2UgdGhpcyBleHBsaWNpdCBhbmQgZGVmZW5zaXZlIGFnYWluc3QgYW55IGZ1dHVy
ZSBjaGFuZ2VzLCB3ZSBjYW4KPj4gPiBzZXBhcmF0ZSB0aGUgZXJyb3IgcmVjb3ZlcnkgcGF0aCB3
aXRoIGRlZGljYXRlZCBsYWJlbHMgYXMgZm9sbG93czoKPj4gPgo+PiA+ICAgZXJyID0gZnJlZV9z
ZWdtZW50X3JhbmdlKHNiaSwgc2VjcywgZmFsc2UpOwo+PiA+ICAgaWYgKGVycikKPj4gPiAtIGdv
dG8gcmVjb3Zlcl9vdXQ7Cj4+ID4gKyBnb3RvIHJlY292ZXJfdXNlcl9ibG9ja3M7Cj4+ID4KPj4g
PiAgIHVwZGF0ZV9zYl9tZXRhZGF0YShzYmksIC1zZWNzKTsKPj4gPgo+PiA+IC4uLgo+PiA+Cj4+
ID4gIHJlY292ZXJfb3V0Ogo+PiA+ICsgc2V0X3NiaV9mbGFnKHNiaSwgU0JJX05FRURfRlNDSyk7
Cj4+ID4gKyBmMmZzX2VycihzYmksICJyZXNpemVfZnMgZmFpbGVkLCBzaG91bGQgcnVuIGZzY2sg
dG8gcmVwYWlyISIpOwo+PiA+ICtyZWNvdmVyX3VzZXJfYmxvY2tzOgo+Pgo+PiBIb3cgYWJvdXQg
dGhpcz8KPj4KPj4gcmVjb3Zlcl9vdXQ6Cj4+ICAgICAgICAgaWYgKGVycikgewo+PiAgICAgICAg
ICAgICAgICAgZjJmc19idWdfb24oc2JpLCBlcnIgPT0gLUVBR0FJTik7Cj4+ICAgICAgICAgICAg
ICAgICBzZXRfc2JpX2ZsYWcoc2JpLCBTQklfTkVFRF9GU0NLKTsKPj4gICAgICAgICAgICAgICAg
IGYyZnNfZXJyKHNiaSwgInJlc2l6ZV9mcyBmYWlsZWQsIHNob3VsZCBydW4gZnNjayB0byByZXBh
aXIhIik7Cj4+ICAgICAgICAgfQo+Pgo+PiByZWNvdmVyX3VzZXJfYmxvY2tzOgo+Pgo+PiBUaGFu
a3MsCj4+Cj4+ID4gICBjbGVhcl9zYmlfZmxhZyhzYmksIFNCSV9JU19SRVNJWkVGUyk7Cj4+ID4g
ICBpZiAoZXJyKSB7Cj4+ID4gLSBzZXRfc2JpX2ZsYWcoc2JpLCBTQklfTkVFRF9GU0NLKTsKPj4g
PiAtIGYyZnNfZXJyKHNiaSwgInJlc2l6ZV9mcyBmYWlsZWQsIHNob3VsZCBydW4gZnNjayB0byBy
ZXBhaXIhIik7Cj4+ID4gLQo+PiA+ICAgc3Bpbl9sb2NrKCZzYmktPnN0YXRfbG9jayk7Cj4+ID4g
ICBzYmktPnVzZXJfYmxvY2tfY291bnQgKz0gc2hydW5rX2Jsb2NrczsKPj4gPiAgIHNwaW5fdW5s
b2NrKCZzYmktPnN0YXRfbG9jayk7Cj4+ID4KPj4gPiBUaGFua3MsCj4+ID4KPj4gPj4KPj4gPj4g
VGhhbmtzLAo+PiA+Pgo+PiA+Pj4KPj4gPj4+IEhvd2V2ZXIsIHRoZSBjdXJyZW50IGVycm9yIHJl
Y292ZXJ5IHBhdGggdW5jb25kaXRpb25hbGx5IHNldHMgdGhlCj4+ID4+PiBTQklfTkVFRF9GU0NL
IGZsYWcgb24gYW55IGVycm9yLCBmb3JjaW5nIGFuIHVubmVjZXNzYXJ5IGFuZCB0aW1lLWNvbnN1
bWluZwo+PiA+Pj4gZnNjay5mMmZzIHJlcGFpciBvbiB0aGUgc3Vic2VxdWVudCBtb3VudC9yZWJv
b3QuCj4+ID4+Pgo+PiA+Pj4gRml4IHRoaXMgYnkgZ3VhcmRpbmcgc2V0X3NiaV9mbGFnKHNiaSwg
U0JJX05FRURfRlNDSykgd2l0aAo+PiA+Pj4gYGlmIChlcnIgIT0gLUVBR0FJTilgLCBhdm9pZGlu
ZyBmYWxzZS1wb3NpdGl2ZSBmaWxlc3lzdGVtIGNvcnJ1cHRpb24KPj4gPj4+IGZsYWdzIG9uIHRy
YW5zaWVudCByZXNpemUgcmV0cmllcy4KPj4gPj4+Cj4+ID4+PiBTaWduZWQtb2ZmLWJ5OiBEYWVo
byBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+PiA+Pj4gU2lnbmVkLW9mZi1ieTogU3Vu
bWluIEplb25nIDxzX21pbi5qZW9uZ0BzYW1zdW5nLmNvbT4KPj4gPj4+IC0tLQo+PiA+Pj4gIGZz
L2YyZnMvZ2MuYyB8IDYgKysrKy0tCj4+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPj4gPj4+Cj4+ID4+PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9n
Yy5jIGIvZnMvZjJmcy9nYy5jCj4+ID4+PiBpbmRleCAxOTJiMTZhYzAyZjguLjc4NzEzM2VlMmVi
MiAxMDA2NDQKPj4gPj4+IC0tLSBhL2ZzL2YyZnMvZ2MuYwo+PiA+Pj4gKysrIGIvZnMvZjJmcy9n
Yy5jCj4+ID4+PiBAQCAtMjQ0Niw4ICsyNDQ2LDEwIEBAIGludCBmMmZzX3Jlc2l6ZV9mcyhzdHJ1
Y3QgZmlsZSAqZmlscCwgX191NjQgYmxvY2tfY291bnQpCj4+ID4+PiAgcmVjb3Zlcl9vdXQ6Cj4+
ID4+PiAgICAgICBjbGVhcl9zYmlfZmxhZyhzYmksIFNCSV9JU19SRVNJWkVGUyk7Cj4+ID4+PiAg
ICAgICBpZiAoZXJyKSB7Cj4+ID4+PiAtICAgICAgICAgICAgIHNldF9zYmlfZmxhZyhzYmksIFNC
SV9ORUVEX0ZTQ0spOwo+PiA+Pj4gLSAgICAgICAgICAgICBmMmZzX2VycihzYmksICJyZXNpemVf
ZnMgZmFpbGVkLCBzaG91bGQgcnVuIGZzY2sgdG8gcmVwYWlyISIpOwo+PiA+Pj4gKyAgICAgICAg
ICAgICBpZiAoZXJyICE9IC1FQUdBSU4pIHsKPj4gPj4+ICsgICAgICAgICAgICAgICAgICAgICBz
ZXRfc2JpX2ZsYWcoc2JpLCBTQklfTkVFRF9GU0NLKTsKPj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICBmMmZzX2VycihzYmksICJyZXNpemVfZnMgZmFpbGVkLCBzaG91bGQgcnVuIGZzY2sgdG8g
cmVwYWlyISIpOwo+PiA+Pj4gKyAgICAgICAgICAgICB9CgoKR290IGl0LiBUaGFua3N+CgoKPj4K
Pj4gPj4+Cj4+ID4+PiAgICAgICAgICAgICAgIHNwaW5fbG9jaygmc2JpLT5zdGF0X2xvY2spOwo+
PiA+Pj4gICAgICAgICAgICAgICBzYmktPnVzZXJfYmxvY2tfY291bnQgKz0gc2hydW5rX2Jsb2Nr
czsKPj4gPj4KPj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
