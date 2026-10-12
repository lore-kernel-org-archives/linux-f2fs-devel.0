Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A863CA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PbbvqRuepDCEUxhNT+hYoqD0Xmv/KDdkvO66x2dmolw=; b=XFlaML6b3G9XneO7dXwzH78y3r
	k5H0kWBxNzkwju12tP++inJ05aGm8HxGzVOZlybH/9rZsfl5zyNla1sWu+NnfCq4Rf0RukixKHpbp
	cOj+zIpe+/ovojp2GLUJ33BMe61zBSXDr9N7zqTqoKA1Se0iF7/E+UfZliCaOsBknmdY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGCjV-0003iR-2t;
	Mon, 12 Oct 2026 09:54:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <joannechien@google.com>) id 1xGCjT-0003iK-HN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pV83cETdvSQqqQgJ/y338Y7EgvcTy8ogVjkaRWjhscY=; b=eFdVtswNMKaydUlXI6ukYfGJ8S
 BuiV3fOXyq4MZHwVOpZetFtW57B+saOndzXxkAm8Hs0zLo6A2zunoQkgLpf0Vwp8D+CvRYX47Q5gv
 kNoT6ysz4AoC1T92Gb5YrN1VKF0Yy1JGTxwgMEc1k7TvSQP4hkEUqTK3XGd5TVi+ZJWc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pV83cETdvSQqqQgJ/y338Y7EgvcTy8ogVjkaRWjhscY=; b=E7T3Zn+WtpJvASeQPOpAP8ujjz
 jlKwLkR2cmtg/O+QCm3Rr8ErHGP0jbmGDDmqGpy11RP5iIbBVsdENMVhPhbzJIisUnVALHS8KZK+N
 b9ewBB90OBqlMarvlU801qqngHjwpbO6igR0Ls9+/VVJEKqjW0OyiGn5um46ETVgL1pE=;
