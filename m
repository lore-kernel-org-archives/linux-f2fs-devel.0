Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB3606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J4Bmje/8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fwjXQGp2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H/j3GDXZ;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HuqW7OuM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OAsxCBRTpSSPgsVq9vWsoDsYb8P1L/zm9bE5bIuSyCo=; b=J4Bmje/8BVjPJb
	AgbsVESAkpqTKAD/POzY+Y0PtofCJxArfOMk2Dvh9okgkvDGDzW/SR7VxjizKIIN2gDyHSmY4lBQd
	SD5FnDWXKxSdZ1ZrvSzWvzkRaYMzzNrG5phV/1sIyrunYpbbyYjlLz3xFSRoMlRXJN36Zf6unjsul
	YYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xT2fW-000000003ii-19vF;
	Mon, 16 Nov 2026 19:47:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daehojeong@google.com>) id 1xT2fU-000000003ic-16AX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=; b=fwjXQGp2iCccNtepAZnsDWM+2j
 CVvePKsZZ7MjnAA/xMXaeawjMJZolsXk6+fn72dJgaOAIT4ft2waWzBpXwZWkdb7QJpIy3I6nHIe5
 y9y5E4QAkP2kO7i7IdVmPxleukQWyc4why2h5H6k2ae+PXYvCtFdJ0KstjbKZdtqCQ/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=; b=H/j3GDXZeh3gE8iDAE0t/RFkPc
 FCWEci3IpIADAuaPhgXAyTgA+PxEg6hOT8jx50HKQXZOxwCvoHjOtjXC06vfv9hGaHL4CyqTRJ5up
 J85oSi3hP77krB+spLFtj3olsL4wV2X2uOoTuxW5KptT+m5dRQg0ibjdC4sdD2NMvLZQ=;
Received: from mail-qt1-f181.google.com ([209.85.160.181])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT2fR-0000000051o-1xFk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:47:08 +0000
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-533202fe429so41121cf.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 11:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858419; cv=none;
 d=google.com; s=arc-20260327;
 b=YtGh7OIo8OLoqlgGjwvKtxMZSpcWCM/rjGAvgQaPU+ygqxw/l34fQa+ejQSneyZo38
 fHlQIMfmG3gyO1duRXT6RR1EzKHpEyuzlzBtZ7XG5X4ENQAVZFUWGXyLHXyo1Fdxocca
 9YUwbCpnvKLOl3E4PEXHcsOXYwRpS46GfsPjE8IHU22pHTQwWpnr9dpu7QYbRigkPfRw
 ZQiI3mG9KM/gqI5fGmkU4XQroQi35/wZ6RxUDRUhO3eYwTYnuPdvBcIgwQ707butnHAk
 V4Si4y92YweLNm6C11aVXC+uaQMuC7PBgOvxHivjJgdlQKp86kPzIgZlBs059jDI+cWb
 Zsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
 fh=8GIhCvD9IFT/y/zv+4vs8qDADbgVcf5Hhuot8o9axlA=;
 b=iKqm7OvRLd7hvMlkMwkzWWY9bD1Ow16T+hPQc933zcpGoJ0/cL5Nc+eiqBHWLkPlvK
 KdhQfeAgXTep1ZqZHCtXSgQmPfwV902gOHR7EWR8xPyVvxyg+ZnqQGhsyEnjYdmDt23/
 sRwLqbmJNj3aBLYFFB2rDkwBa0VhZwfZmnJewAmbnu1P9cszZpuHQvkVPPq7T7TreWM7
 l/DGwfFVjptNzjpxd+hQpvTqZXFeql3Onxmu56TGdJuBNzVPOiXxGKOl62OV6cIECHb7
 ESZnJsx96fxpF65QhxV5p50BEcNOlhW3R/J5BsaLLLUf1JJCbkX2wSeHN4smZePeVVX+
 //0w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794858419; x=1795463219;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
 b=HuqW7OuMQS+dcJs4cpICdXKHSDfE4wnirYIRuWVj9eX1nWw1AtOJWuhGmeBR9xuYXp
 7Oa5NDYvMpZqEa86eoy6HAEUfRJYuypfwLMhKi3Ie7KBMTsBLJhRPWE9wNDCNVI6Ixh4
 p7swhNGiZvVLLcKV1d9BJ69hLGQW64WYx6GE0YLEGKY6Wrrl8tBlcxDDwtRrk6abFU0G
 eHOliE7zsU4NxpD7EViCvUZoYx3UrlqASjhou8de3SmssPdgIwtnCH9+bmyI/1/dxPQh
 6AWXZADDOn/REINNr8lFR5XraH91mioOp4Alajv81kP+q+epuxNQqU68H1JfaMtPROAM
 k+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794858419; x=1795463219;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P+Td53i4gLVL614EDe7ngJcewRkwlZAfzI7C1/wn6i8=;
 b=iH0Ipbdg0yCBL0RqbRfvYFWW25F9EXDZac7/9IUMfEfN4IV8bqoKeI3LVrLfjTz8uJ
 xzIWTI/mWZw+RvbJSvKAi8B3m/HYEFEjUuH5lFOiCQVh1ZyjDJrXQvFHKqpqRsQ9offQ
 jFtB+OMtwLI/+Ivy1Sk+Ek5TenCq3fGTWXjFCklZQQvH/EDbLC4pMqDey5RcampvSqLp
 ovvt38GFJa+jfzyNo96MvSz5eGEM/rby8YWBD1uCUDqO3hpzJgBJ2XFpEeNRdhIu5b1m
 FREwsxehOtV1TdQ2Aib1VcOi6LbhyLI9xUnCoM0vUPZp0pJQ3UcfcKaBlkF45xibQoYs
 tQzg==
