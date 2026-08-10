Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2529C5B56A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oilR01AtbdYR5pQD0tUQBrLc0fjvboWF0hyMaUh3ShI=; b=mZLBIuRhbsndRcWqD7ONOSLHo0
	nkmK1yI4QybIW70BlGqjva1403+corqfVxT1XdLF4i0nmPffTsrCPHRZdDLM7Yp+hj9tuqmGK0w6a
	rkdhMAn3j3D+IRTzcOl3os6sUc1+MGjhNGjSCBT+apFMvCpb2dSTc3G++SE4SMT0xfLw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtTFq-0006mk-QQ;
	Mon, 10 Aug 2026 16:53:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wtTFq-0006md-4I
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 16:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=; b=ThF1WNGi8GtKkum9GgO6dD0OU/
 0NSddhD150jTYaHZDLgxBLmRcFoVyTlSVfllUFCTW2/4odTwp0SFvkKMb9E7PMdgnh17ziikC3ZUN
 czF8bp+acN90dtvjoqHnQxKa/Y9Kvydb+4l9z03GcSWMdcWZNDnDedKJ+E6YgR7ea6k8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=; b=dfoNfKoCbFmXHSftF7NnbTZCIp
 XGOAN19V/FvktIAr0pH4XctYsXGm9rN5hlkUSlhxF8wMN1RDndFzUNV93uqGu649icyxEfS6ukJ/V
 BjdZD0ed6KsUql0uEyCIPam4cgVdu/RTCLYiCkuVrSWKKubKlS/w0NLiOIesL90yAecQ=;
