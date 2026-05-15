Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F011ECD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 22:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vp9oaLSkvbJqB6Sh1wkLaoINCPPAqbMfmSIqoMbwORM=; b=FebbWQM3Mw/aHrQJ5JM3ORL4Ct
	Sdm6qfGEM8CXOi6/KwAMkycsZY0bvEKoPckMtx40kcxMO8MW6RtDyMsSWL9PeGP0mp28IJfQ7Of8A
	UbNeg1QL6XmQp/r0AWFcJ/wFDQUlXgsF9Ao5WflniN7R61gYkccn7OycB6c8vKLX2sQc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0xT-00057z-La;
	Fri, 15 May 2026 22:24:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0xS-00057s-Um
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:24:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Et6+E/4u8tPTTTpLDHIBdHbpFsEpY+ts+wzQVI+pdX4=; b=ToL7Dq0s6ueePctxz47MUuchPC
 brGPBh3OH5nc0mLpqJEJ3d4UHdQ7t784k3CAyG5xj7nbnt23SxHSv6wt4+3HTfNQyFO/P+Fsu21oY
 sG5tjaCSjGH0K41/K5e5xenmsZk+0iVsA6qPlLK/qH8DLONvZ25abOIQibVpKqIHY0P8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Et6+E/4u8tPTTTpLDHIBdHbpFsEpY+ts+wzQVI+pdX4=; b=UjU883X8f1Bal6buvW8xCXmgkB
 U5SOJH0x3fhQ8zb1QtrjwUsDwa78T6tTYNg0cj7OAP9ypO8N/I4PNAnm5MD2rRTOanyqBSUHAEFvU
 36g+xArPd7K5vfAGwpQYC+HkkR3EOYlb9nhEnGcyFaPUzjtdFllOScef+FBVX/Xwolt8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0xS-0003Tc-PR for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:24:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E643B445C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE7DC2BD01
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778883868;
 bh=CQjBHE398jfmQc9Nk7uTNv+8vscqO8uzAxJfVr6TjOw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=I75LpWDrE4HspM1Nom8QNNiBxvvPPC1Z/wA25yBCJ/4enl3WTmrgj8AZMjhk2O/xG
 yshsfHF9WvD9zWHVLpX9AeHo3Ri3ddj1aGewMbBUU8ZueR0ecjlr9Q0zOirV60mTuL
 Blg8dz0+peaFU83cqwIw+GtehBIoilyr1JVfpLfi/1DhIwPgar4tiP57UNiR2Z6RXb
 jJG0DtJ2+JgFoQLnfeXEZOoydPFpzXHXPWSjEyaxuisnvQztS1Uw/mSHrNECrgkznS
 jVFyqqaY/Np9buMNHRC3bZWYDATHC2YK2s+ERM+sBFNsc5fqz/AcPMBEuFWjFE7Hyy
 AhPRursx/3ldg==
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-654672a6d68so720726d50.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 15:24:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/QwXB9fq22ZLNpHbUH38VNlPh3jWk+GA5gcF5WE/quaamd7TwtpZa6XjvXBKVgSzdn3jU5jT2UPTIWlK+yWlMy@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzhhcFwSZMc6tWex/FzUM74TVHXnZyqfWRwBO8aMWqEwMdKJ7Z5
 rGwDmHHuXMcE7lcn+cBeITndVLCIoFKqHmdYnJV6ME3hloRAd7WA7YDUl2ReKxf1OB111nfmwfc
 7yWWJOc3MrgGyE0iis1M8pi+TIpB66svTUfktxgnMzg==
X-Received: by 2002:a05:690c:c504:b0:7b8:926e:3ef4 with SMTP id
 00721157ae682-7c9599a3c98mr72668207b3.17.1778883868040; Fri, 15 May 2026
 15:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-4-hch@lst.de>
In-Reply-To: <20260512053625.2950900-4-hch@lst.de>
Date: Fri, 15 May 2026 15:24:16 -0700
X-Gmail-Original-Message-ID: <CACePvbVmxUVVZLd=hUnzjRLtt3hBWRxemR_YQZCVSYYNadiAUw@mail.gmail.com>
X-Gm-Features: AVHnY4K8odfW_w5Sv5zxMaAGvoOSmdsLHmORiA0lm6BrpYzORI9rYZ53g2APvuQ
Message-ID: <CACePvbVmxUVVZLd=hUnzjRLtt3hBWRxemR_YQZCVSYYNadiAUw@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0xS-0003Tc-PR
Subject: Re: [f2fs-dev] [PATCH 03/12] swap,
 fs: move swapfile operations to struct file_operations
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
From: Chris Li via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chris Li <chrisl@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Kairui Song <kasong@tencent.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 linux-btrfs@vger.kernel.org, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBNYXkgMTEsIDIwMjYgYXQgMTA6MzfigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cj4KPiBUaGUgc3dhcCBvcGVyYXRpb25zIGhhdmUgbm90aGluZyB0byBk
byB3aXRoIHRoZSBhZGRyZXNzX3NwYWNlLCB3aGljaCBpcwo+IHVzZWQgZm9yIHBhZ2VjYWNoZSBv
cGVyYXRpb25zLiAgTW92ZSB0aGVtIHRvIHN0cnVjdCBmaWxlX29wZXJhdGlvbnMKPiBpbnN0ZWFk
LiAgVGhpcyB3aWxsIGFsbG93IG1vdmluZyB0aGUgYmxvY2sgZGV2aWNlIHNwZWNpYWwgY2FzZXMg
aW50bwo+IGJsb2NrL2ZvcHMuYyBzdWJzZXF1ZW50bHkuCj4KPiBQYXNzIHN0cnVjdCBmaWxlIGZp
cnN0IHRvIC0+c3dhcF9hY3RpdmF0ZSBhcyBmaWxlIG9wZXJhdGlvbnMgdHlwaWNhbGx5Cj4gZ2V0
IHRoZSBmaWxlIG9yIGlvY2IgYXMgZmlyc3QgYXJndW1lbnQgYW5kIHVzZSBzd2FwX2FjdGl2YXRl
IGluc3RlYWQgb2YKPiBzd2FwZmlsZV9hY3RpdmF0ZSBpbiBhbGwgbmFtZXMgdG8gYmUgY29uc2lz
dGVudC4KPgo+IE5vdGUgdGhhdCB3aGlsZSB0aGUgdHJpdmlhbCBpb21hcCB3cmFwcGVycyBhcmUg
bW92ZWQgdG8gYSBuZXcgZmlsZSB3aGVuCj4gYXBwbGljYWJsZSB0byBrZWVwIHRoZW0gbG9jYWwg
dG8gdGhlIGZpbGUgb3BlcmF0aW9uIGluc3RhbmNlcywgY29tcGxleAo+IGltcGxlbWVudGF0aW9u
IGFyZSBrZXB0IGluIHRoZWlyIGV4aXN0aW5nIHBsYWNlLiAgSXQgbWlnaHQgYmUgd29ydGggdG8K
PiBtb3ZlIHRoZW0gaW4gZm9sbG93LW9uIHBhdGNoZXMgaWYgdGhlIG1haW50YWluZXJzIGRlc2ly
ZSBzby4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgoK
VGhhdCBtYWtlcyBzZW5zZSB0byBtZS4gSSBhY2sgZm9yIHRoZSBjb3JlIHN3YXAgcGFydCBvZiB0
aGUgY29kZS4KCkFja2VkLWJ5OiBDaHJpcyBMaSA8Y2hyaXNsQGtlcm5lbC5vcmc+CgpDaHJpcwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