X-Forwarded-Encrypted: i=1;
 AL+hErGuTVumOuuQ5mtxzLyNi0Xp+cRtv0J8l8wEKi7auwWmsn1N/Vveh9yOGNlY7xh3rbcK+xdLcm4zrkM6P6Jath1E@lists.sourceforge.net
X-Gm-Message-State: APuU4Z95rgmpnlKapBGcqppSsdHfprVAu4UUAPJlSCuI7bdljzvKs1rF
 sHusl6k8EubkVz1XAObBUTsi097ILhJrqJRGtbo2toaTMh2ccGesmmQoREtuZ/TqGACAGgrMaO+
 kpo4on26jFguaiuz+805V2I1Nf4AAKFdwI97omwn5gQXOk/Wn9mwCQUQv1so=
X-Gm-Gg: AYBFou1kydCoXVzMNI6pceUa8ezJmmSmBkUCBJbJ2g41qGOnw+CFYSdhK7mLUJ92zO6
 /6gDGUNXZn3Lf2uDymgPFQcMYjiLf9gNIFj/iWhi2jnIq7sSAJBAlX4Uqh6ITfy/mwqgacpG9nf
 TGjVSms1Nf3qL1Cuq7oy369eVYQwwRKL2OxdwKlXMGC4mCyuYuzI9EORunuZZ4aUr867zqhEk7Q
 YmuTyf88Jr/fADgCMhfvgNo36AiBVtaFJrNnmRzi6g8avLckW49qf0y4DgfTgi9Axpi6P7Hg2qK
 IIpzhXvU1eXnjcXStEJa+JQ4Ur9gOQrxYbHA4mx2nV7C4Jb88v7p9FcSwW6b/A4/hTvKuVGy+AB
 St7al5N8GXEE/b1hH/cJ+MRuGUVHb7+Chjs8dfz4oiZ3+Ogbw0ZVAR5xatEYpvUnr7Jmgk+KlTY
 p+fYv4mjPp6aqc
X-Received: by 2002:ac8:5cc3:0:b0:533:9731:f0f1 with SMTP id
 d75a77b69052e-55d4a2054d9mr1659681cf.10.1794856737600; Mon, 16 Nov 2026
 11:18:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116000534.2303800-1-daeho43@gmail.com>
