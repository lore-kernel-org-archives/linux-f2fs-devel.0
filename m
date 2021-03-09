Return-Path: <SRS0=Syn1=IH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D14C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  9 Mar 2021 13:01:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D7D6526C;
	Tue,  9 Mar 2021 13:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D7D6526C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lJbyy-0000he-O0; Tue, 09 Mar 2021 13:01:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1lJbyx-0000hX-Qa
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Mar 2021 13:01:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rm5lW1ENcl89omxJ8N+57DdgA2Z/G+rN4bPKq9l7yQQ=; b=Bti/Td70zA7YyIic6uUZamK2oQ
 zZy8UkFwsDcvq5uSDQ9wFKHobB/77aWGslnM5SwPexR/MnNS0IK6LmPWHGFXpPyqN3/cRXv9Jn31r
 QmFfgocLUqMAZE1sKj8R5Jl1plsVYzPNN7cVYCbpkCwVPj7UMlAch2j8FwBrAfyqajqM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rm5lW1ENcl89omxJ8N+57DdgA2Z/G+rN4bPKq9l7yQQ=; b=lCGwVFFfho2DG/bmolhw5MSMML
 ZEglNfD7/srvicj5t+BvEGNQdMcnclzIH/Gj3ocSTi1HvU0TI0DcWGBdMcNLVxMOuKSmt9kQ5dZIO
 aSAwDP57G1LFvIkqMBY9dFaBYoNR9Os87hWaydHtPwfWFCZTJvHo0Sy1nAAn3PC+cpwY=;
