Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043A7C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s0MM2-00086v-8R;
	Fri, 26 Apr 2024 14:15:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1s0MM0-00086o-Cy
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Apr 2024 14:15:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gPlmlFgQLT0cE7r2xhzAyFZFOTgssBOxfGKG5d5+F7c=; b=Uk5wqO0fEZ7zvU9vud/B7f8KtK
 AtbeBotpUAk7YV11zbIssaRYGVFqyxBltwY10ZAasrd5Xd/cTvYl8Yvd0IKSOjp0HJpKfSWL8G7ls
 tfEyGhuRn+ndfI4BfGsV3k1AMNPCIOtmr3A/ULP1SL0CtrtlO35y8DpojcUzmX1oG/K0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gPlmlFgQLT0cE7r2xhzAyFZFOTgssBOxfGKG5d5+F7c=; b=j+cxUug2hMIYSmB8NyQwasL6Yi
 VNDeL5vPSgfdSZ2K4j0ZC0JhtT+EuPS8kRoUEmobdW2oeSWnoi8YuSw92BWvathzMS3hJv8oVum8X
 FtrnzUHmwDwv36lpsnoUPmJoZIN0cTt9qd4rhAmU4hlWNSpA9gzXKDKzzkEtSd4opdLM=;
Received: from mail-ot1-f48.google.com ([209.85.210.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1s0MLy-0003ta-U7 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Apr 2024 14:15:08 +0000
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-6ebc92079b5so1298577a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 26 Apr 2024 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714140901; x=1714745701; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPlmlFgQLT0cE7r2xhzAyFZFOTgssBOxfGKG5d5+F7c=;
 b=PR/RREYyuQkBJiDkpn+RH4LGciazrsFiRbmraZnICenlDvJxr+BO78E4IQbwkynFp5
 bMhWYWkQOcOk0Du5tty3IWV3a4/GGJzIPzqwTUP0lsYRMHva0xKhDZonGZv7s16WFSbY
 4mv2OMK+boyp6c7xA9xBICVMxtJzBKuunYXuhMNykZr7gN5tm8lrm9PqB6xkUnhp9Gcn
 4U0MIfnqc6k+gPDh/3pgZV6vCwatNC2LnsNiCucx5XSTEqV2c3yF4I5H1EcZ4uudeeHU
 9ZcDiL4SHmbiQK00b1mAilIRTaf5z6Y0ZOaS+di/gEFv1CxzX52pQ9KuWrA09ChwRGyT
 4iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140901; x=1714745701;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPlmlFgQLT0cE7r2xhzAyFZFOTgssBOxfGKG5d5+F7c=;
 b=bI6Yg0+kTECKlDCa/qHkc33ImqDMbjd9ajGo/OYVPFLS7p4Ht4MufmdlrBqsXG4YAc
 nhXFwvMTEbRH7V9O+teOmIHufOIUIooZeJs6ODael8W3M+GN+PhbKCrs6eVLDr6hHCkJ
 Z8z7nflvbUJpLHB5RRjykXT/6t0wWjNv7aOnzNiy6EVklcfhKKYTufWICGYXaXMzUlpK
 UVYkkq7ywdK5pvj0iwr+9gCW6IvDGabwZibVbPZ/WbTqv9m+rOtAJ0puCwf3StGFG5jI
 w+9OVmMk4rC0a6ZfEpTPp8cge2Hjc1r+Bb0wL2EtowvzHEAZhO0dK+82Hxgch8LYy6O4
 CUng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHP8VLm1OLUB9JQ7YCq9S3l3H6rvFdcRM04+YKvI9K9Xz+nHxxtmH2AOCCpNEX0zFCXIDpWiOyAEqwwGWqnD0OlLHkPTkCeeWuMQ/TGjRbZymZi+YJmg==
X-Gm-Message-State: AOJu0YyqGZjkSh6Xy/IiHawrOZ6NhJnyeo/fxpL2loNHgZUjEfm/XMKB
 u7N2NeK7Qt/vmQ7lzgJqHjrgHfkq0bmE6OhcRvAER/to/mZX5pqNYzEuhVRKejaFi7aB1HM2I7J
 IW/M9FqtYTI3Gf/vY3ShEgZzoOAAv9WZF
X-Google-Smtp-Source: AGHT+IEU/fzFbjm4XcHlxqFxpzS5ez+DsOKQ2iJOG0Ge0GQMeA3KxS1g4yOdaPsS0RENAoimAZNgPDWoRALfaLJXeJU=
X-Received: by 2002:a05:6358:838e:b0:186:2720:2122 with SMTP id
 c14-20020a056358838e00b0018627202122mr2879599rwk.2.1714140901218; Fri, 26 Apr
 2024 07:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240426103528.406063-1-chao@kernel.org>
In-Reply-To: <20240426103528.406063-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 26 Apr 2024 07:14:50 -0700
Message-ID: <CACOAw_xiC08JTanBSLaBED8_zveCEhoaDWeJ3YVU0h9+dNkQUg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1s0MLy-0003ta-U7
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to don't trigger OPU on
 pinfile for direct IO
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgMzozNeKAr0FNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPdGhlcndpc2UsIGl0IGJyZWFrcyBwaW5maWxlJ3Mgc2VtYXRpY3MuCj4K
PiBDYzogRGFlaG8gSmVvbmcgPGRhZWhvNDNAZ21haWwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IENo
YW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPiAtLS0KPiAgZnMvZjJmcy9kYXRhLmMgfCAzICsrLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEuYwo+IGluZGV4IGJlZTFlNDVm
NzZiOC4uZTI5MDAwZDgzZDUyIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZGF0YS5jCj4gKysrIGIv
ZnMvZjJmcy9kYXRhLmMKPiBAQCAtMTU5Niw3ICsxNTk2LDggQEAgaW50IGYyZnNfbWFwX2Jsb2Nr
cyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZjJmc19tYXBfYmxvY2tzICptYXAsIGludCBm
bGFnKQo+Cj4gICAgICAgICAvKiB1c2Ugb3V0LXBsYWNlLXVwZGF0ZSBmb3IgZGlyZWN0IElPIHVu
ZGVyIExGUyBtb2RlICovCj4gICAgICAgICBpZiAobWFwLT5tX21heV9jcmVhdGUgJiYKPiAtICAg
ICAgICAgICAoaXNfaG9sZSB8fCAoZjJmc19sZnNfbW9kZShzYmkpICYmIGZsYWcgPT0gRjJGU19H
RVRfQkxPQ0tfRElPKSkpIHsKPiArICAgICAgICAgICAoaXNfaG9sZSB8fCAoZmxhZyA9PSBGMkZT
X0dFVF9CTE9DS19ESU8gJiYgKGYyZnNfbGZzX21vZGUoc2JpKSAmJgo+ICsgICAgICAgICAgICgh
ZjJmc19zYl9oYXNfYmxrem9uZWQoc2JpKSB8fCAhZjJmc19pc19waW5uZWRfZmlsZShpbm9kZSkp
KSkpKSB7Cj4gICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShmMmZzX2NwX2Vycm9yKHNiaSkp
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZXJyID0gLUVJTzsKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIHN5bmNfb3V0Owo+IC0tCj4gMi40MC4xCgpTbywgd2UgYmxvY2sgb3Zl
cndyaXRlIGlvIGZvciB0aGUgcGluZmlsZSBoZXJlLgoKc3RhdGljIHNzaXplX3QgZjJmc19maWxl
X3dyaXRlX2l0ZXIoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKmZyb20pCgp7
Ci4uLgogICAgICAgIGlmIChmMmZzX2lzX3Bpbm5lZF9maWxlKGlub2RlKSAmJgogICAgICAgICAg
ICAhZjJmc19vdmVyd3JpdGVfaW8oaW5vZGUsIHBvcywgY291bnQpKSB7CiAgICAgICAgICAgICAg
ICByZXQgPSAtRUlPOwogICAgICAgICAgICAgICAgZ290byBvdXRfdW5sb2NrOwogICAgICAgIH0K
Cgo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