In-Reply-To: <20261116000534.2303800-1-daeho43@gmail.com>
Date: Mon, 16 Nov 2026 11:18:21 -0800
X-Gm-Features: AclHuK-qQ2-LUVPUDC8WbXro110m72c8YZKmMgPHn_9p8GCIathgq-RTR8N6zaA
Message-ID: <CABdZyexiNTnEkbrY0Pzw2ADWMCiwq2dSu521yBmec2+0PGiEnw@mail.gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Spam-Score: -7.7 (-------)
X-Headers-End: 1xT2fR-0000000051o-1xFk
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip the inode update for a size
 grown within a block
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Daeho Jeong via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daeho Jeong <daehojeong@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCBOb3YgMTUsIDIwMjYgYXQgNDowNeKAr1BNIERhZWhvIEplb25nIDxkYWVobzQzQGdt
YWlsLmNvbT4gd3JvdGU6Cj4KPiBGcm9tOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUu
Y29tPgo+Cj4gZjJmc19za2lwX2lub2RlX3VwZGF0ZSgpIGxldHMgZnN5bmMoKSBza2lwIHdyaXRp
bmcgdGhlIGlub2RlIHdoZW4KPiBGSV9BVVRPX1JFQ09WRVIgaXMgc2V0IGFuZCBpX3NpemUgaXMg
YmxvY2sgYWxpZ25lZCwgcmVseWluZyBvbiByb2xsLWZvcndhcmQKPiByZWNvdmVyeSB0byByZWNv
dmVyIGlfc2l6ZSBmcm9tIHRoZSBwb3NpdGlvbiBvZiB0aGUgZnN5bmNlZCBkYXRhIGJsb2NrLgo+
IEhvd2V2ZXIsIGRvX3JlY292ZXJfZGF0YSgpIGV4dGVuZHMgaV9zaXplIG9ubHkgYnkgYSBibG9j
ayB0aGF0IHN0YXJ0cyBhdCBvcgo+IGJleW9uZCB0aGUgcmVjb3ZlcmVkIGlfc2l6ZSwgc28gaXQg
Y2Fubm90IHJlY292ZXIgYSBzaXplIHRoYXQgZ3JldyB3aXRoaW4KPiB0aGUgYmxvY2sgaG9sZGlu
ZyB0aGUgb2xkIHNpemUuCj4KPiBGb3IgZXhhbXBsZSwgb24gYSA0S0IgYmxvY2sgZmlsZXN5c3Rl
bToKPgo+ICAgd3JpdGUoZmQsIGJ1ZiwgMTRLQik7IGZzeW5jKGZkKTsKPiAgIHdyaXRlKGZkLCBi
dWYsIDJLQik7ICBmc3luYyhmZCk7Cj4gICA8c3VkZGVuIHBvd2VyLW9mZj4KPgo+ICAgLSB0aGUg
Zmlyc3QgZnN5bmMoKSB3cml0ZXMgdGhlIGlub2RlIHdpdGggaV9zaXplIDE0S0IuCj4gICAtIHRo
ZSBzZWNvbmQgd3JpdGUoKSBtYWtlcyBpX3NpemUgMTZLQiBpbiB0aGUgc2FtZSBibG9jay4gSWYg
aXQgaXMgaW4KPiAgICAgdGhlIHNhbWUgdGltZXN0YW1wIHRpY2sgYXMgdGhlIGZpcnN0IG9uZSwg
dGhlIHRpbWVzdGFtcHMgZG8gbm90IGNoYW5nZQo+ICAgICBhbmQgdGhlIGlub2RlIGlzIHN0aWxs
IGNsZWFuLCBzbyBGSV9BVVRPX1JFQ09WRVIgaXMgc2V0Lgo+ICAgLSB0aGUgYmxvY2sgaXMgYWxy
ZWFkeSBhbGxvY2F0ZWQsIHNvIHRoZSBzZWNvbmQgZnN5bmMoKSB1cGRhdGVzIGl0IGluCj4gICAg
IHBsYWNlIGFuZCB3cml0ZXMgbm8gbm9kZS4gZjJmc19za2lwX2lub2RlX3VwZGF0ZSgpIHNraXBz
IHRoZSBpbm9kZSBhcwo+ICAgICB3ZWxsLCBzaW5jZSBpX3NpemUgaXMgYmxvY2sgYWxpZ25lZCBh
bmQgZXF1YWxzIGxhc3RfZGlza19zaXplLgo+ICAgLSByZWNvdmVyeSBmaW5kcyBpX3NpemUgMTRL
QiBpbiB0aGUgaW5vZGUgZnJvbSB0aGUgZmlyc3QgZnN5bmMoKSBhbmQgaGFzCj4gICAgIG5vIGJs
b2NrIHRvIGV4dGVuZCBpdCB3aXRoLCBzbyB0aGUgbGFzdCAyS0IgaXMgbG9zdC4KPgo+IFJlcGVh
dGluZyBhIDJLQiBhcHBlbmQgYW5kIGZzeW5jKCkgdXAgdG8gMTZLQiBhbmQgdGhlbiBzaHV0dGlu
ZyBkb3duIHRoZQo+IGZpbGVzeXN0ZW0gbGVmdCAxMTcgb2YgMTIwMCBmaWxlcyB3aXRoIDE0S0Ig
b24gYSA0S0IgcGFnZSBrZXJuZWwsIGFuZCBub25lCj4gd2l0aCB0aGlzIHBhdGNoLgo+Cj4gU2V0
IEZJX0FVVE9fUkVDT1ZFUiBvbmx5IGlmIHRoZSBvbGQgaV9zaXplIGlzIGJsb2NrIGFsaWduZWQs
IGFuZCBjbGVhciBpdAo+IG90aGVyd2lzZSwgc28gdGhhdCBmc3luYygpIHdyaXRlcyB0aGUgaW5v
ZGUgZm9yIHN1Y2ggYSBzaXplIGNoYW5nZS4KClBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaC4KCkkg
bWlzc2VkIHRoYXQgQ2hhbyBhbHJlYWR5IHBvc3RlZCBhIGZpeCBmb3IgdGhlIHNhbWUgcHJvYmxl
bToKICBbUEFUQ0ggMS83XSBmMmZzOiBmaXggdG8gcGVyc2lzdCBpX3NpemUgZXh0ZW5kZWQgaW5z
aWRlIGxhc3QgYmxvY2sgZm9yIGZzeW5jCiAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
ZjJmcy1kZXZlbC8yMDI2MTAyMjEyNTI0NC4yMjA1Mjc1LTEtY2hhb0BrZXJuZWwub3JnLwoKU29y
cnkgZm9yIHRoZSBub2lzZS4KClRoYW5rcywKRGFlaG8KCj4KPiBGaXhlczogM2EzYTVlYWQ3YjZk
ICgiZjJmczogZG8gbm90IHJlY292ZXIgaV9zaXplIGlmIGl0J3MgdmFsaWQiKQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1ieTogRGFlaG8gSmVvbmcgPGRhZWhvamVv
bmdAZ29vZ2xlLmNvbT4KPiAtLS0KPiAgZnMvZjJmcy9mMmZzLmggfCAxMyArKysrKysrKysrKy0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2ZzL2YyZnMvZjJmcy5oIGIvZnMvZjJmcy9mMmZzLmgKPiBpbmRleCA1MGE1
Zjg0NTE3NmQuLmIzMjhlNjc4ZDI5NSAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL2YyZnMuaAo+ICsr
KyBiL2ZzL2YyZnMvZjJmcy5oCj4gQEAgLTM2NzYsOCArMzY3Niw5IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBmMmZzX2lfc2l6ZV93cml0ZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgaV9zaXpl
KQo+ICB7Cj4gICAgICAgICBib29sIGNsZWFuID0gIWlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBG
SV9ESVJUWV9JTk9ERSk7Cj4gICAgICAgICBib29sIHJlY292ZXIgPSBpc19pbm9kZV9mbGFnX3Nl
dChpbm9kZSwgRklfQVVUT19SRUNPVkVSKTsKPiArICAgICAgIGxvZmZfdCBvbGRfc2l6ZSA9IGlf
c2l6ZV9yZWFkKGlub2RlKTsKPgo+IC0gICAgICAgaWYgKGlfc2l6ZV9yZWFkKGlub2RlKSA9PSBp
X3NpemUpCj4gKyAgICAgICBpZiAob2xkX3NpemUgPT0gaV9zaXplKQo+ICAgICAgICAgICAgICAg
ICByZXR1cm47Cj4KPiAgICAgICAgIGlfc2l6ZV93cml0ZShpbm9kZSwgaV9zaXplKTsKPiBAQCAt
MzY4Niw4ICszNjg3LDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmMmZzX2lfc2l6ZV93cml0ZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgaV9zaXplKQo+ICAgICAgICAgICAgICAgICByZXR1
cm47Cj4KPiAgICAgICAgIGYyZnNfbWFya19pbm9kZV9kaXJ0eV9zeW5jKGlub2RlLCB0cnVlKTsK
PiAtICAgICAgIGlmIChjbGVhbiB8fCByZWNvdmVyKQo+ICsKPiArICAgICAgIC8qCj4gKyAgICAg
ICAgKiBSb2xsLWZvcndhcmQgcmVjb3ZlcnkgZXh0ZW5kcyBpX3NpemUgb25seSBieSBhIGJsb2Nr
IHRoYXQgc3RhcnRzIGF0Cj4gKyAgICAgICAgKiBvciBiZXlvbmQgdGhlIHJlY292ZXJlZCBpX3Np
emUsIHNvIGl0IGNhbm5vdCByZWNvdmVyIGEgc2l6ZSB0aGF0IGdyZXcKPiArICAgICAgICAqIHdp
dGhpbiB0aGUgYmxvY2sgaG9sZGluZyB0aGUgb2xkIHNpemUuCj4gKyAgICAgICAgKi8KPiArICAg
ICAgIGlmICgoY2xlYW4gfHwgcmVjb3ZlcikgJiYgIShvbGRfc2l6ZSAmIH5QQUdFX01BU0spKQo+
ICAgICAgICAgICAgICAgICBzZXRfaW5vZGVfZmxhZyhpbm9kZSwgRklfQVVUT19SRUNPVkVSKTsK
PiArICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAgY2xlYXJfaW5vZGVfZmxhZyhpbm9kZSwg
RklfQVVUT19SRUNPVkVSKTsKPiAgfQo+Cj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBmMmZzX2lfZGVw
dGhfd3JpdGUoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IGRlcHRoKQo+Cj4gYmFz
ZS1jb21taXQ6IGI5ZDczNzlkMTBkNDMzODZiNTkwODJkYThjOWEwYjExMWUwNTQ3ODEKPiAtLQo+
IDIuNTYuMC42MTEuZzEwMzBmMGI5NDAtZ29vZwo+CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