Received: from mail-lj1-f179.google.com ([209.85.208.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtTFm-0006YM-7p for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 16:53:35 +0000
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-39c74722e27so1364191fa.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 09:53:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380807; cv=none;
 d=google.com; s=arc-20260327;
 b=cnmXjMEZpCnZSTQxKfkPwfN7bhescFn2QPMBw5d0LFQM1hyzQFg91okYenjGXFD8RV
 QJTKVs8ZFEA6RdB325f+lJVOMYAaWI3kusFTp4KdvZtuP7JMZJ7tyZ48Tkh5d8m60+r+
 YLWVLW8pYsv+aGztzHdBJoM54T8kI4ZZRNt6QNcBFfs2Mn+4bFDe5hJlDbGpce92+0U6
 UeQJJ7NQ2nS25ia3sMNCuHDdNkS18IHq+cF/ROXJyLXlosJljh15qkk8AjGGoopZ9qNu
 UVbj9e9xnX39OOxkox0M8deDOq8tXA/bHMIurD/9dnd0RKj/TiD7AvBoHh+HHjWPX997
 sfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
 fh=yP/upTdJzKeUu6wNNI5iXC0WDUn1SHYdNhcryGT+mc0=;
 b=hH4eUunGs7vftzKlL1N6xVbi9JcZ5XK/ZKXbYhoejfxLHlaANLdLbg4yruUXWDe5O2
 kcXtgWxfFMo+bWIOvHXzmUpDrerXx8yCFogtF3wkYH3E3Pr0S7iYe1sw0HYv2k7lndIi
 mNrXpJOY5p9GPWSa3+4yntCttl8BjO2+Ue/FDJzH8444beOTRnf0dLIyNN2Y9J9obcyx
 G64cQRxb6pIrdUFeMeKdLKgLHKpgRrnJemwFtHgaCZkNqRdo2lPZlFmKUbiWNFZxCiZg
 p71XD1839Rh5DItDKL8DQPu/gnjO8Mv127KcujZPGJxR2erJ85Tll/sVvsmSmQsyByqv
 mC2A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786380807; x=1786985607; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
 b=X8UkPLWNQ5sB/dP7lfaKtJjkvXqLgs8s5tjyvCbdwFd19h2bm1fNi1FVnxID1uuOqD
 onNvXIvr6BRuIZIjL11lUjxVNvbURocGJ7O2GqEJHzV6W7HHebihiLTdaojC6AKgQTJZ
 BU81frZRgG5vh+HZ85L4Ta4Lg0NSJNEnCZB6SOwPzV5d5cdMw6i7h+Q4isEYfP8N8zfS
 71pWQEZlLkgcK1+iEadZhsJ5lCtJYGqyXJtgZpVkJo8m5UBa9OLbM65Rv2AipYJBvIQT
 YM1AvUBR1wmhzxUQCZRVPolJ2Eh7BtmxBhJo1bBtBmpz444claaQDIUPpMJHFZvSdnjH
 onAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786380807; x=1786985607;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0bO/4kz8Aib9NVgfYR/0fvWYSJJ+gEF2SgfiBtwRXyI=;
 b=gqVyoRBFSYKjron6SHkyMGQteFAEkR1zI8w3K/i+rT6UevEk9xfnKOBS1xDrx8juaa
 j9VYcLHDG35sKZx0LQlEeEyMzTmhhlu8t14nlZSYCqTowbkGulGp4t50x+pDjIqvymav
 K9kgpGTHFyxg75Z5fk2q8D7xeC7Syc6sTw3cykpbRh32iNXpTeYzNzFDa/bOZpZncZzB
 8CJH3JI0NqWO+GAa3t5BFJTgF7g9mLpxvAHwAzkF0cdqNMWv6xW2mvbfzQVYvk79b3PI
 bNxwUMTfmKegKoL4+2csRH716zzrah9ZPY5pwBQqYBcWqJcyaMVN2BUpY+MWAV7V6Ij6
 Fu6w==
X-Forwarded-Encrypted: i=1;
 AHgh+Roh3cu4XOVZyoeNR1Wf1wcOducLSssAq6LNn+UuYUNuoL/JPMSElrmA5W6fq9ihwXS7VUpxT34jipNm8zMg0U/6@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxvhenIKowx82nUqdanDkJRqISsLd1La67EYcEIS+rf+fIMoD6d
 iECpvI+WmgoAxoBdDE+ML9LmWjT6KkC8bxvyXSZiMs2KfPXOHaAiM0nbVptizUhNaEQnPgY9Ohx
 5t2R6ChTFntFNuKRN5dkN51PSnRoaxX4=
X-Gm-Gg: AR+sD10uC3s79C4vsVjHbDjRRb8UDlfCGXjHR6j7atcdPDjzp8w8cLYtPw7Pik1UJAc
 NGJqPyJD9iII1S9xLe9p4EmrrNrucl85xc0m9IgXmkA4Q/pUcoSvr+UN9o01H2yn9Al5r+L0AF3
 Ukgd+/dLpS3QiDWAH1qzEs7A0/EjGKVnkHilC0CiFn255DkLBu6gIxnov/ZpR/Q7YH8X3qjcl3X
 pVGbbwxYMhnsnoWJFECBaCT3boaMkWFT+YaKl1LysOxPCuTtIfk7G1uT8Jvx0+tTj0IThMTnVoa
 FkpvbqZjEfXSWdr/9mSci7STNRdxs34B0Wv/fkRH/0R/qoQw9qoJBIpSiNCzuKjvy+9Ii4GjHtC
 kzcAWYGUAHlPS6Tvf1zuxNpxyN2wYKPyhwKF/KJPn9Hc5zQ==
X-Received: by 2002:a2e:a589:0:b0:39f:af21:75d7 with SMTP id
 38308e7fff4ca-39fe8316b4cmr28346751fa.2.1786380807071; Mon, 10 Aug 2026
 09:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com>
 <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
In-Reply-To: <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 10 Aug 2026 09:53:14 -0700
X-Gm-Features: AUfX_myHa-HGIxfGx31VEif489SQOdZ1JWJCG5M4SLT2WDWvbOhVQ3bd6pEJrl8
Message-ID: <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
X-Headers-End: 1wtTFm-0006YM-7p
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quiesce background threads during
 system suspend using PM notifier
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
Cc: linux-block@vger.kernel.org, Daeho Jeong <daehojeong@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, kernel-team@android.com,
 Pavel Machek <pavel@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBBdWcgMTAsIDIwMjYgYXQgOTozNOKAr0FNIEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFz
c2NoZUBhY20ub3JnPiB3cm90ZToKPgo+IE9uIDgvMTAvMjYgODo1NCBBTSwgQ2hyaXN0b3BoIEhl
bGx3aWcgd3JvdGU6Cj4gPiBPbiBUaHUsIEF1ZyAwNiwgMjAyNiBhdCAxMDowMTowOEFNIC0wNzAw
LCBEYWVobyBKZW9uZyB3cm90ZToKPiA+PiBGcm9tOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bn
b29nbGUuY29tPgo+ID4+Cj4gPj4gRHVyaW5nIHN5c3RlbSBzdXNwZW5kLCBhIHJhY2UgY29uZGl0
aW9uIGNhbiBjYXVzZSBmMmZzX2djIGFuZCBmMmZzX2Rpc2NhcmQKPiA+PiB0aHJlYWRzIHRvIGNh
bGwgc3VibWl0X2JpbygpIHdoaWxlIHRoZSB1bmRlcmx5aW5nIGJsb2NrIGRldmljZSAoZS5nLiwg
VUZTKQo+ID4+IGlzIGluIFJ1bnRpbWUgUE0gc3VzcGVuZC4gQmVjYXVzZSBSdW50aW1lIFBNIHdv
cmtlciB0aHJlYWRzIGFyZSBhbHJlYWR5Cj4gPj4gZnJvemVuIGR1cmluZyB0YXNrIGZyZWV6aW5n
LCB0aGUgdGhyZWFkcyBiZWNvbWUgdHJhcHBlZCBpbgo+ID4+IF9fYmlvX3F1ZXVlX2VudGVyKCkg
d2FpdGluZyBvbiBtcV9mcmVlemVfd3EsIGxlYWRpbmcgdG8gYSBQTSBmcmVlemVyCj4gPj4gdGlt
ZW91dC4KPiA+Cj4gPiBUaGF0IGRvZXMgc291bmQgbGlrZSBhIGdlbmVyYWwgaXNzdWUgd2l0aCBv
dXIgYmxvY2sgZGV2aWNlIC8gdGhyZWFkaW5nCj4gPiBoYW5kbGluZy4KPgo+IERhZWhvJ3MgZGVz
Y3JpcHRpb24gYWJvdmUgbWl4ZXMgdXAgdW5yZWxhdGVkIHRvcGljcy4gQSBydW50aW1lIHN1c3Bl
bmRlZAo+IFVGUyBkZXZpY2UgaXMgcmVzdW1lZCBhdXRvbWF0aWNhbGx5IGJ5IHRoZSBibG9jayBs
YXllciBpZiBuZWNlc3NhcnkuIFRoZQo+IGlzc3VlIERhZWhvIGlzIHRyeWluZyB0byBzb2x2ZSBp
cyB1bnJlbGF0ZWQgdG8gcnVudGltZSBzdXNwZW5kIGFjY29yZGluZwo+IHRvIG15IHVuZGVyc3Rh
bmRpbmcuCj4KPiA+PiBUbyBwcmV2ZW50IHRoaXMgZGVhZGxvY2ssIHJlZ2lzdGVyIGEgUE0gbm90
aWZpZXIgdG8gc2V0IFNCSV9JU19TVVNQRU5ESU5HCj4gPj4gZHVyaW5nIFBNX1NVU1BFTkRfUFJF
UEFSRS4gQmFja2dyb3VuZCBHQyBhbmQgZGlzY2FyZCB0aHJlYWRzIGNoZWNrIHRoaXMKPiA+PiBm
bGFnIGFuZCBpbW1lZGlhdGVseSBzdG9wIGlzc3VpbmcgbmV3IGJpb3MsIGFsbG93aW5nIHRoZW0g
dG8gZW50ZXIgYQo+ID4+IGZyZWV6YWJsZSBzbGVlcCBzdGF0ZSBjbGVhbmx5IGJlZm9yZSBwcm9j
ZXNzIGZyZWV6aW5nIGJlZ2lucy4KPiA+Pgo+ID4+IEluIGFkZGl0aW9uLCBjaGVjayBmcmVlemlu
ZygpIGFzIGEgZmFzdCBwYXRoIHRvIHN0b3AgaXNzdWluZyBuZXcgSS9PCj4gPj4gd2hlbiBub24t
UE0gZnJlZXppbmcgKGUuZy4gZG0tc25hcHNob3Qgb3IgY2dyb3VwIGZyZWV6ZXIpIGlzIHJlcXVl
c3RlZC4KPiA+Cj4gPiAuLiB3aGljaCBtZWFucyB0aGF0IHdlIHJlYWxseSBzb3VsZCBoYXZlIGFs
bCB0aGUgcmVsZXZhbnQgcGFydGllcwo+ID4gaW52aXRlZCBpbnRvIGZpZ3VyaW5nIG91dCB3aGFz
dCBpcyBoYXBwZW5pbmcgaGVyZSwgcmF0aGVyIHRoYW4KPiA+IGJhbmQtYWlkaW5nIHNvbWV0aGlu
ZyB0aGF0IGxvb2tzIGxpa2UgYSBob3JyaWJsZSBoYWNrIGluc2lkZSBhCj4gPiBmaWxlIHN5c3Rl
bS4KPiA+Cj4gPiBVbmZvcnR1bmF0ZWx5IEkgc2VlIHRoaXMgYSBsb3Qgd2l0aCBmMmZzLiAgUGxl
YXNlIHJlYWNoIG91dCB0byBhbGwKPiA+IHJlbGV2YW50IG1haW50YWluZXJzIGZvciBzb21ldGhp
bmcgdGhhdCBkb2VzIG5vdCBsb29rIHN0cmljdGx5IGxvY2FsCj4gPiB0byBmMmZzLgo+Cj4gVGhp
cyBpbmZvcm1hdGlvbiB3YXMgc2hhcmVkIGVhcmxpZXIgd2l0aCBEYWVobwo+IChodHRwczovL2Iu
Y29ycC5nb29nbGUuY29tL2lzc3Vlcy81MTU0NzAzMDkjY29tbWVudDQ1KTogWyAuLi4gXQo+IFJl
Z2lzdGVyIGEgRnJlZXphYmxlIEtlcm5lbCBUaHJlYWQgKFJlY29tbWVuZGVkKSBbIC4uLiBdCj4g
V2h5IHRoaXMgd29ya3M6IER1cmluZyBzdXNwZW5kLCBmcmVlemVyIHN0b3BzIGZyZWV6YWJsZSBr
ZXJuZWwgdGhyZWFkcwo+IGJlZm9yZSBkZXZpY2VzIGFuZCBibG9jayBxdWV1ZXMgZW50ZXIgdGhl
aXIgUE0gc3VzcGVuZCBwaGFzZXMuIFdoZW4gdGhlCj4gcXVldWUgZnJlZXplcyBsYXRlciwgeW91
ciB0aHJlYWQgaXMgYWxyZWFkeSBzYWZlbHkgc2xlZXBpbmcgaW4KPiB0cnlfdG9fZnJlZXplKCkg
YW5kIHdpbGwgbm90IGF0dGVtcHQgc3VibWl0X2JpbygpLiBbIC4uLiBdCgpIaSBCYXJ0LAoKVG8g
Y2xhcmlmeSBpdDoKCmYyZnMgdGhyZWFkcyBhcmUgYWxyZWFkeSBmcmVlemFibGU6IGYyZnNfZ2Mg
YW5kIGYyZnNfZGlzY2FyZCBhcmUKYWxyZWFkeSByZWdpc3RlcmVkIHdpdGggc2V0X2ZyZWV6YWJs
ZSgpIGFuZCBjYWxsIHRyeV90b19mcmVlemUoKS4KSG93ZXZlciwgYSByYWNlIHdpbmRvdyBleGlz
dHM6IGEgdGhyZWFkIGNoZWNrcyBmcmVlemluZygpIChmYWxzZSksCmNhbGxzIHN1Ym1pdF9iaW8o
KSwgYW5kIGdldHMgdHJhcHBlZCBpbnNpZGUgX19iaW9fcXVldWVfZW50ZXIoKS4KQmVjYXVzZSBp
dCBnZXRzIGJsb2NrZWQgYmVmb3JlIHJlYWNoaW5nIHRyeV90b19mcmVlemUoKSwgaXQgdHJpZ2dl
cnMgYQpQTSBmcmVlemVyIHRpbWVvdXQuCgpIaSBDaHJpc3RvcGgsCgpQb2ludCB0YWtlbi4gQXNp
ZGUgZnJvbSB0aGlzIGYyZnMgcGF0Y2gsIEkgYWdyZWUgdGhhdCBhZGRyZXNzaW5nIHRoaXMKYXQg
dGhlIGJsb2NrIGxheWVyIG9yIFBNIHN1YnN5c3RlbSBsZXZlbCB3b3VsZCBiZSBhIG11Y2ggY2xl
YW5lciwKc3lzdGVtLXdpZGUgc29sdXRpb24uCknigJlsbCBnaXZlIG1vcmUgdGhvdWdodCB0byBo
b3cgd2UgY2FuIHByb3Blcmx5IHNvbHZlIHRoaXMgcmFjZQpjb25kaXRpb24gZm9yIHRoZSBlbnRp
cmUgc3lzdGVtLCBhbmQgSSdsbCBsb29wIGluIHRoZSByZWxldmFudApQTS9ibG9jayBtYWludGFp
bmVycyBpZiBhIHZpYWJsZSBnZW5lcmljIGFwcHJvYWNoIGVtZXJnZXMuCgpUaGFuayB5b3UsCgo+
Cj4gUFM6IEknbSBubyBsb25nZXIgc3Vic2NyaWJlZCB0byB0aGUgZjJmcy1kZXZlbCBtYWlsaW5n
IGxpc3QuCj4KPiBCYXJ0LgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
