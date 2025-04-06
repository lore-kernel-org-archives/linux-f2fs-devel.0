Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450AEC3600C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  6 Apr 2025 08:30:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u1LOq-0005BR-Bo;
	Sun, 06 Apr 2025 08:30:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1u1LOo-0005B9-Jd
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 06 Apr 2025 08:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:To:Subject:
 Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fMGhlMBUOs082JQxTRLbmoucuU/fjElncPneYDVdNFY=; b=iZVamLMhVajHuIyF33/RY+HTw1
 NiBoXNX1S28wMjSq9bKpfUsQToJfai2GThjpsCS4at7X4uCgYDg+ErYv/RKMFItf+vl20XWhO13aT
 vlGHsjLzjqQROvGa1ZD3YxC4/77XUylAT+xx12otemFlEgv15GvY/9gZxLjfQX/MmbZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fMGhlMBUOs082JQxTRLbmoucuU/fjElncPneYDVdNFY=; b=H74H7RO7naupKZ6FrCgBdGZBwi
 WuQpZMi+cS+yAUk2WQUKIXvQHtstE6Uje7F5N2LYaBZYcR3KLSX9De0zJXsdy/G+psjD1xs3kX5Di
 wOVF85Ug3vqDrDW8mdTspKgfbL30PUdTa/O+U4P9RAPg/eGQoKWX9/nTTtdbrCXrsQrk=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1u1LOZ-0000C1-N6 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 06 Apr 2025 08:30:39 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so5487958a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 06 Apr 2025 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743928217; x=1744533017; darn=lists.sourceforge.net;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMGhlMBUOs082JQxTRLbmoucuU/fjElncPneYDVdNFY=;
 b=kRK6IBElgnvv5luxhoxfXuihkc5yeRWJuuKw1etE0avMzGkEj96ujLuhgHueFWyOkh
 cXt+vT28yUe/M1wRQlgif4TXIL2/e4orYSjbwyGJ0s1MlhlWmQLrIjFl6wErIydb2o8O
 eXy+e1TIoMptX9x7b4sY5cj3RNgs29reopEyaaMk8NBGMlGK4r9rLFE2NHLovymGQfoB
 s7blEFm5MbLqWufryPoL0IbQ/BN0IVZqCwGQulsMj33DqBnNCjAIVFJ9sTOSrL8p/SMH
 4J5w9Xwe3yBRW6U/nBjotJw5Kcr0mgTlsr5lMogLZa2hKsQHpqAJcWB+M0burChlMePu
 VVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743928217; x=1744533017;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMGhlMBUOs082JQxTRLbmoucuU/fjElncPneYDVdNFY=;
 b=dxerI/W9Z13yYeXgMWAZP5ulqeAG9Sw4zT3csop2HV/ol6SWSGW3Pf+Fj2oRca8f/P
 AelwHdyXB514NdSWqazNePVraveKJtHpuwk1r36aqgWCNcNtzDjvXbyDRnwNy3UQFzE3
 RVwBlJ0TINnQxNqsZxeandrzxCu8ftqbb/+x3R0rZpxs0T+yukbvGiAryqzhyb9FTGNs
 Go4T9hN4MtyLU7pWpKGfTrzgc7GGFHKbQVfq4d+7+prDEWX9tdqLnGzN56qZCgWHVKey
 D3iJE45eUss7FueWeTl5StCIOe7cNUNOi4k0qrlFegSxcO5HDSi0Z38SRFHLowAfMvhV
 D0SA==
X-Gm-Message-State: AOJu0YwhndG8hFigulJH03z7NUv8MzAQhI0vVTGaDWEkGVxnjE1zkEJ8
 zYMuCO0tboQZOJVq0XwdSQzw/RZ8LDyD6aFamkWh4HKHI9Qwy9FJ1YXAQydmjR/YjBsIQbOXAgi
 /ps54IQ4cVAsEpGUtPy/FOZQqIY1yBQihCCI=
X-Gm-Gg: ASbGncv2MY8W8C0Zqgm5NjchMiPnE8b4D5vedUDLmH2cFPCJxqJckRQsWrYwxOTg7or
 AUYUtlfMdwXESDePhWn7qC5uSx4wHy1BmpaIYSArvV7UMV6W0oYJVFYvmIhnqizG87R4bEv3T4c
 MEp49CuQ5cJY9lyEv6e8zG3ZQ6gmI=
X-Google-Smtp-Source: AGHT+IFvbkSsqX9nFYFzOc1Oux3OrTP1R2FwU12pQgUmjksPEywxKDsNL8IpvV8e8mGFEx8kfetY3IhVtc4JEYRorIE=
X-Received: by 2002:a17:906:c155:b0:ac7:b480:e38a with SMTP id
 a640c23a62f3a-ac7d16bcf97mr799717866b.2.1743928216389; Sun, 06 Apr 2025
 01:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <88f281ff9ff9b1fb899c92d6b32f52b7@airmail.cc>
