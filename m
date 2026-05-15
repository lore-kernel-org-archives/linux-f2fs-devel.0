Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB30CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 21:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nTjpmRdj9o0iru9qLIXOKEBt2uTm8/Mz2rvAc2RnwZA=; b=V6olfMhXF2Q2BbVtfheFDv1DZf
	D8wipBm7SRYMkm5JNLVPrZIjDIh9CuaaMWhMJZ9zJQiIlLg9ct4Q9vEzdTMtqRjsKDMPANfV35qj3
	if0fX5NpV7XNp4Wa5xAnx+gOlpuTba1Btwbew6atnnDBkNt44vJHQeWX0iRFFAcJMAEc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0H7-0001cJ-2i;
	Fri, 15 May 2026 21:40:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0Gq-0001ad-1P
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 21:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ut7AANN5nElwKGLUY0lhnbp+1RRiqivwknCkUgAInnw=; b=Gz7nSOLOiipO57sPMOsgEvmT9s
 CC/sw4vBeYrDbHxDP1olNE+sFC8oHIOwDIfW/k8W0tQIV6qXlQAJKEcjy9SMOe1XLUCblDPBu/rgp
 m/BYn9pXddw6qMxfDEQWMeFpoPztE5exPYnMk917ZSypaV3Y6zhKYTOVk4LupilQe3dE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ut7AANN5nElwKGLUY0lhnbp+1RRiqivwknCkUgAInnw=; b=VRCacOWiM1ZVJvCA0nqmg0z2Fa
 3yLUyeXHomRu8Elq43+3gOe2IDBHxci+XUkGgKpWbZRYCamtgAAilTVZinQgb6RXn/XsKN6AUPmCo
 wZ0EOdcbye44a47h563kjASiRBZBn4Od0hjLVAnI+ykcIAhePXh6yQ8NL9f4Zbjxz3hI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0Gl-0001Dd-UZ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 21:40:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AD7E44493
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21219C2BCFB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778881221;
 bh=yn5Ug5k2IASPmOnTWh5/NWKfju83Ji8V+BAWrGXvmqg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qpCqy77UuxiJP5M69OT6OBhAi0drLyRIk9VrbL5PImuXKJVo+W1DGL1GTxyvwm/Ap
 qYwzicA0HugWD3WdRdaqiY/qERdDF+qJ1yrOi80dBJMJ2lOnTNbAjGt057QXURnpdu
 byM7OJvl/hvAMzB6gwZFP0SMXkNkbAhxODh/esykup4ZKSL6tD6QWIL7kRkgiCrvWQ
 4c8rjPGv/7SheIbtlwMVjNkzW+2nRHjSPzGcpbRyqvRlyvup2g26IG+XkmKklpY6Od
 D52c5rAlfSSCPy8Y7KdIS36um5pUDXFrzSJ2loLdDZtVaLknB5oRahkX+Msz7ANBRB
 9GuEtMCHC/EQw==
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6530287803cso611966d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 14:40:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9S7Ssm1ucnzcSfbiBBf0zTiFXyBiJ2Me8/jRoRuwzVqqbwQqyak+qFCcOecaK6cmWtfDprUj6OtNjIMTj3tYee@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzGaN8Wni7EZ3c5cMEOfPShNG+pPBqz0e/AsTJAiZcUZ5pV5jyj
 EUNJ3lFx3d6PMg+OJoke8XPzph2ytsCNXWgOMBtzRX95yotoaMlcZHD7yLyVrNhd98UwRiEFzDQ
 56Rt2EZGYQBW307C+wpA+tcct8ilW07dc/a5nRAuXNw==
X-Received: by 2002:a53:accf:0:20b0:651:d6a2:f766 with SMTP id
 956f58d0204a3-65e227bae88mr5109450d50.35.1778881220197; Fri, 15 May 2026
 14:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
In-Reply-To: <20260512053625.2950900-1-hch@lst.de>
Date: Fri, 15 May 2026 14:40:09 -0700
X-Gmail-Original-Message-ID: <CACePvbUj0-fAd-gjRjxFXYz22hGQaT9upFL85KUqD=W=SWX+0Q@mail.gmail.com>
X-Gm-Features: AVHnY4IVYDXe6JpHvzKEq9XldjgLC8IpryDPCEhie3HNTVfz3whVFC9mf8Ia0bI
Message-ID: <CACePvbUj0-fAd-gjRjxFXYz22hGQaT9upFL85KUqD=W=SWX+0Q@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0Gl-0001Dd-UZ
Subject: Re: [f2fs-dev] improve the swap_activate interface
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
QGxzdC5kZT4gd3JvdGU6Cj4KPiBIaSBhbGwsCj4KPiBEYXJyaWNrIHJlY2VudGx5IHBvc3RlZCBp
b21hcCBzdXBwb3J0IGZvciBmdXNlLWlvbWFwLCB3aGljaCB3YXMgdHJpdmlhbAo+IGJ1dCBhIGJp
dCB1Z2x5LCB3aGljaCB0cmlnZ2VyZWQgbWUgaW50byBsb29raW5nIGhvdyB0aGlzIGNvdWxkIGJl
IGRvbmUKPiBpbiBhIGNsZWFuZXIgd2F5LiAgVGhlIHJlc3VsdCBvZiB0aGF0IGlzIHRoaXMgZmFp
cmx5IGJpZyBzZXJpZXMgdGhhdAo+IHJld29ya3MgaG93IHRoZSBNTSBjb2RlIGNhbGxzIGludG8g
dGhlIGZpbGUgc3lzdGVtIHRvIGFjdGl2YXRlIHN3YXAKPiBmaWxlcyB0byBtYWtlIGl0IG11Y2gg
Y2xlYW5lciBhbmQgZWFzaWVyIHRvIHVzZS4KCk15IGZpcnN0IGltcHJlc3Npb24gaXQgbG9va3Mg
dmVyeSBwcm9taXNpbmcuIEkgd2lsbCBuZWVkIG1vcmUgdGltZSB0bwp0YWtlIGEgY2xvc2VyIGxv
b2suCgpCVFcsIEkganVzdCB0cmllZCBpdCwgdGhpcyBzZXJpZXMgY29uZmxpY3RzIHdpdGggS2Fp
cnVpJ3Mgc3dhcCB0YWJsZQpwaGFzZSBJViBzZXJpZXMuIE1pZ2h0IG5lZWQgdG8gY29vcmRpbmF0
ZSB0aGUgbWVyZ2Ugb3JkZXIgd2l0aCBLYWlydWkuCgpDaHJpcwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
