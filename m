Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F07CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxaV3kqYjoxWmbBXv13cGHikFUci1vrc4Kinl1qunF0=; b=TUjYOWqSG1JGboxy7wSg91adAY
	TUQT6HWPsR8syPxy4Wt1DLRDjSW9ywan5SOyIfpoyMttP3GcmFB7iLS1cKwp8nPufPEi3NYN+xOle
	98X4+vfMG8VWfXNvhwZTW52TGWlCDJXXrA/QS2P9AoK7S6t8OTXsefWM+E093GQ6oyRQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO13G-000252-7Q;
	Fri, 15 May 2026 22:30:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO132-00024j-3B
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:30:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1naeqAFqERRgX/gD+rpZA/fNmVhQ5XU4ecUjA+j4urM=; b=VTp0UXqw7EQecoetxe4h+MuHqL
 TP9CY/q/yxA5SL3aSW3lolRH6oW3UCf+Sst3yHP+aPKAYmeqnX07vc8hbpwMA+O+4g6pKlubmheFV
 u0BMKhTfhkkZmUOg8rc9YZ/akqAT8omQXsqrORAOiOxCELYZw8Vhz5AQilsIHe2iPbzs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1naeqAFqERRgX/gD+rpZA/fNmVhQ5XU4ecUjA+j4urM=; b=E/HKTk60Ubumy0aIb5Ohe5+Evt
 zxkg40WrjzRYCLyVh2CYhIK72KA59gJVyoXVjlhAPDTBFjNLwmm4pvg0nBI4tl45xQ996PAw+nMAa
 7wZ1CtG4Rl8+ppl32AqXCjvILwwoNZ24IumRxLqhTcvrzQlsycZ3yPwZ/pjRXH8UZz0Y=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO12w-0003j4-P8 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:30:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E47CB4387D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C160BC2BCB0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778884208;
 bh=ReQtRGN6YCVCM+VLe1SVEp6J++lmzI2ST6cnJuKfsNY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=l1BmAcRSlMtkGR8AS0UI7PMBSsVdeQ+vAfkS1phC7SdTdRHX+BGs4MAQg6DgBmiXA
 d+XKcoVCgyus/I8MJO2S5377iU9wMxI4ndzUMSOH3X0aA5wcic6o9RuVDF3YmW+Cyd
 Rsm0oXBAm3I4KOJJf2LhQe4ro/ZXtPTXTgkhYGdTF1JpalHy6mrdtRIOikrONxR6gi
 khlgGqooS0g8AnPRBVazaVmq7yYCJ19qdANfoofjF9OShgb9otGvgrG9SRWnjQPRsF
 l52n9H+vH0yBViDvJWLpYnNjBc23ogiZTPw0OfmtteiSRyxOR0C1GXSFcVk7sCYfIz
 GNPD2LtwC5Ozg==
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-656d749109cso450368d50.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 15:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8Vz+xuXyTfzY54Rlg5JHP80f6GV61WWXXvnOaHLoakBaTtF+a+KXekRyLkAtySo06QT57WOXAXeHZkC4EPz970@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzPSgY2CdismnIbnwp9ahD4F+QpzckHUtKXyoVEEkssar89Sx14
 sa7NCwxHHSdS+HuzEPG5p2pNqpmN696xqre11N3wGELBcGHiaqY8s4DsahCrGP9eWTorfwxme0J
 TDOrqMwP4CTMPo1mTqxfiF4JPxgllVIrag25kFFE2tw==
X-Received: by 2002:a05:690e:480f:b0:64e:597a:f5c2 with SMTP id
 956f58d0204a3-65e2289a39cmr4822587d50.65.1778884208163; Fri, 15 May 2026
 15:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-3-hch@lst.de>
In-Reply-To: <20260512053625.2950900-3-hch@lst.de>
Date: Fri, 15 May 2026 15:29:57 -0700
X-Gmail-Original-Message-ID: <CACePvbUPQ=tO5feC=2-8XdBV1PgzoX+EwASU__jNiuzcGsPMPA@mail.gmail.com>
X-Gm-Features: AVHnY4KVT3GwVUdlKXUpf18PwWGpkgh1B7IPlKLHiB6TxVcw3NQNEM73-FjKVDw
Message-ID: <CACePvbUPQ=tO5feC=2-8XdBV1PgzoX+EwASU__jNiuzcGsPMPA@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO12w-0003j4-P8
Subject: Re: [f2fs-dev] [PATCH 02/12] swap: move boilerplate code into the
 core swap code
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

T24gTW9uLCBNYXkgMTEsIDIwMjYgYXQgMTA6MzbigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cj4KPiBNYWtlIHRoZSBjb3JlIHN3YXAgY29kZSBjYWxjdWxhdGUgc2lz
LT5wYWdlcywgbnJfZXh0ZW50cyBhbmQgdGhlIHNwYW4sCj4gcmUtc2V0IHNpcy0+bWF4IGJhc2Vk
IG9uIGl0IGFuZCBkb24ndCByZXF1aXJlIHBhc3NpbmcgdGhlIGN1cnJlbnQgb2Zmc2V0Cj4gaW50
byB0aGUgc3dhcCBmaWxlIHRvIHN3YXBfYWRkX2V4dGVudCBhcyBhbGwgdGhhdCBjYW4gdHJpdmlh
bGx5IGJlCj4gY2FsY3VsYXRlZCBpbnRlcm5hbGx5LiAgQWxzbyB0cnVuY2F0ZSB0aGUgc3BhbnMg
YmFzZWQgb24gdGhlIGF2YWlsYWJsZQo+IGluZm9ybWF0aW9uLgo+Cj4gQWxsIHRoaXMgcmVtb3Zl
cyBhIGxvdCBvZiBib2lsZXJwbGF0ZSBjb2RlIGluIHRoZSBjYWxsZXJzLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CgpWZXJ5IG5pY2UgY2xlYW51cC4K
CkFja2VkLWJ5OiBDaHJpcyBMaSA8Y2hyaXNsQGtlcm5lbC5vcmc+CgpDaHJpcwoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwg
bWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBz
Oi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
