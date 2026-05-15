Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A95CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 22:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pt/FgRRMygFbKF9ZxoUINtl85wrfIy4efJSAaeWMumU=; b=TY2sySXJ1l853r+yM8Z7NaBsnc
	YzUwztuXXJfnYfAZK0ei9/63CCVAF9mAtIcTLkxw5yytM3uDEovrU2xTvUxMXewY89oXLfGcPECr6
	JZ3uOkzPIKjbG5knIPz9/rStaFMcXes8dbHTOnyCwCCb3wxnTpKpxu8JAhVOMUtLKCf0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wO0m4-0004qF-P5;
	Fri, 15 May 2026 22:12:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chrisl@kernel.org>) id 1wO0m1-0004q7-5E
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mb2Px+VFI1la/B1T8HdQLAoDo+pi65QwRBrBz9J8j3A=; b=KhEfyzY9DbbZJ9ppJ40Cjx/Y0/
 WRzNJXTsxlSUOXjyW8W19b0RkTS/C/jm93rCYWvk9j9iF/jVRBYhWmKT3v+hdtw19K9kgwIzmVB5t
 hf7caEadXeUuRtD+7r36Xog7EiKPBCu1gQ8HX7i/bNc+1n//qyaOMnYgDXYn8woG5uUg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mb2Px+VFI1la/B1T8HdQLAoDo+pi65QwRBrBz9J8j3A=; b=RTWe6t3s0j5vYLP1XbF2Sb+P2Y
 nNdy99DvkPb43JhrT6nZSPh75v4bZwMX/VTUDDhxKCOplC6fZts1SAxqa/fz5kfTVEBfPQlKQS5DA
 T5lPKu8xTh88/GZ9JmdQ+i22oIUbIelWW8La0AvXKtaKCPo3mC1nGZ9ckoKs09tGDWUs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wO0lz-0002tO-WF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 22:12:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2B06743E7E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD572C2BCFA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 22:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778883162;
 bh=Xo9RN/YaHlAbWe60yDn3HcJADUDb6frVOkoaJStZf5s=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tv+IRzby0Wc1y1AfRAfBW3nKPJfKGSdDUKMAC83W6JZ/dYSjgCeuFvnvRb+k2fDWh
 xbo5tF45ctQN2+lUP3uiBUSdgPOAi+Wx+0tkvg+4pJup5eskAOQTJlwp6phqJcshLI
 zwma6B6kmV2AJ2QU39YgSPGY+7u3MZcxTeE3mLdPCH/vhNyTGPwjMe4zxLH36reM8B
 Aer/b8HC7tlHs6JLUSTc8CC6m60eU8oVJuXGFC3sjcHNI2tTjQrIJ4E+efJOd+l39W
 8dpKuDtdYrLdKdfWZ3TWstbmXaMPftJx2DJhHT9Ud2qtgOsF/sPz15MPQ/jP7lSeCE
 kkkwEGkOg5Eqg==
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-65c2cd216c9so622262d50.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 May 2026 15:12:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+AQ4PxKbgl1kQLZU2KGho5WRs22GMV+d4Q0lDceVXUb0132YTmeH9+dymZrHwVRDVnyckPH5gKS1T4e7Tl2qbJ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy+/a3YSR8xAIm7pZbW4PF1AgfX9SuuOGmXtGWPr9P7XDMBvSc4
 aUOyX8ymow738bC2zwBPqYBlDxLXm9nkNOMP97Sr07TuiSxsjJZx6Q1Uv5BEo6qIOoqnOcNrF4o
 5PLMVv0WBKtH/+F8yV2zR1pFyVTU0byId/coZvDbOpg==
X-Received: by 2002:a05:690e:14c4:b0:64e:f106:60ea with SMTP id
 956f58d0204a3-65e22807f82mr6158139d50.44.1778883162092; Fri, 15 May 2026
 15:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-10-hch@lst.de>
In-Reply-To: <20260512053625.2950900-10-hch@lst.de>
Date: Fri, 15 May 2026 15:12:31 -0700
X-Gmail-Original-Message-ID: <CACePvbVPV55SgPmivqMX+bP8H7FKcSAbWCwAe5icgZjZV9vUNA@mail.gmail.com>
X-Gm-Features: AVHnY4LtC3KSyPNEsLh1ud1t2IOob9XfSBaYZO4ouG71LQM8qOS5lvZuuzrl4N0
Message-ID: <CACePvbVPV55SgPmivqMX+bP8H7FKcSAbWCwAe5icgZjZV9vUNA@mail.gmail.com>
To: Christoph Hellwig <hch@lst.de>
X-Headers-End: 1wO0lz-0002tO-WF
Subject: Re: [f2fs-dev] [PATCH 09/12] swap: push down setting sis->bdev into
 ->swap_activate
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
QGxzdC5kZT4gd3JvdGU6Cj4KPiBPbmx5IHRoZSBmaWxlIG9wZXJhdGlvbiBtZXRob2Qga25vd3Mg
d2hhdCBibG9jayBkZXZpY2Ugd2UnbGwgc3dhcAo+IHRvLiAgU28gbW92ZSBkb3duIHNldHRpbmcg
c2lzLT5iZGV2IGFuZCB0aGUgc3BlY2lhbCBibG9ja2RldiBmbGFnCj4gaW50byAtPnN3YXBfYWN0
aXZhdGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4K
CgpUaGUgY29yZSBzd2FwIHBhcnQgb2YgdGhlIGNvZGUgbG9va3MgZmluZSB0byBtZSwgSSBkaWQg
bm90IGxvb2sgbXVjaApkZWVwZXIgaW50byB0aGUgZnMgc2lkZS4KCkFjay1ieTogQ2hyaXMgTGkg
PGNocmlzbEBrZXJuZWwub3JnPgoKQ2hyaXMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1m
MmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdl
Lm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
