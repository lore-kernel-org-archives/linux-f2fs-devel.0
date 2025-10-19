Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE9CCD195
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Oct 2025 08:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7or7a9dWIpyPGy1+Z7XmXqNtVP+EyQpIvDC/+DrQW2A=; b=T17j7WBr6ZwEXhvQzcrfVdqR1D
	c55xiSMdnIWv/Kla75kC2VA4WsXxuMBsqXzD71fCb1J7z4Ew0Z7s+6J9wfd8dXnWSCmm38nnSp5Qb
	xYQEuiO1cOG4Z5I1MIifKSk0G6Kfz1+cDVIVFmEKkr91DipwvNLzTfb4IYZPoRRfkfEc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vAOVe-0003sY-7f;
	Sun, 19 Oct 2025 08:11:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <safinaskar@gmail.com>) id 1vAOVU-0003oH-A2
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Oct 2025 08:11:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=; b=YcEJFdqlWVz0hqFxVzWglNLKYt
 3cqF1Ean5elN7u1dO2r7NJ4nxIRMS1MRImAMmDlndGqE4Eo7JZWsJVlOM9YXRKgCwx2ZAQAECDRLW
 Bb4ZWnXfXjhzMmOkdTj7A2UoG0Ddq3yiM+iWHQAUIc0/huYprGGUNV7aosN3G/ssO458=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=; b=ZNPtJPggIvd7vLCyLBfLY7RG79
 0sWGuF0pV1j9YvoW97aluifTXvUeEEY79w9kuBFmmgtkFgIUA8DFEJDWT4jtwGplPvzT6nBnut7Jg
 8wO3AewaAKcxpjjq0SHlUxrOdRwWf5mhu3zWd1/Z865PE1v33ZtRxOFx8Qxgm3T+69Bc=;
