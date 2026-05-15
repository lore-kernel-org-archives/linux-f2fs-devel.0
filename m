Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D2DCD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BrPb0ln3OOUC8NkV+ffErvGjXCLvJSmJmenyEoLYdzw=; b=g11im6AmKCDHj0QeQOUuNo7HPp
	0zPnPwEEkvt8dTQA7MwuG2+99CmK5WGxAkewQeR/lka0sgHcQ3tAlTi5jTXQOxYRR8yz1cDp48FTI
	kSqH7g1x9RxYMhVllL6B/fcVqT0ESEOo8jYnJx+c8dHOqRn4wLkU9DSIuB5LQSGgXGS0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0av-0004bk-8R;
	Fri, 15 May 2026 22:01:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0au-0004be-4g
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Da1KZpOjYE8D68IakmHMLRFYpruCGLnO4oj2vfewy4A=; b=MQGwtHRKv0ntO2/No4eqsVnTUo
 4NezjMIJ7B7fk4Reozp5ULKbj/gmLt12AFdZmzX6dv/gcEOIZKsjnBuJ6bc213oCXog9z0MN6SGlt
 IMYo+fzSBNJ/FBU9L9zkpZmAn/eMmW01HYjrAjlh9roF9m6AdqMHO1KHXuRADVndAo0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Da1KZpOjYE8D68IakmHMLRFYpruCGLnO4oj2vfewy4A=; b=OZxlmf+ooBuqq6WrtIYy/huO0I
 2CPuk45S667iq2cSQznlifZUPO2hvMCOUnQSZu0NykzgLJxfMELSUpREp9qkwNWjcNM7E2ByNhkxn
 ezFv3Uq9YENfmlNeKu0b1sqms0qo3nt3dqXjBNmXFSAoj2ON0yluHxfsd7OVDJXx81cA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0aq-0002K1-4x for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:01:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CAA54405F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:01:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EAF2C2BCFB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778882466;
 bh=8FzUPImWV18kvph4lTxQrEFg0N5DGTFbvVX3bryYp3g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VnxyRqbTDYx6GgcrEkNlGe2hGiAg4yRf75lATHoVW0PpFzHCCZ+JgXUyuTTzFzYbZ
 nNFOXRco11MWvh1JDJOczfjW/o82VAln7pHQl4C82nUu1ViOis3SosrtDwHSbeQ5h2
 7hh5YIRfWUUE01drL01kz1ymKoCuIOuYafR/+moxrWHGCFsIPM/YwkCOoOMPR2BW2F
 sEFBWfkOLqEDVYWBgUv069lwh+x4UOBR3ulzyYJOKkob68jjmMKdwTenYe8GkABinC
 7xFMM9GSsMSLs+ZAmcpTxsTv3F41hHwR75Z87TBgh2LyaBVb9TXRTx2e7ts+Cg9SFX
 aQUiJr4F/vybw==
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-6579254f996so476058d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 15:01:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/cwPrtukIafykTCDKgleffBsL8ieM0MFXGk8ey/TWn5HhPvYVebWI2p39q9XEjmQDW/01JMu9Lq6+R2XZl+exE@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxf9CEinnAakYutTEaipF/LnOrES4zcmxnPvfzN96KNPfEe2hN1
 F2lEx3uxo8R3NER+Vx7AZpxyD7RFLN3WuyTldyoJptxsvqOpXD940VtN87VDu4bG1wFwxQqNYaX
 iMNAjHcUTW6uOZ43IBZFRMfEQCPJvivYM1p6MIRF7xQ==
X-Received: by 2002:a53:accd:0:20b0:654:468c:7dd5 with SMTP id
 956f58d0204a3-65e2280d9e5mr5432439d50.33.1778882465457; Fri, 15 May 2026
 15:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-11-hch@lst.de>
In-Reply-To: <20260512053625.2950900-11-hch@lst.de>
Date: Fri, 15 May 2026 15:00:54 -0700
X-Gmail-Original-Message-ID: <CACePvbXY5sdG=JXV2TE65NAWaEQ975wHhcGGzuFg5mRECkwy+Q@mail.gmail.com>
X-Gm-Features: AVHnY4LoQkrm9-GqAeD5m6WwSsE12ARR5KdnPZLUwdKcGhFx_HvxcMbpEFa8lE4
Message-ID: <CACePvbXY5sdG=JXV2TE65NAWaEQ975wHhcGGzuFg5mRECkwy+Q@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0aq-0002K1-4x
Subject: Re: [f2fs-dev] [PATCH 10/12] swap: add a swap_activate_fs_ops helper
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
QGxzdC5kZT4gd3JvdGU6Cj4KPiBBZGQgYSBoZWxwZXIgYWJzdHJhY3RpbmcgYXdheSB0aGUgbG93
LWxldmVsIGRldGFpbHMgb2YgZW5hYmxpbmcKPiBmc19vcHMtYmFzZWQgc3dhcHBpbmcuICBUaGlz
IHByZXBhcmVzIGZvciB0YWtpbmcgc3dhcF9pbmZvX3N0cnVjdAo+IHByaXZhdGUuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KCkFja2VkLWJ5OiBDaHJp
cyBMaSA8Y2hyaXNsQGtlcm5lbC5vcmc+CgpDaHJpcwoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0Ckxp
bnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