In-Reply-To: <88f281ff9ff9b1fb899c92d6b32f52b7@airmail.cc>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Sun, 6 Apr 2025 01:30:05 -0700
X-Gm-Features: ATxdqUGk52CkA-MuegbMHUBObIBDd1R20n4jcTn15f7AiIcjYOm3WmFqKLzM2nk
Message-ID: <CAD14+f1CYZ-OyKg36b_=VPmbBK0LSiieq1pgtXUy4OV2+KrR_g@mail.gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, uplinkr@airmail.cc
X-Headers-End: 1u1LOZ-0000C1-N6
Subject: Re: [f2fs-dev] Resize metadata corruption
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGkgYWxsLAoKSSBhbHNvIGVuY291bnRlcmVkIHNvbWV0aGluZyBzaW1pbGFyIGEgd2hpbGUgYmFj
ayB3aXRoIHJlc2l6aW5nIGJ1dApkaWRuJ3QgcmVwb3J0IGl0IGFuZCBqdXN0IG1hbnVhbGx5IG1p
Z3JhdGVkIHRoZSBmaWxlcy4KSSBhc3Npc3RlZCBoaW0gdG8gZW5zdXJlIHVzaW5nIHRoZSBsYXRl
c3Qga2VybmVsL2YyZnMtdG9vbHMsIGJ1dCBoaXMKbWV0YWRhdGEgc2VlbXMgcHJldHR5IGJhZCBy
aWdodCBub3cgYW5kIEkgc3VnZ2VzdGVkIGhpbSB0byBhc2sgdGhlCm1haWxpbmcgbGlzdCBkaXJl
Y3RseS4KClRoZSBVUkwgdGhlcmUgc2hvdWxkIGJlIGh0dHBzOi8vYXJ0ZXI5Ny5jb20vLmYyZnMt
MjAyNTA0MDYvZnNjay5sb2cgLAphIGxpdHRsZSB0eXBvIHRoZXJlLgoKQ2FuIHdlIGhhdmUgc29t
ZSBzb3J0IG9mIENJL2F1dG9tYXRlZCB0ZXN0aW5nIGZvciB0aGUgcmVzaXppbmcgYXMgd2VsbD8K
ClRoYW5rcy4KCk9uIFN1biwgQXByIDYsIDIwMjUgYXQgMToyNuKAr0FNIHVwbGlua3ItLS0gdmlh
IExpbnV4LWYyZnMtZGV2ZWwKPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
PiB3cm90ZToKPgo+IEhlbGxvIGV2ZXJ5b25lLAo+Cj4gSSBhbSBoYXZpbmcgdHJvdWJsZSB3aXRo
IEYyRlMuIFNwZWNpZmljYWxseSwgSSBiZWxpZXZlIG1ldGFkYXRhIGdvdAo+IGNvcnJ1cHRlZCB3
aGVuIEkgcmVzaXplZCBpdC4gSSBoYXZlIGEgNTEyIEdCIGRyaXZlLiBNeSBGMkZTIHBhcnRpdGlv
bgo+IHdhcyBhcHByb3hpbWF0ZWx5IGxvY2F0ZWQgb24gMzY5LTQ5NyBHQiAoMTI4IEdCIHNpemUp
LiBVc2luZyBHUGFydGVkLCBJCj4gcmVzaXplZCBpdCB0byAwLjUtNDk3IEdCLiBXaGlsZSB0aGUg
cGFydGl0aW9uIHJlc2l6aW5nIHdlbnQgdGhyb3VnaAo+IHN1Y2Nlc3NmdWxseSwgZmlsZXN5c3Rl
bSByZXNpemluZyBpbml0aWFsbHkgZmFpbGVkIHdpdGggIk1vdW50IHVuY2xlYW4KPiBpbWFnZSB0
byByZXBsYXkgbG9nIi4gSSBoYXZlIGRvbmUgdGhhdCBhbmQgcmV0cmllZCByZXNpemluZy4KPgo+
IEFmdGVyd2FyZHMsIGhvd2V2ZXIsIGZzY2sgc3RhcnRlZCBnaXZpbmcgb3V0IGEgbG90IG9mIGVy
cm9ycywgYXQgb25lCj4gcG9pbnQgaXQgYXNrZWQgaWYgSSB3aXNoZWQgdG8gcmVzdG9yZSBsb3N0
IGRhdGEsIHdoaWNoIEkgYWdyZWVkIHRvLiBMb2dzCj4gc3BlY2lmaWVkIGEgbG90IG9mIG15IGZp
bGVzICh3aGljaCBJIGNvdWxkIHRlbGwgYnkgZmlsZW5hbWVzKSBhbmQKPiBtaWQtd2F5IHRocm91
Z2ggdGhlIHByb2Nlc3MsIGl0IHNlZ2ZhdWx0ZWQuIE5vdywgd2hlbiBJIHJ1biBmc2NrLCBubwo+
IGZpbGVzIGFyZSBhc2tlZCB0byBiZSByZXN0b3JlZCwgYW5kIGl0IGNvbXBsZXRlcyBzdWNjZXNz
ZnVsbHkuIEhvd2V2ZXIsCj4gd2hlbiBJIGF0dGVtcHQgdG8gbW91bnQgaXQsIEkgZ2V0IGFuIGVy
cm9yIHNheWluZyAiU3RydWN0dXJlIG5lZWRzCj4gY2xlYW5pbmciLgo+Cj4gQ291bGQgc29tZW9u
ZSBoZWxwIG1lIHJlc3RvcmUgbXkgbWV0YWRhdGEgKGF0IGxlYXN0LCBsb25nIGVub3VnaCB0bwo+
IGV4dHJhY3QgbXkgZmlsZXMpPyBUaGFua3MuCj4KPiBkbWVzZyBsb2dzOgo+Cj4gWyAgIDk2LjE4
NDEyN10gRjJGUy1mcyAobnZtZTBuMXA1KTogTWlzbWF0Y2ggdmFsaWQgYmxvY2tzIDc2OSB2cy4g
NjgKPiBbICAgOTYuMTg4MDUwXSBGMkZTLWZzIChudm1lMG4xcDUpOiBGYWlsZWQgdG8gaW5pdGlh
bGl6ZSBGMkZTIHNlZ21lbnQKPiBtYW5hZ2VyICgtMTE3KQo+Cj4gZnNjay5mMmZzIC0tZHJ5LXJ1
biAtZCAzIGxvZ3M6IGh0dHBzOi8vYXJ0ZXIuY29tLy5mMmZzLTIwMjUwNDA2L2ZzY2subG9nCj4K
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
