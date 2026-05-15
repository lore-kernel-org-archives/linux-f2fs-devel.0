Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D32ACD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1rC0E6M1vlLB/FEPo9wLlZeH19flzi/ixCJNF1DTjI=; b=IYpjGC039ZhLpZiV7uwgnwyUdd
	cuVJ1LOPLtTjsECLEl9vN8abMK5grYDYSAPI1e+h3WPR3DBICGiCEI5IMHToZSjscGg94++REP+J3
	Iob+T2WINNs93TPUdCb1wBGyaEf6CL5NsWFKzII5H0VhCi6PKgeFS8n+2hfl6wUsQgns=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0s6-0005F4-2W;
	Fri, 15 May 2026 22:19:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0s4-0005Ep-G5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nLOP4eZBjEsFOJKb2AlLdYmcbjxfM6qIcB/R7/H5A5s=; b=BwpNg+pred738FYB4gl596K2wb
 LlMNWQNqRkKG7vXXJaCKRVwbcW2/c2/+Ub/zKlZjDdzAJhpY72S6sTqaLN9AmMYjCBb5kttWt/CNE
 laOPvp1Av9B0qY6g2/ROJhtx6kwMSS7Rw1oI6zNzsls6LOKrMgxxrREmGRyAB1FFXOiM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nLOP4eZBjEsFOJKb2AlLdYmcbjxfM6qIcB/R7/H5A5s=; b=IAaLR8NaRvmQlm6VG43Rp3T3NH
 fw//BSgEhkHKNz0vtQNr3YYzv5Loq37bSdwkdWRZPj08VL0U/3RqwEsG64u3cRMRua2+4kpWVSZik
 wf4YIk2T0/qjOhdfUcAhvJyOYDR/dOmMyPA9fBotl4itJDBDopzl9mv/nLRqqwD6l+f4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0s4-0003DW-CC for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:19:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4212F445D9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BC7C4AF0F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778883534;
 bh=1MhrEcqiffOJJ9gu4tKqW5/j2FFYBdwL8v/OjHOXbE8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GTicYoCI2yr2rAe/AMU6ocS3i7LeGzP+5ynLWd/haZ7OK8z5QsL08GhRu4vI6vNmU
 /3SJUN65uYsO6Z6W57GiFhyamzuFs+17wJ2EPj9kxjsYdcXZy+4OY7C4TydzVuwIdP
 cqcIdDzhU29K9Oe1AlyD+O5jJc4jbWA6EeBEkcwAcnD95DXjA85X87gsLYpVZ0Vl+v
 s9ouykehmJF23xqYyIAgLfZ+jgPUx5hix68bt162AGCCbP31GBjIV+8LsNDU1NS6dl
 g1UnI8kJdJjySSQvW8vM9rhm8ucv7sproY87J44pKcG2J+gIOgiTGJhOMkBLiDtpqr
 b/+lLlGeQOBKw==
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-651bc83e74aso693078d50.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 15:18:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+mHbZU37XqL2Y1YH1BTgFmXfB07H0eAdWHVfiqNpcFueEcpJ4GnVU6u0oO5YwlIhOVORZl2AxmKb7krLaRKYFK@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzN1a6voVUoYzDYNh0bTncL4ReZOBrpKKQRrQJ3/f+O1+9tQ6qy
 9Lc7RwS2TnTA50TZybcETB7ix5Wh9NZAh78j9ANDUia9lJ0mIzOLDRpX9+OlPzSDtBWH16kEGFl
 sP/My9lf0yXt7kr8lnWzaGFAGq7bDruayrqQsxlKdsg==
X-Received: by 2002:a05:690e:2513:20b0:651:cd15:8c67 with SMTP id
 956f58d0204a3-65e226e2fb9mr5283044d50.15.1778883533149; Fri, 15 May 2026
 15:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-6-hch@lst.de>
In-Reply-To: <20260512053625.2950900-6-hch@lst.de>
Date: Fri, 15 May 2026 15:18:42 -0700
X-Gmail-Original-Message-ID: <CACePvbUpuNF9VsFUnmGpSwA9mHERG9fAxqezO=gdLzU99gpEdw@mail.gmail.com>
X-Gm-Features: AVHnY4IEAMD4CIhbQwbpq5_x4qZkKrPnDwnZZ2hkgP66BNy2UiBnbzLNgfCVsSA
Message-ID: <CACePvbUpuNF9VsFUnmGpSwA9mHERG9fAxqezO=gdLzU99gpEdw@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0s4-0003DW-CC
Subject: Re: [f2fs-dev] [PATCH 05/12] swap: cleanup setup_swap_extents
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
QGxzdC5kZT4gd3JvdGU6Cj4KPiBSZWZsb3cgc2V0dXBfc3dhcF9leHRlbnRzIHNvIHRoYXQgdGhl
IGZsYWcgY2hlY2tpbmcgaXMgbm90IGNvbmRpdGlvbmFsIG9uCj4gYSBzd2FwX2FjdGl2YXRlIG1l
dGhvZC4gIFRoaXMgaXMgY3VycmVudGx5IGEgbm8tb3AgYmVjYXVzZSB0aGUgc3dhcG9mZgo+IGNv
ZGUgc3RpbGwgY2hlY2tzIHRoZSBwcmVzZW5jZSBvZiBhIHN3YXBfZGVhY3RpdmF0ZSBtZXRob2Qs
IGJ1dCBpdAo+IHNpbXBsaWZpZXMgYWRkaW5nIGEgbmV3IGNoZWNrLCBhbmQgYWxzbyBtYWtlcyB0
aGUgU1dQX0FDVElWQVRFRCBmbGFnCj4gbW9yZSBjb25zaXN0ZW50Lgo+Cj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CgpBY2tlZC1ieTogQ2hyaXMgTGkgPGNo
cmlzbEBrZXJuZWwub3JnPgoKQ2hyaXMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZz
LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5l
dC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