Received: from mail-lf1-f44.google.com ([209.85.167.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGCjR-0004LI-WD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 09:54:11 +0000
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5bcf03d95b8so4055e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 02:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791798843; cv=none;
 d=google.com; s=arc-20260327;
 b=U3MkjfNhweN1Ynpdc3VYRJQKKiURyAGjULACR2Dm/vZNlTZbMmm1EqpS4KMPD2V4+q
 52koFn+/EebuoLCpIwr4/SHjxkbJvY6jfyLbM2DQtre0TIZP0NbBrtzGIsCtFmLBZFYQ
 TFWg7ECWm6g9lFlMvtQtA7KKpW10MmHu0ujGR7dKaUUk+A067rsHyZrftNJ2oVjR6S3u
 Mjyr8ZgwnEYOVlH6EtnEGHBQkT0rx+I/XL2PQbSSDCaUYQLaxwcpz8OhoZFFcW6DWtEf
 TUW9OesRfDzcR3ertrY1oYmfzBdNmQE0uOInG70g/2KKRRsdWqv+PrnFsM3MDASHEAUJ
 qV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pV83cETdvSQqqQgJ/y338Y7EgvcTy8ogVjkaRWjhscY=;
 fh=rWe0Or+I6FHYS4w0MoMFWdCBUUqKxToH5L18gmbkeLU=;
 b=dvMnriZXbWYD5JFz7U9E20H6VTrq5lcH63q6Va8ceogQji8qKDbe/3yI6UQ4C1niQp
 GL/diBMPKLlpI0l6KHOJ/CVo9teYPAZC1kldXDktEeLfhzYnKbKjvZ7m1U3p1XKBQRxI
 rDJPJwmbQevfQlecVYYUxEZTejr8LPF6JUj2VX1aFSY07k9aAG04gg6Pamgr6rXRrhmq
 JmL6RB8Uva+w7EAmYkIyi9pPHiwc4vvbvTs1mfEZVBQYDLL7NpspGBPGxgIiIts7TBbD
 NATKHduu+2ziKYqQIovCVYwF6EJDxWWRVR93rosfkkljBgyZD4w8wtIyrJ+ix6pqzlEJ
 TuiQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791798843; x=1792403643;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pV83cETdvSQqqQgJ/y338Y7EgvcTy8ogVjkaRWjhscY=;
 b=n1ltnkotvQQAusW2x6UI4SD9VYINMq3bLgeC/mfOa6ZYv+NXRVZmXuFaDy934YJj04
 lijX/ItDBbRmRBghPAKh4hCWcnvS2P9FdKRKi9dwEFupmkmRpCUZeAwewq2b0ApSe6s6
 0uoTyFdEnWNkB/8yy7oIMpvjlYezL8HB1EsTLGMpQ5VbTCpSsvnVfEjrL/7tEXlRLWY9
 xDsfE0N6diEomh2jZx9hdjDktfzJ0FQhDhHaBDOXievJcmvTiG4zaA90RL9DOa4yZPIG
 NHYBS1msCHejq+9kWLf+vACQAaqXvSlkAdueAfYolkIZHkJ9ilWnKKDe7T47fTT4N4+l
 UwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798843; x=1792403643;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pV83cETdvSQqqQgJ/y338Y7EgvcTy8ogVjkaRWjhscY=;
 b=RmyGUkKhE8gSnH5UYGJxJWMhRKl4NplTHnSe1xJs616/a4qMUBi1Uxl5zBZjRo+MqP
 j0ciX8bavfvEz9Y88WVK9Wl4vl0HI6NELm2YD3ePzCBhZlJkdKf/w9UaOx3s9cn+ZTk2
 urJu4Syb5WXoPeUsT2+6tWhVo2sU26Y2o3ANFT2W1+rXPfElV51+WRb/7E08kbZL5T9m
 MTCb/KJPkjRAAIKTXmF3zsj8cD4Dv5KPlRxHt44GaeZt/W8FM6nwCz6uyuCv0W5Pm0YR
 w6OVnlsaAb7QXl9FareNrF3ra1Sx5L2m6g7nQggQzFHy5xDxoNEWogJdsTvmcFHwKk+K
 s2dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx5AVUXgroZTnH+PSDrMpJPEAhzEuQXvKPf7t3qxGWAq0iqCE6bJJ0myyVt7LyuehlKfDn5RMWIMKse6d6XIqzH@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJOQWG6lk1j5KLn9oLS2DfQeFAdbDxbhosfVh2H36lLCyX1noH6
 FujL5T5+PQq8TG/s05V9o8AZJOE74gwxmizeLwx8qDr/krD7js31XXEg3BaAM39Tgrj4yXEjNHf
 IA2Su+mAOtXghQwULSf8qnSwvBgQ5z5mp1rnP9D69zcRqsQjmq7zUfRpskh8=
X-Gm-Gg: AYBFou0TebtR69zmep7SZrV68hpWWSKLtdq7p5LqFN2wzOAZPUIv77UtHXb5LLnjpzy
 6fSiQeTyHSMYTDfvRnq+iTox1Ti5QpQmXNXOcUrWzwwBL77F/N75W3+ad5moM5lhTewAWF+AC5H
 05qUqYh6Z1Q9sr3oH0LtDkZJ3GcAzhpIh/kIDf54yIzGmxo5scOveFjLIUTheVCujcN27QyrVqM
 kWEIE1D6qsSw+I2hvZSpPwaF80yqQ3RzNO+hfA53z1eOvftnkb/FMytEl5RXIml06O03QGsR2uY
 9yi++awZnvV2BJus3sPzjW7YEaqzY3parupv4upI/6+4cSA/icwf7V11iWaEGmETpJ7oMu4G90H
 frotimMK8zQ==
X-Received: by 2002:a05:6402:1492:b0:6af:afce:184f with SMTP id
 4fb4d7f45d1cf-6b1988f1271mr63498a12.3.1791797289766; Mon, 12 Oct 2026
 02:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261009095335.749891-1-joannechien@google.com>
 <2ae11ebc-dd27-409f-9b9f-a153fe310178@kernel.org>
In-Reply-To: <2ae11ebc-dd27-409f-9b9f-a153fe310178@kernel.org>
Date: Mon, 12 Oct 2026 17:27:42 +0800
X-Gm-Features: AclHuK_6fjPI-Vr-bb9F6H5CvWucCED5mEC_yBYFlY-X0kLidmlZ2eoJBsu7ulw
Message-ID: <CACQK4XALrKkq3jphYVxDoni7T0_Ez-T7QXZfbmNdRzM6GdAdHQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xGCjR-0004LI-WD
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: allow pinning empty compressed files
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
From: Joanne Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Joanne Chang <joannechien@google.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU3VuLCBPY3QgMTEsIDIwMjYgYXQgNDozMeKAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiAxMC85LzI2IDE3OjUzLCBKb2FubmUgQ2hhbmcgd3JvdGU6Cj4gPiBD
b21taXQgYTY0YTNmZWMxMWU3ICgiZjJmczogZm9yY2Ugb3V0LXBsYWNlIHVwZGF0ZSBmb3IgYWxs
IHdyaXRlcyBvbgo+ID4gY29tcHJlc3NlZCBmaWxlIikgdXBkYXRlZCBmMmZzX3Nob3VsZF91cGRh
dGVfb3V0cGxhY2UoKSB0byBhbHdheXMKPiA+IHJldHVybiB0cnVlIGZvciBjb21wcmVzc2VkIGZp
bGVzLiBIb3dldmVyLCB0aGlzIGZ1bmN0aW9uIGlzIGFsc28KPiA+IGNhbGxlZCBkdXJpbmcgZjJm
c19pb2Nfc2V0X3Bpbl9maWxlKCkgdmFsaWRhdGlvbiwgc28gcGlubmluZyBhbgo+ID4gZW1wdHkg
ZmlsZSB3aXRoIGNvbXByZXNzaW9uIGVuYWJsZWQgbm93IGZhaWxzIHdpdGggLUVJTlZBTCBiZWZv
cmUgdGhlCj4gPiBjb21wcmVzc2lvbiBmbGFnIGNhbiBiZSBzdHJpcHBlZC4KPgo+IEJ1dCwgSSB0
aGluayBpdCdzIGFzIGV4cGVjdGVkLCB3ZSBmb3JjZSBjb21wcmVzc2VkIGZpbGUgdG8gT1BVLCBh
bmQgcGluZmlsZQo+IHRvIElQVSwgaXQncyBjb25mbGljdC4KClRoYW5rIHlvdSBmb3IgcmV2aWV3
aW5nIHRoZSBwYXRjaC4gSSB1bmRlcnN0YW5kIHRoYXQgY29tcHJlc3NlZCBmaWxlcwpjYW5ub3Qg
YmUgcGlubmVkIGJlY2F1c2UgY29tcHJlc3NlZCBmaWxlcyBuZWVkIE9QVS4KClRoZSBjYXNlIEkg
d2FudCB0byBjaGVjayBpcyBwaW5uaW5nIGEgY29tcHJlc3NlZCBmaWxlIHdpdGggbm8gYmxvY2tz
LgpmMmZzX2lvY19zZXRfcGluX2ZpbGUoKSBvbmx5IGFsbG93cyBwaW5uaW5nIGZpbGVzIHdpdGgg
bm8gYmxvY2tzLCBhbmQKYWxzbyBjYWxscyBmMmZzX2Rpc2FibGVfY29tcHJlc3NlZF9maWxlKCkg
dG8gY2xlYXIgdGhlIGNvbXByZXNzaW9uIGZsYWcsCnNvIHRoZXJlIGlzIG5vIGNvbmZsaWN0IHdp
dGggSVBVIGZvciBzdWNoIGEgZmlsZS4gSWYgSSB1bmRlcnN0YW5kCmNvcnJlY3RseSwgdGhpcyBp
cyBhbGxvd2VkIG9uIHpvbmVkIGRldmljZXMgYXMgdGhlCmYyZnNfc2hvdWxkX3VwZGF0ZV9vdXRw
bGFjZSgpIGNoZWNrIGlzIHNraXBwZWQgdGhlcmUuCgpCZXN0IHJlZ2FyZHMsCkpvYW5uZQoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMt
ZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0
Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMt
ZGV2ZWwK
