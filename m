Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEC1CA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwyVzpwsJRL8MIya1KQRwgCbeT8qXvLFifVjU9iV/zY=; b=hLycvRgvg5q4kSLsMzgqZf+mTg
	VCnnDLkI7q9zqQAfcrwuGHgUkAyF62LNUMNZk9s07hxvFhubseIEHFUo4QCQCYMYqwarGKvv6zcYq
	GlZ+u53iKOAWcymecWNbdyWztSN1bWdNz9TCbh/ZqJIklRlP7W+29V6aIN7qBd64yWG0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDimh-0001Td-8z;
	Mon, 05 Oct 2026 13:31:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1xDimf-0001TV-LM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:31:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YJVFrcH51dcWxKvIvBoz5wPALOazHMgdkbmMui1YFvM=; b=F35wLZITcJSx3OHJ1cyPZ1kDh4
 6p5rus6PEixMQojvL11pn51TjfwgGFgke1VUXh7Qw4Dqfhtb2/uUb0f6Xq7HEUaTZtgf+PqacZaZC
 8eIz4XbfKXuow0CvJvTjTS7/+zEiExCnCUT2CXVcr553rbU2QwwygWZqLMjMkFyPj0QQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YJVFrcH51dcWxKvIvBoz5wPALOazHMgdkbmMui1YFvM=; b=Xrcwu9J8d24Hyv2DFb3PPXpTHT
 +sGBgIHjrzHP83kzrFC2sg97tlPMjEQLaiu0YMuP2IYnhba95SIfXoM8LBLtRaC4OkT1mIxO4Mihv
 n8gtTueDhf1Le1ahEjZxJCZ5Rx4A4xbRfOCMY8NgYhS8dM6ZdXYgMD2CMoVEG9SV8CuA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDimc-0008Ma-4w for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 13:31:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ECDD043920;
 Mon,  5 Oct 2026 13:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F051F000FF;
 Mon,  5 Oct 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791207063;
 bh=YJVFrcH51dcWxKvIvBoz5wPALOazHMgdkbmMui1YFvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NZ6Jfn/XZvbHZ9XZWUeKBjHSx8Gwxg6v9+i6QIGrWRSYK6B+BD325E+wAPloxoe/i
 Fs0cNZt9HTSfTT2fIuyt6SYI1V09qLZotsQ26++U92UybnNUaDw0daQxMq6OXEmHz0
 i0PFp2xlI5bN8hSzGOBBRCH3JWS+H70cQojexrMqnWd03bd2zyUxgPDLGWsM8ic8Ku
 QnX5ZkA4xjMnqmwLM1PpJtDCy+KyfG/1LhrPesOPoEB6lMAvHhPjgubeCTHc9m14iL
 +eol8QKhP1q2npvOdrJ21JxbWpF29PQuDSXup+Vj4YervpvvbsjXI7A0l5yidd80/U
 VY/SQv9Bzlw+w==
Date: Mon, 5 Oct 2026 15:30:58 +0200
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261005133058.GA3436@quark>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002232542.GA15366@quark>
 <asDvqctUgrxflcCa@nidhogg.toxiclabs.cc>
 <asN8lCPmZpA0tp5S@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <asN8lCPmZpA0tp5S@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Headers-End: 1xDimc-0008Ma-4w
Subject: Re: [f2fs-dev] [PATCH v17 00/21] fs-verity support for XFS with
 post EOF merkle tree
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 05, 2026 at 01:26:18PM +0200, Andrey Albershteyn wrote:
> On 2026-10-03 14:07:23, Carlos Maiolino wrote:
> > On Fri, Oct 02, 2026 at 04:25:42PM -0700, Eric Biggers wrote:
> > > On Sat, Oct 03, 2026 at 12:36:41AM +0200, Andrey Albershteyn wrote:
> > > > Andrey Albershteyn (19):
> > > >   fsverity: report validation errors through fserror to fsnotify
> > > >   fsverity: expose ensure_fsverity_info()
> > > >   fsverity: pass digest size and hash of the all-zeroes block to ->write
> > > >   fsverity: hoist pagecache_read from f2fs/ext4 to fsverity
> > > >   fsverity: don't allow setting DAX file attribute on fsverity files
> > > >   fsverity: hoist statx reporting of fs-verity flag
> > > 
> > > Would it be helpful if I applied these six patches to fsverity/for-next
> > > for 7.4, or do you want to wait for the full series to go in at once
> > > (presumably through the XFS tree)?
> > > 
> > > - Eric
> > > 
> > 
> > It's your call, I *think*, this is too late for xfs 7.4, so I want to
> > queue it as soon as possible for 7.5.
> > 
> > If you want to take the fsverity patches into 7.4, go for it, then the
> > xfs ones I'll pull in once yours are merged.
> > 
> > Sounds reasonable?
> > 
> > Carlos
> > 
> 
> Fine with me too

Applied patches 1-6 to
https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
