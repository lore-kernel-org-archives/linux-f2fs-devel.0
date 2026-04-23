Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E27FDEE50
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Apr 2026 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0SOj5q9VsdTvuwXAqDp75rS5uWt2hdirjQvxPE2vbuU=; b=X7tI9jcKETao5R9KiuemT6ixV+
	V5XcgHIza6Z4dxuDMLHEoGbB84TtV2r9hhtHZdSp2L5X+CIS+MbGxw9MoupHfSZWbY8uoOgfbYYCr
	NtZm/ggTTvm0Hk9FGn15ITR4waw6nICSbsxym4GLB4g2sSXlwzPJl/6/Oo4WhJUJD0QY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wG1Ci-00009F-05;
	Thu, 23 Apr 2026 21:03:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <smfrench@gmail.com>) id 1wG1Cg-00008z-Md
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 21:03:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=; b=R6y9HYXb2R8KXWI1GpZsBP+dR/
 F+OSfdva+6MPWi3RYLQnOz9CetLPFuPtDJQZ3R1v9o4+HbKGQ18ibeItYrgtHjq/1/kZmNVLmwPse
 7y+BqunnjXhOCOiweOxXli/bJXq9RlHo1r8Sm+F+L8AGiCZXjQ81MyI1xw7OOsrTVZqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=; b=DSCxA8PPa/yQroAdZjwpcZnv50
 ez3m5Mu+Jc6OJihsRSnXcmbZGNZ0nmiNRxjw+yV2zhqDgqCxRpWqUonTWSV+Lp/+jYnXl6rPYFb4m
 FR+QIPpOVfmkkkxmoYAf/EIw3o8o01NmG6VRSnDD/keO9/geERqwt7DWX4bMsLfScY1Q=;