Received: from mail-io1-f47.google.com ([209.85.166.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lJbys-0007sn-Qj
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Mar 2021 13:01:03 +0000
Received: by mail-io1-f47.google.com with SMTP id a7so13726631iok.12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 09 Mar 2021 05:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rm5lW1ENcl89omxJ8N+57DdgA2Z/G+rN4bPKq9l7yQQ=;
 b=Fll48E2oUhz0FUSH6bLGlApSjh82B8QHzwmdjDkZA7x3jakx4fPOYyRJaHZ+6SXD7S
 YZFxXMp/nsJhSX1tenc3K1yBZGHJdo0yCjlv9p7lEYwd/IJqY9GZCw7Ea8X+nL0RukQJ
 i9tPV0NZuKFgU0HMNhbJL8UbwuCkPzor31bOd1ItSGwoFf+7zalpM+XW+IYFp55fdUyb
 WxyQAmyJAhi/MgpWbBr9DNlUE+YhT/TikJWIp5siEYjryL+q9P7WaPPuSWb1ktnePKgF
 MXA7c888gYT7IbbrSLcE7+TRaSohEZ7E/+gO9Wj0G5r51mk1+BHZ0WnrMsUKe88DLUyL
 HdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rm5lW1ENcl89omxJ8N+57DdgA2Z/G+rN4bPKq9l7yQQ=;
 b=q7pIJa4FYR9GP+MMP2sN2Al3jHXAlIetmS8jXMQTQMrNd6/P4xpDYDNZ6WH5L7B7Ut
 D4m2jH9o1/xXlV2Yh2DsRGa1ws4VKY7bsEf9HTy5984Nlfsens0cizu5mWvgNtsE7/P+
 yaC+3/t7LyypYk6XrbCYV5V6Yl5O4P1PFeSugikkWesprlnoOdNFwdE9AxnLZ6+4Q9yI
 9IUxliLOEUXmFbn3JRehfuGIDwVbJ2nrSjnpnkjXZ6w/aE0d1CXaBopHcxy3RR020Fqg
 KsBNem8EFutMOUSEU8HDs+QXTFt2cecydSNewtG/d+BOPc2HGgeeaQ6gjGk7S2zoAfJ4
 aO4Q==
X-Gm-Message-State: AOAM532R6vq7TysaA9zBUFpuEIYx/oS/0u/UDCzKp+kiGIdHogPqah9k
 CSsomIKehajKMtWLEn3HO+a8ddN5BqhqnfCYcv0=
X-Google-Smtp-Source: ABdhPJwAPNA4NvHj1OiawwaamclqFEuNri6ZPN8VfYbDPO3QhsL+7kqp6rllhzwiby5c+ZvLosFmwzD/GLfG7vJh2tA=
X-Received: by 2002:a05:6638:1a6:: with SMTP id
 b6mr28397712jaq.116.1615294853126; 
 Tue, 09 Mar 2021 05:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20210305022402.2721974-1-daeho43@gmail.com>
 <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
In-Reply-To: <2f2abc41-24d5-6795-44fe-b770ed8514df@huawei.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 9 Mar 2021 22:00:40 +0900
Message-ID: <CACOAw_woQGgTy_hTfdcFufA7VG3cBVSN9vSD5bubvTeo+3wxsg@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1lJbys-0007sn-Qj
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs nodes to get accumulated
 compression info
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

MjAyMeuFhCAz7JuUIDnsnbwgKO2ZlCkg7Jik7ZuEIDY6MjIsIENoYW8gWXUgPHl1Y2hhbzBAaHVh
d2VpLmNvbT7ri5jsnbQg7J6R7ISxOgo+Cj4gT24gMjAyMS8zLzUgMTA6MjQsIERhZWhvIEplb25n
IHdyb3RlOgo+ID4gRnJvbTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KPiA+
Cj4gPiBBZGRlZCBhY2NfY29tcHJfaW5vZGVzIHRvIHNob3cgYWNjdW11bGF0ZWQgY29tcHJlc3Nl
ZCBpbm9kZSBjb3VudCBhbmQKPiA+IGFjY19jb21wcl9ibG9ja3MgdG8gc2hvdyBhY2N1bXVsYXRl
ZCBzZWN1cmVkIGJsb2NrIGNvdW50IHdpdGgKPgo+IEkgbm90aWNlZCB0aGF0IHRoZXNlIHN0YXQg
bnVtYmVycyBhcmUgcmVjb3JkZWQgaW4gZXh0cmEgcmVzZXJ2ZWQgYXJlYSBpbgo+IGhvdCBub2Rl
IGN1cnNlZyBqb3VybmFsLCB0aGUgam91cm5hbCB3aWxsIGJlIHBlcnNpc3RlZCBvbmx5IGZvciB1
bW91bnQKPiBvciBmYXN0Ym9vdCBjaGVja3BvaW50LCBzbyB0aGUgbnVtYmVycyBhcmUgbm90IHNv
IGFjY3VyYXRlLi4uIGRvZXMgdGhpcwo+IHNhdGlzZnkgeW91ciByZXF1aXJlbWVudD8KPgoKWWVz
LCB3ZSBhcmUgc2F0aXNmaWVkIHdpdGgganVzdCBnZXR0aW5nIHJvdWdoIG51bWJlciBvZiB0aGVt
LiBCdXQsIGl0CndvdWxkIGJlIGJldHRlciBpZiB5b3Ugc3VnZ2VzdCBtb3JlIGFjY3VyYXRlIHdh
eS4gOikKCj4gPiBjb21wcmVzc2lvbiBpbiBzeXNmcy4gVGhlc2UgY2FuIGJlIHJlLWluaXRpYWxp
emVkIHRvICIwIiBieSB3cml0aW5nICIwIgo+ID4gdmFsdWUgaW4gb25lIG9mIGJvdGguCj4KPiBX
aHkgZG8gd2UgYWxsb3cgcmVzZXQgdGhlIHN0YXQgbnVtYmVycz8KPgoKQWN0dWFsbHksIEkgd2Fu
dCB0byBoYXZlIGEgd2F5IHRvIGNsZWFyIGFueSBzdGFsZSBudW1iZXIgb2YgdGhlbSwgYnV0Ckkg
YWdyZWUgd2UgZG9uJ3QgbmVlZCB0aGlzLgoKPiBXaHkgbm90IGNvdmVyaW5nIGFsbCBjb2RlIHdp
dGggbWFjcm8gQ09ORklHX0YyRlNfRlNfQ09NUFJFU1NJT04sIHNpbmNlIHRoZXNlCj4gbnVtYmVy
cyBhcmUgb25seSBiZSB1cGRhdGVkIHdoZW4gd2UgZW5hYmxlIGNvbXByZXNzaW9uLgo+CgpJIHdh
bnRlZCB0byBrZWVwIHRoZSBpbmZvIGV2ZW4gaW4gdGhlIGtlcm5lbCB3aXRoIGRvZXNuJ3Qgc3Vw
cG9ydApwZXItZmlsZSBjb21wcmVzc2lvbiBpZiB0aG9zZSBoYWQgYmVlbiB3cml0dGVuIG9uY2Uu
IFdoYXQgZG8geW91CnRoaW5rPwoKPiBUaGFua3MsCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGlu
dXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
