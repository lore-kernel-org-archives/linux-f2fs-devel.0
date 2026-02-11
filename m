Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316ABE9E30A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Feb 2026 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YNcdSofHaz1/mAfX0SnL7Z5HY/lN7sHgFvbcruPYp9I=; b=DgKmBoOIDypACm/mI9OBNUapmf
	nyBqhdCMVAeRetNvwdeWrv14/eSbKlOLZmel0lZ1R1ACN+s17qUNZJn54iW9p0/2Uwy2Zz/WKFH/t
	ZL4W12DtLiIxlkZtfDn49O2VTWPhE6icRbKYZC5fnFO9wm6IqLir2vqXHw36KnXoiovQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vqAbl-00013D-To;
	Wed, 11 Feb 2026 13:50:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <agruenba@redhat.com>) id 1vqAbk-000137-Fs
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Feb 2026 13:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=; b=X6/SKq2RklDtpVMACWO+jOm7Ym
 t0zybdP2sLZSNFv8J5sg4EQWL8OQ6uCfee0YX4qjJOGBi6V1497FlNuvyXDCBTOaEx7KqG+VsF7ST
 eCxXUGni1XZtkfaQD5Zw0M39IVK1c4XJ9xKmc5r6lWEvjGB8G6yldVLjNgqZVl5WyLZ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=; b=Yv6Y18/IBOYaFzg5BtgCxM4g5R
 OIzATa4BQMT/G6Fnn5TfpBxylPV6loJibVX3LRdsYVwqSmKCfaxAQAA55t7fhgZEj5lmE4eHPlI7z
 syf32QF/ZSIKtIxdCsoZSLoVrHRlSNTABETPBDcTMXo+2f3PJEZvclUWW2vZbvn9hPmM=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vqAbk-0007Is-0g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Feb 2026 13:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770817808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
 b=eR/238IGT8jTn4sdPWxALomPmhLJ9TURIwDpwULelgISUfh6cqH8X1crohw0mHWW/lNjvl
 T1qFo/+ac+nIyVJ4EaHIKdxRCXFctPOW6tf0VbfW/4LtHituayTA16vcBVhzk6Tt6cczt7
 kDDhKE9484QaK8E8UGqkQRw7oqre8JI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-u3pM6u9kN--tllxTBGh28Q-1; Wed, 11 Feb 2026 08:50:07 -0500
X-MC-Unique: u3pM6u9kN--tllxTBGh28Q-1
X-Mimecast-MFC-AGG-ID: u3pM6u9kN--tllxTBGh28Q_1770817807
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79431a41d9bso112365937b3.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Feb 2026 05:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770817807; x=1771422607;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyGxR5LQHMgd3AjzZ3ErlH/2lpT7HfDqYV4EqF+AD+E=;
 b=Q0rgG4JiXegMwGCL6DGefQFWWYAup6+Bujcuo/BfvVw6V/oCmgcQ41EUpDmK3JECgF
 hojPUap8jEC64LNr5TCcpuwStIJ3M1DEH2Q8hEoVEKCjkGdltH4j8u3NrreIrprKmcFy
 UL45E9cGKyXRIECbk8jJYt2y2uS6w9rYx/Op3ut3ezFlWii8KasK43rzai7C25JQySTl
 8hZVjoiJXdb0PnmKoOMt42yBe23ZT5ehwEbYvIgomwqUQ+qLTfndQ1PSr3elvCJiFVXw
 SrTeAeGccPxzUjJgSeqeab0tbQeCK9go8sTd/VlSnH5Y1XxaqaGU8UwGFQkHU7SeqwuF
 mi0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCwB/WB8U038mBeYVfruWf8SZlFA0qGbdorks5O2MLBmqxh/hdreWuvYgM2s9PZ59BwIogqQeATbe2VlVh13Gi@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxi/7GNQlQ1iWGuyMyfZR95xt/SbM0jordXeMYLxzN67rKHClvJ
 Tw46vre2ZfzEyD8jm0ScBISxdfIP23Dy+gPHZpB4BSzj98cf104V/A4AhZTYfGqzN5AriNGUBpJ
 SCjU3r9ywFwHHOpjvVnzCI1fuMnXo9MDrpflNYdUJ8Z7FOvXvLSUdA3enzYsdjPHdM2zvhy+AeM
 zTUpA2fwMYBnD8RJ4YxtQQD8vEjPm+Op3ymosujVBBnpmOTlgqwHI+nA==
X-Gm-Gg: AZuq6aIE2X8dYYW727nL2RAjvu08LKNKQBDkpxt2u60Q2rAwK200V2qNS012Uga6yzL
 WIA3I59y13AFGTUe7hrcYoCrb4f38Ng+u5mu4fDgT6p/RUkgIax2NmxRjft8uc1ZcRwdbe4Afxc
 T2yJ4gFOudduVOgOd/rxwY3g1SplwM+bP7Q8oolNmgzPdQendpHmDNXrrvuCodsM6QQxkobrPbn
 JE/D7pd8z1XQpEamoM+KTf8yjHBBcI2dKf9LZuBgQoKKbMYrtrlqAa9x5AOjKKgmQ==
X-Received: by 2002:a05:690e:dcf:b0:64a:dd9d:e944 with SMTP id
 956f58d0204a3-64afe30abbcmr1311187d50.25.1770817806894; 
 Wed, 11 Feb 2026 05:50:06 -0800 (PST)