Received: from mail-qv1-f53.google.com ([209.85.219.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wG1Ch-0003YU-0q for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Apr 2026 21:03:19 +0000
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8a4b8c3a30bso80923736d6.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 23 Apr 2026 14:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776978188; cv=none;
 d=google.com; s=arc-20240605;
 b=Jqyg8x18CoDQH45iOb4kDBHRVpnVAWcYgBAhFo1zCZvxW/N1YCbtK2kre8mHKV9A62
 gNqwH+38QNinymEUhGemC6uvi2DcD5difVLsqYk36l+8wnpWjrB9rbTBrZVBxM7KrWAt
 cYzn0XqY0hdcrxbaUGxUqSw8FrU01b2G0hBp0vOWSHtY4RdY9cJLnTE9ZH97z0en22+G
 ViKXXBS5nXua/YTAg91cjjWAedEc7AtG09gsAxvsDFDKbKYdynJme+hmUCtoI7ZhgFl2
 6wRwgfhGle7aYojeRb+/par+1aF3MXRquw3y0kIIpiQZuaTrSatwHKFbqxAp3GKWoIJ9
 DBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
 fh=N191yA9ng914SPgw21gyQx2V4zZrrmXol2SSqJvGJNY=;
 b=j05U2aW3pGoCjTP7ek+GOM7QSmWtOv7RKyjBGZ8gk12dW9XbjGeaoc2Px3yEM2+HFv
 8CEu8o3yQgQbFS/TY8i2jfchnI6Nr/ESDTuCq2idw5iZAUWHjqsCbRwLms0h3m/bKKpU
 IMyv/oc6PBtQ/AaaXj7b89D+gnqXC4iubAuggfJe/ScLobSSex5e7PB3tqbpfrQZJjpO
 +1HKzoLtWrAiIPEAjT0W30SA7UGmumOb1yl73+83KTgu43x55AjMCzYhUqQ3vgESsv0G
 H1h5Qw052zuE0KVXO1vs3nD74nxXoFJtd8V6z3r8VuCz1o4JgklXVsgh91y5uGLfDvJI
 JDzA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776978188; x=1777582988; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
 b=h/JoIaGLYjiNkOvCOE4QJu9eXmofccqZvcPIi6ORKtaogw29FUPm3MQRxMYrdi3QG1
 EFHfz3oWo+XLCGD7/5ry+a7MVb/sN4tB3Xrj80evvhKXa8cC6CUVM40lMfv/mzb94EWG
 JNbRgtmAJhRv+x6Eihisc3XRCYSpnMy76T8uDkPLdsdQpt6Qk0b4EGb811eiP4FeKT1z
 UP0mwpjMd/OBaNPOvGukRnc3yDg7Tk/E/wL18lc0c/XC/1+fOrLQvuj1yQMcayPxGpzv
 mtqGNMFs3lKO05CU6rUhaVH3IvnvwJv9wGSlFlMMIvTesHTA1Q+D5th9anGLjKqLx2FJ
 GKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776978188; x=1777582988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
 b=sqglrXxsFfBiVSP6MH8Ocr5JeuGTK6OdTVbEjcLuw19xTXWwNrs8ojC7ZvdKt22+QT
 n6GEGLiRTo0T3ZR08SGRVEZgEQSG5gzKME79WZvldRkohjCSTLwTVnbeEOEB01lpcliN
 di9EawvdRuvg03KgszOo37C2WxKhYyK9pRKLS0apGxP8vbkFvxXo9izYdsHEDizJ0mQ5
 tX7sZZZo8vcO3yzS6x9/eBwm9BUtPoQ96LknCOd9F7NHOAA5Yw9tpBe8BLkHiFOZrcZu
 v259qafGFKNSzo8zxgUWaM6h9jj3yN871M6rNotJyc/bEDNgUuQ4yqpAflt/qJL1DJaG
 75oA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Y6Hr4PoWjO3fUXhA9YARXxdztu972gWjTkpwd9nPHiRb+ASqTK1Y7lU9hXUGHy1TcMQZb8XKm06XNF3soEMwk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxuAp8c+K3Xdlg0qlQewgm7AjnO/jCpbst+KljcueXqCymK1KuO
 3EvQJsiO/RDQMzI0zE+YDH9xatS+2/JxjEOmFK/cmKN+xXZMpjUXje54ggnmUV240TMBWfsxbot
 tbXHfQHNG9/F+R8KLgq7zGNm6ENEWRmE=
X-Gm-Gg: AeBDieuq3TS2zoefnED9+S+sOuCGfwSKO3J5m8d+rdVmE75m8KVUoK7z21vS5kBVNUF
 MyDKqo5v6ldtZP61mAw20c7nEBzmi6loJ/RZCmqY1FjrWKfCi7dPDAcxurwoZeZ2EwHyGhqSNsj
 JSgnD7jKzx8aykcBtcaTq0SytKwbGKZco7/5SpWxYc/NUlqY0UO+elcHq0qcvDnNuQMsjvHQvL2
 sNft7n6WaOrcwmD8eqGYWWId+tN4dc2yXuD21Zn04Xe0yqd+dOgX416W/ktEz4X/JBwmp5UgJ9v
 EL8dw1S1Pv7R3x5mgOah1huCNP6x0sovgzRa83UfPzvSgk6E0sDWF14H1Kc/8qwttb20PH6AVp8
 qP1Ddh82jVZyGI8YJ5HUdPeIuBAP9+cgp584WcyLOt/j7gA8RyhJRlEDYDaknjsR576QwYn1LT8
 0FwFBa7IVGxzsIyvIezeVHmh5pBjrpZPY=
X-Received: by 2002:ad4:5d65:0:b0:8ae:6282:df2e with SMTP id
 6a1803df08f44-8b02822456emr461252066d6.44.1776978187970; Thu, 23 Apr 2026
 14:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
 <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 23 Apr 2026 16:02:56 -0500
X-Gm-Features: AQROBzDF43-id-Qgk6rRbL0HPyUPTg1w8GYo4-J0uBb2d6IfD5ElWAtE-TtbFxA
Message-ID: <CAH2r5mu1Wg_9tZCjei-xF357UjKR+h6jQr9zey39v59rx9quZQ@mail.gmail.com>
To: Chuck Lever <cel@kernel.org>
X-Headers-End: 1wG1Ch-0003YU-0q
Subject: Re: [f2fs-dev] [PATCH v10 10/17] cifs: Implement fileattr_get for
 case sensitivity
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
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 Steve French <stfrench@microsoft.com>, sprasad@microsoft.com,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

U2hvdWxkIHRoaXMgYWxzbyBiZSBjaGVja2luZyBpZiB0aGUgU01CMy4xLjEgTGludXggRXh0ZW5z
aW9ucyBvciBTTUIKUE9TSVggRXh0ZW5zaW9ucyBhcmUgbmVnb3RpYXRlZCAoaWUgdGhlIHNlcnZl
ciBzdXBwb3J0cyBjYXNlCnNlbnNpdGl2aXR5KT8KCk9uIFRodSwgQXByIDIzLCAyMDI2IGF0IDg6
MjDigK9BTSBDaHVjayBMZXZlciA8Y2VsQGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gRnJvbTogQ2h1
Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+Cj4KPiBVcHBlciBsYXllcnMgc3VjaCBh
cyBORlNEIG5lZWQgYSB3YXkgdG8gcXVlcnkgd2hldGhlciBhIGZpbGVzeXN0ZW0KPiBoYW5kbGVz
IGZpbGVuYW1lcyBpbiBhIGNhc2Utc2Vuc2l0aXZlIG1hbm5lci4gUmVwb3J0IENJRlMvU01CIGNh
c2UKPiBoYW5kbGluZyBiZWhhdmlvciB2aWEgdGhlIEZTX1hGTEFHX0NBU0VGT0xEIGZsYWcuCj4K
PiBDSUZTIHNlcnZlcnMgKHR5cGljYWxseSBXaW5kb3dzIG9yIFNhbWJhKSBhcmUgdXN1YWxseSBj
YXNlLWluc2Vuc2l0aXZlCj4gYnV0IGNhc2UtcHJlc2VydmluZywgbWVhbmluZyB0aGV5IGlnbm9y
ZSBjYXNlIGR1cmluZyBsb29rdXBzIGJ1dCBzdG9yZQo+IGZpbGVuYW1lcyBleGFjdGx5IGFzIHBy
b3ZpZGVkLgo+Cj4gVGhlIGltcGxlbWVudGF0aW9uIHJlcG9ydHMgY2FzZSBzZW5zaXRpdml0eSBi
YXNlZCBvbiB0aGUgbm9jYXNlIG1vdW50Cj4gb3B0aW9uLCB3aGljaCByZWZsZWN0cyB3aGV0aGVy
IHRoZSBjbGllbnQgZXhwZWN0cyB0aGUgc2VydmVyIHRvIHBlcmZvcm0KPiBjYXNlLWluc2Vuc2l0
aXZlIGNvbXBhcmlzb25zLiBXaGVuIG5vY2FzZSBpcyBzZXQsIHRoZSBtb3VudCBpcyByZXBvcnRl
ZAo+IGFzIGNhc2UtaW5zZW5zaXRpdmUuCj4KPiBUaGUgY2FsbGJhY2sgaXMgcmVnaXN0ZXJlZCBp
biBhbGwgdGhyZWUgaW5vZGVfb3BlcmF0aW9ucyBzdHJ1Y3R1cmVzCj4gKGRpcmVjdG9yeSwgZmls
ZSwgYW5kIHN5bWxpbmspIHRvIGVuc3VyZSBjb25zaXN0ZW50IHJlcG9ydGluZyBhY3Jvc3MKPiBh
bGwgaW5vZGUgdHlwZXMuCj4KPiBBY2tlZC1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNy
b3NvZnQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFj
bGUuY29tPgo+IC0tLQo+ICBmcy9zbWIvY2xpZW50L2NpZnNmcy5jIHwgMjAgKysrKysrKysrKysr
KysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS9mcy9zbWIvY2xpZW50L2NpZnNmcy5jIGIvZnMvc21iL2NsaWVudC9jaWZzZnMuYwo+IGlu
ZGV4IDIwMjU3MzlmMDcwYS4uOWI3MGZmYTNlMDFkIDEwMDY0NAo+IC0tLSBhL2ZzL3NtYi9jbGll
bnQvY2lmc2ZzLmMKPiArKysgYi9mcy9zbWIvY2xpZW50L2NpZnNmcy5jCj4gQEAgLTMwLDYgKzMw
LDcgQEAKPiAgI2luY2x1ZGUgPGxpbnV4L3hhdHRyLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9tbS5o
Pgo+ICAjaW5jbHVkZSA8bGludXgva2V5LXR5cGUuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2ZpbGVh
dHRyLmg+Cj4gICNpbmNsdWRlIDx1YXBpL2xpbnV4L21hZ2ljLmg+Cj4gICNpbmNsdWRlIDxuZXQv
aXB2Ni5oPgo+ICAjaW5jbHVkZSAiY2lmc2ZzLmgiCj4gQEAgLTExOTksNiArMTIwMCwyMiBAQCBz
dHJ1Y3QgZmlsZV9zeXN0ZW1fdHlwZSBzbWIzX2ZzX3R5cGUgPSB7Cj4gIE1PRFVMRV9BTElBU19G
Uygic21iMyIpOwo+ICBNT0RVTEVfQUxJQVMoInNtYjMiKTsKPgo+ICtzdGF0aWMgaW50IGNpZnNf
ZmlsZWF0dHJfZ2V0KHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGZpbGVfa2F0dHIgKmZh
KQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiID0gQ0lGU19TQihk
ZW50cnktPmRfc2IpOwo+ICsgICAgICAgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiA9IGNpZnNfc2Jf
bWFzdGVyX3Rjb24oY2lmc19zYik7Cj4gKwo+ICsgICAgICAgLyoKPiArICAgICAgICAqIFRoZSBu
b2Nhc2UgbW91bnQgb3B0aW9uIGluc3RhbGxzIGNhc2UtaW5zZW5zaXRpdmUgZGVudHJ5Cj4gKyAg
ICAgICAgKiBvcGVyYXRpb25zIG9uIHRoaXMgc3VwZXJibG9jay4gU01CIHByZXNlcnZlcyBjYXNl
IG9uIHRoZQo+ICsgICAgICAgICogd2lyZSBhbmQgYXQgcmVzdCwgc28gdGhlIG1vdW50IG1hdGNo
ZXMgRlNfWEZMQUdfQ0FTRUZPTEQKPiArICAgICAgICAqIHNlbWFudGljczogY2FzZS1mb2xkZWQg
bG9va3VwLCB2ZXJiYXRpbSBzdG9yYWdlLgo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAodGNv
bi0+bm9jYXNlKQo+ICsgICAgICAgICAgICAgICBmYS0+ZnN4X3hmbGFncyB8PSBGU19YRkxBR19D
QVNFRk9MRDsKPiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICBjb25zdCBzdHJ1Y3QgaW5v
ZGVfb3BlcmF0aW9ucyBjaWZzX2Rpcl9pbm9kZV9vcHMgPSB7Cj4gICAgICAgICAuY3JlYXRlID0g
Y2lmc19jcmVhdGUsCj4gICAgICAgICAuYXRvbWljX29wZW4gPSBjaWZzX2F0b21pY19vcGVuLAo+
IEBAIC0xMjE3LDYgKzEyMzQsNyBAQCBjb25zdCBzdHJ1Y3QgaW5vZGVfb3BlcmF0aW9ucyBjaWZz
X2Rpcl9pbm9kZV9vcHMgPSB7Cj4gICAgICAgICAubGlzdHhhdHRyID0gY2lmc19saXN0eGF0dHIs
Cj4gICAgICAgICAuZ2V0X2FjbCA9IGNpZnNfZ2V0X2FjbCwKPiAgICAgICAgIC5zZXRfYWNsID0g
Y2lmc19zZXRfYWNsLAo+ICsgICAgICAgLmZpbGVhdHRyX2dldCA9IGNpZnNfZmlsZWF0dHJfZ2V0
LAo+ICB9Owo+Cj4gIGNvbnN0IHN0cnVjdCBpbm9kZV9vcGVyYXRpb25zIGNpZnNfZmlsZV9pbm9k
ZV9vcHMgPSB7Cj4gQEAgLTEyMjcsNiArMTI0NSw3IEBAIGNvbnN0IHN0cnVjdCBpbm9kZV9vcGVy
YXRpb25zIGNpZnNfZmlsZV9pbm9kZV9vcHMgPSB7Cj4gICAgICAgICAuZmllbWFwID0gY2lmc19m
aWVtYXAsCj4gICAgICAgICAuZ2V0X2FjbCA9IGNpZnNfZ2V0X2FjbCwKPiAgICAgICAgIC5zZXRf
YWNsID0gY2lmc19zZXRfYWNsLAo+ICsgICAgICAgLmZpbGVhdHRyX2dldCA9IGNpZnNfZmlsZWF0
dHJfZ2V0LAo+ICB9Owo+Cj4gIGNvbnN0IGNoYXIgKmNpZnNfZ2V0X2xpbmsoc3RydWN0IGRlbnRy
eSAqZGVudHJ5LCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAo+IEBAIC0xMjYxLDYgKzEyODAsNyBAQCBj
b25zdCBzdHJ1Y3QgaW5vZGVfb3BlcmF0aW9ucyBjaWZzX3N5bWxpbmtfaW5vZGVfb3BzID0gewo+
ICAgICAgICAgLnNldGF0dHIgPSBjaWZzX3NldGF0dHIsCj4gICAgICAgICAucGVybWlzc2lvbiA9
IGNpZnNfcGVybWlzc2lvbiwKPiAgICAgICAgIC5saXN0eGF0dHIgPSBjaWZzX2xpc3R4YXR0ciwK
PiArICAgICAgIC5maWxlYXR0cl9nZXQgPSBjaWZzX2ZpbGVhdHRyX2dldCwKPiAgfTsKPgo+ICAv
Kgo+Cj4gLS0KPiAyLjUzLjAKPgo+CgoKLS0gClRoYW5rcywKClN0ZXZlCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWls
aW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
