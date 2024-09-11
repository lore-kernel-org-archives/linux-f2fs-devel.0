Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC92EE49BD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:56:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soOlF-0000Xl-E2;
	Wed, 11 Sep 2024 14:56:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1soOlE-0000Xf-A4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 14:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=; b=T3MdhiaeZMi3GcB2gMG7HTWxGM
 WnkpR+TVeQg/Ph4oQ2F+f0t33MCuh1bIqQC5dN7Yb2JX9MwdkBDmvpWcMnkcX7L9UOIRKBnlZrXnz
 NCbBhA5p9y2ijSYbj2/tZDFL3ysl2Cq08u6Wim5jlu4owSQAHa+bhq3SBuUhh5PHyCss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=; b=KC8PR/5CoU1CsLFqqCZzaY8gvF
 T9HKI15F7WS98kINY5yPeLqm8ytSYIt7rwZNSEjdh1o5hWWnc0hrUOMcUDolsUGFKzpNRdvQQUvOt
 llZ9uHBOz2tLBjYhrX3QJeY2bSt1UVzvaAr3XNrM/uGvQneorT5G5H/RsgB4LfF9cyxs=;
Received: from mail-vk1-f173.google.com ([209.85.221.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1soOlD-0000mE-3s for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 14:55:59 +0000
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-502bb7cc965so481521e0c.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Sep 2024 07:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726066553; x=1726671353; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=;
 b=WfUpz3+kJHyUa+C3tXM3xfh5QgHEg5LOAPFFvTUx9BatdJH5St5x8OFllbsBOd73qd
 g+NUn28uV/cyWJl4nKanC6eF+RVhXnFBC2NEYSwyP9QmWpexUH4WuD3Jt4O+ddMUC/qo
 Ofd6j6TGyqO93Go22oZb7HarqY4r5p4PF9eORC/f+/kFLBZseo6zjNpXFwYXmW+Dsaxz
 wRYcD2vWPFecTSj8ShfDYUXOdU0suu5RuU0pjqdaZw8eU6KPSfu8krU48YCkuyGBgZC4
 dmx4qD3P4IpZL3PfaiyM1RIbhGgVjAGBh9IGPLeC8iUXlwl+Uwy/xzEv6XgppIqcuxGQ
 UGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726066553; x=1726671353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmqJO4vSGwyIvIHlbU9meDBRQSWmv8EFougT1GMDwII=;
 b=Ss5lSe7HXTKWldcC0yGloCtsHKHb6T5CNeqDHFJiYDz1Gk+Ccgu74iR+jm5g4L/hAr
 AJvDeuJcohjXFmcCZtJAf5i98fe+TLJhxh2JjEIrocLAPX/BNoWR0Yc15e1EfVohFyxr
 fK5+9HP9UrBpdU2cK0eVKEWUKqNWWxSWhJeQv6K+Kk/iipKv63vZ34FzKHnzI4if0UVK
 2Qy0LH/NRepRtxmO9hFdXgEzV6LK64GX6NlrtgGmiQiCKwyPCAOD5RdjXGX7FJmFF8an
 qI/opDURxL4YibLBgHyeH6hnNu5G7bisjWYGimboJkvzTeDoyo2UMjJ/y61U6I5FfuCQ
 CvYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVuzOeXtrkltmYyt34IJIiC2V0ec3chWKfhZLvuHJ0hACMrw765KsN7SeF/DihPkw0feT78vH/+6P8Po1ggfI/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwlBq5W7rbDh8oGvYNzji1in3zvtSO8ZYLvk/CCmOS6Eo8RYZh1
 eZF8pQ8P12f0CFOKH4JJdb++bfdF2xCoahUZncyqqfrhU9GLe3RG/WcFE/roqkIgAWQeZKrDXcC
 sARMzjoK4888tJ+nlkKFA68YpSX4=
X-Google-Smtp-Source: AGHT+IFod2Home+5dVI1fJDal5UYbnIHTMR/YCg0SWQI6bRbBjB8pp2ETC8YsrVQct7getXIj/F7HVVBVVG6mWo33A8=
X-Received: by 2002:a05:6122:35c9:b0:502:bcda:f3fb with SMTP id
 71dfb90a1353d-50310f2d62amr2244481e0c.6.1726066553016; Wed, 11 Sep 2024
 07:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <b98143c0-fec4-4d58-a230-05317dab577e@kernel.org>
In-Reply-To: <b98143c0-fec4-4d58-a230-05317dab577e@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 11 Sep 2024 07:55:41 -0700
Message-ID: <CACOAw_yQzEWTysEsUpv8THq3xPsq2deto4Oih2USz_QX4PG8dw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1soOlD-0000mE-3s
Subject: Re: [f2fs-dev] [PATCH v2 1/7] f2fs: make BG GC more aggressive for
 zoned devices
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVHVlLCBTZXAgMTAsIDIwMjQgYXQgNzowM+KAr1BNIENoYW8gWXUgPGNoYW9Aa2VybmVsLm9y
Zz4gd3JvdGU6Cj4KPiBPbiAyMDI0LzkvMTAgNjoxOSwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBG
cm9tOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+ID4KPiA+IFNpbmNlIHdl
IGRvbid0IGhhdmUgYW55IEdDIG9uIGRldmljZSBzaWRlIGZvciB6b25lZCBkZXZpY2VzLCBuZWVk
IG1vcmUKPiA+IGFnZ3Jlc3NpdmUgQkcgR0MuIFNvLCB0dW5lIHRoZSBwYXJhbWV0ZXJzIGZvciB0
aGF0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2ds
ZS5jb20+Cj4KPiBEYWVobywKPgo+IFdoYXQgYWJvdXQgY29sbGVjdGluZyBhbGwgbGFzdCByZXZp
ZXdlZC1ieSB0YWdzIGZvciBlYWNoIHBhdGNoIG9mIHRoaXMKPiBwYXRjaHNldD8gaWYgdGhlcmUg
aXMgbm8gY2hhbmdlIHdoZW4gdmVyc2lvbiB1cGRhdGVzLgoKT2gsIGdvdCBpdC4gVGhhbmtzfiEK
Cj4KPiBSZXZpZXdlZC1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+Cj4gVGhhbmtzLAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
