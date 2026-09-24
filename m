Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F551C98321
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UoeQQXitj4/jQ7qzhQZeHKfqbU5JmGlvYB5YhDL7xd8=; b=lWePGU09wBAQ5c4m420Lixdrh0
	K/WRsfjrfZQw4d08xOk37fzgLTpRmvyzRnUcAbuB8c5HmIRRaRb7REwpXuM7e58zBoSooSIik2CoM
	nh8D4KzqtIWGIpv3St78VdGX5/05DUXeHG8ooXzBCoRn4akuQeM7LE89y+h0+2nj49XY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9lpt-00071o-Hw;
	Thu, 24 Sep 2026 15:58:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x9lps-00071i-F0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 15:58:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cDpTNZVHqrO0WKs3SLOrqTa6JLMU8MhI0fa0CuoT9rQ=; b=kpGrCoOfL+lgQ2tpjpVaKop8na
 R7CLoK8fBwFO/8D+S0ecsnjklEQ1uVfoQiZcJkdFO8/b/weGo+hy1q/m6QZ68ApOG0d3ri/MCbxAN
 r6fC9KvCHz/0ERlQmP3Xkmf5BFx04m37yRCrw2W4XK5/jk7xjtAfG+9mjfGJD/L2rnMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cDpTNZVHqrO0WKs3SLOrqTa6JLMU8MhI0fa0CuoT9rQ=; b=hC+U6xx0IRf0Zt2mDURIscMNxu
 Pqnr7Cc3BXFfOFDcY/EMZRraHz1HVD+pMbMP5KfZ1xzcYMo8gAHDLfFG0z/fLB2vzOTjs+5WB0SRI
 41wX/UMHowg7Fc85ECLCcB4oM/cFDMU9nUKjw8ByMBsUW0M/R7eOyg4my1HYSJ7XYAGs=;
Received: from mail-pz2-f12.google.com ([74.125.228.12])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9lpp-0004u3-8y for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 15:58:09 +0000
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-85469a3490bso35354b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 08:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790265483; cv=none;
 d=google.com; s=arc-20260327;
 b=jFh7NJRlqssVQq/R9kNpo9Krf9C3QFcm7XMFI8Ij8FWcMyDC8fR0NgXqyIvQ9Sukmn
 VpqD9gqh+D9rlohOwEUB5Ct191UoO1TEG8ra52fhuIST6IjMnKWUwCIgRYW5vLczURFY
 QZbaaoWAJp6sQyuHKC3ZrZrTjQZrgLWvfDeOqEjS/dehvLRqQ2geRy0TeNqDCynguxiR
 Kh7szvHUy5hzsSKZ2xSJTrn8jBSC+HCaOYku3pbAUlw8TBEQKrDY8V7cqrtwan0Jjyol
 GycqgdmlshNdGibDWpWQPYy18QyuKYJbcg6q8oxqYtCQhR15sGsN7+djATTrou2qiSzk
 FiQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=cDpTNZVHqrO0WKs3SLOrqTa6JLMU8MhI0fa0CuoT9rQ=;
 fh=hgkHxWKgms8D0XoiLPw8HAVx5pWhYvVn3dsbAngmLe0=;
 b=rgym6VR3Rsl3DD6VPpJtGyW+Dlpbu55ZGcUqHcqhBsNvaUfQuqWW1mQDLJKHCXr6E3
 HZz69hECVKbjBf6C0CqqjYUOWpIAIb5lUEDFAzzM//DLMEhX8jkai3xKCho1g0VueFWe
 WowGj/N/ub9UhE/jFqS8wWopvvdhv9uOUwvDqIAepdL3hgf5hATXYhIgVD+/Ed7vvAT9
 UJhJxEFqYgmJvG75bUNBX9ruygdVTqcgBhfwNWu3wXJrs54nVVrI6DFXeyiuXLoKvX6I
 6pJ1NsKTHeO9SJLXkeCJEEVILPTm0JQhP6C/qQriz0uiLas74i7UM70cmLOS1vDtdSzM
 6MQQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790265483; x=1790870283; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cDpTNZVHqrO0WKs3SLOrqTa6JLMU8MhI0fa0CuoT9rQ=;
 b=sCwc5cHn9pQrccrzqkpLozEA0ADuQsVrgHD5djYEdrghMkM3ZFio3hDMY4swJAET3f
 L9gVRvey+L+YyXNjV3WIqLn6FQnw5DCSK3F7POV8aDv3ps1NCugfrtSNrPX+x6Ce4hx/
 r77x0KIMyeuDFLa036BzSl4N0gZQqey+8hEN6AooVnhf6S4QQnYjG0gFZSfbf6GPGe+T
 ud9fGgcS0H6/M4eIHJI9bkaDaGZzfo8MNbgC6YnfVXOpQx3K86kaakhUSK3Qoo/KB/Ct
 9YHey5X2F4GBryIEUxccvJtFGim09ioGO0pBnD7v64dLZLTPc5vzFdv/aNLaZviaTRJV
 v1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790265483; x=1790870283;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cDpTNZVHqrO0WKs3SLOrqTa6JLMU8MhI0fa0CuoT9rQ=;
 b=jteJQCa+m8G3Zu9qFbeE7NMe+fmeWJcqAQDxTIouOhX8c9ct7gxlWhQ3sZBYIu9zJA
 L3AIqVdrwi2uQ1K2aB2fW8fYT7AxbsKsmN9B1fSv5Gtbsz+tkkdb3tp4SXELlepO9efa
 v/5rV+AzZjufiMfCeRsqiuOqUtLQS7SoToncp/nulFZwtIPHeY4vkzjECNqWCpBj4huw
 X3xI7/gbq+4cqvc2k/VWGf9QKVS6MIBtbG6qjgKPUcYpKQitAViJJmDempQEXGW5iq1P
 9RCJZ3HbYsTS6bwkBUKUstSnMIDoOr+Ra5k+hlDISsj1hP9UhKwR45znhbXDGfV2NaPv
 30sw==