Received: from mail-yw1-f169.google.com ([209.85.128.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vAOVT-0002bf-WD for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Oct 2025 08:11:12 +0000
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-7817c2d909cso36853597b3.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 19 Oct 2025 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760861461; x=1761466261; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
 b=OEf//A4zOqX04RruXmbQlBjuDlfsDk5LCbwK4iYeg6Gb9rE+/oyiovpRACPhXwdgBo
 JORD3syRKqWPs8YQR5KL1BMyTaLR5qgctLvk49gOqWkaogsecKzZNahE0RtHHTEmv+P7
 h7Na3oXr+XWwwkAeGk5fB/y2qL8PKSvHVRcbO705KVC87sYg2qM5/pDJKO+OYSTFRG9h
 905+TwPrYQVrtvrIHHKvoaF4alqDvyVZbLRIiVxPeUiwkNBvJYRt5vL1w7f5m0r8BRyr
 iXcv7cPySp6Zn3w62aOTT7Rf1Y9fAznbVTtq7ynxHSNAxmvFjpGCNN8RZNEnewDWfOdp
 +Vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760861461; x=1761466261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JD5EhU3dMvt2TzDGGngYx4VWjKCENlPlTrXXievwr0=;
 b=WQ292j2DZXMTwfgaQ/46/wnrgNI6xvRiADNH1FxJGpPGZ3/WTR1tr71iLkC8woNj48
 LLuvJ5C8hVPL4sKopyV7F6jlzebOqVMtS1kH3UhjBmCqtSFWB+w430nccHirLsC9TBoc
 Uyunu5wcBOs7r9/NSUW6sTsvDLI1YpI5tfv7fFFRWwxQEBXnFvrnUQiCsIHtFpYgtpbA
 +dA/UUQ+tL+xRIStkLVK+TeZ5Eu7igMKaGqRMNt6P4srWmjQ5fUJ3RIpdhDMxNdZ8K7s
 uDg4BQMyY4U7NMUrpqNrPMWiWxm4o783imXaeyqNDB4E/QdEhwGr5r2Zu9ikZEEiR/Lh
 VzAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV73a/NXHd+uYViubSUm4Th0TNJFFNU+0b+2NnWlixEK5AuQevwXeYJg+K1TfHOexUI7SrfvhSNhAeBnrl3NxIk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YytYI6y/0K52i7cGEVhKglBx6JYyVwel6uiPxXNddZi5/h3F6Bd
 NVNGXqEKE1WGYAUiqoc5W+JmEOiza6QUXNR6KUriEGVQ/UuX+ihu6NFrGlcHr/Ic56Jm3d8WfRn
 vKnF6TlfpdfBVfdtyVBGhkG+judNgJTw=
X-Gm-Gg: ASbGncsYsP83kQ2ddtGW85Xl0XFxg9Cr16RUViL1ZWI6G3yWCyqTIljPbJTdZWrvReX
 jwP+HEJ30tplKxVf44krMvygN7hoQ/2empMZWiU1TORgTC3w5yq4mJXZ9dvW+s/T4ZRt0jMaXxv
 +WuAG4G1mtkyRzsmKgHGmc1Mao4IXz1Hc90ckf5bJrmrJLBL57JBirM801/2cYOAcmIxvpRZXuO
 55D8+cYEQoEthOsrllG/Jm1NreoU99b+8JUAJhooHRc1HFJPFgStD79DWENCe1igKkeiI7O3C8=
X-Google-Smtp-Source: AGHT+IEDp/usYEtVSaz10lwwm2/rh8YYcBuxag2F0nuBjSfSMoio/EijPl9t2f1PGKCDHr/mRoxnx6oC2CKJ7h3r2Ic=
X-Received: by 2002:a05:690c:31e:b0:782:9037:1491 with SMTP id
 00721157ae682-7837780ba2dmr109813007b3.42.1760861461100; Sun, 19 Oct 2025
 01:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241202010844.144356-16-ebiggers@kernel.org>
 <20251019060845.553414-1-safinaskar@gmail.com>
In-Reply-To: <20251019060845.553414-1-safinaskar@gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 19 Oct 2025 11:10:25 +0300
X-Gm-Features: AS18NWAhDVf2aU8hB0qWERPwO9zi-ils_dPukaoQchmqqRauvEb3B93Zz-69KFg
Message-ID: <CAPnZJGAb7AM4p=HdsDhYcANCzD8=gpGjuP4wYfr2utLp3WMSNQ@mail.gmail.com>
To: ebiggers@kernel.org
X-Headers-End: 1vAOVT-0002bf-WD
Subject: Re: [f2fs-dev] [PATCH v4 15/19] lib/crc32: make crc32c() go
 directly to lib
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-mips@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 loongarch@lists.linux.dev, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-ext4@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, ardb@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gU3VuLCBPY3QgMTksIDIwMjUgYXQgOTowOeKAr0FNIEFza2FyIFNhZmluIDxzYWZpbmFza2Fy
QGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+
Ogo+ID4gTm93IHRoYXQgdGhlIGxvd2VyIGxldmVsIF9fY3JjMzJjX2xlKCkgbGlicmFyeSBmdW5j
dGlvbiBpcyBvcHRpbWl6ZWQgZm9yCj4KPiBUaGlzIHBhdGNoIChpLiBlLiAzOGE5YTUxMjFjM2Ig
KCJsaWIvY3JjMzI6IG1ha2UgY3JjMzJjKCkgZ28gZGlyZWN0bHkgdG8gbGliIikpCj4gc29sdmVz
IGFjdHVhbCBidWcgSSBmb3VuZCBpbiBwcmFjdGljZS4gU28sIHBsZWFzZSwgYmFja3BvcnQgaXQK
PiB0byBzdGFibGUga2VybmVscy4KCk9vcHMuIEkganVzdCBub3RpY2VkIHRoYXQgdGhpcyBwYXRj
aCByZW1vdmVzIG1vZHVsZSAibGliY3JjMzJjIi4KQW5kIHRoaXMgYnJlYWtzIGJ1aWxkIGZvciBE
ZWJpYW4ga2VybmVsIHY2LjEyLjQ4LgpQcmV2aW91c2x5IEkgdGVzdGVkIG1pbmltYWwgYnVpbGQg
dXNpbmcgIm1ha2UgbG9jYWxtb2Rjb25maWciLgpOb3cgSSB0cmllZCBmdWxsIGJ1aWxkIG9mIERl
YmlhbiBrZXJuZWwgdXNpbmcgImRwa2ctYnVpbGRwYWNrYWdlIi4KQW5kIGl0IGZhaWxlZCwgYmVj
YXVzZSBzb21lIG9mIERlYmlhbiBmaWxlcyByZWZlcmVuY2UgImxpYmNyYzMyYyIsCndoaWNoIGlz
IG5vdCBhdmFpbGFibGUuCgpTbywgcGxlYXNlLCBkb24ndCBiYWNrcG9ydCB0aGlzIHBhdGNoIHRv
IHN0YWJsZSBrZXJuZWxzLgpJJ20gc29ycnkuCgoKCi0tIApBc2thciBTYWZpbgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
