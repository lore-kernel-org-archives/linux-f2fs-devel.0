Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79F4CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tRBKtdZpdNDAD5cGjbXMq9+RCyqntcjqsbqUz8HYKAE=; b=MNWh9MrLUCPGSPkiDZjkaXOdHH
	lheJpYnkWCN2NWGbGHd5q87sNyPH6oR7oawgJg7bKTeLzEuZX7sGIhXcGd4jqdWxtB6N8LRzWo9Jb
	fXqDFoWW1xThATkLldlWxlBE8XtCLRS24IEk4fBh3WXMnpjxRhKDTDyFtdEgsvJC2JW4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0Yz-0004XF-P4;
	Fri, 15 May 2026 21:59:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0Yy-0004X7-9z
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 21:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tefq8HvM4P5E2wSS3fwKg/uRUohzy18j3qB5eF3vc+I=; b=WiwYm6vyKeIrCjfL0OzvLAXAsB
 ofzi+h59vVBGxnKElg+wkc3lL+9dU0eT3AevnKTz71oOT57fXTccUtEKElII8Q8QDHwfJU8MoI+Cu
 Ua3Uj6oopbR2LHnaw0kjPO4KV7D0iofol9uvMJSk8dkzU3rKznF+IsFl1LO7iId402Po=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Tefq8HvM4P5E2wSS3fwKg/uRUohzy18j3qB5eF3vc+I=; b=DryOVeO6qUu1HI2MKEsUKKaGLf
 Ydc8j1eTBqRVOru5eY/oP6Tz8kmOt6LTWIG2xMmPSmugszLRpNXIfO67af/uoE56SasjVulDD0P1+
 n1p6V7QtP7kwMr8R3J79abBQFtf02LduKXTLzB8tF39USAftQqB/lkJZrSt2pr4/aRQc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0Yx-00029Y-09 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 21:59:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C74B8601DF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 21:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DAAC2BCFA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778882348;
 bh=Tefq8HvM4P5E2wSS3fwKg/uRUohzy18j3qB5eF3vc+I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mlxAZ0IAIzSCHzLngeDmNQ4J6co9JfMfAyyTD56EEM12uxEwPF+d70rIFEgbXNu+t
 nmFWRYoP8nH71/SzDNTwckMpq9wyB25aRToRPAIigrb7jE/X+huxz3wV5weJQEh3lf
 ZsxLaxQxb/gZTw7PSxPLrOv75lNNcS2p2VvYZC9t6B4LYinmg6kLafUf0DfUj6eBpq
 kZXCFWY/C9/weqMV5t5f0tzNqll4Mc26mgKMjPP/M9Z9q4x7BWVbGRpdIXWiR96TOE
 0nKaYS+uAe3dGdJ5WvMJ67+DHS+m1Sv1+QgNDDJhKoqmJOrx70mm+Pc9QAldu7MgQe
 B0cPfkZiG0HUw==
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-65c37eafcbeso837524d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 14:59:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+zIIKB+jdqVjqkDRpOnM71ltkDK7xS285nvB1ByKOsZdFidGnPxqSfPwNMDGjnqPp8/YMrvocATSIHuE3sGRER@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yxav+PsRZdp5LLxCXJRh4UxyoFchx8stJplacC09MBpQAKvcvwf
 mC8p0H4umtDiF5Y2wuvqS1/kH2+QZT0Q+pdlX+a7Wesp3YTrdXxuno2sxjjSFrGfQSoyGw6tzc5
 pV48aPIKXoHucJUJQQJFsuRAGhzSVDRMTzkNArFfOBg==
X-Received: by 2002:a05:690e:4188:b0:65c:477a:2ad7 with SMTP id
 956f58d0204a3-65e22733998mr4980962d50.25.1778882347862; Fri, 15 May 2026
 14:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-12-hch@lst.de>
In-Reply-To: <20260512053625.2950900-12-hch@lst.de>
Date: Fri, 15 May 2026 14:58:56 -0700
X-Gmail-Original-Message-ID: <CACePvbWMpfBo0zSFmMGLh7uxrpL2ugHCmD9xp=FC4aXiv9GYmQ@mail.gmail.com>
X-Gm-Features: AVHnY4JjyLNu3psg3JDksoA1h3sEopdVsiktUSZMp2g3bBnm0ZZ5mBGkhXfViRA
Message-ID: <CACePvbWMpfBo0zSFmMGLh7uxrpL2ugHCmD9xp=FC4aXiv9GYmQ@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0Yx-00029Y-09
Subject: Re: [f2fs-dev] [PATCH 11/12] swap: move struct swap_extent to
 swapfile.c
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

T24gTW9uLCBNYXkgMTEsIDIwMjYgYXQgMTA6MzjigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cj4KPiBzdHJ1Y3Qgc3dhcF9leHRlbnQgaXMgb25seSB1c2VkIGluc2lk
ZSBvZiBtbS9zd2FwZmlsZS5jLCBzbyBtb3ZlIGl0Cj4gdGhlcmUuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KCkFja2VkLWJ5OiBDaHJpcyBMaSA8Y2hy
aXNsQGtlcm5lbC5vcmc+CgpDaHJpcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