X-Forwarded-Encrypted: i=1;
 AKwUvByB7jFLsfb5venFqA76QSufHOe2GzpEkS9kukMN+uHqnEV4SP6MFChPeChNcv2xBa/6ltbjsR9X/cpzHsl+sxHA@lists.sourceforge.net
X-Gm-Message-State: AFuF++n0AByYncry9dA56PkyFgcEnQ5HaONMzT+KtPS75U0axm0Mj757
 owfkaHeyIVCAMXauOiYDv8EuJgRK7xa9Ogmqghvs6Y9IuvviA56L3gopR6WADHa908+OCvgW3ZK
 mnYrTZ4pnYT+as4ua1eGq1KrjVREhuqk=
X-Gm-Gg: AYBFou3AwUclxbgQUEFIaRtk5/E3/b5bYyuphAij9KxO4W4NM6RplUv48BXGorvwo2E
 pKR9PCYV8wjI2YpbbE6qndKhmY0IkoD/obd5G234PQcqmAmI3nw7QpSygT20R0ZcDkBKA9tx+Ar
 e7A666lvzPIvJc9LDvdOG5iRDZLat1LlR74armp0ihvEXtzvK2Exmvr0LmCYRZ460I0x02jm6Ka
 8P64O+0Bbw1T1s6y75g+bW33dQlWHt29VvDzbm6azaexVtq6qj/t7J7cLdIuRh3A8HrVUhn2S/8
 10gliPnqVYU5IkR21efLoq8VKlga3JzLBJUxeF1hjDDlxBodBbQzj4pc2IWLo66GlFGciov+rPx
 JjKQP4eFAp6QUAw9MStmKilnl0c/alP8TYopK2WCZpQ==
X-Received: by 2002:a05:6a20:4388:b0:3dd:cc61:c0df with SMTP id
 adf61e73a8af0-3de0e899e4emr2697830637.25.1790265483478; Thu, 24 Sep 2026
 08:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Thu, 24 Sep 2026 08:57:49 -0700