X-Received: by 2002:a05:690e:dcf:b0:64a:dd9d:e944 with SMTP id
 956f58d0204a3-64afe30abbcmr1311156d50.25.1770817806461; Wed, 11 Feb 2026
 05:50:06 -0800 (PST)
MIME-Version: 1.0
References: <CGME20260211070533epcas5p32f50f317b20250bb61b1b5a0b3a2a5d9@epcas5p3.samsung.com>
 <20260211070057.22001-1-kundan.kumar@samsung.com>
In-Reply-To: <20260211070057.22001-1-kundan.kumar@samsung.com>
Date: Wed, 11 Feb 2026 14:49:55 +0100
X-Gm-Features: AZwV_QjumAFlbk9ZsPEeDmvoG4FkvqsDNDq1VBbfmeKSRae7isamuXkM1GDbV04
Message-ID: <CAHc6FU4O4YTm-0cU+kpqY2L3BRaA_Jsyh20tTk2KjmGN7-kKCg@mail.gmail.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0vFFgSU0HkUgnkGd_eOwjncA2JIjWvxP6TeyE4j2hXo_1770817807
X-Mimecast-Originator: redhat.com
X-Headers-End: 1vqAbk-0007Is-0g
Subject: Re: [f2fs-dev] [PATCH 0/4] Avoid filesystem references to writeback
 internals
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
From: Andreas Gruenbacher via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: brauner@kernel.org, jack@suse.cz, pankaj.raghav@linux.dev,
 djwong@kernel.org, anuj20.g@samsung.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, gfs2@lists.linux.dev,
 mcgrof@kernel.org, viro@zeniv.linux.org.uk, anna@kernel.org,
 gost.dev@samsung.com, jaegeuk@kernel.org, vishak.g@samsung.com,
 linux-nfs@vger.kernel.org, hch@lst.de, trondmy@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBGZWIgMTEsIDIwMjYgYXQgODoxM+KAr0FNIEt1bmRhbiBLdW1hciA8a3VuZGFuLmt1
bWFyQHNhbXN1bmcuY29tPiB3cm90ZToKPiBUaGUgc2VyaWVzIGludHJvZHVjZXMgd3JpdGViYWNr
IGhlbHBlciBBUElzIGFuZCBjb252ZXJ0cyBmMmZzLCBnZnMyCj4gYW5kIG5mcyB0byBzdG9wIGFj
Y2Vzc2luZyB3cml0ZWJhY2sgaW50ZXJuYWxzIGRpcmVjdGx5Lgo+Cj4gQXMgc3VnZ2VzdGVkIGJ5
IENocmlzdG9waCBbMV0sIGZpbGVzeXN0ZW0gY29kZSB0aGF0IGRpcmVjdGx5IGFjY2Vzc2VzCj4g
d3JpdGViYWNrIGludGVybmFscyBpcyBzcGxpdCBvdXQ6Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI1MTAxNTA3MjkxMi5HQTExMjk0QGxzdC5kZS8KPgo+IE5vIGZ1bmN0aW9u
YWwgY2hhbmdlcyBpbnRlbmRlZAo+Cj4gS3VuZGFuIEt1bWFyICg0KToKPiAgIHdyaXRlYmFjazog
cHJlcCBoZWxwZXJzIGZvciBkaXJ0eS1saW1pdCBhbmQgd3JpdGViYWNrIGFjY291bnRpbmcKPiAg
IGYyZnM6IHN0b3AgdXNpbmcgd3JpdGViYWNrIGludGVybmFscyBmb3IgZGlydHlfZXhjZWVkZWQg
Y2hlY2tzCj4gICBnZnMyOiBzdG9wIHVzaW5nIHdyaXRlYmFjayBpbnRlcm5hbHMgZm9yIGRpcnR5
X2V4Y2VlZGVkIGNoZWNrCj4gICBuZnM6IHN0b3AgdXNpbmcgd3JpdGViYWNrIGludGVybmFscyBm
b3IgV0JfV1JJVEVCQUNLIGFjY291bnRpbmcKPgo+ICBmcy9mMmZzL25vZGUuYyAgICAgICAgICAg
ICAgfCAgNCArKy0tCj4gIGZzL2YyZnMvc2VnbWVudC5oICAgICAgICAgICB8ICAyICstCj4gIGZz
L2dmczIvc3VwZXIuYyAgICAgICAgICAgICB8ICAyICstCj4gIGZzL25mcy9pbnRlcm5hbC5oICAg
ICAgICAgICB8ICAyICstCj4gIGZzL25mcy93cml0ZS5jICAgICAgICAgICAgICB8ICA0ICsrLS0K
PiAgaW5jbHVkZS9saW51eC9iYWNraW5nLWRldi5oIHwgMTEgKysrKysrKysrKysKPiAgNiBmaWxl
cyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4KPiBiYXNlLWNv
bW1pdDogMDVmN2U4OWFiOTczMTU2NWQ4YTYyZTNiNWQxZWMyMDY0ODVlZWIwYgoKU3VyZSwgdGhh
dCB3b24ndCBodXJ0LgoKUmV2aWV3ZWQtYnk6IEFuZHJlYXMgR3J1ZW5iYWNoZXIgPGFncnVlbmJh
QHJlZGhhdC5jb20+CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