X-Gm-Features: AclHuK989g8w5jlc0v8XBTZNQE2OwIfTRkHZBKYmw-nwjYIpnh-4i8jQ3FcXQYc
Message-ID: <CACOAw_xmQcAwcXowkv99XOV3X-6Gtis6Hu2NWNs1zQCfe6iiWw@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1x9lpp-0004u3-8y
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: flush SIT journal during
 filesystem resize
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
Cc: daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, sunqiuyang@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gRnJpLCBBdWcgMjgsIDIwMjYgYXQgNzoxNeKAr0FNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gRHVyaW5nIGEgZmlsZXN5c3RlbSByZXNpemUsIFNCSV9JU19SRVNJ
WkVGUyBwcmV2ZW50cyBuZXcgU0lUIGVudHJpZXMKPiBmcm9tIGJlaW5nIGFkZGVkIHRvIHRoZSBq
b3VybmFsIGFuZCBmb3JjZXMgZXhpc3RpbmcgZW50cmllcyB0byB0aGUgU0lUCj4gYXJlYS4gSG93
ZXZlciwgZjJmc19mbHVzaF9zaXRfZW50cmllcygpIHJldHVybnMgZWFybHkgd2hlbiB0aGVyZSBh
cmUgbm8KPiBuZXcgZGlydHkgc2VudHJpZXMsIGxlYXZpbmcgZXhpc3Rpbmcgam91cm5hbCBlbnRy
aWVzIGJlaGluZC4KPgo+IEFmdGVyIHRoZSBtYWluIGFyZWEgc2hyaW5rcywgYSBsYXRlciBjaGVj
a3BvaW50IGNhbiBhY2Nlc3MgYSBqb3VybmFsCj4gZW50cnkgd2hvc2Ugc2VnbWVudCBudW1iZXIg
aXMgb3V0c2lkZSB0aGUgbmV3IGdlb21ldHJ5IGFuZCB0cmlnZ2VyCj4gZjJmc19idWdfb24oKS4K
Pgo+IE9ubHkgdGFrZSB0aGUgemVyby1kaXJ0eSBmYXN0IHBhdGggd2hlbiBlbnRyaWVzIG1heSBi
ZSB3cml0dGVuIGJhY2sgdG8KPiB0aGUgam91cm5hbC4gVGhpcyBsZXRzIHJlc2l6ZSBkcmFpbiBl
eGlzdGluZyBlbnRyaWVzIHRocm91Z2gKPiByZW1vdmVfc2l0c19pbl9qb3VybmFsKCkgZXZlbiB3
aGVuIHRoZXJlIGFyZSBubyBuZXcgZGlydHkgc2VudHJpZXMuCj4KPiBGaXhlczogMDRmMGIyZWFh
M2IzICgiZjJmczogaW9jdGwgZm9yIHJlbW92aW5nIGEgcmFuZ2UgZnJvbSBGMkZTIikKPiBTaWdu
ZWQtb2ZmLWJ5OiBXZW5qaWUgUWkgPHFpd2VuamllQHhpYW9taS5jb20+Cj4gLS0tCj4gIGZzL2Yy
ZnMvc2VnbWVudC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL3NlZ21lbnQuYyBiL2ZzL2YyZnMv
c2VnbWVudC5jCj4gaW5kZXggMWU3ZTc0NWJlNzFkLi45ZjljZTI1ZGQwN2UgMTAwNjQ0Cj4gLS0t
IGEvZnMvZjJmcy9zZWdtZW50LmMKPiArKysgYi9mcy9mMmZzL3NlZ21lbnQuYwo+IEBAIC00ODE2
LDcgKzQ4MTYsNyBAQCB2b2lkIGYyZnNfZmx1c2hfc2l0X2VudHJpZXMoc3RydWN0IGYyZnNfc2Jf
aW5mbyAqc2JpLCBzdHJ1Y3QgY3BfY29udHJvbCAqY3BjKQo+Cj4gICAgICAgICBkb3duX3dyaXRl
KCZzaXRfaS0+c2VudHJ5X2xvY2spOwo+Cj4gLSAgICAgICBpZiAoIXNpdF9pLT5kaXJ0eV9zZW50
cmllcykKPiArICAgICAgIGlmICghc2l0X2ktPmRpcnR5X3NlbnRyaWVzICYmIHRvX2pvdXJuYWwp
Cj4gICAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+Cj4gICAgICAgICAvKgo+IC0tCj4gMi40My4w
Cj4KClJldmlld2VkLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgoKVGhh
bmtzLAoKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
